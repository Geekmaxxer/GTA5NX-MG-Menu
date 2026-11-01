"""Review menu metadata and execute selected SanScript state transitions.

Run with Python 3 from any directory. No compiler, engine headers or game data
are needed. Native calls are deterministic models: these checks do not execute
the RAGE VM or establish Nintendo Switch gameplay acceptance.
"""

import argparse
import copy
import hashlib
import json
import math
import re
from pathlib import Path

SOURCE = Path(__file__).resolve().parents[1] / "source"
TOKENS = re.compile(
    r'"(?:\\.|[^"\\])*"|\d+(?:\.\d+)?|[A-Za-z_]\w*|<>|\+=|<=|>=|!=|[(),\[\]+*/%=<>-]'
)
PRECEDENCE = {
    "OR": 1,
    "AND": 2,
    "=": 3,
    "<>": 3,
    "!=": 3,
    "<": 3,
    ">": 3,
    "<=": 3,
    ">=": 3,
    "+": 4,
    "-": 4,
    "*": 5,
    "/": 5,
    "%": 5,
}


class Returned(Exception):
    def __init__(self, value=None):
        self.value = value


class Parser:
    def __init__(self, text):
        text = "\n".join(line.split("//", 1)[0] for line in text.splitlines())
        self.tokens = TOKENS.findall(text)
        self.at = 0

    def peek(self):
        return self.tokens[self.at] if self.at < len(self.tokens) else ""

    def take(self, expected=None):
        value = self.peek()
        assert value and (expected is None or expected == value), (expected, value)
        self.at += 1
        return value

    def expression(self, minimum=0):
        token = self.take()
        if token in ("NOT", "-"):
            value = ("unary", token, self.expression(6))
        elif token == "(":
            value = self.expression()
            self.take(")")
        elif token.startswith('"'):
            value = ("value", json.loads(token))
        elif token in ("TRUE", "FALSE"):
            value = ("value", token == "TRUE")
        elif token[0].isdigit():
            value = ("value", float(token) if "." in token else int(token))
        else:
            value = ("name", token)
            if self.peek() == "(":
                self.take()
                args = []
                while self.peek() != ")":
                    args.append(self.expression())
                    if self.peek() != ",":
                        break
                    self.take(",")
                self.take(")")
                value = ("call", token, args)
            elif self.peek() == "[":
                self.take()
                value = ("index", token, self.expression())
                self.take("]")
        while PRECEDENCE.get(self.peek(), -1) >= minimum:
            op = self.take()
            value = ("binary", op, value, self.expression(PRECEDENCE[op] + 1))
        return value

    def block(self, ends=()):
        result = []
        while self.peek() and self.peek() not in ends:
            token = self.take()
            if token == "SWITCH":
                expr = self.expression()
                branches = []
                default = []
                while self.peek() != "ENDSWITCH":
                    marker = self.take()
                    assert marker in ("CASE", "DEFAULT"), marker
                    value = self.expression(6) if marker == "CASE" else None
                    body = self.block(("CASE", "DEFAULT", "ENDSWITCH"))
                    if value is None:
                        default = body
                    else:
                        branches.append((value, body))
                self.take("ENDSWITCH")
                result.append(("switch", expr, branches, default))
            elif token == "BREAK":
                result.append(("break",))
            elif token == "REPEAT":
                count = self.expression()
                index = self.take()
                body = self.block(("ENDREPEAT",))
                self.take("ENDREPEAT")
                result.append(("repeat", count, index, body))
            elif token == "IF":
                branches = [(self.expression(), self.block(("ELIF", "ELSE", "ENDIF")))]
                while self.peek() == "ELIF":
                    self.take()
                    branches.append(
                        (self.expression(), self.block(("ELIF", "ELSE", "ENDIF")))
                    )
                if self.peek() == "ELSE":
                    self.take()
                    branches.append((("value", True), self.block(("ENDIF",))))
                self.take("ENDIF")
                result.append(("if", branches))
            elif token == "WHILE":
                condition = self.expression()
                body = self.block(("ENDWHILE",))
                self.take("ENDWHILE")
                result.append(("while", condition, body))
            elif token in ("RETURN", "EXIT"):
                result.append(
                    (
                        "return",
                        self.expression() if token == "RETURN" else ("value", None),
                    )
                )
            elif token in (
                "INT",
                "BOOL",
                "STRING",
                "FLOAT",
                "TEXT_LABEL_15",
                "TEXT_LABEL_31",
                "TEXT_LABEL_63",
                "MODEL_NAMES",
                "VEHICLE_INDEX",
                "PED_INDEX",
                "OSK_STATUS",
                "REL_GROUP_HASH",
                "RELATIONSHIP_TYPE",
            ):
                name = self.take()
                value = ("value", "" if token == "STRING" or "LABEL" in token else 0)
                if self.peek() == "=":
                    self.take()
                    value = self.expression()
                result.append(("assign", ("name", name), value, False))
            else:
                self.at -= 1
                target = self.expression(6)
                if self.peek() in ("=", "+="):
                    op = self.take()
                    result.append(("assign", target, self.expression(), op == "+="))
                else:
                    result.append(("evaluate", target))
        return result


class Break(Exception):
    pass


class Engine:
    def evaluate(self, node, local):
        kind, *data = node
        if kind == "value":
            return data[0]
        if kind == "name":
            return self.globals[data[0]] if data[0] in self.globals else local[data[0]]
        if kind == "index":
            return self.globals[data[0]][self.evaluate(data[1], local)]
        if kind == "unary":
            value = self.evaluate(data[1], local)
            return not value if data[0] == "NOT" else -value
        if kind == "binary":
            op, left, right = data
            left = self.evaluate(left, local)
            if op == "AND":
                return left and self.evaluate(right, local)
            if op == "OR":
                return left or self.evaluate(right, local)
            right = self.evaluate(right, local)
            return {
                "=": lambda: left == right,
                "<>": lambda: left != right,
                "!=": lambda: left != right,
                "<": lambda: left < right,
                ">": lambda: left > right,
                "<=": lambda: left <= right,
                ">=": lambda: left >= right,
                "+": lambda: left + right,
                "-": lambda: left - right,
                "*": lambda: left * right,
                "/": lambda: left // right,
                "%": lambda: left % right,
            }[op]()
        assert kind == "call"
        name, args = data
        return self.invoke(name, args, local)

    def execute(self, statements, local):
        for statement in statements:
            kind, *args = statement
            if kind == "if":
                for condition, body in args[0]:
                    if self.evaluate(condition, local):
                        self.execute(body, local)
                        break
            elif kind == "while":
                iterations = 0
                while self.evaluate(args[0], local):
                    self.execute(args[1], local)
                    iterations += 1
                    assert iterations < 10000
            elif kind == "return":
                raise Returned(self.evaluate(args[0], local))
            elif kind == "evaluate":
                self.evaluate(args[0], local)
            else:
                target, expression, append = args
                value = self.evaluate(expression, local)
                if append:
                    value = self.evaluate(target, local) + value
                if target[0] == "index":
                    self.globals[target[1]][self.evaluate(target[2], local)] = value
                else:
                    (self.globals if target[1].startswith("g_") else local)[
                        target[1]
                    ] = value

    def call(self, name, *values):
        parameters, statements = self.functions[name]
        try:
            self.execute(statements, dict(zip(parameters, values)))
        except Returned as returned:
            return returned.value


class Program(Engine):
    def __init__(self):
        self.globals = {}
        self.functions = {}
        self.defaults = {}
        self.native_calls = []
        self.now = 10000
        self.save_ok = True
        self.alive = set()
        self.generation = 0
        self.stubs = {}
        self.values_bool = [False] * 37
        self.values_int = [0] * 27
        self.files = {}
        self.failure = None
        self.writes = 0
        self.reads = 0
        all_text = "\n".join(
            p.read_text(encoding="utf-8-sig")
            for p in SOURCE.rglob("*")
            if p.suffix in (".sc", ".sch")
        )
        self.globals.update({name: 0 for name in re.findall(r"\bg_\w+", all_text)})
        for name, value in re.findall(
            r"^CONST_INT (\w+) (-?\d+)\b", all_text, re.MULTILINE
        ):
            self.globals[name] = int(value)
        self.globals.update(
            NULL=0,
            OSK_SUCCESS=1,
            OSK_PENDING=0,
            OSK_CANCELLED=2,
            OSK_FAILED=3,
            OSK_INVALID=4,
        )
        for kind, name, length, value in re.findall(
            r"^(INT|BOOL|FLOAT|STRING|TEXT_LABEL_\d+) (g_\w+)(?:\[(\w+)\])?(?:\s*=\s*([^\n]+))?",
            all_text,
            re.MULTILINE,
        ):
            if length:
                self.globals[name] = [0] * int(self.globals.get(length, length))
            elif value:
                value = value.split("//")[0].strip()
                try:
                    self.globals[name] = json.loads(
                        value.lower() if value in ("TRUE", "FALSE") else value
                    )
                except (ValueError, TypeError):
                    pass
        self.globals.update(
            g_persist_sd_data=[0] * 1024, g_persist_veh_sd_data=[0] * 2048
        )

    def load(self, file, *names):
        text = (SOURCE / file).read_text(encoding="utf-8-sig")
        for name in names:
            m = re.search(
                r"^(?:FUNC \w+|PROC) " + name + r"\((.*?)\)\s*\n(.*?)^END(?:FUNC|PROC)",
                text,
                re.MULTILINE | re.DOTALL,
            )
            assert m, name
            params = []
            defaults = {}
            for arg in m[1].split(","):
                if not arg.strip():
                    continue
                declaration, *default = arg.split("=")
                param = declaration.split()[-1].lstrip("&")
                params.append(param)
                if default:
                    defaults[param] = default[0].strip() == "TRUE"
            parser = Parser(m[2])
            body = parser.block()
            assert parser.at == len(parser.tokens), name
            self.functions[name] = (params, body)
            self.defaults[name] = defaults

    def evaluate(self, node, local):
        if node[0] == "call":
            return self.invoke(node[1], node[2], local)
        if node[0] == "binary" and node[1] in ("+", "-", "*"):
            value = super().evaluate(node, local)
            return ((value + 2**31) % 2**32) - 2**31 if type(value) == int else value
        return super().evaluate(node, local)

    def invoke(self, name, args, local):
        if name in ("SHVNX_SAVE", "SHVNX_LOAD"):
            pointer, count, namespace = args
            assert pointer[0] == "index"
            array = self.globals[pointer[1]]
            count = self.evaluate(count, local)
            namespace = self.evaluate(namespace, local)
            if name == "SHVNX_LOAD":
                self.reads += 1
                payload = self.files.get(namespace)
                if payload is None:
                    return 0
                array[: len(payload)] = payload
                return len(payload)
            write = self.writes
            self.writes += 1
            if write == self.failure:
                return False
            self.files[namespace] = list(array[:count])
            return True
        values = [self.evaluate(arg, local) for arg in args]
        self.native_calls.append((name, copy.deepcopy(values)))
        if name in self.stubs:
            return self.stubs[name](*values)
        if name in self.functions:
            return self.call(name, *values)
        builtins = {
            "GET_GAME_TIMER": lambda: self.now,
            "DOES_ENTITY_EXIST": lambda entity: entity in self.alive,
            "MEGASAVE": lambda *args: self.save_ok,
            "PERSIST_GLOBAL_BOOL": lambda slot: self.values_bool[slot],
            "PERSIST_GLOBAL_INT": lambda slot: self.values_int[slot],
            "TR": lambda *args: args[0],
            "COUNT_OF": len,
            "TO_FLOAT": float,
            "FLOOR": math.floor,
            "ROUND": round,
            "IS_STRING_NULL_OR_EMPTY": lambda value: not value,
            "ARE_STRINGS_EQUAL": lambda a, b: a == b,
            "GET_HASH_KEY": lambda value: hashlib.sha256(value.encode()).hexdigest(),
            "COMPARE_STRINGS": lambda a, b, case_sensitive, limit: (
                0
                if (a[:limit] if case_sensitive else a[:limit].lower())
                == (b[:limit] if case_sensitive else b[:limit].lower())
                else 1
            ),
            "GET_LENGTH_OF_LITERAL_STRING": len,
            "GET_CHARACTER_FROM_AUDIO_CONVERSATION_FILENAME": lambda s, a, b: s[a:b],
        }
        if name in builtins:
            return builtins[name](*values)
        raise AssertionError(("unmodeled call", name, values))

    def call(self, name, *values):
        params, body = self.functions[name]
        local = dict(self.defaults.get(name, {}))
        local.update(zip(params, values))
        try:
            self.execute(body, local)
        except Returned as r:
            return r.value

    def execute(self, statements, local):
        for statement in statements:
            kind, *args = statement
            if kind == "break":
                raise Break()
            if kind == "switch":
                value = self.evaluate(args[0], local)
                active = False
                try:
                    for label, body in args[1]:
                        if self.evaluate(label, local) == value:
                            active = True
                        if active:
                            self.execute(body, local)
                    if not active:
                        self.execute(args[2], local)
                except Break:
                    pass
            elif kind == "repeat":
                for i in range(self.evaluate(args[0], local)):
                    local[args[1]] = i
                    self.execute(args[2], local)
            else:
                super().execute([statement], local)


def audit_metadata():
    checks = []
    files = sorted(p for p in SOURCE.rglob("*") if p.suffix in (".sc", ".sch"))
    functions = {}
    translations = 0
    for path in files:
        text = path.read_text(encoding="utf-8-sig")
        assert "\ufffd" not in text, str(path) + ": invalid replacement character"
        # Quoted strings are matched before comments so URLs do not truncate
        # comments incorrectly. Translation arguments contain literal strings.
        code = re.sub(
            r'"(?:\\.|[^"\\])*"|//[^\n]*',
            lambda match: "" if match[0].startswith("//") else match[0],
            text,
        )
        for match in re.finditer(r"\bTR\(", code):
            if code[max(0, match.start() - 12) : match.start()].endswith(
                "FUNC STRING "
            ):
                continue
            end = match.end()
            depth = 1
            in_string = False
            escaped = False
            commas = 0
            while depth and end < len(code):
                c = code[end]
                if escaped:
                    escaped = False
                elif c == "\\" and in_string:
                    escaped = True
                elif c == '"':
                    in_string = not in_string
                elif not in_string:
                    if c == "(":
                        depth += 1
                    elif c == ")":
                        depth -= 1
                    elif c == "," and depth == 1:
                        commas += 1
                end += 1
            assert depth == 0 and commas == 7, (
                path,
                text[: match.start()].count("\n") + 1,
                commas,
            )
            translations += 1
        for match in re.finditer(
            r"^(?:PROC\s+(\w+)|FUNC\s+\w+\s+(\w+))\s*\((.*?)\)(.*?)^END(?:PROC|FUNC)\b",
            code,
            re.MULTILINE | re.DOTALL,
        ):
            name = match[1] or match[2]
            # Auxiliary scripts have separate address spaces.
            key = (path.name, name)
            assert key not in functions, ("duplicate function", key)
            functions[key] = match[4]
        checks.append(
            str(path.relative_to(SOURCE))
            + ": UTF-8, translation arity and function declarations"
        )

    def body(file, name):
        return functions[file, name]

    def cases(file, name):
        result = {}
        for key, value in re.findall(
            r"\bCASE\s+(-?\d+)\s+RETURN\s+(.+?)(?=\s+BREAK\b|\n)", body(file, name)
        ):
            key = int(key)
            assert key not in result, ("duplicate catalogue key", name, key)
            result[key] = value.strip()
        return result

    catalogues = {}

    def paired_pages(file, model_prefix, label_prefix, count, size, global_cases=False):
        models = {}
        labels = {}
        for page in range((count + size - 1) // size):
            a = cases(file, model_prefix + str(page))
            b = cases(file, label_prefix + str(page))
            offset = page * size if global_cases else 0
            expected = set(range(offset, offset + min(size, count - page * size)))
            assert set(a) == set(b) == expected, (file, page, set(a) ^ set(b))
            models.update({page * size + k - offset: v for k, v in a.items()})
            labels.update({page * size + k - offset: v for k, v in b.items()})
        catalogues[model_prefix] = count
        checks.append(
            file + ": complete paired catalogue of " + str(count) + " entries"
        )
        return models, labels

    count = int(
        re.search(r"RETURN\s+(\d+)", body("util_ped_catalog.sch", "PED_CHOICE_COUNT"))[
            1
        ]
    )
    models, labels = paired_pages(
        "util_ped_catalog.sch", "PED_MODEL_PAGE_", "PED_NAME_PAGE_", count, 96
    )
    assert all(value == labels[key].strip('"') for key, value in models.items()), (
        "PED model/name mismatch"
    )
    paired_pages(
        "util_spooner.sch",
        "SPOONER_CATALOG_MODEL_PAGE_",
        "SPOONER_CATALOG_LABEL_PAGE_",
        314,
        80,
        global_cases=True,
    )
    paired_pages(
        "util_story_peds.sch",
        "STORY_CHAR_DEFAULT_MODEL_PAGE_",
        "STORY_CHAR_DISPLAY_NAME_PAGE_",
        112,
        56,
    )
    for prefix in (
        "STORY_CHAR_ALT_MODEL_PAGE_",
        "STORY_CHAR_DEFAULT_MODEL_NAME_PAGE_",
        "STORY_CHAR_SCENE_HANDLE_1_PAGE_",
        "STORY_CHAR_SCENE_HANDLE_2_PAGE_",
    ):
        for page in range(2):
            assert set(cases("util_story_peds.sch", prefix + str(page))) == set(
                range(min(56, 112 - page * 56))
            ), prefix
    doors = 0
    for page in range(8):
        a = cases("util_door_catalog.sch", "DOOR_MODEL_PAGE_" + str(page))
        assert set(a) == set(range(min(96, 746 - page * 96)))
        doors += len(a)
    catalogues["doors"] = doors
    checks.append("Door catalogue: 746 contiguous paged entries")
    count = int(
        re.search(r"RETURN\s+(\d+)", body("util_weapons.sch", "MENU_WEAPON_COUNT"))[1]
    )
    for name in (
        "MENU_WEAPON_FOR_CHOICE",
        "MENU_WEAPON_AMMO_FOR_CHOICE",
        "MENU_WEAPON_NAME_FOR_CHOICE",
    ):
        assert set(cases("util_weapons.sch", name)) == set(range(count)), name
    catalogues["weapons"] = count
    checks.append(
        "Weapon models, names and ammunition cover the same " + str(count) + " choices"
    )
    for name in ("CHAUFFEUR_VEHICLE_MODEL", "CHAUFFEUR_VEHICLE_NAME"):
        assert set(cases("util_chauffeur.sch", name)) == set(range(14)), name
    checks.append("Chauffeur vehicle models and names cover all 14 choices")
    models = cases("util_vehicle_catalog.sch", "GET_VEHICLE_CHOICE_MODEL")
    models.update(cases("util_vehicle_catalog.sch", "MISC_VEHICLE_MODEL"))
    labels = cases("util_vehicle_catalog.sch", "GET_VEHICLE_CHOICE_NAME")
    assert set(models) == set(labels) == set(range(190)), (
        "Vehicle catalogue domains",
        len(models),
        len(labels),
    )
    checks.append("Vehicle model and label catalogue: 190 matching choices")
    # Every fixed row renderer is checked independently of its page's scrolling.
    rows = {
        "DRAW_PLAYER_ROW": 26,
        "DRAW_VEHICLE_ROW": 28,
        "DRAW_MISC_ROW": 14,
        "DRAW_TELEPORT_ROW": 14,
        "DRAW_WORLD_ROW": 17,
        "DRAW_RADIO_ROW": 5,
        "DRAW_TP_STORE_ROW": 19,
        "DRAW_TP_LOCATION_ROW": 35,
        "DRAW_VEHICLE_CONTROL_ROW": 17,
        "DRAW_WHEELTYRE_ROW": 10,
        "DRAW_INTERIOR_ROW": 11,
        "DRAW_LSC_EXTRAS_ROW": 10,
        "DRAW_HYDRO_ROW": 19,
        "DRAW_CHAUFFEUR_ROW": 8,
        "DRAW_WORLD_MAYHEM_ROW": 4,
    }
    for name, total in rows.items():
        candidates = [
            value for (file, function), value in functions.items() if function == name
        ]
        assert len(candidates) == 1, name
        domain = {int(v) for v in re.findall(r"\bCASE\s+(\d+)\b", candidates[0])}
        assert domain == set(range(total)), (name, domain ^ set(range(total)))
        checks.append(name + ": complete fixed row domain 0.." + str(total - 1))
    return {
        "checks": checks,
        "source_files": len(files),
        "functions": len(functions),
        "translation_calls": translations,
        "catalogues": catalogues,
        "method": "Static structure and catalogue-domain checks; this is not gameplay validation.",
    }


def main():
    checks = []
    metadata = audit_metadata()

    def check(name, condition):
        assert condition, name
        checks.append(name)

    p = Program()
    p.load("util/util_spooner.sch", "COMPACT_SPOONER_POOL")
    for live in (set(), {1}, {1, 3}, {1, 2, 3}):
        p.alive = live
        p.globals.update(
            g_spooner_objects=[1, 2, 3, 0],
            g_spooner_object_count=3,
            g_spooner_selected_index=2,
            g_spooner_obj_flags=[10, 20, 30, 0],
            g_spooner_obj_rot=[100, 200, 300, 0],
        )
        p.call("COMPACT_SPOONER_POOL")
        n = len(live)
        check(
            "Spooner compacts live handles and metadata: " + str(sorted(live)),
            p.globals["g_spooner_object_count"] == n
            and p.globals["g_spooner_objects"][:n] == sorted(live)
            and p.globals["g_spooner_selected_index"] == max(0, n - 1)
            and p.globals["g_spooner_obj_flags"][:n] == [x * 10 for x in sorted(live)],
        )
    p.alive = {2, 3}
    p.globals.update(
        g_spooner_objects=[1, 2, 3, 0],
        g_spooner_object_count=3,
        g_spooner_selected_index=1,
        g_spooner_obj_flags=[10, 20, 30, 0],
        g_spooner_obj_rot=[100, 200, 300, 0],
    )
    p.call("COMPACT_SPOONER_POOL")
    check(
        "Spooner compaction preserves the selected live object",
        p.globals["g_spooner_selected_index"] == 0
        and p.globals["g_spooner_objects"][0] == 2,
    )
    p.load(
        "util/util_persistence.sch",
        "PERSIST_SAVE_ALL",
        "PERSIST_SAVE_DELTA",
        "PERSIST_REFRESH_SHADOW",
        "PERSIST_PACK_ALL_TO_BUFFER",
        "PERSIST_COMPUTE_SD_CHECKSUM",
        "PERSIST_CLEAR_ALL",
        "MARK_PERSIST_DIRTY",
        "PROCESS_PERSISTENCE",
        "PERSIST_FLUSH_NOW",
    )
    p.globals.update(g_persist_enabled=True, g_persist_load_done=True)
    p.values_bool[0] = True
    p.values_int[0] = 4
    p.globals["g_menu_language"] = 3
    p.save_ok = False
    p.call("PERSIST_SAVE_ALL")
    check(
        "Failed settings save retains dirty state without publishing shadow",
        p.globals["g_persist_dirty"] and not p.globals["g_persist_shadow_valid"],
    )
    check(
        "Settings retry is paced after maximum coalescing deadline",
        p.globals["g_persist_next_write"] == p.now + 5000
        and p.globals["g_persist_dirty_since"] == p.now,
    )
    count = sum(name == "MEGASAVE" for name, args in p.native_calls)
    p.now += 100
    p.call("PROCESS_PERSISTENCE")
    check(
        "Failed storage does not retry every frame",
        count == sum(name == "MEGASAVE" for name, args in p.native_calls),
    )
    p.now += 5000
    p.save_ok = True
    p.call("PROCESS_PERSISTENCE")
    check(
        "Recovered storage publishes exact successful state",
        not p.globals["g_persist_dirty"]
        and p.globals["g_persist_shadow_valid"]
        and p.globals["g_persist_shadow_language"] == 3,
    )
    p.globals.update(g_persist_enabled=False)
    p.save_ok = False
    p.call("MARK_PERSIST_DIRTY", True)
    p.call("PERSIST_SAVE_ALL")
    p.now += 5000
    p.save_ok = True
    p.call("PROCESS_PERSISTENCE")
    check(
        "Disabled preference can recover from failed writes",
        not p.globals["g_persist_dirty"],
    )
    p.globals.update(g_persist_enabled=True, g_persist_dirty=True)
    p.call("PERSIST_CLEAR_ALL")
    before = len(p.native_calls)
    p.call("PERSIST_SAVE_DELTA")
    check(
        "Clear is not immediately overwritten by unchanged session settings",
        not any(name == "MEGASAVE" for name, args in p.native_calls[before:]),
    )
    p.globals["g_menu_language"] = 4
    p.save_ok = False
    p.call("PERSIST_SAVE_ALL")
    p.save_ok = True
    p.call("PERSIST_SAVE_DELTA")
    check(
        "Failed language save remains detectable after buffer packing",
        p.globals["g_persist_shadow_language"] == 4
        and not p.globals["g_persist_dirty"],
    )
    p.globals["g_menu_language"] = 5
    p.save_ok = False
    p.call("PERSIST_FLUSH_NOW")
    # Explicitly mark the actual change before a menu-close flush.
    p.call("MARK_PERSIST_DIRTY")
    p.call("PERSIST_FLUSH_NOW")
    check(
        "Menu-close flush does not discard a failed write", p.globals["g_persist_dirty"]
    )
    p.save_ok = False
    p.call("PERSIST_CLEAR_ALL")
    check(
        "Clear reports write failure instead of success",
        "Failed" in p.globals["g_persist_status_text"],
    )
    p.load(
        "util/util_saved_vehicles.sch",
        "PERSIST_SAVE_SAVED_VEHICLES",
        "PROCESS_SAVED_VEHICLE_STORAGE",
    )
    p.stubs["PERSIST_PACK_VEHICLES_TO_BUFFER"] = lambda: None
    p.call("PERSIST_SAVE_SAVED_VEHICLES")
    check(
        "Saved-vehicle storage retains pending changes",
        p.globals["g_saved_vehicles_dirty"],
    )
    p.now += 5000
    p.save_ok = True
    p.call("PROCESS_SAVED_VEHICLE_STORAGE")
    check(
        "Saved-vehicle storage retries and confirms success",
        not p.globals["g_saved_vehicles_dirty"]
        and p.globals["g_saved_veh_feedback"] == 2,
    )
    p.load("features/features_main.sch", "ADJUST_SELECTOR", "IS_SELECTOR_ACTIVE")
    for value, direction, expected in (
        (2147483647, 1, 2147483647),
        (2147479999, 1, 2147483647),
        (0, -1, 0),
        (9999, -1, 0),
        (50000, -1, 40000),
    ):
        p.globals.update(g_tab=0, g_item=17, g_cash_amount=value)
        p.call("ADJUST_SELECTOR", direction)
        check(
            "Cash selector saturates before signed overflow: "
            + str((value, direction)),
            p.globals["g_cash_amount"] == expected,
        )
    for key, row in (("g_vehicle_acceleration_level", 8), ("g_vehicle_grip_level", 9)):
        for value, direction, expected in (
            (5, -1, 5),
            (100, 1, 105),
            (100, -1, 95),
            (99900, 1, 99900),
        ):
            p.globals.update(g_tab=3, g_item=row, **{key: value})
            check(key + " row accepts selector", p.call("IS_SELECTOR_ACTIVE"))
            p.call("ADJUST_SELECTOR", direction)
            check(
                key + " step/clamp " + str((value, direction)),
                p.globals[key] == expected,
            )
    p.load("features/features_main.sch", "ITEM_COUNT", "ACTIVE_ITEM_COUNT")
    p.stubs.update(
        PED_CHOICE_COUNT=lambda: 760,
        STORY_CHAR_VISIBLE_COUNT=lambda: 111,
        MENU_WEAPON_COUNT=lambda: 93,
        SAVED_VEHICLES_TOTAL_ROWS=lambda: 17,
        VEHICLE_LIST_TOTAL_ROWS=lambda: 190,
        COUNT_ACTIVE_CUSTOM_NSC_SCRIPTS=lambda: 0,
        NSC_LOADER_TOTAL_ROWS=lambda: 100,
        PLUGIN_MGR_TOTAL_ROWS=lambda: 24,
    )
    for tab, count in enumerate((25, 11, 6, 28, 17, 14, 14, 12)):
        p.globals.update(g_tab=tab, g_auto_save=False, g_accent_choice=0)
        check("Base page row count: " + str(tab), p.call("ITEM_COUNT") == count)
    p.globals["g_bodyguard_tp_too_far"] = False
    for tab, flag, count in (
        (0, "g_outfit_open", 21),
        (0, "g_radio_open", 5),
        (0, "g_ped_open", 764),
        (0, "g_bodyguard_open", 10),
        (0, "g_attacker_open", 6),
        (3, "g_spawner_open", 12),
        (3, "g_chauffeur_open", 8),
        (3, "g_vehicle_control_open", 17),
        (3, "g_hydro_open", 19),
        (3, "g_interior_open", 11),
        (3, "g_wheeltyre_open", 10),
        (3, "g_lsc_extras_open", 10),
        (4, "g_timeweather_open", 9),
        (4, "g_mayhem_open", 4),
        (5, "g_tp_stores_open", 19),
        (5, "g_tp_locs_open", 35),
        (7, "g_spooner_open", 21),
        (7, "g_plugin_mgr_open", 24),
        (7, "g_nsc_loader_open", 100),
    ):
        p.globals.update(g_tab=tab, g_cached_player_in_veh=True, **{flag: True})
        check("Submenu row count: " + flag, p.call("ITEM_COUNT") == count)
        p.globals[flag] = False
    p.load(
        "util/util_ped_catalog.sch",
        "ADJUST_PED_SELECTOR",
        "APPLY_CHARACTER_PROFILE",
        "SAVED_CHARACTER_PED",
    )
    requested = []
    p.stubs["REQUEST_PED_CHANGE"] = lambda model: requested.append(model)
    p.globals.update(
        g_item=3,
        g_character_slot=0,
        g_character_profile_choice=0,
        g_michael_ped=100,
        g_franklin_ped=101,
        g_trevor_ped=102,
    )
    p.call("ADJUST_PED_SELECTOR", 1)
    check(
        "Browsing another character profile preserves the active owner",
        p.globals["g_character_slot"] == 0
        and p.globals["g_character_profile_choice"] == 1,
    )
    p.call("APPLY_CHARACTER_PROFILE", 1)
    check("Character profile applies the selected model", requested == [101])

    p.load(
        "features/features_main.sch",
        "RESTORE_FREECAM_STATE",
        "SET_PLAYER_FREECAM_ENABLED",
    )
    p.stubs.update(
        PLAYER_PED_ID=lambda: 1,
        SET_ENTITY_VISIBLE=lambda *args: None,
        IS_PED_IN_ANY_VEHICLE=lambda ped: False,
        SET_PLAYER_NOCLIP_ENABLED=lambda enabled: p.globals.update(
            g_player_noclip=enabled
        ),
    )
    for invisible, first_person, noclip in (
        (a, b, c) for a in (False, True) for b in (False, True) for c in (False, True)
    ):
        p.globals.update(
            g_player_freecam=False,
            g_invisible=invisible,
            g_first_person=first_person,
            g_player_noclip=noclip,
        )
        p.call("SET_PLAYER_FREECAM_ENABLED", True)
        p.call("SET_PLAYER_FREECAM_ENABLED", True)
        p.call("SET_PLAYER_FREECAM_ENABLED", False)
        check(
            "Freecam restores its captured state: "
            + str((invisible, first_person, noclip)),
            (
                p.globals["g_invisible"],
                p.globals["g_first_person"],
                p.globals["g_player_noclip"],
            )
            == (invisible, first_person, noclip),
        )

    p.load(
        "util/util_saved_vehicles.sch",
        "PERSIST_COMPUTE_VEH_SD_CHECKSUM",
        "PERSIST_LOAD_SAVED_VEHICLES",
    )
    for version in (1, 2):
        p.globals["g_persist_veh_sd_data"] = [0] * 2048
        data = p.globals["g_persist_veh_sd_data"]
        data[:3] = [p.globals["PERSIST_VEH_MAGIC"], version, 1]
        data[20] = 1234
        data[3] = p.call("PERSIST_COMPUTE_VEH_SD_CHECKSUM")
        p.stubs["MEGALOAD"] = lambda *args: 2048
        p.stubs["PERSIST_UNPACK_VEHICLES_FROM_BUFFER"] = lambda: None
        check(
            "Saved-vehicle schema remains readable: " + str(version),
            p.call("PERSIST_LOAD_SAVED_VEHICLES"),
        )
        data[20] += 1
        check(
            "Saved-vehicle checksum rejects changed payload: " + str(version),
            not p.call("PERSIST_LOAD_SAVED_VEHICLES"),
        )
    data[20] -= 1
    data[2] = 2
    check(
        "Saved-vehicle schema 2 protects the record count",
        not p.call("PERSIST_LOAD_SAVED_VEHICLES"),
    )
    data[2] = 1
    p.stubs["MEGALOAD"] = lambda *args: 2047
    check(
        "Saved-vehicle load rejects incomplete records",
        not p.call("PERSIST_LOAD_SAVED_VEHICLES"),
    )

    p.stubs.update(
        GET_VEHICLE_PED_IS_IN=lambda ped: 2,
        ENUM_TO_INT=lambda value: value,
        LSC_KIT_FOR_SLOT=lambda *args: 0,
        APPLY_HYDRO_LEVEL=lambda: None,
        APPLY_INTERIOR_SLOT=lambda: None,
        APPLY_LIVERY=lambda: None,
    )
    p.globals["MOD_HYDRO"] = "hydro-slot"
    p.stubs["IS_PED_IN_ANY_VEHICLE"] = lambda ped: True
    for page, row, value in (
        ("g_hydro_open", 1, "g_hydro_level"),
        ("g_interior_open", 3, "g_interior_choice"),
        ("g_lsc_extras_open", 0, "g_lsc_livery"),
    ):
        for available in (0, 3, 12):
            p.stubs["GET_NUM_VEHICLE_MODS"] = lambda *args, count=available: count
            p.stubs["INTERIOR_AVAILABLE"] = lambda count=available: count
            p.stubs["GET_VEHICLE_LIVERY_COUNT"] = lambda vehicle, count=available: count
            p.globals.update(g_tab=3, g_item=row, **{page: True, value: -1})
            p.call("ADJUST_SELECTOR", -1)
            check(
                page + " wraps to the actual final variant: " + str(available),
                p.globals[value] == available - 1,
            )
            p.call("ADJUST_SELECTOR", 1)
            check(
                page + " wraps to Stock after the final variant: " + str(available),
                p.globals[value] == -1,
            )
            p.globals[page] = False

    # Execute the exact wheel/tyre apply block without interpreting unrelated
    # vector-heavy branches of the full dispatcher.
    submenu = (SOURCE / "submenus/submenus_all.sch").read_text(encoding="utf-8")
    block = re.search(
        r"ELIF g_wheeltyre_open\s*\n(.*?)\n\s*ELIF g_lsc_extras_open",
        submenu,
        re.DOTALL,
    )[1]
    statements = Parser(block).block()
    p.stubs.update(
        APPLY_WHEEL_TYRE_SMOKE=lambda: None,
        APPLY_TYRES_CAN_BURST=lambda: None,
        APPLY_SOFT_SUSPENSION=lambda: None,
    )
    for row, value in (
        (7, "g_wheeltyre_smoke"),
        (8, "g_wheeltyre_can_burst"),
        (9, "g_wheeltyre_soft_suspension"),
    ):
        for initial in (False, True):
            p.globals.update(g_item=row, **{value: initial})
            p.execute(statements, {"playerPed": 1})
            check(
                value + " apply toggles: " + str(initial), p.globals[value] != initial
            )

    p.load("util/util_story_peds.sch", "PROCESS_CUSTOM_STORY_PEDS")
    retired = []
    p.stubs.update(
        CLEANUP_STORY_CUTSCENE_SLOTS=lambda: retired.append(True),
        CLEANUP_ALL_STORY_PROXIES=lambda: None,
    )
    for customized, mission_threads in ((False, 0), (True, 1)):
        p.globals.update(g_story_peds_any_active=customized, g_story_cs_was_active=True)
        p.stubs["GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH"] = (
            lambda value, count=mission_threads: count
        )
        p.stubs["HASH"] = lambda value: value
        p.stubs["IS_CUTSCENE_ACTIVE"] = lambda: True
        retired.clear()
        p.call("PROCESS_CUSTOM_STORY_PEDS")
        check(
            "Cutscene actor cleanup waits for engine release: " + str(customized),
            not retired and p.globals["g_story_cs_was_active"],
        )
        p.stubs["IS_CUTSCENE_ACTIVE"] = lambda: False
        p.call("PROCESS_CUSTOM_STORY_PEDS")
        check(
            "Deferred cutscene actors are retired after playback: " + str(customized),
            retired == [True] and not p.globals["g_story_cs_was_active"],
        )

    q = Program()
    q.load(
        "util/util_nsc_loader.sch",
        "INIT_NSC_CATALOG",
        "NSC_READ_PAGE",
        "NSC_NAME_AT",
        "NSC_WRITE_CACHED_NAME",
        "NSC_PREPARE_PAGE",
        "NSC_COMMIT_COUNT",
        "FIND_CUSTOM_NSC_SLOT_BY_HASH",
        "TRY_REGISTER_CUSTOM_NSC",
        "REMOVE_SAVED_CUSTOM_NSC_AT_SLOT",
        "NORMALIZE_NSC_SCRIPT_NAME",
        "NSC_CHAR_TO_CODE",
        "NSC_CODE_TO_CHAR",
    )
    q.stubs.update(
        IS_STOCK_OR_CORE_NSC_HASH=lambda value: (
            value == hashlib.sha256(b"ragemenu").hexdigest()
        ),
        WAIT=lambda time: None,
        SET_NSC_FEEDBACK=lambda value: None,
        TERMINATE_AND_UNLOAD_CUSTOM_NSC_NAME=lambda value: None,
        SET_SCRIPT_AS_NO_LONGER_NEEDED=lambda value: None,
    )
    for character in "abcdefghijklmnopqrstuvwxyz0123456789_-.":
        encoded = q.call("NSC_CHAR_TO_CODE", character)
        check(
            "NSC filename character round trip: " + character,
            q.call("NSC_CODE_TO_CHAR", encoded) == character,
        )
    # Cache the verified live codec to keep large catalogue tests bounded.
    alphabet = "abcdefghijklmnopqrstuvwxyz0123456789_-."
    encoded_characters = {c: q.call("NSC_CHAR_TO_CODE", c) for c in alphabet}
    decoded_characters = {
        n: q.call("NSC_CODE_TO_CHAR", n) for n in encoded_characters.values()
    }
    q.stubs["NSC_CHAR_TO_CODE"] = lambda c: encoded_characters.get(c.lower(), 0)
    q.stubs["NSC_CODE_TO_CHAR"] = lambda n: decoded_characters.get(n, "")
    names = [f"custom_script_{i:03}_long_name" for i in range(96)]
    for name in names:
        assert q.call("TRY_REGISTER_CUSTOM_NSC", name)
    check(
        "Saved NSC catalogue retains 96 names across multiple pages",
        [q.call("NSC_NAME_AT", i) for i in range(96)] == names,
    )
    baseline_files = copy.deepcopy(q.files)
    baseline_globals = copy.deepcopy(q.globals)
    for failure in (0, 1):
        q.files = copy.deepcopy(baseline_files)
        q.globals = copy.deepcopy(baseline_globals)
        q.writes = 0
        q.failure = failure
        assert not q.call("TRY_REGISTER_CUSTOM_NSC", "one_more")
        check(
            "Failed NSC append preserves committed names: " + str(failure),
            [q.call("NSC_NAME_AT", i) for i in range(96)] == names,
        )
        q.failure = None
        check(
            "Failed NSC append can be retried without restarting: " + str(failure),
            q.call("TRY_REGISTER_CUSTOM_NSC", "one_more")
            and q.globals["g_nsc_discovered_count"] == 97,
        )
    for failure in (0, 1, 2):
        q.files = copy.deepcopy(baseline_files)
        q.globals = copy.deepcopy(baseline_globals)
        q.writes = 0
        q.failure = failure
        q.call("REMOVE_SAVED_CUSTOM_NSC_AT_SLOT", 3)
        check(
            "Failed NSC removal preserves committed names: " + str(failure),
            [q.call("NSC_NAME_AT", i) for i in range(96)] == names,
        )
        q.failure = None
        q.call("REMOVE_SAVED_CUSTOM_NSC_AT_SLOT", 3)
        expected = list(names)
        expected[3] = expected.pop()
        check(
            "Failed NSC removal can be retried without restarting: " + str(failure),
            [q.call("NSC_NAME_AT", i) for i in range(95)] == expected,
        )
    q.files = copy.deepcopy(baseline_files)
    q.globals = copy.deepcopy(baseline_globals)
    q.globals.update(
        g_nsc_catalog_loaded=False,
        g_nsc_discovered_count=0,
        g_nsc_catalog_generation=0,
        g_nsc_catalog_page=-1,
        g_nsc_catalog_cached_page=-1,
    )
    q.call("INIT_NSC_CATALOG")
    check(
        "Fresh catalogue state reads the committed generation",
        [q.call("NSC_NAME_AT", i) for i in range(96)] == names,
    )
    q.load("util/util_persistence.sch", "PERSIST_LOAD_CUSTOM_NSC_LIST")
    q.files = {}
    q.globals = Program().globals
    legacy = ["chaosmod", "cardealership", "a_script", "z_9-name"]
    encoded_legacy = []
    for name in legacy:
        if encoded_legacy:
            encoded_legacy.append(62)
        encoded_legacy.extend(encoded_characters[c] for c in name)
    q.globals["g_persist_sd_data"][69 : 69 + len(encoded_legacy)] = encoded_legacy
    q.failure = None
    q.call("PERSIST_LOAD_CUSTOM_NSC_LIST")
    q.call("PERSIST_LOAD_CUSTOM_NSC_LIST")
    check(
        "Legacy names migrate with the actual filename codec without duplicates",
        q.globals["g_nsc_discovered_count"] == len(legacy)
        and [q.call("NSC_NAME_AT", i) for i in range(len(legacy))] == legacy,
    )

    checks.extend(metadata["checks"])
    proof = {
        "passed": len(checks),
        "checks": checks,
        "scope": __doc__.strip(),
        "physical_switch_accepted": False,
    }
    proof["metadata"] = metadata
    proof["sources"] = {
        str(p.relative_to(SOURCE)).replace("\\", "/"): hashlib.sha256(
            p.read_bytes()
        ).hexdigest()
        for p in sorted(SOURCE.rglob("*"))
        if p.suffix in (".sc", ".sch")
    }
    if OUTPUT is not None:
        OUTPUT.write_text(json.dumps(proof, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"passed": len(checks), "scope": proof["scope"]}, indent=2))


if __name__ == "__main__":
    if not __debug__:
        raise RuntimeError("Run this verifier without Python's -O option.")
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-root", type=Path, default=SOURCE)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    SOURCE = args.source_root.resolve()
    OUTPUT = args.output.resolve() if args.output else None
    main()

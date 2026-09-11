using System;
using System.Collections.Generic;
using System.IO.Compression;
using System.IO;
using System.Net.Http;
using System.Linq;
using System.Text;

namespace Decompiler
{
    internal static class Program
    {
        public static NativeFile nativefile;
        public static x64NativeFile x64nativefile;
        public static object ThreadLock = new object();
        public enum IntType { _int, _uint, _hex }
        public static IntType getIntType { get { return IntType._hex; } }
        public static bool Hex_Index { get { return true; } }
        public static bool Declare_Variables { get { return true; } }
        public static bool Shift_Variables { get { return false; } }
        public static bool Show_Func_Pointer { get { return false; } }
        public static bool Use_MultiThreading { get { return false; } }
        public static bool IncFuncPos { get { return true; } }
        public static bool Show_Nat_Namespace { get { return true; } }
        public static bool Upper_Natives { get { return false; } }
        public static bool Reverse_Hashes { get { return true; } }
        public static bool Show_Array_Size { get { return true; } }

        public static int Main(string[] args)
        {
            if (args.Length == 2 && string.Equals(args[0], "--scan-dir", StringComparison.OrdinalIgnoreCase) && Directory.Exists(args[1]))
            {
                string baseDir = AppContext.BaseDirectory;
                string nativePath = Path.GetFullPath(Path.Combine(baseDir, "..", "..", "..", "..", "third_party", "GTA-V-Script-Decompiler", "GTA V Script Decompiler", "Resources", "x64natives.dat"));
                x64nativefile = new x64NativeFile(File.OpenRead(nativePath));
                ScanDirectory(args[1]);
                return 0;
            }
            if (args.Length == 3 && string.Equals(args[0], "--native-db", StringComparison.OrdinalIgnoreCase) && Directory.Exists(args[1]))
            {
                string databaseBaseDir = AppContext.BaseDirectory;
                string databaseNativePath = Path.GetFullPath(Path.Combine(databaseBaseDir, "..", "..", "..", "..", "third_party", "GTA-V-Script-Decompiler", "GTA V Script Decompiler", "Resources", "x64natives.dat"));
                if (File.Exists(databaseNativePath)) x64nativefile = new x64NativeFile(File.OpenRead(databaseNativePath));
                WriteNativeDatabase(args[1], args[2]);
                return 0;
            }
            if (args.Length == 3 && string.Equals(args[0], "--find-script", StringComparison.OrdinalIgnoreCase) && Directory.Exists(args[1]))
            {
                FindScriptHashReferences(args[1], args[2]);
                return 0;
            }
            if (args.Length == 2 && string.Equals(args[0], "--validate-names", StringComparison.OrdinalIgnoreCase) && Directory.Exists(args[1]))
            {
                ValidateScriptNames(args[1]);
                return 0;
            }
            if (args.Length == 3 && string.Equals(args[0], "--compare-native-tables", StringComparison.OrdinalIgnoreCase) && File.Exists(args[1]) && File.Exists(args[2]))
            {
                CompareNativeTables(args[1], args[2]);
                return 0;
            }
            if (args.Length == 3 && string.Equals(args[0], "--compare-native-url", StringComparison.OrdinalIgnoreCase) && File.Exists(args[1]))
            {
                using var client = new HttpClient();
                byte[] pcData = client.GetByteArrayAsync(args[2]).GetAwaiter().GetResult();
                CompareNativeTables(ReadNscPayload(args[1]), ReadNscPayload(pcData, args[2]));
                return 0;
            }
            if (args.Length == 4 && string.Equals(args[0], "--write-crossmap", StringComparison.OrdinalIgnoreCase) && File.Exists(args[1]) && File.Exists(args[2]))
            {
                WriteCrossmap(args[1], args[2], args[3]);
                return 0;
            }
            if (args.Length == 4 && string.Equals(args[0], "--adapt-header", StringComparison.OrdinalIgnoreCase) && File.Exists(args[1]) && File.Exists(args[2]))
            {
                AdaptHeader(args[1], args[2], args[3]);
                return 0;
            }
            if (args.Length != 1 || !File.Exists(args[0]))
            {
                Console.Error.WriteLine("Usage: NscDump <script.nsc> | --scan-dir <directory> | --native-db <directory> <output.json> | --find-script <directory> <name> | --validate-names <directory> | --compare-native-tables <switch.nsc> <pc.ysc> | --compare-native-url <switch.nsc> <url> | --write-crossmap <switch.nsc> <pc.ysc> <output.json> | --adapt-header <switch.nsc> <candidate.ysc> <output.nsc>");
                return 2;
            }
            string singleBaseDir = AppContext.BaseDirectory;
            string singleNativePath = Path.GetFullPath(Path.Combine(singleBaseDir, "..", "..", "..", "..", "third_party", "GTA-V-Script-Decompiler", "GTA V Script Decompiler", "Resources", "x64natives.dat"));
            x64nativefile = new x64NativeFile(File.OpenRead(singleNativePath));
            DumpSwitchResource(args[0]);
            return 0;
        }

        private static void ScanDirectory(string directory)
        {
            Console.WriteLine("SCRIPT\tCODE_LENGTH\tNATIVES\tCALL_CANDIDATES\tOUT_OF_RANGE_CANDIDATES");
            foreach (string path in Directory.EnumerateFiles(directory, "*.nsc", SearchOption.AllDirectories).OrderBy(p => p, StringComparer.OrdinalIgnoreCase))
            {
                try
                {
                    ScanSummary(path, out uint codeLength, out uint nativeCount, out int calls, out int invalidCalls);
                    Console.WriteLine($"{Path.GetRelativePath(directory, path)}\t{codeLength}\t{nativeCount}\t{calls}\t{invalidCalls}");
                }
                catch (Exception ex) when (ex is InvalidDataException || ex is IOException)
                {
                    Console.WriteLine($"{Path.GetRelativePath(directory, path)}\tERROR\t{ex.Message}");
                }
            }
        }

        private static void WriteNativeDatabase(string directory, string outputPath)
        {
            var entries = new Dictionary<ulong, NativeObservation>();
            int scripts = 0;
            foreach (string path in Directory.EnumerateFiles(directory, "*.nsc", SearchOption.AllDirectories).OrderBy(p => p, StringComparer.OrdinalIgnoreCase))
            {
                byte[] data = ReadNscPayload(path);
                if (data.Length < 0x78) continue;
                uint codeLength = U32(data, 0x1c);
                uint nativeCount = U32(data, 0x2c);
                int nativeOffset = ResourceOffset(U64(data, 0x40));
                if (nativeOffset < 0 || nativeOffset + (long)nativeCount * 8 > data.Length) continue;
                scripts++;
                string relative = Path.GetRelativePath(directory, path).Replace('\\', '/');
                for (uint i = 0; i < nativeCount; i++)
                {
                    int offset = checked(nativeOffset + (int)i * 8);
                    ulong stored = U64(data, offset);
                    ulong decoded = RotateLeft(stored, unchecked((int)(codeLength + i)));
                    if (!entries.TryGetValue(decoded, out NativeObservation observation))
                    {
                        observation = new NativeObservation(decoded);
                        entries.Add(decoded, observation);
                    }
                    observation.Occurrences.Add(new NativeOccurrence(relative, i, stored));
                }
            }

            string fullOutput = Path.GetFullPath(outputPath);
            string parent = Path.GetDirectoryName(fullOutput);
            if (!string.IsNullOrEmpty(parent)) Directory.CreateDirectory(parent);
            using var writer = new StreamWriter(fullOutput, false, new UTF8Encoding(false));
            writer.WriteLine("{");
            writer.WriteLine("  \"format\": \"switch-nsc-native-database-v1\",");
            writer.WriteLine($"  \"scriptsScanned\": {scripts},");
            writer.WriteLine($"  \"uniqueDecodedValues\": {entries.Count},");
            writer.WriteLine("  \"entries\": [");
            int entryIndex = 0;
            foreach (NativeObservation entry in entries.Values.OrderByDescending(e => e.Occurrences.Count).ThenBy(e => e.Decoded))
            {
                writer.WriteLine("    {");
                writer.WriteLine($"      \"decoded\": \"0x{entry.Decoded:X16}\",");
                string name = x64nativefile != null && x64nativefile.ContainsKey(entry.Decoded) ? x64nativefile[entry.Decoded] : null;
                if (name != null) writer.WriteLine($"      \"pcTableName\": \"{EscapeJson(name)}\",");
                writer.WriteLine($"      \"occurrences\": {entry.Occurrences.Count},");
                writer.WriteLine("      \"uses\": [");
                for (int i = 0; i < entry.Occurrences.Count; i++)
                {
                    NativeOccurrence use = entry.Occurrences[i];
                    string comma = i + 1 == entry.Occurrences.Count ? "" : ",";
                    writer.WriteLine($"        {{ \"script\": \"{EscapeJson(use.Script)}\", \"index\": {use.Index}, \"stored\": \"0x{use.Stored:X16}\" }}{comma}");
                }
                writer.Write("      ]\n    }");
                writer.WriteLine(entryIndex + 1 == entries.Count ? "" : ",");
                entryIndex++;
            }
            writer.WriteLine("  ]");
            writer.WriteLine("}");
            Console.WriteLine($"Wrote {entries.Count} unique decoded native values from {scripts} scripts to {fullOutput}");
        }

        private static string EscapeJson(string value) => value.Replace("\\", "\\\\").Replace("\"", "\\\"");

        private sealed class NativeObservation
        {
            public NativeObservation(ulong decoded) { Decoded = decoded; }
            public ulong Decoded { get; }
            public List<NativeOccurrence> Occurrences { get; } = new List<NativeOccurrence>();
        }

        private sealed class NativeOccurrence
        {
            public NativeOccurrence(string script, uint index, ulong stored)
            {
                Script = script;
                Index = index;
                Stored = stored;
            }
            public string Script { get; }
            public uint Index { get; }
            public ulong Stored { get; }
        }

        private static void ScanSummary(string path, out uint codeLength, out uint nativeCount, out int calls, out int invalidCalls)
        {
            byte[] data = ReadNscPayload(path);
            if (data.Length < 0x78) throw new InvalidDataException("file is too small for a Switch NSC header");
            int codeBlocksOffset = ResourceOffset(U64(data, 0x10));
            codeLength = U32(data, 0x1c);
            nativeCount = U32(data, 0x2c);
            int blockCount = checked((int)((codeLength + 0x3fffU) / 0x4000U));
            calls = 0;
            invalidCalls = 0;
            for (int block = 0; block < blockCount; block++)
            {
                int pointerOffset = checked(codeBlocksOffset + block * 8);
                if (pointerOffset + 8 > data.Length) throw new InvalidDataException("code block table extends past file");
                int codeOffset = ResourceOffset(U64(data, pointerOffset));
                int blockLength = Math.Min(0x4000, checked((int)codeLength - block * 0x4000));
                if (codeOffset < 0 || codeOffset + blockLength > data.Length) throw new InvalidDataException("code block extends past file");
                for (int i = 0; i + 3 < blockLength;)
                {
                    int p = codeOffset + i;
                    if (data[p] == 0x2c)
                    {
                        calls++;
                        ushort index = (ushort)((data[p + 2] << 8) | data[p + 3]);
                        if (index >= nativeCount) invalidCalls++;
                    }
                    int size = SwitchOpcodeSize(data, p, blockLength - i);
                    if (size <= 0) break;
                    i += size;
                }
            }
        }

        private static void FindScriptHashReferences(string directory, string scriptName)
        {
            uint hash = Joaat(scriptName);
            Console.WriteLine($"SCRIPT_HASH {scriptName} 0x{hash:X8}");
            int total = 0;
            foreach (string path in Directory.EnumerateFiles(directory, "*.nsc", SearchOption.AllDirectories).OrderBy(p => p, StringComparer.OrdinalIgnoreCase))
            {
                byte[] data;
                try { data = ReadNscPayload(path); }
                catch (InvalidDataException) { continue; }
                var offsets = new List<int>();
                for (int i = 0; i + 4 <= data.Length; i += 4)
                {
                    if (BitConverter.ToUInt32(data, i) == hash) offsets.Add(i);
                }
                if (offsets.Count == 0) continue;
                total += offsets.Count;
                Console.WriteLine($"{Path.GetRelativePath(directory, path).Replace('\\', '/')}\t{string.Join(",", offsets.Select(o => $"0x{o:X}"))}");
            }
            Console.WriteLine($"MATCHES {total}");
        }

        private static void ValidateScriptNames(string directory)
        {
            int files = 0;
            int mismatches = 0;
            foreach (string path in Directory.EnumerateFiles(directory, "*.nsc", SearchOption.AllDirectories).OrderBy(p => p, StringComparer.OrdinalIgnoreCase))
            {
                byte[] data;
                try { data = ReadNscPayload(path); }
                catch (Exception ex) when (ex is InvalidDataException || ex is IOException)
                {
                    Console.WriteLine($"ERROR\t{Path.GetRelativePath(directory, path).Replace('\\', '/')}\t{ex.Message}");
                    mismatches++;
                    continue;
                }
                if (data.Length < 0x78) continue;
                files++;
                string fileName = Path.GetFileNameWithoutExtension(path);
                string internalName = ReadNullTerminated(data, ResourceOffset(U64(data, 0x60)));
                uint storedHash = U32(data, 0x58);
                uint expectedHash = Joaat(internalName);
                bool nameOk = string.Equals(fileName, internalName, StringComparison.OrdinalIgnoreCase);
                bool hashOk = storedHash == expectedHash;
                if (!nameOk || !hashOk)
                {
                    mismatches++;
                    Console.WriteLine($"MISMATCH\t{Path.GetRelativePath(directory, path).Replace('\\', '/')}\tinternal={internalName}\tfile={fileName}\theaderHash=0x{storedHash:X8}\texpected=0x{expectedHash:X8}");
                }
            }
            Console.WriteLine($"VALIDATED {files} files; mismatches={mismatches}");
        }

        private static void CompareNativeTables(string switchPath, string pcPath)
        {
            CompareNativeTables(ReadNscPayload(switchPath), ReadNscPayload(pcPath));
        }

        private static void CompareNativeTables(byte[] switchData, byte[] pcData)
        {
            ulong switchNativeRef = U64(switchData, 0x40);
            ulong pcNativeRef = U64(pcData, 0x40);
            uint switchCodeLength = U32(switchData, 0x1c);
            uint pcCodeLength = U32(pcData, 0x1c);
            uint switchCount = U32(switchData, 0x2c);
            uint pcCount = U32(pcData, 0x2c);
            int switchOffset = ResourceOffset(switchNativeRef);
            int pcOffset = ResourceOffset(pcNativeRef);
            var switchDecoded = new Dictionary<ulong, List<uint>>();
            for (uint i = 0; i < switchCount; i++)
            {
                ulong stored = U64(switchData, checked(switchOffset + (int)i * 8));
                ulong decoded = RotateLeft(stored, unchecked((int)(switchCodeLength + i)));
                if (!switchDecoded.TryGetValue(decoded, out List<uint> indices))
                {
                    indices = new List<uint>();
                    switchDecoded.Add(decoded, indices);
                }
                indices.Add(i);
            }
            int decodedMatches = 0;
            int directMatches = 0;
            Console.WriteLine($"SWITCH codeLength={switchCodeLength} natives={switchCount}");
            Console.WriteLine($"PC codeLength={pcCodeLength} natives={pcCount}");
            Console.WriteLine("PC_INDEX\tPC_DECODED_HASH\tPC_STORED\tSWITCH_INDEXES_AFTER_ROTATION\tDIRECT_SWITCH_INDEXES");
            for (uint i = 0; i < pcCount; i++)
            {
                ulong pcStored = U64(pcData, checked(pcOffset + (int)i * 8));
                ulong pcHash = RotateLeft(pcStored, unchecked((int)(pcCodeLength + i)));
                string decoded = switchDecoded.TryGetValue(pcHash, out List<uint> match) ? string.Join(",", match) : "";
                if (decoded.Length != 0) decodedMatches++;
                string direct = FindDirectSwitchIndices(switchData, switchOffset, switchCount, pcStored);
                if (direct.Length != 0) directMatches++;
                if (decoded.Length != 0 || direct.Length != 0)
                    Console.WriteLine($"{i}\t0x{pcHash:X16}\t0x{pcStored:X16}\t{decoded}\t{direct}");
            }
            Console.WriteLine($"ROTATION_MATCHES {decodedMatches}/{pcCount}");
            Console.WriteLine($"DIRECT_STORED_MATCHES {directMatches}/{pcCount}");
        }

        private static void WriteCrossmap(string switchPath, string pcPath, string outputPath)
        {
            byte[] switchData = ReadNscPayload(switchPath);
            byte[] pcData = ReadNscPayload(pcPath);
            uint switchCodeLength = U32(switchData, 0x1c);
            uint pcCodeLength = U32(pcData, 0x1c);
            uint switchCount = U32(switchData, 0x2c);
            uint pcCount = U32(pcData, 0x2c);
            int switchOffset = ResourceOffset(U64(switchData, 0x40));
            int pcOffset = ResourceOffset(U64(pcData, 0x40));
            var switchDecoded = new Dictionary<ulong, List<uint>>();
            for (uint i = 0; i < switchCount; i++)
            {
                ulong stored = U64(switchData, checked(switchOffset + (int)i * 8));
                ulong decoded = RotateLeft(stored, unchecked((int)(switchCodeLength + i)));
                if (!switchDecoded.TryGetValue(decoded, out List<uint> indices))
                {
                    indices = new List<uint>();
                    switchDecoded.Add(decoded, indices);
                }
                indices.Add(i);
            }

            string fullOutput = Path.GetFullPath(outputPath);
            string parent = Path.GetDirectoryName(fullOutput);
            if (!string.IsNullOrEmpty(parent)) Directory.CreateDirectory(parent);
            using var writer = new StreamWriter(fullOutput, false, new UTF8Encoding(false));
            writer.WriteLine("{");
            writer.WriteLine($"  \"switchCodeLength\": {switchCodeLength},");
            writer.WriteLine($"  \"pcCodeLength\": {pcCodeLength},");
            writer.WriteLine($"  \"switchNativeCount\": {switchCount},");
            writer.WriteLine($"  \"pcNativeCount\": {pcCount},");
            writer.WriteLine("  \"entries\": [");
            for (uint i = 0; i < pcCount; i++)
            {
                ulong pcStored = U64(pcData, checked(pcOffset + (int)i * 8));
                ulong pcHash = RotateLeft(pcStored, unchecked((int)(pcCodeLength + i)));
                bool found = switchDecoded.TryGetValue(pcHash, out List<uint> matches);
                uint? switchIndex = found ? matches![0] : null;
                ulong? switchStored = found ? U64(switchData, checked(switchOffset + (int)switchIndex!.Value * 8)) : null;
                writer.Write("    { ");
                writer.Write($"\"pcIndex\": {i}, \"pcDecodedHash\": \"0x{pcHash:X16}\", \"pcStored\": \"0x{pcStored:X16}\", ");
                if (!found)
                    writer.Write("\"switchIndices\": [], \"status\": \"unmatched\" }");
                else
                {
                    writer.Write($"\"switchIndices\": [{string.Join(", ", matches!) }], \"switchDecodedHash\": \"0x{pcHash:X16}\", \"switchStoredAtMatchedIndex\": \"0x{switchStored!.Value:X16}\", \"status\": \"matched\" }}");
                }
                if (i + 1 < pcCount) writer.Write(",");
                writer.WriteLine();
            }
            writer.WriteLine("  ]");
            writer.WriteLine("}");
            Console.WriteLine($"WROTE_CROSSMAP {fullOutput}");
        }

        private static void AdaptHeader(string switchPath, string candidatePath, string outputPath)
        {
            byte[] switchData = ReadNscPayload(switchPath);
            byte[] candidateContainer = File.ReadAllBytes(candidatePath);
            bool candidateHasRscHeader = candidateContainer.Length >= 16 && U32(candidateContainer, 0) == 0x37435352;
            byte[] candidate = ReadNscPayload(candidateContainer, candidatePath);
            if (switchData.Length < 0x20 || candidate.Length < 0x78)
                throw new InvalidDataException("resource is too small for a GTA V script header");

            ulong switchPageBase = U64(switchData, 0);
            uint switchUnknown2 = U32(switchData, 0x18);
            WriteU64(candidate, 0, switchPageBase);
            WriteU32(candidate, 0x18, switchUnknown2);

            string fullOutput = Path.GetFullPath(outputPath);
            string parent = Path.GetDirectoryName(fullOutput);
            if (!string.IsNullOrEmpty(parent)) Directory.CreateDirectory(parent);
            byte[] output = candidateHasRscHeader
                ? candidateContainer.Take(16).Concat(candidate).ToArray()
                : candidate;
            File.WriteAllBytes(fullOutput, output);
            Console.WriteLine($"WROTE_ADAPTED_HEADER {fullOutput}");
            Console.WriteLine($"PAGE_BASE 0x{switchPageBase:X16}");
            Console.WriteLine($"UNKNOWN2 0x{switchUnknown2:X8}");
            Console.WriteLine("NOTE native tables and code were preserved; inspect and compare before packaging");
        }

        private static string FindDirectSwitchIndices(byte[] data, int offset, uint count, ulong value)
        {
            var matches = new List<uint>();
            for (uint i = 0; i < count; i++)
                if (U64(data, checked(offset + (int)i * 8)) == value) matches.Add(i);
            return string.Join(",", matches);
        }

        private static byte[] ReadNscPayload(byte[] data, string sourceName)
        {
            if (data.Length >= 18 && U32(data, 0) == 0x37435352)
            {
                if (IsUncompressedResource(data)) return data.Skip(16).ToArray();
                using var input = new MemoryStream(data, 16, data.Length - 16, false);
                using var deflate = new DeflateStream(input, CompressionMode.Decompress);
                using var output = new MemoryStream();
                deflate.CopyTo(output);
                return output.ToArray();
            }
            return data;
        }

        private static uint Joaat(string value)
        {
            uint hash = 0;
            foreach (byte b in Encoding.ASCII.GetBytes(value.ToLowerInvariant()))
            {
                hash += b;
                hash += hash << 10;
                hash ^= hash >> 6;
            }
            hash += hash << 3;
            hash ^= hash >> 11;
            hash += hash << 15;
            return hash;
        }

        private static ulong U64(byte[] data, int offset) => BitConverter.ToUInt64(data, offset);
        private static uint U32(byte[] data, int offset) => BitConverter.ToUInt32(data, offset);
        private static void WriteU64(byte[] data, int offset, ulong value) => Buffer.BlockCopy(BitConverter.GetBytes(value), 0, data, offset, 8);
        private static void WriteU32(byte[] data, int offset, uint value) => Buffer.BlockCopy(BitConverter.GetBytes(value), 0, data, offset, 4);

        private static byte[] ReadNscPayload(string path)
        {
            byte[] data = File.ReadAllBytes(path);
            if (data.Length >= 18 && U32(data, 0) == 0x37435352)
            {
                if (IsUncompressedResource(data)) return data.Skip(16).ToArray();
                using var input = new MemoryStream(data, 16, data.Length - 16, false);
                using var deflate = new DeflateStream(input, CompressionMode.Decompress);
                using var output = new MemoryStream();
                deflate.CopyTo(output);
                return output.ToArray();
            }
            return data;
        }

        private static bool IsUncompressedResource(byte[] data)
        {
                        if (data.Length < 24) return false;
            ulong firstValue = U64(data, 16);
            return firstValue >= 0x0000700000000000UL && firstValue < 0x0000800000000000UL;
        }
        private static int ResourceOffset(ulong value)
        {
            // Switch script pointers use a 0x50000000 resource tag and a 24-bit file offset.
            ulong offset = value & 0x00ffffffUL;
            if (offset > int.MaxValue) throw new InvalidDataException("resource pointer is out of range");
            return (int)offset;
        }

        private static void DumpSwitchResource(string path)
        {
            byte[] data = ReadNscPayload(path);
            if (data.Length < 0x78) throw new InvalidDataException("file is too small for a Switch NSC header");

            ulong codeBlocksRef = U64(data, 0x10);
            uint codeLength = U32(data, 0x1c);
            uint parameters = U32(data, 0x20);
            uint statics = U32(data, 0x24);
            uint globals = U32(data, 0x28);
            uint nativeCount = U32(data, 0x2c);
            ulong nativeRef = U64(data, 0x40);
            ulong scriptNameRef = U64(data, 0x60);
            ulong stringsRef = U64(data, 0x68);
            uint stringsSize = U32(data, 0x70);

            int codeBlocksOffset = ResourceOffset(codeBlocksRef);
            int nativeOffset = ResourceOffset(nativeRef);
            int scriptNameOffset = ResourceOffset(scriptNameRef);
            int stringsOffset = ResourceOffset(stringsRef);
            int blockCount = (int)((codeLength + 0x3fffU) / 0x4000U);

            string scriptName = ReadNullTerminated(data, scriptNameOffset);
            Console.WriteLine("SCRIPT " + scriptName);
            Console.WriteLine($"CODE_LENGTH {codeLength}");
            Console.WriteLine($"CODE_BLOCKS {blockCount}");
            Console.WriteLine($"NATIVES {nativeCount}");
            Console.WriteLine($"PARAMETERS {parameters}");
            Console.WriteLine($"STATICS {statics}");
            Console.WriteLine($"GLOBALS {globals}");
            Console.WriteLine($"STRINGS offset=0x{stringsOffset:X} size={stringsSize}");
            Console.WriteLine("NATIVE_TABLE_8BYTE");
            for (uint i = 0; i < nativeCount; i++)
            {
                int offset = checked(nativeOffset + (int)i * 8);
                if (offset + 8 > data.Length) throw new InvalidDataException("native table extends past file");
                ulong stored = U64(data, offset);
                ulong decoded = RotateLeft(stored, unchecked((int)(codeLength + i)));
                decoded = x64nativefile.TranslateHash(decoded);
                string name = x64nativefile.ContainsKey(decoded) ? x64nativefile[decoded] : "<unmapped>";
                Console.WriteLine($"{i:X4}: {Convert.ToHexString(data, offset, 8)} => {decoded:X16} {name}");
            }

            Console.WriteLine("CALL_NATIVE_SITES");
            for (int block = 0; block < blockCount; block++)
            {
                int pointerOffset = checked(codeBlocksOffset + block * 8);
                int codeOffset = ResourceOffset(U64(data, pointerOffset));
                int blockLength = Math.Min(0x4000, checked((int)codeLength - block * 0x4000));
                for (int i = 0; i + 3 < blockLength;)
                {
                    int p = codeOffset + i;
                    if (data[p] == 0x2c)
                    {
                        byte signature = data[p + 1];
                        // The Switch bytecode keeps the opcode/signature bytes in the same
                        // order as the legacy format, but stores the 16-bit native index
                        // big-endian (e.g. 00 04 means table entry 4).
                        ushort index = (ushort)((data[p + 2] << 8) | data[p + 3]);
                        int parameterCount = signature >> 2;
                        int returnCount = signature & 3;
                        string validity = index < nativeCount ? "" : " INVALID_INDEX";
                        Console.WriteLine($"block={block} offset=0x{(block * 0x4000 + i):X} params={parameterCount} returns={returnCount} native={index}{validity}");
                    }
                    int size = SwitchOpcodeSize(data, p, blockLength - i);
                    if (size <= 0) break;
                    i += size;
                }
            }
        }

        private static ulong RotateLeft(ulong value, int amount)
        {
            amount &= 63;
            return amount == 0 ? value : (value << amount) | (value >> (64 - amount));
        }

        private static ulong RotateRight(ulong value, int amount)
        {
            amount &= 63;
            return amount == 0 ? value : (value >> amount) | (value << (64 - amount));
        }

        private static int SwitchOpcodeSize(byte[] data, int offset, int remaining)
        {
            if (remaining <= 0) return 0;
            byte op = data[offset];
            if (op <= 36 || (op >= 42 && op <= 43) || (op >= 100 && op <= 126)) return 1;
            if (op == 37) return remaining >= 2 ? 2 : 0;
            if (op == 38) return remaining >= 3 ? 3 : 0;
            if (op == 39 || op == 40 || op == 41) return remaining >= 5 ? 5 : 0;
            if (op == 44) return remaining >= 4 ? 4 : 0;
            if (op == 45) return remaining >= 5 ? 5 + data[offset + 4] : 0;
            if (op == 46) return remaining >= 3 ? 3 : 0;
            if (op == 63) return 1; // GetImmP (stack form)
            if (op >= 52 && op <= 62) return remaining >= 2 ? 2 : 0;
            if (op >= 64 && op <= 66) return remaining >= 2 ? 2 : 0;
            if (op == 67) return remaining >= 3 ? 3 : 0;
            if (op >= 68 && op <= 69) return remaining >= 3 ? 3 : 0;
            if (op >= 70 && op <= 84) return remaining >= 3 ? 3 : 0;
            if (op >= 85 && op <= 92) return remaining >= 3 ? 3 : 0;
            if (op >= 93 && op <= 97) return remaining >= 4 ? 4 : 0;
            if (op == 98)
            {
                if (remaining < 2) return 0;
                int cases = data[offset + 1];
                return 2 + cases * 6;
            }
            if (op == 99) return remaining >= 4 ? 4 : 0;
            // 0x27/0x28/0x29 are variable-size immediates handled above;
            // anything else is an unclassified opcode, so stop rather than
            // accidentally treating data bytes as instructions.
            return 1;
        }

        private static string ReadNullTerminated(byte[] data, int offset)
        {
            if (offset < 0 || offset >= data.Length) return "<invalid>";
            int end = offset;
            while (end < data.Length && data[end] != 0) end++;
            return Encoding.UTF8.GetString(data, offset, end - offset);
        }
    }
}

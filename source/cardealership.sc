// *****************************************************************************************
// *****************************************************************************************
//
//      SCRIPT NAME     :   cardealership.sc
//      TITLE           :   Modern Car Dealership-NX (Standalone Nintendo Switch Script)
//      AUTHOR          :   Geekmaxxer & Antigravity
//      DESCRIPTION     :   Interactive physical car showroom at Premium Deluxe Motorsport.
//                          5 showroom pedestals with 25 swappable luxury/sports/supercars,
//                          walk-up inspection card with stats & pricing, live paint preview,
//                          2-minute test drives with auto-return, and full Single-Player
//                          cash purchase with outdoor delivery bay spawning.
//                          Zero memory leaks with distance-based interior/vehicle lifecycle.
//
// *****************************************************************************************
// *****************************************************************************************

USING "rage_builtins.sch"
USING "commands_script.sch"
USING "commands_pad.sch"
USING "commands_graphics.sch"
USING "commands_hud.sch"
USING "commands_player.sch"
USING "commands_entity.sch"
USING "commands_ped.sch"
USING "commands_weapon.sch"
USING "commands_law.sch"
USING "commands_vehicle.sch"
USING "commands_audio.sch"
USING "commands_clock.sch"
USING "commands_misc.sch"
USING "commands_camera.sch"
USING "commands_streaming.sch"
USING "commands_task.sch"
USING "commands_interiors.sch"
USING "commands_stats.sch"
USING "stats_enums.sch"
USING "commands_object.sch"

// -------------------------------------------------------------------------
// CONSTANTS (Matches RageMenu core_constants.sch 1:1)
// -------------------------------------------------------------------------
CONST_INT NUM_SHOWROOM_SLOTS            5
CONST_INT NUM_MODELS_PER_SLOT           5
CONST_INT NUM_SHOWROOM_PAINTS           16
CONST_INT TEST_DRIVE_DURATION_MS        120000
CONST_INT DEALER_MENU_ROWS              8

CONST_FLOAT DEALER_MENU_W               0.250
CONST_FLOAT DEALER_MENU_TOP             0.150
CONST_FLOAT DEALER_ROW_H                0.038
CONST_FLOAT DEALER_MENU_X               0.830

// -------------------------------------------------------------------------
// SCRIPT STATE GLOBALS
// -------------------------------------------------------------------------
BLIP_INDEX g_dealer_map_blip
BLIP_INDEX g_dealer_delivery_blip
INTERIOR_INSTANCE_INDEX g_dealer_interior_id = NULL

VEHICLE_INDEX g_dealer_showroom_vehs[5]
INT g_dealer_slot_model[5]
INT g_dealer_slot_paint[5]

BOOL g_dealer_in_range                  = FALSE
BOOL g_dealer_test_drive_active         = FALSE
INT g_dealer_test_drive_end             = 0
VEHICLE_INDEX g_dealer_test_veh         = NULL
VEHICLE_INDEX g_dealer_purchased_veh    = NULL
INT g_dealer_test_slot                  = 0

INT g_dealer_selected_slot              = -1
INT g_dealer_menu_item                  = 0
INT g_dealer_input_cooldown             = 0
INT g_dealer_exit_cooldown              = 0
INT g_dealer_dpad_down_guard_until      = 0

// Curated showroom paint colors (Classic & Metallic palette)
FUNC INT DEALER_GET_PAINT_COLOR(INT index)
    SWITCH index
        CASE 0 RETURN 0 BREAK
        CASE 1 RETURN 1 BREAK
        CASE 2 RETURN 4 BREAK
        CASE 3 RETURN 5 BREAK
        CASE 4 RETURN 27 BREAK
        CASE 5 RETURN 28 BREAK
        CASE 6 RETURN 38 BREAK
        CASE 7 RETURN 49 BREAK
        CASE 8 RETURN 64 BREAK
        CASE 9 RETURN 70 BREAK
        CASE 10 RETURN 73 BREAK
        CASE 11 RETURN 88 BREAK
        CASE 12 RETURN 89 BREAK
        CASE 13 RETURN 92 BREAK
        CASE 14 RETURN 111 BREAK
        CASE 15 RETURN 112 BREAK
    ENDSWITCH
    RETURN 0
ENDFUNC

FUNC STRING DEALER_GET_PAINT_NAME(INT index)
    SWITCH index
        CASE 0 RETURN "Classic Black" BREAK
        CASE 1 RETURN "Graphite Black" BREAK
        CASE 2 RETURN "Metallic Silver" BREAK
        CASE 3 RETURN "Blue Silver" BREAK
        CASE 4 RETURN "Classic Red" BREAK
        CASE 5 RETURN "Torino Red" BREAK
        CASE 6 RETURN "Sunrise Orange" BREAK
        CASE 7 RETURN "Dark Green" BREAK
        CASE 8 RETURN "Midnight Blue" BREAK
        CASE 9 RETURN "Bright Blue" BREAK
        CASE 10 RETURN "Ultra Blue" BREAK
        CASE 11 RETURN "Race Yellow" BREAK
        CASE 12 RETURN "Dew Yellow" BREAK
        CASE 13 RETURN "Lime Green" BREAK
        CASE 14 RETURN "Classic White" BREAK
        CASE 15 RETURN "Frost White" BREAK
    ENDSWITCH
    RETURN "Custom Paint"
ENDFUNC

// -------------------------------------------------------------------------
// VEHICLE CATALOG DATA (25 High-End Vehicles Across 5 Categories)
// -------------------------------------------------------------------------
FUNC MODEL_NAMES DEALER_GET_MODEL(INT slot, INT choice)
    SWITCH slot
        // Slot 0: Centerstage Hypercars
        CASE 0
            SWITCH choice
                CASE 0 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("adder")) BREAK
                CASE 1 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("zentorno")) BREAK
                CASE 2 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("cheetah")) BREAK
                CASE 3 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("entityxf")) BREAK
                CASE 4 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("t20")) BREAK
            ENDSWITCH
        BREAK

        // Slot 1: Exotic Supercars
        CASE 1
            SWITCH choice
                CASE 0 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("turismor")) BREAK
                CASE 1 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("infernus")) BREAK
                CASE 2 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("vacca")) BREAK
                CASE 3 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("bullet")) BREAK
                CASE 4 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("reaper")) BREAK
            ENDSWITCH
        BREAK

        // Slot 2: Sports & Tuners
        CASE 2
            SWITCH choice
                CASE 0 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("comet2")) BREAK
                CASE 1 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("elegy2")) BREAK
                CASE 2 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("massacro")) BREAK
                CASE 3 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("jester")) BREAK
                CASE 4 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("feltzer2")) BREAK
            ENDSWITCH
        BREAK

        // Slot 3: Luxury Executive Sedans & GTs
        CASE 3
            SWITCH choice
                CASE 0 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("exemplar")) BREAK
                CASE 1 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("tailgater")) BREAK
                CASE 2 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("schafter2")) BREAK
                CASE 3 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("windsor")) BREAK
                CASE 4 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("superd")) BREAK
            ENDSWITCH
        BREAK

        // Slot 4: Performance Luxury SUVs & 4x4s
        CASE 4
            SWITCH choice
                CASE 0 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("huntley")) BREAK
                CASE 1 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("toros")) BREAK
                CASE 2 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("dubsta")) BREAK
                CASE 3 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("baller2")) BREAK
                CASE 4 RETURN INT_TO_ENUM(MODEL_NAMES, HASH("xls")) BREAK
            ENDSWITCH
        BREAK
    ENDSWITCH
    RETURN INT_TO_ENUM(MODEL_NAMES, HASH("adder"))
ENDFUNC

FUNC STRING DEALER_GET_NAME(INT slot, INT choice)
    SWITCH slot
        CASE 0
            SWITCH choice
                CASE 0 RETURN "Truffade Adder" BREAK
                CASE 1 RETURN "Pegassi Zentorno" BREAK
                CASE 2 RETURN "Grotti Cheetah" BREAK
                CASE 3 RETURN "Overflod Entity XF" BREAK
                CASE 4 RETURN "Progen T20" BREAK
            ENDSWITCH
        BREAK
        CASE 1
            SWITCH choice
                CASE 0 RETURN "Grotti Turismo R" BREAK
                CASE 1 RETURN "Pegassi Infernus" BREAK
                CASE 2 RETURN "Pegassi Vacca" BREAK
                CASE 3 RETURN "Vapid Bullet" BREAK
                CASE 4 RETURN "Pegassi Reaper" BREAK
            ENDSWITCH
        BREAK
        CASE 2
            SWITCH choice
                CASE 0 RETURN "Pfister Comet" BREAK
                CASE 1 RETURN "Annis Elegy RH8" BREAK
                CASE 2 RETURN "Dewbauchee Massacro" BREAK
                CASE 3 RETURN "Dinka Jester" BREAK
                CASE 4 RETURN "Benefactor Feltzer" BREAK
            ENDSWITCH
        BREAK
        CASE 3
            SWITCH choice
                CASE 0 RETURN "Dewbauchee Exemplar" BREAK
                CASE 1 RETURN "Obey Tailgater" BREAK
                CASE 2 RETURN "Benefactor Schafter" BREAK
                CASE 3 RETURN "Enus Windsor" BREAK
                CASE 4 RETURN "Enus Super Diamond" BREAK
            ENDSWITCH
        BREAK
        CASE 4
            SWITCH choice
                CASE 0 RETURN "Enus Huntley S" BREAK
                CASE 1 RETURN "Pegassi Toros" BREAK
                CASE 2 RETURN "Benefactor Dubsta" BREAK
                CASE 3 RETURN "Gallivanter Baller" BREAK
                CASE 4 RETURN "Benefactor XLS" BREAK
            ENDSWITCH
        BREAK
    ENDSWITCH
    RETURN "Showroom Vehicle"
ENDFUNC

FUNC STRING DEALER_GET_CLASS(INT slot)
    SWITCH slot
        CASE 0 RETURN "Hypercar" BREAK
        CASE 1 RETURN "Super" BREAK
        CASE 2 RETURN "Sports" BREAK
        CASE 3 RETURN "Luxury Sedan" BREAK
        CASE 4 RETURN "Luxury SUV" BREAK
    ENDSWITCH
    RETURN "Exotic"
ENDFUNC

FUNC STRING DEALER_GET_SPEED(INT slot, INT choice)
    SWITCH slot
        CASE 0
            SWITCH choice
                CASE 0 RETURN "250 mph" BREAK
                CASE 1 RETURN "240 mph" BREAK
                CASE 2 RETURN "230 mph" BREAK
                CASE 3 RETURN "245 mph" BREAK
                CASE 4 RETURN "255 mph" BREAK
            ENDSWITCH
        BREAK
        CASE 1
            SWITCH choice
                CASE 0 RETURN "235 mph" BREAK
                CASE 1 RETURN "230 mph" BREAK
                CASE 2 RETURN "220 mph" BREAK
                CASE 3 RETURN "215 mph" BREAK
                CASE 4 RETURN "240 mph" BREAK
            ENDSWITCH
        BREAK
        CASE 2
            SWITCH choice
                CASE 0 RETURN "210 mph" BREAK
                CASE 1 RETURN "215 mph" BREAK
                CASE 2 RETURN "225 mph" BREAK
                CASE 3 RETURN "220 mph" BREAK
                CASE 4 RETURN "205 mph" BREAK
            ENDSWITCH
        BREAK
        CASE 3
            SWITCH choice
                CASE 0 RETURN "195 mph" BREAK
                CASE 1 RETURN "180 mph" BREAK
                CASE 2 RETURN "185 mph" BREAK
                CASE 3 RETURN "190 mph" BREAK
                CASE 4 RETURN "180 mph" BREAK
            ENDSWITCH
        BREAK
        CASE 4
            SWITCH choice
                CASE 0 RETURN "185 mph" BREAK
                CASE 1 RETURN "210 mph" BREAK
                CASE 2 RETURN "175 mph" BREAK
                CASE 3 RETURN "180 mph" BREAK
                CASE 4 RETURN "180 mph" BREAK
            ENDSWITCH
        BREAK
    ENDSWITCH
    RETURN "200 mph"
ENDFUNC

FUNC INT DEALER_GET_PRICE(INT slot, INT choice)
    SWITCH slot
        CASE 0
            SWITCH choice
                CASE 0 RETURN 1000000 BREAK
                CASE 1 RETURN 725000 BREAK
                CASE 2 RETURN 650000 BREAK
                CASE 3 RETURN 795000 BREAK
                CASE 4 RETURN 2200000 BREAK
            ENDSWITCH
        BREAK
        CASE 1
            SWITCH choice
                CASE 0 RETURN 500000 BREAK
                CASE 1 RETURN 440000 BREAK
                CASE 2 RETURN 240000 BREAK
                CASE 3 RETURN 155000 BREAK
                CASE 4 RETURN 1595000 BREAK
            ENDSWITCH
        BREAK
        CASE 2
            SWITCH choice
                CASE 0 RETURN 85000 BREAK
                CASE 1 RETURN 95000 BREAK
                CASE 2 RETURN 275000 BREAK
                CASE 3 RETURN 240000 BREAK
                CASE 4 RETURN 145000 BREAK
            ENDSWITCH
        BREAK
        CASE 3
            SWITCH choice
                CASE 0 RETURN 205000 BREAK
                CASE 1 RETURN 55000 BREAK
                CASE 2 RETURN 116000 BREAK
                CASE 3 RETURN 845000 BREAK
                CASE 4 RETURN 250000 BREAK
            ENDSWITCH
        BREAK
        CASE 4
            SWITCH choice
                CASE 0 RETURN 195000 BREAK
                CASE 1 RETURN 498000 BREAK
                CASE 2 RETURN 125000 BREAK
                CASE 3 RETURN 90000 BREAK
                CASE 4 RETURN 253000 BREAK
            ENDSWITCH
        BREAK
    ENDSWITCH
    RETURN 100000
ENDFUNC

// -------------------------------------------------------------------------
// SHOWROOM PEDESTAL COORDINATES & HEADINGS
// -------------------------------------------------------------------------
FUNC VECTOR DEALER_GET_SLOT_COORDS(INT slot)
    SWITCH slot
        CASE 0 RETURN <<-40.0875, -1104.3572, 25.4223>> BREAK
        CASE 1 RETURN <<-47.0216, -1101.9651, 25.4223>> BREAK
        CASE 2 RETURN <<-51.5186, -1095.6345, 25.4223>> BREAK
        CASE 3 RETURN <<-46.1276, -1093.3507, 25.4223>> BREAK
        CASE 4 RETURN <<-41.0003, -1095.0573, 25.4223>> BREAK
    ENDSWITCH
    RETURN <<-40.0875, -1104.3572, 25.4223>>
ENDFUNC

FUNC FLOAT DEALER_GET_SLOT_HEADING(INT slot)
    SWITCH slot
        CASE 0 RETURN 354.9994 BREAK
        CASE 1 RETURN 308.1984 BREAK
        CASE 2 RETURN 241.5996 BREAK
        CASE 3 RETURN 208.4002 BREAK
        CASE 4 RETURN 214.6002 BREAK
    ENDSWITCH
    RETURN 0.0
ENDFUNC

// -------------------------------------------------------------------------
// SP CASH MANAGEMENT (Franklin, Michael, Trevor)
// -------------------------------------------------------------------------
FUNC INT DEALER_GET_PLAYER_CASH(PED_INDEX pPed)
    INT cash = 0
    SWITCH GET_ENTITY_MODEL(pPed)
        CASE PLAYER_ZERO
            STAT_GET_INT(SP0_TOTAL_CASH, cash)
        BREAK
        CASE PLAYER_ONE
            STAT_GET_INT(SP1_TOTAL_CASH, cash)
        BREAK
        CASE PLAYER_TWO
            STAT_GET_INT(SP2_TOTAL_CASH, cash)
        BREAK
    ENDSWITCH
    RETURN cash
ENDFUNC

PROC DEALER_DEDUCT_PLAYER_CASH(PED_INDEX pPed, INT amount)
    INT cash = DEALER_GET_PLAYER_CASH(pPed)
    IF cash >= amount
        cash = cash - amount
        SWITCH GET_ENTITY_MODEL(pPed)
            CASE PLAYER_ZERO
                STAT_SET_INT(SP0_TOTAL_CASH, cash)
            BREAK
            CASE PLAYER_ONE
                STAT_SET_INT(SP1_TOTAL_CASH, cash)
            BREAK
            CASE PLAYER_TWO
                STAT_SET_INT(SP2_TOTAL_CASH, cash)
            BREAK
        ENDSWITCH
    ENDIF
ENDPROC

// -------------------------------------------------------------------------
// UI & NOTIFICATION HELPERS (1:1 RageMenu core_menu.sch Layout & Scales)
// -------------------------------------------------------------------------
PROC DEALER_SHOW_NOTIFICATION(STRING text)
    BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
    END_TEXT_COMMAND_THEFEED_POST_TICKER(TRUE, FALSE)
ENDPROC

PROC DEALER_MENU_TEXT(FLOAT x, FLOAT y, FLOAT scale, INT r, INT g, INT b, STRING value)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(scale, scale)
    SET_TEXT_COLOUR(r, g, b, 255)
    SET_TEXT_WRAP(0.0, 1.0)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(value)
    END_TEXT_COMMAND_DISPLAY_TEXT(x, y)
ENDPROC

PROC DEALER_MENU_TEXT_RIGHT(FLOAT x, FLOAT y, FLOAT scale, INT r, INT g, INT b, STRING value)
    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(scale, scale)
    SET_TEXT_COLOUR(r, g, b, 255)
    SET_TEXT_WRAP(0.0, x)
    SET_TEXT_RIGHT_JUSTIFY(TRUE)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 190)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(value)
    END_TEXT_COMMAND_DISPLAY_TEXT(x, y)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
ENDPROC

PROC DEALER_DRAW_OPTION(FLOAT y, STRING label, STRING value, BOOL selected, INT state)
    INT rr = 20
    INT gg = 22
    INT bb = 26
    IF selected
        IF state = 0
            rr = 162
            gg = 50
            bb = 55
        ELIF state = 1
            rr = 27
            gg = 142
            bb = 82
        ELSE
            rr = 31
            gg = 100
            bb = 190
        ENDIF
    ENDIF
    DRAW_RECT(DEALER_MENU_X - 0.015, y, DEALER_MENU_W - 0.012, DEALER_ROW_H - 0.002, rr, gg, bb, 238)
    DEALER_MENU_TEXT(DEALER_MENU_X - 0.130, y - 0.012, 0.315, 255, 255, 255, label)
    IF state = 0
        DEALER_MENU_TEXT_RIGHT(DEALER_MENU_X + 0.086, y - 0.012, 0.290, 255, 100, 100, value)
    ELIF state = 1
        DEALER_MENU_TEXT_RIGHT(DEALER_MENU_X + 0.086, y - 0.012, 0.290, 95, 245, 150, value)
    ELSE
        DEALER_MENU_TEXT_RIGHT(DEALER_MENU_X + 0.086, y - 0.012, 0.290, 210, 230, 255, value)
    ENDIF
ENDPROC

FUNC STRING DEALER_GET_ROW_DESCRIPTION(INT row)
    SWITCH row
        CASE 0 RETURN "D-Pad Left/Right swaps the showroom model. Press A to buy." BREAK
        CASE 1 RETURN "D-Pad Left/Right previews 16 factory and metallic paint finishes." BREAK
        CASE 2 RETURN "Showroom pedestal vehicle class and model index." BREAK
        CASE 3 RETURN "Estimated top speed for this showroom model." BREAK
        CASE 4 RETURN "Showroom purchase price for this vehicle." BREAK
        CASE 5 RETURN "Available cash in your current character's bank account." BREAK
        CASE 6 RETURN "Press A to purchase this vehicle and deliver it outside." BREAK
        CASE 7 RETURN "Press A or X to test drive outside for 2 minutes. B exits." BREAK
    ENDSWITCH
    RETURN "D-Pad Up/Down moves cursor. Left/Right adjusts. B exits."
ENDFUNC

PROC DEALER_DRAW_INSPECTION_CARD(INT slot, PED_INDEX playerPed)
    // Hide Dealership UI while RageMenu is open so the two menus never overlap
    IF NOT IS_CONTROL_ENABLED(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN)
        EXIT
    ENDIF

    INT modelChoice = g_dealer_slot_model[slot]
    INT paintChoice = g_dealer_slot_paint[slot]
    STRING vehName = DEALER_GET_NAME(slot, modelChoice)
    STRING vehClass = DEALER_GET_CLASS(slot)
    STRING vehSpeed = DEALER_GET_SPEED(slot, modelChoice)
    STRING paintName = DEALER_GET_PAINT_NAME(paintChoice)
    INT vehPrice = DEALER_GET_PRICE(slot, modelChoice)
    INT playerCash = DEALER_GET_PLAYER_CASH(playerPed)
    INT priceState = 0
    STRING buyValue = "LOW FUNDS"

    IF playerCash >= vehPrice
        priceState = 1
        buyValue = "APPLY"
    ENDIF

    TEXT_LABEL_63 slotTag = "SLOT "
    slotTag += (slot + 1)
    slotTag += " / 5"

    TEXT_LABEL_63 modelSelector = "< "
    modelSelector += vehName
    modelSelector += " >"

    TEXT_LABEL_63 paintSelector = "< "
    paintSelector += paintName
    paintSelector += " >"

    TEXT_LABEL_63 classValue = vehClass
    classValue += " ("
    classValue += (modelChoice + 1)
    classValue += "/5)"

    TEXT_LABEL_63 priceValue = "$"
    priceValue += vehPrice

    TEXT_LABEL_63 cashValue = "$"
    cashValue += playerCash

    TEXT_LABEL_63 tlCounter = ""
    tlCounter += (g_dealer_menu_item + 1)
    tlCounter += " / "
    tlCounter += DEALER_MENU_ROWS

    // 1. Menu Backdrop (Matches DRAW_MENU_BACKDROP in core_menu.sch 1:1)
    DRAW_RECT(DEALER_MENU_X - 0.015, 0.403, DEALER_MENU_W, 0.505, 8, 9, 12, 220)

    // 2. Top Accent Header & Black Subheader Strip (Matches DRAW_HOME in features_main.sch 1:1)
    DRAW_RECT(DEALER_MENU_X - 0.015, DEALER_MENU_TOP, DEALER_MENU_W, 0.102, 31, 100, 190, 255)
    DRAW_RECT(DEALER_MENU_X - 0.015, 0.210, DEALER_MENU_W, 0.035, 0, 0, 0, 255)

    SET_TEXT_FONT(FONT_CURSIVE)
    SET_TEXT_SCALE(1.050, 1.050)
    SET_TEXT_COLOUR(255, 255, 255, 255)
    SET_TEXT_WRAP(0.0, 1.0)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("Simeon's")
    END_TEXT_COMMAND_DISPLAY_TEXT(DEALER_MENU_X - 0.072, 0.100)

    DEALER_MENU_TEXT(DEALER_MENU_X - 0.085, 0.158, 0.390, 255, 255, 255, "Premium Deluxe")
    DEALER_MENU_TEXT(DEALER_MENU_X - 0.130, 0.198, 0.270, 255, 255, 255, "SHOWROOM")
    DEALER_MENU_TEXT_RIGHT(DEALER_MENU_X + 0.105, 0.198, 0.270, 255, 255, 255, slotTag)

    // 3. 8 Option Rows (y = 0.268 .. 0.534, spacing 0.038, identical to RageMenu)
    DEALER_DRAW_OPTION(0.268, "Vehicle:",        modelSelector, g_dealer_menu_item = 0, 2)
    DEALER_DRAW_OPTION(0.306, "Paint:",          paintSelector, g_dealer_menu_item = 1, 2)
    DEALER_DRAW_OPTION(0.344, "Category",        classValue,    g_dealer_menu_item = 2, 2)
    DEALER_DRAW_OPTION(0.382, "Top Speed",       vehSpeed,      g_dealer_menu_item = 3, 2)
    DEALER_DRAW_OPTION(0.420, "Price",           priceValue,    g_dealer_menu_item = 4, priceState)
    DEALER_DRAW_OPTION(0.458, "Your Cash",       cashValue,     g_dealer_menu_item = 5, 2)
    DEALER_DRAW_OPTION(0.496, "Buy Vehicle",     buyValue,      g_dealer_menu_item = 6, priceState)
    DEALER_DRAW_OPTION(0.534, "Test Drive (2m)", "APPLY",       g_dealer_menu_item = 7, 2)

    // 4. Page Counter ("1 / 8" at bottom-right above description box)
    DEALER_MENU_TEXT_RIGHT(DEALER_MENU_X + 0.105, 0.556, 0.270, 31, 100, 190, tlCounter)

    // 5. Divider & Description Panel (Matches DRAW_DESCRIPTION_PANEL in core_menu.sch 1:1)
    DRAW_RECT(DEALER_MENU_X - 0.015, 0.578, DEALER_MENU_W - 0.012, 0.002, 100, 108, 118, 220)
    DRAW_RECT(DEALER_MENU_X - 0.015, 0.593 + (0.054 / 2.0), DEALER_MENU_W - 0.012, 0.054, 8, 9, 12, 205)

    SET_TEXT_FONT(FONT_STANDARD)
    SET_TEXT_SCALE(0.300, 0.300)
    SET_TEXT_COLOUR(205, 212, 220, 255)
    SET_TEXT_WRAP(DEALER_MENU_X - 0.130, DEALER_MENU_X + 0.105)
    SET_TEXT_RIGHT_JUSTIFY(FALSE)
    SET_TEXT_DROPSHADOW(1, 0, 0, 0, 150)
    BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(DEALER_GET_ROW_DESCRIPTION(g_dealer_menu_item))
    END_TEXT_COMMAND_DISPLAY_TEXT(DEALER_MENU_X - 0.130, 0.594)
ENDPROC

PROC DEALER_DRAW_TEST_DRIVE_HUD(INT slot, INT minutes, INT seconds, PED_INDEX playerPed)
    IF NOT IS_CONTROL_ENABLED(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN)
        EXIT
    ENDIF

    INT modelChoice = g_dealer_slot_model[slot]
    STRING vehName = DEALER_GET_NAME(slot, modelChoice)
    INT vehPrice = DEALER_GET_PRICE(slot, modelChoice)
    INT playerCash = DEALER_GET_PLAYER_CASH(playerPed)
    INT buyState = 0
    IF playerCash >= vehPrice
        buyState = 1
    ENDIF

    TEXT_LABEL_63 timerTag = "0"
    timerTag += minutes
    timerTag += ":"
    IF seconds < 10
        timerTag += "0"
    ENDIF
    timerTag += seconds

    TEXT_LABEL_63 buyLabel = "Buy ($"
    buyLabel += vehPrice
    buyLabel += ")"

    // Compact 3-row RageMenu-styled Test Drive status panel
    DRAW_RECT(DEALER_MENU_X - 0.015, 0.273, DEALER_MENU_W, 0.165, 8, 9, 12, 220)
    DRAW_RECT(DEALER_MENU_X - 0.015, 0.210, DEALER_MENU_W, 0.035, 31, 100, 190, 255)
    DEALER_MENU_TEXT(DEALER_MENU_X - 0.130, 0.198, 0.270, 255, 255, 255, "TEST DRIVE")
    DEALER_MENU_TEXT_RIGHT(DEALER_MENU_X + 0.105, 0.198, 0.270, 255, 255, 255, timerTag)

    DEALER_DRAW_OPTION(0.254, "Vehicle",         vehName,      FALSE, 2)
    DEALER_DRAW_OPTION(0.292, buyLabel,          "LB + Right", FALSE, buyState)
    DEALER_DRAW_OPTION(0.330, "Return Showroom", "LB + Left",  FALSE, 2)
ENDPROC

PROC DEALER_SUPPRESS_INSPECTION_CONTROLS()
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_JUMP, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_PHONE, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_PHONE, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CELLPHONE_UP, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CELLPHONE_UP, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CELLPHONE_DOWN, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CELLPHONE_DOWN, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CHARACTER_WHEEL, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_ENTER, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_ENTER, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_EXIT, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_VEH_EXIT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CONTEXT, TRUE)
    DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CONTEXT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_MELEE_ATTACK_LIGHT, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_MELEE_ATTACK_HEAVY, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_ATTACK, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_RELOAD, TRUE)
    DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_SELECT_WEAPON, TRUE)
ENDPROC

PROC DEALER_APPLY_SHOWROOM_PROTECTION(VEHICLE_INDEX veh, INT paintColor)
    IF NOT DOES_ENTITY_EXIST(veh)
        EXIT
    ENDIF
    SET_ENTITY_AS_MISSION_ENTITY(veh, TRUE, TRUE)
    SET_ENTITY_INVINCIBLE(veh, TRUE)
    SET_ENTITY_PROOFS(veh, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)
    SET_VEHICLE_STRONG(veh, TRUE)
    SET_VEHICLE_CAN_BREAK(veh, FALSE)
    SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(veh, FALSE)
    SET_VEHICLE_TYRES_CAN_BURST(veh, FALSE)
    SET_VEHICLE_DIRT_LEVEL(veh, 0.0)
    SET_VEHICLE_COLOURS(veh, paintColor, paintColor)
    SET_VEHICLE_DOORS_LOCKED(veh, VEHICLELOCK_CANNOT_ENTER)
    SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(veh, TRUE)
    SET_VEHICLE_ENGINE_ON(veh, FALSE, TRUE, TRUE)
    SET_VEHICLE_LIGHTS(veh, FORCE_VEHICLE_LIGHTS_OFF)
    FREEZE_ENTITY_POSITION(veh, TRUE)
ENDPROC

// -------------------------------------------------------------------------
// SHOWROOM VEHICLE SPAWN & REFRESH (Pristine Display Setup)
// -------------------------------------------------------------------------
PROC DEALER_SPAWN_SLOT_VEHICLE(INT slot)
    MODEL_NAMES model = DEALER_GET_MODEL(slot, g_dealer_slot_model[slot])
    VECTOR coords = DEALER_GET_SLOT_COORDS(slot)
    FLOAT heading = DEALER_GET_SLOT_HEADING(slot)
    INT paintColor = DEALER_GET_PAINT_COLOR(g_dealer_slot_paint[slot])
    INT waitTime = 0

    REQUEST_MODEL(model)
    waitTime = GET_GAME_TIMER() + 2000
    WHILE NOT HAS_MODEL_LOADED(model) AND GET_GAME_TIMER() < waitTime
        IF g_dealer_selected_slot >= 0 AND DOES_ENTITY_EXIST(PLAYER_PED_ID()) AND NOT IS_ENTITY_DEAD(PLAYER_PED_ID())
            DEALER_SUPPRESS_INSPECTION_CONTROLS()
            DEALER_DRAW_INSPECTION_CARD(g_dealer_selected_slot, PLAYER_PED_ID())
        ENDIF
        WAIT(0)
    ENDWHILE

    IF HAS_MODEL_LOADED(model)
        // Delete existing vehicle in slot only after replacement model has loaded
        IF DOES_ENTITY_EXIST(g_dealer_showroom_vehs[slot])
            DELETE_VEHICLE(g_dealer_showroom_vehs[slot])
            g_dealer_showroom_vehs[slot] = NULL
        ENDIF

        g_dealer_showroom_vehs[slot] = CREATE_VEHICLE(model, coords, heading, FALSE, TRUE)
        IF DOES_ENTITY_EXIST(g_dealer_showroom_vehs[slot])
            IF SET_VEHICLE_ON_GROUND_PROPERLY(g_dealer_showroom_vehs[slot])
            ENDIF
            DEALER_APPLY_SHOWROOM_PROTECTION(g_dealer_showroom_vehs[slot], paintColor)
        ENDIF
    ENDIF
    SET_MODEL_AS_NO_LONGER_NEEDED(model)
ENDPROC

PROC DEALER_FORCE_OPEN_DOOR(MODEL_NAMES doorModel, VECTOR doorCoords, FLOAT openRatio)
    INT doorHash = 0
    SET_STATE_OF_CLOSEST_DOOR_OF_TYPE(doorModel, doorCoords, FALSE, openRatio, TRUE)
    IF DOOR_SYSTEM_FIND_EXISTING_DOOR(doorCoords, doorModel, doorHash)
        DOOR_SYSTEM_SET_DOOR_STATE(doorHash, DOORSTATE_FORCE_UNLOCKED_THIS_FRAME, TRUE, TRUE)
        DOOR_SYSTEM_SET_OPEN_RATIO(doorHash, openRatio, TRUE, TRUE)
        DOOR_SYSTEM_SET_HOLD_OPEN(doorHash, TRUE)
        DOOR_SYSTEM_SET_SPRING_REMOVED(doorHash, TRUE, TRUE, TRUE)
    ENDIF
ENDPROC

PROC DEALER_MAINTAIN_DOORS_OPEN()
    MODEL_NAMES doorL = INT_TO_ENUM(MODEL_NAMES, HASH("v_ilev_csr_door_l"))
    MODEL_NAMES doorR = INT_TO_ENUM(MODEL_NAMES, HASH("v_ilev_csr_door_r"))
    MODEL_NAMES garageDoor = INT_TO_ENUM(MODEL_NAMES, HASH("v_ilev_csr_garagedoor"))
    VECTOR foundCoords = <<0.0, 0.0, 0.0>>
    VECTOR foundRot = <<0.0, 0.0, 0.0>>

    // Unlock and hold open front double doors
    DEALER_FORCE_OPEN_DOOR(doorL, <<-59.89, -1092.95, 26.88>>, 1.0)
    DEALER_FORCE_OPEN_DOOR(doorR, <<-60.55, -1094.75, 26.89>>, 1.0)

    // Unlock and hold open side lot double doors
    DEALER_FORCE_OPEN_DOOR(doorL, <<-39.13, -1108.22, 26.72>>, 1.0)
    DEALER_FORCE_OPEN_DOOR(doorR, <<-37.33, -1108.87, 26.72>>, 1.0)

    // Unlock and hold open dealership garage door
    DEALER_FORCE_OPEN_DOOR(garageDoor, <<-30.88, -1088.34, 25.42>>, 1.0)
    IF GET_COORDS_AND_ROTATION_OF_CLOSEST_OBJECT_OF_TYPE(<<-30.88, -1088.34, 25.42>>, 25.0, garageDoor, foundCoords, foundRot)
        DEALER_FORCE_OPEN_DOOR(garageDoor, foundCoords, 1.0)
    ENDIF
ENDPROC

PROC DEALER_ENTER_SHOWROOM()
    INT s = 0

    // Ensure intact showroom IPL is loaded
    REMOVE_IPL("fakeint")
    REMOVE_IPL("carshowroom_broken")
    REMOVE_IPL("carshowroom_boarded")
    REQUEST_IPL("shr_int")

    // Pin interior in memory and open interior garage shutter entity set
    g_dealer_interior_id = GET_INTERIOR_AT_COORDS(<<-40.0, -1100.0, 26.4>>)
    IF g_dealer_interior_id != NULL
        PIN_INTERIOR_IN_MEMORY(g_dealer_interior_id)
        IF IS_INTERIOR_ENTITY_SET_ACTIVE(g_dealer_interior_id, "shutter_closed")
            DEACTIVATE_INTERIOR_ENTITY_SET(g_dealer_interior_id, "shutter_closed")
        ENDIF
        IF NOT IS_INTERIOR_ENTITY_SET_ACTIVE(g_dealer_interior_id, "shutter_open")
            ACTIVATE_INTERIOR_ENTITY_SET(g_dealer_interior_id, "shutter_open")
        ENDIF
        REFRESH_INTERIOR(g_dealer_interior_id)
    ENDIF

    // Unlock and open all entrance and garage doors
    DEALER_MAINTAIN_DOORS_OPEN()

    // Spawn all 5 showroom display vehicles
    FOR s = 0 TO 4
        DEALER_SPAWN_SLOT_VEHICLE(s)
    ENDFOR

    g_dealer_in_range = TRUE
ENDPROC

PROC DEALER_EXIT_SHOWROOM()
    INT s = 0

    // Delete showroom display cars to free memory
    FOR s = 0 TO 4
        IF DOES_ENTITY_EXIST(g_dealer_showroom_vehs[s])
            DELETE_VEHICLE(g_dealer_showroom_vehs[s])
            g_dealer_showroom_vehs[s] = NULL
        ENDIF
    ENDFOR

    // Unpin interior
    IF g_dealer_interior_id != NULL
        UNPIN_INTERIOR(g_dealer_interior_id)
        g_dealer_interior_id = NULL
    ENDIF

    ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_PHONE)
    ENABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_PHONE)
    ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CELLPHONE_UP)
    ENABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CELLPHONE_UP)
    ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_ENTER)
    ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CONTEXT)

    g_dealer_in_range = FALSE
    g_dealer_selected_slot = -1
ENDPROC

// -------------------------------------------------------------------------
// TEST DRIVE & PURCHASE HANDLERS
// -------------------------------------------------------------------------
PROC DEALER_START_TEST_DRIVE(INT slot, PED_INDEX playerPed)
    MODEL_NAMES model = DEALER_GET_MODEL(slot, g_dealer_slot_model[slot])
    INT paintColor = DEALER_GET_PAINT_COLOR(g_dealer_slot_paint[slot])
    VECTOR spawnPos = <<-45.10, -1116.3706, 25.4346>>
    FLOAT spawnHeading = 2.7999
    INT waitTime = 0

    // Delete any old test vehicle
    IF DOES_ENTITY_EXIST(g_dealer_test_veh)
        DELETE_VEHICLE(g_dealer_test_veh)
        g_dealer_test_veh = NULL
    ENDIF

    REQUEST_MODEL(model)
    waitTime = GET_GAME_TIMER() + 2000
    WHILE NOT HAS_MODEL_LOADED(model) AND GET_GAME_TIMER() < waitTime
        IF g_dealer_selected_slot >= 0 AND DOES_ENTITY_EXIST(playerPed) AND NOT IS_ENTITY_DEAD(playerPed)
            DEALER_SUPPRESS_INSPECTION_CONTROLS()
            DEALER_DRAW_INSPECTION_CARD(g_dealer_selected_slot, playerPed)
        ENDIF
        WAIT(0)
    ENDWHILE

    IF HAS_MODEL_LOADED(model)
        DO_SCREEN_FADE_OUT(400)
        WAIT(450)

        IF DOES_ENTITY_EXIST(playerPed) AND NOT IS_ENTITY_DEAD(playerPed)
            IF IS_PED_IN_ANY_VEHICLE(playerPed)
                CLEAR_PED_TASKS_IMMEDIATELY(playerPed)
            ENDIF
            REQUEST_COLLISION_AT_COORD(spawnPos)
            SET_ENTITY_COORDS(playerPed, spawnPos, FALSE, FALSE, FALSE, TRUE)
            SET_ENTITY_HEADING(playerPed, spawnHeading)
        ENDIF

        IF NOT DOES_ENTITY_EXIST(g_dealer_purchased_veh) OR GET_DISTANCE_BETWEEN_COORDS(GET_ENTITY_COORDS(g_dealer_purchased_veh), spawnPos, TRUE) > 8.0
            CLEAR_AREA_OF_VEHICLES(spawnPos, 5.0)
        ENDIF
        g_dealer_test_veh = CREATE_VEHICLE(model, spawnPos, spawnHeading, TRUE, TRUE)
        IF DOES_ENTITY_EXIST(g_dealer_test_veh)
            SET_ENTITY_AS_MISSION_ENTITY(g_dealer_test_veh, TRUE, TRUE)
            IF SET_VEHICLE_ON_GROUND_PROPERLY(g_dealer_test_veh)
            ENDIF
            SET_VEHICLE_COLOURS(g_dealer_test_veh, paintColor, paintColor)
            SET_VEHICLE_DIRT_LEVEL(g_dealer_test_veh, 0.0)
            SET_VEHICLE_DOORS_LOCKED(g_dealer_test_veh, VEHICLELOCK_UNLOCKED)
            IF DOES_ENTITY_EXIST(playerPed) AND NOT IS_ENTITY_DEAD(playerPed)
                SET_PED_INTO_VEHICLE(playerPed, g_dealer_test_veh, VS_DRIVER)
            ENDIF
            SET_VEHICLE_ENGINE_ON(g_dealer_test_veh, TRUE, TRUE, FALSE)
        ENDIF

        ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_PHONE)
        ENABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_PHONE)
        ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CELLPHONE_UP)
        ENABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CELLPHONE_UP)
        ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_ENTER)
        ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CONTEXT)

        DO_SCREEN_FADE_IN(400)

        g_dealer_selected_slot = -1
        g_dealer_test_drive_active = TRUE
        g_dealer_test_drive_end = GET_GAME_TIMER() + TEST_DRIVE_DURATION_MS
        g_dealer_test_slot = slot

        DEALER_SHOW_NOTIFICATION("~y~TEST DRIVE:~s~ 2 minutes remaining! Enjoy the ride.")
    ENDIF
    SET_MODEL_AS_NO_LONGER_NEEDED(model)
ENDPROC

PROC DEALER_FINISH_TEST_DRIVE(PED_INDEX playerPed)
    DO_SCREEN_FADE_OUT(400)
    WAIT(450)

    IF DOES_ENTITY_EXIST(playerPed) AND NOT IS_ENTITY_DEAD(playerPed) AND IS_PED_IN_ANY_VEHICLE(playerPed)
        CLEAR_PED_TASKS_IMMEDIATELY(playerPed)
    ENDIF

    IF DOES_ENTITY_EXIST(g_dealer_test_veh)
        DELETE_VEHICLE(g_dealer_test_veh)
        g_dealer_test_veh = NULL
    ENDIF

    // Return player to showroom entrance
    IF DOES_ENTITY_EXIST(playerPed) AND NOT IS_ENTITY_DEAD(playerPed)
        SET_ENTITY_COORDS(playerPed, <<-45.0, -1106.5, 26.4>>, FALSE, FALSE, FALSE, TRUE)
        SET_ENTITY_HEADING(playerPed, 20.0)
    ENDIF

    DO_SCREEN_FADE_IN(400)

    g_dealer_test_drive_active = FALSE
    DEALER_SHOW_NOTIFICATION("~b~TEST DRIVE:~s~ Concluded. Vehicle returned to showroom.")
ENDPROC

FUNC BOOL DEALER_PURCHASE_VEHICLE(INT slot, PED_INDEX playerPed, BOOL fromTestDrive)
    INT modelChoice = g_dealer_slot_model[slot]
    INT price = DEALER_GET_PRICE(slot, modelChoice)
    INT cash = DEALER_GET_PLAYER_CASH(playerPed)
    MODEL_NAMES model = DEALER_GET_MODEL(slot, modelChoice)
    STRING name = DEALER_GET_NAME(slot, modelChoice)
    INT paintColor = DEALER_GET_PAINT_COLOR(g_dealer_slot_paint[slot])
    VECTOR spawnPos = <<-50.7373, -1116.3706, 25.4346>>
    FLOAT spawnHeading = 2.7999
    VEHICLE_INDEX boughtVeh = NULL
    INT waitTime = 0

    // Check funds
    IF cash < price
        PLAY_SOUND_FRONTEND(-1, "ERROR", "HUD_AMMO_SHOP_SOUNDSET", TRUE)
        DEALER_SHOW_NOTIFICATION("~r~INSUFFICIENT FUNDS: ~w~You cannot afford this vehicle.")
        RETURN FALSE
    ENDIF

    // If buying on the spot during a test drive while sitting in the test vehicle,
    // convert the active test vehicle directly into the player's purchased vehicle!
    IF fromTestDrive AND DOES_ENTITY_EXIST(g_dealer_test_veh) AND NOT IS_ENTITY_DEAD(g_dealer_test_veh)
        IF DOES_ENTITY_EXIST(playerPed)
            DEALER_DEDUCT_PLAYER_CASH(playerPed, price)
        ENDIF
        PLAY_SOUND_FRONTEND(-1, "PURCHASE", "HUD_AWARDS", TRUE)

        IF DOES_ENTITY_EXIST(g_dealer_purchased_veh) AND g_dealer_purchased_veh != g_dealer_test_veh
            IF NOT IS_PED_IN_VEHICLE(playerPed, g_dealer_purchased_veh, FALSE)
                DELETE_VEHICLE(g_dealer_purchased_veh)
            ELSE
                SET_VEHICLE_AS_NO_LONGER_NEEDED(g_dealer_purchased_veh)
            ENDIF
        ENDIF

        g_dealer_purchased_veh = g_dealer_test_veh
        g_dealer_test_veh = NULL
        g_dealer_test_drive_active = FALSE

        SET_VEHICLE_FIXED(g_dealer_purchased_veh)
        SET_VEHICLE_DIRT_LEVEL(g_dealer_purchased_veh, 0.0)
        SET_ENTITY_AS_MISSION_ENTITY(g_dealer_purchased_veh, TRUE, TRUE)

        IF DOES_BLIP_EXIST(g_dealer_delivery_blip)
            REMOVE_BLIP(g_dealer_delivery_blip)
            g_dealer_delivery_blip = NULL
        ENDIF

        TEXT_LABEL_63 tdBuyMsg = "~g~PURCHASED: ~y~"
        tdBuyMsg += name
        tdBuyMsg += "~s~ is now yours!"
        DEALER_SHOW_NOTIFICATION(tdBuyMsg)
        RETURN TRUE
    ENDIF

    // Request model and spawn delivered vehicle outside
    REQUEST_MODEL(model)
    waitTime = GET_GAME_TIMER() + 2000
    WHILE NOT HAS_MODEL_LOADED(model) AND GET_GAME_TIMER() < waitTime
        IF g_dealer_selected_slot >= 0 AND DOES_ENTITY_EXIST(playerPed) AND NOT IS_ENTITY_DEAD(playerPed)
            DEALER_SUPPRESS_INSPECTION_CONTROLS()
            DEALER_DRAW_INSPECTION_CARD(g_dealer_selected_slot, playerPed)
        ENDIF
        WAIT(0)
    ENDWHILE

    IF HAS_MODEL_LOADED(model)
        IF DOES_ENTITY_EXIST(playerPed)
            DEALER_DEDUCT_PLAYER_CASH(playerPed, price)
        ENDIF
        PLAY_SOUND_FRONTEND(-1, "PURCHASE", "HUD_AWARDS", TRUE)

        IF fromTestDrive AND DOES_ENTITY_EXIST(g_dealer_test_veh)
            DELETE_VEHICLE(g_dealer_test_veh)
            g_dealer_test_veh = NULL
            g_dealer_test_drive_active = FALSE
        ENDIF

        IF DOES_ENTITY_EXIST(g_dealer_purchased_veh)
            IF NOT IS_PED_IN_VEHICLE(playerPed, g_dealer_purchased_veh, FALSE)
                DELETE_VEHICLE(g_dealer_purchased_veh)
            ELSE
                SET_VEHICLE_AS_NO_LONGER_NEEDED(g_dealer_purchased_veh)
            ENDIF
            g_dealer_purchased_veh = NULL
        ENDIF

        CLEAR_AREA_OF_VEHICLES(spawnPos, 6.0)
        boughtVeh = CREATE_VEHICLE(model, spawnPos, spawnHeading, TRUE, TRUE)
        g_dealer_purchased_veh = boughtVeh
        IF DOES_ENTITY_EXIST(boughtVeh)
            IF SET_VEHICLE_ON_GROUND_PROPERLY(boughtVeh)
            ENDIF
            SET_VEHICLE_COLOURS(boughtVeh, paintColor, paintColor)
            SET_VEHICLE_DIRT_LEVEL(boughtVeh, 0.0)
            SET_VEHICLE_DOORS_LOCKED(boughtVeh, VEHICLELOCK_UNLOCKED)
            SET_VEHICLE_ENGINE_ON(boughtVeh, TRUE, TRUE, FALSE)
            SET_ENTITY_AS_MISSION_ENTITY(boughtVeh, TRUE, TRUE)

            // Flash hazard indicators once to announce delivery
            SET_VEHICLE_INDICATOR_LIGHTS(boughtVeh, TRUE, TRUE)
            SET_VEHICLE_INDICATOR_LIGHTS(boughtVeh, FALSE, TRUE)

            // Create delivery blip
            IF DOES_BLIP_EXIST(g_dealer_delivery_blip)
                REMOVE_BLIP(g_dealer_delivery_blip)
            ENDIF
            g_dealer_delivery_blip = ADD_BLIP_FOR_ENTITY(boughtVeh)
            SET_BLIP_SPRITE(g_dealer_delivery_blip, RADAR_TRACE_CAR_SHOWROOM)
            SET_BLIP_COLOUR(g_dealer_delivery_blip, 2) // Green
            SET_BLIP_SCALE(g_dealer_delivery_blip, 0.80)
        ENDIF

        TEXT_LABEL_63 buyMsg = "~g~PURCHASED: ~y~"
        buyMsg += name
        buyMsg += "~s~ delivered outside!"
        DEALER_SHOW_NOTIFICATION(buyMsg)
        SET_MODEL_AS_NO_LONGER_NEEDED(model)
        RETURN TRUE
    ELSE
        DEALER_SHOW_NOTIFICATION("~r~DELIVERY FAILED: ~w~Vehicle could not be streamed. No funds charged.")
    ENDIF
    SET_MODEL_AS_NO_LONGER_NEEDED(model)
    RETURN FALSE
ENDFUNC

// -------------------------------------------------------------------------
// MAIN SCRIPT ENTRY POINT
// -------------------------------------------------------------------------
SCRIPT
    PED_INDEX playerPed = NULL
    VECTOR pCoords
    VECTOR showroomCenter
    FLOAT distToShowroom = 0.0
    FLOAT distToSlot = 0.0
    INT nearestSlot = -1
    FLOAT nearestDist = 999.0
    INT s = 0
    INT now = 0
    INT timeLeftMs = 0
    INT minutes = 0
    INT seconds = 0
    INT lastInspectedSlot = -1
    FLOAT curTurnHeading = 0.0
    VECTOR slotLightPos
    BOOL menuOpen = FALSE

    pCoords = <<0.0, 0.0, 0.0>>
    showroomCenter = <<-44.0, -1100.0, 26.4>>
    slotLightPos = <<0.0, 0.0, 0.0>>

    WHILE NOT DOES_ENTITY_EXIST(PLAYER_PED_ID())
        WAIT(100)
    ENDWHILE
    WAIT(500)

    // Create World Map Showroom Blip (Simeon's Dealership)
    g_dealer_map_blip = ADD_BLIP_FOR_COORD(showroomCenter)
    SET_BLIP_SPRITE(g_dealer_map_blip, RADAR_TRACE_CAR_SHOWROOM)
    SET_BLIP_COLOUR(g_dealer_map_blip, 3) // Light Blue
    SET_BLIP_SCALE(g_dealer_map_blip, 0.85)
    SET_BLIP_AS_SHORT_RANGE(g_dealer_map_blip, FALSE)

    WHILE TRUE
        WAIT(0)

        playerPed = PLAYER_PED_ID()
        IF DOES_ENTITY_EXIST(playerPed) AND NOT IS_ENTITY_DEAD(playerPed)
            now = GET_GAME_TIMER()
            pCoords = GET_ENTITY_COORDS(playerPed)
            distToShowroom = GET_DISTANCE_BETWEEN_COORDS(pCoords, showroomCenter, TRUE)
            menuOpen = NOT IS_CONTROL_ENABLED(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN)

            IF DOES_BLIP_EXIST(g_dealer_delivery_blip)
                IF NOT DOES_ENTITY_EXIST(g_dealer_purchased_veh) OR IS_ENTITY_DEAD(g_dealer_purchased_veh) OR IS_PED_IN_VEHICLE(playerPed, g_dealer_purchased_veh, FALSE)
                    REMOVE_BLIP(g_dealer_delivery_blip)
                    g_dealer_delivery_blip = NULL
                ENDIF
            ENDIF

            // --- 1. TEST DRIVE IN-PROGRESS LOOP ---
            IF g_dealer_test_drive_active
                IF NOT DOES_ENTITY_EXIST(g_dealer_test_veh) OR IS_ENTITY_DEAD(g_dealer_test_veh) OR NOT IS_VEHICLE_DRIVEABLE(g_dealer_test_veh, FALSE)
                    IF DOES_ENTITY_EXIST(g_dealer_test_veh)
                        DELETE_VEHICLE(g_dealer_test_veh)
                        g_dealer_test_veh = NULL
                    ENDIF
                    g_dealer_test_drive_active = FALSE
                    DEALER_SHOW_NOTIFICATION("~r~TEST DRIVE ENDED:~s~ Vehicle was damaged or destroyed.")
                ELSE
                    timeLeftMs = g_dealer_test_drive_end - now
                    IF timeLeftMs < 0
                        timeLeftMs = 0
                    ENDIF
                    minutes = timeLeftMs / 60000
                    seconds = (timeLeftMs % 60000) / 1000

                    // Top-Right RageMenu-Styled Test Drive Status Panel
                    DEALER_DRAW_TEST_DRIVE_HUD(g_dealer_test_slot, minutes, seconds, playerPed)

                    BOOL lbHeld = NOT menuOpen AND (IS_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LB) OR IS_DISABLED_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LB))
                    BOOL rbHeld = IS_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_RB) OR IS_DISABLED_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_RB)

                    // Use Hold LB + D-Pad Left [Return Showroom] and Hold LB + D-Pad Right [Buy Vehicle]
                    // so D-Pad Down + A/Y is never used and driving controls (A/B/X/Y) are never interrupted.
                    IF lbHeld AND NOT rbHeld
                        DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CELLPHONE_LEFT, TRUE)
                        DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CELLPHONE_RIGHT, TRUE)
                        DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_VEH_RADIO_WHEEL, TRUE)
                        DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CONTEXT, TRUE)
                        DISABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CONTEXT, TRUE)
                    ENDIF

                    // Test drive expired or shortcut pressed:
                    IF timeLeftMs <= 0
                        DEALER_FINISH_TEST_DRIVE(playerPed)
                    ELIF lbHeld AND NOT rbHeld
                        IF IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LEFT) OR IS_DISABLED_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LEFT) OR IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_SCRIPT_PAD_LEFT) OR IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_SCRIPT_PAD_LEFT)
                            DEALER_FINISH_TEST_DRIVE(playerPed)
                        ELIF IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_RIGHT) OR IS_DISABLED_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_RIGHT) OR IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_SCRIPT_PAD_RIGHT) OR IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_SCRIPT_PAD_RIGHT)
                            // Buy on the spot! Only ends test drive if purchase succeeds.
                            IF DEALER_PURCHASE_VEHICLE(g_dealer_test_slot, playerPed, TRUE)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

            // --- 2. SHOWROOM AREA MANAGEMENT ---
            ELSE
                // Entering showroom range (< 65m)
                IF distToShowroom < 65.0 AND NOT g_dealer_in_range
                    DEALER_ENTER_SHOWROOM()
                // Leaving showroom range (> 85m)
                ELIF distToShowroom > 85.0 AND g_dealer_in_range
                    DEALER_EXIT_SHOWROOM()
                    lastInspectedSlot = -1
                ENDIF

                // Inside Showroom: Maintain Open Doors & Walk-Up Inspection Logic
                IF g_dealer_in_range
                    DEALER_MAINTAIN_DOORS_OPEN()

                    nearestSlot = -1
                    nearestDist = 999.0

                    FOR s = 0 TO 4
                        // Auto-recover if any external explosion/mod deleted or damaged a display car
                        IF NOT DOES_ENTITY_EXIST(g_dealer_showroom_vehs[s]) OR IS_ENTITY_DEAD(g_dealer_showroom_vehs[s])
                            DEALER_SPAWN_SLOT_VEHICLE(s)
                        ELSE
                            IF IS_PED_IN_VEHICLE(playerPed, g_dealer_showroom_vehs[s], FALSE)
                                CLEAR_PED_TASKS_IMMEDIATELY(playerPed)
                            ENDIF
                            IF GET_DISTANCE_BETWEEN_COORDS(GET_ENTITY_COORDS(g_dealer_showroom_vehs[s]), DEALER_GET_SLOT_COORDS(s), TRUE) > 0.35
                                SET_ENTITY_COORDS(g_dealer_showroom_vehs[s], DEALER_GET_SLOT_COORDS(s), FALSE, FALSE, FALSE, TRUE)
                            ENDIF
                        ENDIF
                        IF now >= g_dealer_exit_cooldown
                            distToSlot = GET_DISTANCE_BETWEEN_COORDS(pCoords, DEALER_GET_SLOT_COORDS(s), TRUE)
                            IF distToSlot < 3.8 AND distToSlot < nearestDist
                                nearestDist = distToSlot
                                nearestSlot = s
                            ENDIF
                        ENDIF
                    ENDFOR

                    // If user moved away or switched cars, restore original pedestal heading
                    // and re-enable phone / enter / context controls immediately
                    IF lastInspectedSlot != nearestSlot
                        IF lastInspectedSlot >= 0 AND DOES_ENTITY_EXIST(g_dealer_showroom_vehs[lastInspectedSlot])
                            SET_ENTITY_HEADING(g_dealer_showroom_vehs[lastInspectedSlot], DEALER_GET_SLOT_HEADING(lastInspectedSlot))
                        ENDIF
                        IF nearestSlot >= 0
                            g_dealer_menu_item = 0
                        ELSE
                            ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_PHONE)
                            ENABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_PHONE)
                            ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CELLPHONE_UP)
                            ENABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CELLPHONE_UP)
                            ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_ENTER)
                            ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CONTEXT)
                        ENDIF
                    ENDIF
                    lastInspectedSlot = nearestSlot
                    g_dealer_selected_slot = nearestSlot

                    // Walked up to a showroom vehicle!
                    IF g_dealer_selected_slot >= 0
                        IF DOES_ENTITY_EXIST(g_dealer_showroom_vehs[g_dealer_selected_slot])
                            // Ceiling Spotlight casting warm luxury showroom light onto car
                            slotLightPos = DEALER_GET_SLOT_COORDS(g_dealer_selected_slot)
                            slotLightPos.z = slotLightPos.z + 3.2
                            DRAW_LIGHT_WITH_RANGE(slotLightPos, 255, 255, 235, 7.5, 2.5)

                            // Smooth turntable rotation while inspecting
                            curTurnHeading = GET_ENTITY_HEADING(g_dealer_showroom_vehs[g_dealer_selected_slot])
                            curTurnHeading = curTurnHeading + 0.22
                            IF curTurnHeading >= 360.0
                                curTurnHeading = curTurnHeading - 360.0
                            ENDIF
                            SET_ENTITY_HEADING(g_dealer_showroom_vehs[g_dealer_selected_slot], curTurnHeading)
                        ENDIF

                        // Suppress phone, vehicle entry, context (DPad-Right), and combat ONLY while showcasing a car
                        DEALER_SUPPRESS_INSPECTION_CONTROLS()
                        DEALER_DRAW_INSPECTION_CARD(g_dealer_selected_slot, playerPed)

                        BOOL dealerLbOrRb = IS_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LB) OR IS_DISABLED_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LB) OR IS_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_RB) OR IS_DISABLED_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_RB)
                        BOOL dealerDpadDown = IS_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN) OR IS_DISABLED_CONTROL_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN) OR IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_SCRIPT_PAD_DOWN) OR IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_SCRIPT_PAD_DOWN)
                        IF dealerDpadDown
                            g_dealer_dpad_down_guard_until = now + 350
                        ENDIF

                        // Controller actions (ignored while RageMenu is open or LB/RB held):
                        IF now >= g_dealer_input_cooldown AND NOT dealerLbOrRb AND NOT menuOpen
                            // [B] Exit Inspection
                            IF NOT dealerDpadDown AND (IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_CANCEL) OR IS_DISABLED_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_CANCEL))
                                IF DOES_ENTITY_EXIST(g_dealer_showroom_vehs[g_dealer_selected_slot])
                                    SET_ENTITY_HEADING(g_dealer_showroom_vehs[g_dealer_selected_slot], DEALER_GET_SLOT_HEADING(g_dealer_selected_slot))
                                ENDIF
                                g_dealer_selected_slot = -1
                                lastInspectedSlot = -1
                                g_dealer_exit_cooldown = now + 1500
                                g_dealer_input_cooldown = now + 400
                                ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_PHONE)
                                ENABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_PHONE)
                                ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CELLPHONE_UP)
                                ENABLE_CONTROL_ACTION(FRONTEND_CONTROL, INPUT_CELLPHONE_UP)
                                ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_ENTER)
                                ENABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CONTEXT)
                                PLAY_SOUND_FRONTEND(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)

                            // [A] Apply Selected Action (Row 7 = Test Drive; other rows = Purchase Vehicle)
                            ELIF NOT dealerDpadDown AND now >= g_dealer_dpad_down_guard_until AND (IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_ACCEPT) OR IS_DISABLED_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_ACCEPT))
                                IF g_dealer_menu_item = 7
                                    PLAY_SOUND_FRONTEND(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
                                    DEALER_START_TEST_DRIVE(g_dealer_selected_slot, playerPed)
                                    g_dealer_input_cooldown = now + 500
                                ELSE
                                    IF DEALER_PURCHASE_VEHICLE(g_dealer_selected_slot, playerPed, FALSE)
                                    ENDIF
                                    g_dealer_input_cooldown = now + 400
                                ENDIF

                            // [X] Quick Test Drive Shortcut (reads both INPUT_FRONTEND_Y [physical Switch X] and INPUT_FRONTEND_X)
                            ELIF NOT dealerDpadDown AND now >= g_dealer_dpad_down_guard_until AND (IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_Y) OR IS_DISABLED_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_Y) OR IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_X) OR IS_DISABLED_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_X))
                                PLAY_SOUND_FRONTEND(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
                                DEALER_START_TEST_DRIVE(g_dealer_selected_slot, playerPed)
                                g_dealer_input_cooldown = now + 500

                            // [D-Pad Right] Adjust Selector Forward (Row 0 = Model, other rows = Paint)
                            ELIF IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_RIGHT) OR IS_DISABLED_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_RIGHT)
                                IF g_dealer_menu_item = 0
                                    g_dealer_slot_model[g_dealer_selected_slot] = (g_dealer_slot_model[g_dealer_selected_slot] + 1) % NUM_MODELS_PER_SLOT
                                    DEALER_SPAWN_SLOT_VEHICLE(g_dealer_selected_slot)
                                    PLAY_SOUND_FRONTEND(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
                                    g_dealer_input_cooldown = now + 300
                                ELSE
                                    g_dealer_slot_paint[g_dealer_selected_slot] = (g_dealer_slot_paint[g_dealer_selected_slot] + 1) % NUM_SHOWROOM_PAINTS
                                    IF DOES_ENTITY_EXIST(g_dealer_showroom_vehs[g_dealer_selected_slot])
                                        SET_VEHICLE_COLOURS(g_dealer_showroom_vehs[g_dealer_selected_slot], DEALER_GET_PAINT_COLOR(g_dealer_slot_paint[g_dealer_selected_slot]), DEALER_GET_PAINT_COLOR(g_dealer_slot_paint[g_dealer_selected_slot]))
                                    ENDIF
                                    PLAY_SOUND_FRONTEND(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
                                    g_dealer_input_cooldown = now + 180
                                ENDIF

                            // [D-Pad Left] Adjust Selector Backward (Row 0 = Model, other rows = Paint)
                            ELIF IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LEFT) OR IS_DISABLED_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_LEFT)
                                IF g_dealer_menu_item = 0
                                    g_dealer_slot_model[g_dealer_selected_slot] = g_dealer_slot_model[g_dealer_selected_slot] - 1
                                    IF g_dealer_slot_model[g_dealer_selected_slot] < 0
                                        g_dealer_slot_model[g_dealer_selected_slot] = NUM_MODELS_PER_SLOT - 1
                                    ENDIF
                                    DEALER_SPAWN_SLOT_VEHICLE(g_dealer_selected_slot)
                                    PLAY_SOUND_FRONTEND(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
                                    g_dealer_input_cooldown = now + 300
                                ELSE
                                    g_dealer_slot_paint[g_dealer_selected_slot] = g_dealer_slot_paint[g_dealer_selected_slot] - 1
                                    IF g_dealer_slot_paint[g_dealer_selected_slot] < 0
                                        g_dealer_slot_paint[g_dealer_selected_slot] = NUM_SHOWROOM_PAINTS - 1
                                    ENDIF
                                    IF DOES_ENTITY_EXIST(g_dealer_showroom_vehs[g_dealer_selected_slot])
                                        SET_VEHICLE_COLOURS(g_dealer_showroom_vehs[g_dealer_selected_slot], DEALER_GET_PAINT_COLOR(g_dealer_slot_paint[g_dealer_selected_slot]), DEALER_GET_PAINT_COLOR(g_dealer_slot_paint[g_dealer_selected_slot]))
                                    ENDIF
                                    PLAY_SOUND_FRONTEND(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
                                    g_dealer_input_cooldown = now + 180
                                ENDIF

                            // [D-Pad Up] Move Menu Cursor Up
                            ELIF IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_UP) OR IS_DISABLED_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_UP)
                                g_dealer_menu_item = g_dealer_menu_item - 1
                                IF g_dealer_menu_item < 0
                                    g_dealer_menu_item = DEALER_MENU_ROWS - 1
                                ENDIF
                                PLAY_SOUND_FRONTEND(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
                                g_dealer_input_cooldown = now + 150

                            // [D-Pad Down] Move Menu Cursor Down
                            ELIF IS_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN) OR IS_DISABLED_CONTROL_JUST_PRESSED(FRONTEND_CONTROL, INPUT_FRONTEND_DOWN)
                                g_dealer_menu_item = (g_dealer_menu_item + 1) % DEALER_MENU_ROWS
                                PLAY_SOUND_FRONTEND(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", TRUE)
                                g_dealer_input_cooldown = now + 150
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ELSE
            // Player is dead or being respawned: clean up any active test drive or showroom lock
            IF IS_SCREEN_FADED_OUT() OR IS_SCREEN_FADING_OUT()
                DO_SCREEN_FADE_IN(0)
            ENDIF
            IF g_dealer_test_drive_active
                IF DOES_ENTITY_EXIST(g_dealer_test_veh)
                    DELETE_VEHICLE(g_dealer_test_veh)
                    g_dealer_test_veh = NULL
                ENDIF
                g_dealer_test_drive_active = FALSE
            ENDIF
            IF g_dealer_in_range
                DEALER_EXIT_SHOWROOM()
                lastInspectedSlot = -1
            ENDIF
        ENDIF
    ENDWHILE
ENDSCRIPT

PROC REFILL_OWNED_WEAPON(PED_INDEX ped, WEAPON_TYPE weapon)
    INT maxAmmo = 0
    IF HAS_PED_GOT_WEAPON(ped, weapon)
        IF GET_MAX_AMMO(ped, weapon, maxAmmo)
            SET_PED_AMMO(ped, weapon, maxAmmo)
        ENDIF
    ENDIF
ENDPROC

PROC REFILL_ALL_OWNED_WEAPONS(PED_INDEX ped)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_PISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_COMBATPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_APPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_MICROSMG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_SMG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_ASSAULTRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_CARBINERIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_ADVANCEDRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_MG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_COMBATMG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_PUMPSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_SAWNOFFSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_ASSAULTSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_SNIPERRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_HEAVYSNIPER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_GRENADELAUNCHER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_GRENADELAUNCHER_SMOKE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_RPG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_MINIGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_GRENADE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_SMOKEGRENADE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_BZGAS)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_STICKYBOMB)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_MOLOTOV)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_FLARE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_STUNGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_FIREEXTINGUISHER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_PETROLCAN)
    // Include the DLC weapon groups present in the Switch build.  The
    // previous list only covered the original single-player set, so Refill
    // All Ammo silently skipped weapons the Give Upgraded Weapons action had
    // just added.
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_PISTOL50)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_SNSPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HEAVYPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_VINTAGEPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MARKSMANPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_REVOLVER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_SNSPISTOL_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_REVOLVER_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_ASSAULTSMG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_COMBATPDW)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MACHINEPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MINISMG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_GUSENBERG)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_SPECIALCARBINE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_BULLPUPRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_COMPACTRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_ASSAULTRIFLE_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_CARBINERIFLE_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_SPECIALCARBINE_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_COMBATMG_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_BULLPUPSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HEAVYSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_DBSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_AUTOSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_PUMPSHOTGUN_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MARKSMANRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HEAVYSNIPER_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MARKSMANRIFLE_MK2)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HOMINGLAUNCHER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_COMPACTLAUNCHER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_RAILGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_FIREWORK)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MUSKET)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_PROXMINE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_PIPEBOMB)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_SNOWBALL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_FLAREGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_BOTTLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_DAGGER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_KNUCKLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MACHETE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_SWITCHBLADE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_BATTLEAXE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HATCHET)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_POOLCUE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_WRENCH)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_RAYPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_RAYCARBINE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_RAYMINIGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_DOUBLEACTION)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_STONE_HATCHET)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_CERAMICPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HAZARDCAN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_NAVYREVOLVER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_GADGETPISTOL)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_MILITARYRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_COMBATSHOTGUN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_HEAVYRIFLE)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_EMPLAUNCHER)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_FERTILIZERCAN)
    REFILL_OWNED_WEAPON(ped, WEAPONTYPE_DLC_STUNGUNG_MP)
ENDPROC

PROC GIVE_ALL_MENU_WEAPONS(PED_INDEX ped)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_PISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_COMBATPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_APPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_PISTOL50, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_SNSPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HEAVYPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_VINTAGEPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MARKSMANPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_REVOLVER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_SNSPISTOL_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_REVOLVER_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_MICROSMG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_SMG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_ASSAULTSMG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_COMBATPDW, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MACHINEPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MINISMG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_GUSENBERG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_ASSAULTRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_CARBINERIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_ADVANCEDRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_SPECIALCARBINE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_BULLPUPRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_COMPACTRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_ASSAULTRIFLE_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_CARBINERIFLE_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_SPECIALCARBINE_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_MG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_COMBATMG, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_COMBATMG_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_PUMPSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_SAWNOFFSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_ASSAULTSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_BULLPUPSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HEAVYSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_DBSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_AUTOSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_PUMPSHOTGUN_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_SNIPERRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_HEAVYSNIPER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MARKSMANRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HEAVYSNIPER_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MARKSMANRIFLE_MK2, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_GRENADELAUNCHER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_RPG, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_MINIGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HOMINGLAUNCHER, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_COMPACTLAUNCHER, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_RAILGUN, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_FIREWORK, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MUSKET, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_GRENADE, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_SMOKEGRENADE, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_BZGAS, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_STICKYBOMB, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_MOLOTOV, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_PROXMINE, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_PIPEBOMB, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_SNOWBALL, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_FLAREGUN, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_STUNGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_FIREEXTINGUISHER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_PETROLCAN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_KNIFE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_NIGHTSTICK, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_HAMMER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_BAT, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_CROWBAR, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_GOLFCLUB, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_BOTTLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_DAGGER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_KNUCKLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MACHETE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_SWITCHBLADE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_BATTLEAXE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HATCHET, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_POOLCUE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_WRENCH, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_RAYPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_RAYCARBINE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_RAYMINIGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_DOUBLEACTION, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_STONE_HATCHET, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_CERAMICPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HAZARDCAN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_NAVYREVOLVER, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_GADGETPISTOL, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_MILITARYRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_COMBATSHOTGUN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_HEAVYRIFLE, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_EMPLAUNCHER, 25, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_FERTILIZERCAN, 9999, TRUE)
    GIVE_DELAYED_WEAPON_TO_PED(ped, WEAPONTYPE_DLC_STUNGUNG_MP, 9999, TRUE)
ENDPROC

// Individual-weapon catalog mirrors the bulk Give All Weapons list. This
// keeps selector availability aligned with the 2699 base/DLC weapon set.
FUNC INT MENU_WEAPON_COUNT()
    RETURN 93
ENDFUNC

FUNC WEAPON_TYPE MENU_WEAPON_FOR_CHOICE(INT choice)
    SWITCH choice
        CASE 0 RETURN WEAPONTYPE_PISTOL BREAK
        CASE 1 RETURN WEAPONTYPE_COMBATPISTOL BREAK
        CASE 2 RETURN WEAPONTYPE_APPISTOL BREAK
        CASE 3 RETURN WEAPONTYPE_DLC_PISTOL50 BREAK
        CASE 4 RETURN WEAPONTYPE_DLC_SNSPISTOL BREAK
        CASE 5 RETURN WEAPONTYPE_DLC_HEAVYPISTOL BREAK
        CASE 6 RETURN WEAPONTYPE_DLC_VINTAGEPISTOL BREAK
        CASE 7 RETURN WEAPONTYPE_DLC_MARKSMANPISTOL BREAK
        CASE 8 RETURN WEAPONTYPE_DLC_REVOLVER BREAK
        CASE 9 RETURN WEAPONTYPE_DLC_SNSPISTOL_MK2 BREAK
        CASE 10 RETURN WEAPONTYPE_DLC_REVOLVER_MK2 BREAK
        CASE 11 RETURN WEAPONTYPE_MICROSMG BREAK
        CASE 12 RETURN WEAPONTYPE_SMG BREAK
        CASE 13 RETURN WEAPONTYPE_DLC_ASSAULTSMG BREAK
        CASE 14 RETURN WEAPONTYPE_DLC_COMBATPDW BREAK
        CASE 15 RETURN WEAPONTYPE_DLC_MACHINEPISTOL BREAK
        CASE 16 RETURN WEAPONTYPE_DLC_MINISMG BREAK
        CASE 17 RETURN WEAPONTYPE_DLC_GUSENBERG BREAK
        CASE 18 RETURN WEAPONTYPE_ASSAULTRIFLE BREAK
        CASE 19 RETURN WEAPONTYPE_CARBINERIFLE BREAK
        CASE 20 RETURN WEAPONTYPE_ADVANCEDRIFLE BREAK
        CASE 21 RETURN WEAPONTYPE_DLC_SPECIALCARBINE BREAK
        CASE 22 RETURN WEAPONTYPE_DLC_BULLPUPRIFLE BREAK
        CASE 23 RETURN WEAPONTYPE_DLC_COMPACTRIFLE BREAK
        CASE 24 RETURN WEAPONTYPE_DLC_ASSAULTRIFLE_MK2 BREAK
        CASE 25 RETURN WEAPONTYPE_DLC_CARBINERIFLE_MK2 BREAK
        CASE 26 RETURN WEAPONTYPE_DLC_SPECIALCARBINE_MK2 BREAK
        CASE 27 RETURN WEAPONTYPE_MG BREAK
        CASE 28 RETURN WEAPONTYPE_COMBATMG BREAK
        CASE 29 RETURN WEAPONTYPE_DLC_COMBATMG_MK2 BREAK
        CASE 30 RETURN WEAPONTYPE_PUMPSHOTGUN BREAK
        CASE 31 RETURN WEAPONTYPE_SAWNOFFSHOTGUN BREAK
        CASE 32 RETURN WEAPONTYPE_ASSAULTSHOTGUN BREAK
        CASE 33 RETURN WEAPONTYPE_DLC_BULLPUPSHOTGUN BREAK
        CASE 34 RETURN WEAPONTYPE_DLC_HEAVYSHOTGUN BREAK
        CASE 35 RETURN WEAPONTYPE_DLC_DBSHOTGUN BREAK
        CASE 36 RETURN WEAPONTYPE_DLC_AUTOSHOTGUN BREAK
        CASE 37 RETURN WEAPONTYPE_DLC_PUMPSHOTGUN_MK2 BREAK
        CASE 38 RETURN WEAPONTYPE_SNIPERRIFLE BREAK
        CASE 39 RETURN WEAPONTYPE_HEAVYSNIPER BREAK
        CASE 40 RETURN WEAPONTYPE_DLC_MARKSMANRIFLE BREAK
        CASE 41 RETURN WEAPONTYPE_DLC_HEAVYSNIPER_MK2 BREAK
        CASE 42 RETURN WEAPONTYPE_DLC_MARKSMANRIFLE_MK2 BREAK
        CASE 43 RETURN WEAPONTYPE_GRENADELAUNCHER BREAK
        CASE 44 RETURN WEAPONTYPE_RPG BREAK
        CASE 45 RETURN WEAPONTYPE_MINIGUN BREAK
        CASE 46 RETURN WEAPONTYPE_DLC_HOMINGLAUNCHER BREAK
        CASE 47 RETURN WEAPONTYPE_DLC_COMPACTLAUNCHER BREAK
        CASE 48 RETURN WEAPONTYPE_DLC_RAILGUN BREAK
        CASE 49 RETURN WEAPONTYPE_DLC_FIREWORK BREAK
        CASE 50 RETURN WEAPONTYPE_DLC_MUSKET BREAK
        CASE 51 RETURN WEAPONTYPE_GRENADE BREAK
        CASE 52 RETURN WEAPONTYPE_SMOKEGRENADE BREAK
        CASE 53 RETURN WEAPONTYPE_BZGAS BREAK
        CASE 54 RETURN WEAPONTYPE_STICKYBOMB BREAK
        CASE 55 RETURN WEAPONTYPE_MOLOTOV BREAK
        CASE 56 RETURN WEAPONTYPE_DLC_PROXMINE BREAK
        CASE 57 RETURN WEAPONTYPE_DLC_PIPEBOMB BREAK
        CASE 58 RETURN WEAPONTYPE_DLC_SNOWBALL BREAK
        CASE 59 RETURN WEAPONTYPE_DLC_FLAREGUN BREAK
        CASE 60 RETURN WEAPONTYPE_STUNGUN BREAK
        CASE 61 RETURN WEAPONTYPE_FIREEXTINGUISHER BREAK
        CASE 62 RETURN WEAPONTYPE_PETROLCAN BREAK
        CASE 63 RETURN WEAPONTYPE_KNIFE BREAK
        CASE 64 RETURN WEAPONTYPE_NIGHTSTICK BREAK
        CASE 65 RETURN WEAPONTYPE_HAMMER BREAK
        CASE 66 RETURN WEAPONTYPE_BAT BREAK
        CASE 67 RETURN WEAPONTYPE_CROWBAR BREAK
        CASE 68 RETURN WEAPONTYPE_GOLFCLUB BREAK
        CASE 69 RETURN WEAPONTYPE_DLC_BOTTLE BREAK
        CASE 70 RETURN WEAPONTYPE_DLC_DAGGER BREAK
        CASE 71 RETURN WEAPONTYPE_DLC_KNUCKLE BREAK
        CASE 72 RETURN WEAPONTYPE_DLC_MACHETE BREAK
        CASE 73 RETURN WEAPONTYPE_DLC_SWITCHBLADE BREAK
        CASE 74 RETURN WEAPONTYPE_DLC_BATTLEAXE BREAK
        CASE 75 RETURN WEAPONTYPE_DLC_HATCHET BREAK
        CASE 76 RETURN WEAPONTYPE_DLC_POOLCUE BREAK
        CASE 77 RETURN WEAPONTYPE_DLC_WRENCH BREAK
        CASE 78 RETURN WEAPONTYPE_DLC_RAYPISTOL BREAK
        CASE 79 RETURN WEAPONTYPE_DLC_RAYCARBINE BREAK
        CASE 80 RETURN WEAPONTYPE_DLC_RAYMINIGUN BREAK
        CASE 81 RETURN WEAPONTYPE_DLC_DOUBLEACTION BREAK
        CASE 82 RETURN WEAPONTYPE_DLC_STONE_HATCHET BREAK
        CASE 83 RETURN WEAPONTYPE_DLC_CERAMICPISTOL BREAK
        CASE 84 RETURN WEAPONTYPE_DLC_HAZARDCAN BREAK
        CASE 85 RETURN WEAPONTYPE_DLC_NAVYREVOLVER BREAK
        CASE 86 RETURN WEAPONTYPE_DLC_GADGETPISTOL BREAK
        CASE 87 RETURN WEAPONTYPE_DLC_MILITARYRIFLE BREAK
        CASE 88 RETURN WEAPONTYPE_DLC_COMBATSHOTGUN BREAK
        CASE 89 RETURN WEAPONTYPE_DLC_HEAVYRIFLE BREAK
        CASE 90 RETURN WEAPONTYPE_DLC_EMPLAUNCHER BREAK
        CASE 91 RETURN WEAPONTYPE_DLC_FERTILIZERCAN BREAK
        CASE 92 RETURN WEAPONTYPE_DLC_STUNGUNG_MP BREAK
    ENDSWITCH
    RETURN WEAPONTYPE_PISTOL
ENDFUNC

FUNC INT MENU_WEAPON_AMMO_FOR_CHOICE(INT choice)
    SWITCH choice
        CASE 0 RETURN 9999 BREAK
        CASE 1 RETURN 9999 BREAK
        CASE 2 RETURN 9999 BREAK
        CASE 3 RETURN 9999 BREAK
        CASE 4 RETURN 9999 BREAK
        CASE 5 RETURN 9999 BREAK
        CASE 6 RETURN 9999 BREAK
        CASE 7 RETURN 9999 BREAK
        CASE 8 RETURN 9999 BREAK
        CASE 9 RETURN 9999 BREAK
        CASE 10 RETURN 9999 BREAK
        CASE 11 RETURN 9999 BREAK
        CASE 12 RETURN 9999 BREAK
        CASE 13 RETURN 9999 BREAK
        CASE 14 RETURN 9999 BREAK
        CASE 15 RETURN 9999 BREAK
        CASE 16 RETURN 9999 BREAK
        CASE 17 RETURN 9999 BREAK
        CASE 18 RETURN 9999 BREAK
        CASE 19 RETURN 9999 BREAK
        CASE 20 RETURN 9999 BREAK
        CASE 21 RETURN 9999 BREAK
        CASE 22 RETURN 9999 BREAK
        CASE 23 RETURN 9999 BREAK
        CASE 24 RETURN 9999 BREAK
        CASE 25 RETURN 9999 BREAK
        CASE 26 RETURN 9999 BREAK
        CASE 27 RETURN 9999 BREAK
        CASE 28 RETURN 9999 BREAK
        CASE 29 RETURN 9999 BREAK
        CASE 30 RETURN 9999 BREAK
        CASE 31 RETURN 9999 BREAK
        CASE 32 RETURN 9999 BREAK
        CASE 33 RETURN 9999 BREAK
        CASE 34 RETURN 9999 BREAK
        CASE 35 RETURN 9999 BREAK
        CASE 36 RETURN 9999 BREAK
        CASE 37 RETURN 9999 BREAK
        CASE 38 RETURN 9999 BREAK
        CASE 39 RETURN 9999 BREAK
        CASE 40 RETURN 9999 BREAK
        CASE 41 RETURN 9999 BREAK
        CASE 42 RETURN 9999 BREAK
        CASE 43 RETURN 9999 BREAK
        CASE 44 RETURN 25 BREAK
        CASE 45 RETURN 9999 BREAK
        CASE 46 RETURN 25 BREAK
        CASE 47 RETURN 25 BREAK
        CASE 48 RETURN 25 BREAK
        CASE 49 RETURN 25 BREAK
        CASE 50 RETURN 9999 BREAK
        CASE 51 RETURN 25 BREAK
        CASE 52 RETURN 25 BREAK
        CASE 53 RETURN 25 BREAK
        CASE 54 RETURN 25 BREAK
        CASE 55 RETURN 25 BREAK
        CASE 56 RETURN 25 BREAK
        CASE 57 RETURN 25 BREAK
        CASE 58 RETURN 25 BREAK
        CASE 59 RETURN 25 BREAK
        CASE 60 RETURN 9999 BREAK
        CASE 61 RETURN 9999 BREAK
        CASE 62 RETURN 9999 BREAK
        CASE 63 RETURN 9999 BREAK
        CASE 64 RETURN 9999 BREAK
        CASE 65 RETURN 9999 BREAK
        CASE 66 RETURN 9999 BREAK
        CASE 67 RETURN 9999 BREAK
        CASE 68 RETURN 9999 BREAK
        CASE 69 RETURN 9999 BREAK
        CASE 70 RETURN 9999 BREAK
        CASE 71 RETURN 9999 BREAK
        CASE 72 RETURN 9999 BREAK
        CASE 73 RETURN 9999 BREAK
        CASE 74 RETURN 9999 BREAK
        CASE 75 RETURN 9999 BREAK
        CASE 76 RETURN 9999 BREAK
        CASE 77 RETURN 9999 BREAK
        CASE 78 RETURN 9999 BREAK
        CASE 79 RETURN 9999 BREAK
        CASE 80 RETURN 9999 BREAK
        CASE 81 RETURN 9999 BREAK
        CASE 82 RETURN 9999 BREAK
        CASE 83 RETURN 9999 BREAK
        CASE 84 RETURN 9999 BREAK
        CASE 85 RETURN 9999 BREAK
        CASE 86 RETURN 9999 BREAK
        CASE 87 RETURN 9999 BREAK
        CASE 88 RETURN 9999 BREAK
        CASE 89 RETURN 9999 BREAK
        CASE 90 RETURN 25 BREAK
        CASE 91 RETURN 9999 BREAK
        CASE 92 RETURN 9999 BREAK
    ENDSWITCH
    RETURN 9999
ENDFUNC

FUNC STRING MENU_WEAPON_NAME_FOR_CHOICE(INT choice)
    SWITCH choice
        CASE 0 RETURN TR("Pistol", "Pistola", "手枪", "Pistole", "ピストル", "Пистолет", "Pistola", "Pistolet") BREAK
        CASE 1 RETURN TR("Combat Pistol", "Pistola de combate", "战斗手枪", "Kampfpistole", "コンバットピストル", "Боевой пистолет", "Pistola de Combate", "Pistolet de combat") BREAK
        CASE 2 RETURN TR("AP Pistol", "Pistola perforante", "穿甲手枪", "AP-Pistole", "APピストル", "Бронебойный пистолет", "Pistola AP", "Pistolet perforant") BREAK
        CASE 3 RETURN TR("Pistol .50", "Pistola cal. 50", ".50口径手枪", "Pistole .50", "ピストル .50", "Пистолет .50", "Pistola .50", "Pistolet .50") BREAK
        CASE 4 RETURN TR("SNS Pistol", "Pistola SNS", "劣质手枪", "SNS-Pistole", "SNSピストル", "Карманный пистолет", "Pistola SNS", "Pistolet SNS") BREAK
        CASE 5 RETURN TR("Heavy Pistol", "Pistola pesada", "重型手枪", "Schwere Pistole", "ヘビーピストル", "Тяжёлый пистолет", "Pistola Pesada", "Pistolet lourd") BREAK
        CASE 6 RETURN TR("Vintage Pistol", "Pistola vintage", "古董手枪", "Vintage-Pistole", "ヴィンテージピストル", "Винтажный пистолет", "Pistola Vintage", "Pistolet vintage") BREAK
        CASE 7 RETURN TR("Marksman Pistol", "Pistola de tirador", "射手手枪", "Präzisionspistole", "マークスマンピストル", "Пистолет марксмана", "Pistola de Atirador", "Pistolet de précision") BREAK
        CASE 8 RETURN TR("Heavy Revolver", "Revólver pesado", "重型左轮手枪", "Schwerer Revolver", "ヘビーリボルバー", "Тяжёлый револьвер", "Revólver Pesado", "Revolver lourd") BREAK
        CASE 9 RETURN TR("SNS Pistol Mk II", "Pistola SNS Mk II", "劣质手枪 Mk II", "SNS-Pistole Mk II", "SNSピストル Mk2", "Карманный пистолет Mk II", "Pistola SNS Mk II", "Pistolet SNS Mk II") BREAK
        CASE 10 RETURN TR("Heavy Revolver Mk II", "Revólver pesado Mk II", "重型左轮手枪 Mk II", "Schwerer Revolver Mk II", "ヘビーリボルバー Mk2", "Тяжёлый револьвер Mk II", "Revólver Pesado Mk II", "Revolver lourd Mk II") BREAK
        CASE 11 RETURN TR("Micro SMG", "Microsubfusil", "微型冲锋枪", "Mikro-MP", "マイクロSMG", "Микро-ПП", "Micro SMG", "Pistolet-mitrailleur") BREAK
        CASE 12 RETURN TR("SMG", "Subfusil", "冲锋枪", "MP", "SMG", "ПП", "SMG", "Mitraillette") BREAK
        CASE 13 RETURN TR("Assault SMG", "Subfusil de asalto", "突击冲锋枪", "Sturm-MP", "アサルトSMG", "Штурмовой ПП", "SMG de Assalto", "Mitraillette d'assaut") BREAK
        CASE 14 RETURN TR("Combat PDW", "ADP de combate", "作战自卫冲锋枪", "Kampf-PDW", "コンバットPDW", "Боевой ПДВ", "PDW de Combate", "ADP de combat") BREAK
        CASE 15 RETURN TR("Machine Pistol", "Pistola ametralladora", "冲锋手枪", "Maschinenpistole", "マシンピストル", "Автоматический пистолет", "Pistola Metralhadora", "Pistolet automatique") BREAK
        CASE 16 RETURN TR("Mini SMG", "Minisubfusil", "迷你冲锋枪", "Mini-MP", "ミニSMG", "Мини-ПП", "Mini SMG", "Mini-mitraillette") BREAK
        CASE 17 RETURN TR("Gusenberg Sweeper", "Barredora Gusenberg", "古森柏冲锋枪", "Gusenberg-Bleispritze", "グゼンバーグスイーパー", "Томми-ган", "Gusenberg Sweeper", "Sulfateuse Gusenberg") BREAK
        CASE 18 RETURN TR("Assault Rifle", "Rifle de asalto", "突击步枪", "Sturmgewehr", "アサルトライフル", "Штурмовая винтовка", "Fuzil de Assalto", "Fusil d'assaut") BREAK
        CASE 19 RETURN TR("Carbine Rifle", "Rifle carabina", "卡宾步枪", "Karabinergewehr", "カービンライフル", "Карабин", "Carabina", "Carabine") BREAK
        CASE 20 RETURN TR("Advanced Rifle", "Rifle avanzado", "高级步枪", "Modifiziertes Gewehr", "アドバンストライフル", "Усовершенствованная винтовка", "Fuzil Avançado", "Fusil amélioré") BREAK
        CASE 21 RETURN TR("Special Carbine", "Carabina especial", "特制卡宾步枪", "Spezialkarabiner", "特殊カービン", "Особый карабин", "Carabina Especial", "Carabine spéciale") BREAK
        CASE 22 RETURN TR("Bullpup Rifle", "Rifle bullpup", "无托式步枪", "Bullpup-Gewehr", "ブルパップライフル", "Винтовка булл-пап", "Fuzil Bullpup", "Fusil bullpup") BREAK
        CASE 23 RETURN TR("Compact Rifle", "Rifle compacto", "紧凑型步枪", "Kompaktgewehr", "コンパクトライフル", "Компактная винтовка", "Fuzil Compacto", "Fusil compact") BREAK
        CASE 24 RETURN TR("Assault Rifle Mk II", "Rifle de asalto Mk II", "突击步枪 Mk II", "Sturmgewehr Mk II", "アサルトライフル Mk2", "Штурмовая винтовка Mk II", "Fuzil de Assalto Mk II", "Fusil d'assaut Mk II") BREAK
        CASE 25 RETURN TR("Carbine Rifle Mk II", "Rifle carabina Mk II", "卡宾步枪 Mk II", "Karabinergewehr Mk II", "カービンライフル Mk2", "Карабин Mk II", "Carabina Mk II", "Carabine Mk II") BREAK
        CASE 26 RETURN TR("Special Carbine Mk II", "Carabina especial Mk II", "特制卡宾步枪 Mk II", "Spezialkarabiner Mk II", "特殊カービン Mk2", "Особый карабин Mk II", "Carabina Especial Mk II", "Carabine spéciale Mk II") BREAK
        CASE 27 RETURN TR("Machine Gun", "Ametralladora", "机枪", "Maschinengewehr", "マシンガン", "Пулемёт", "Metralhadora", "Mitrailleuse") BREAK
        CASE 28 RETURN TR("Combat MG", "Ametralladora de combate", "战斗机枪", "Kampf-MG", "コンバットMG", "Боевой пулемёт", "MG de Combate", "Mitrailleuse de combat") BREAK
        CASE 29 RETURN TR("Combat MG Mk II", "Ametralladora de combate Mk II", "战斗机枪 Mk II", "Kampf-MG Mk II", "コンバットMG Mk2", "Боевой пулемёт Mk II", "MG de Combate Mk II", "Mitrailleuse de combat Mk II") BREAK
        CASE 30 RETURN TR("Pump Shotgun", "Escopeta de corredera", "泵动式霰弹枪", "Pump-Action-Schrotflinte", "ポンプ式ショットガン", "Помповый дробовик", "Escopeta Pump", "Fusil à pompe") BREAK
        CASE 31 RETURN TR("Sawed-Off Shotgun", "Escopeta recortada", "短管霰弹枪", "Abgesägte Schrotflinte", "ソードオフ・ショットガン", "Обрез", "Escopeta Serrada", "Fusil à canon scié") BREAK
        CASE 32 RETURN TR("Assault Shotgun", "Escopeta de asalto", "突击霰弹枪", "Sturmschrotflinte", "アサルトショットガン", "Штурмовой дробовик", "Escopeta de Assalto", "Fusil à pompe d'assaut") BREAK
        CASE 33 RETURN TR("Bullpup Shotgun", "Escopeta bullpup", "无托式霰弹枪", "Bullpup-Schrotflinte", "ブルパップショットガン", "Дробовик булл-пап", "Escopeta Bullpup", "Fusil à pompe bullpup") BREAK
        CASE 34 RETURN TR("Heavy Shotgun", "Escopeta pesada", "重型霰弹枪", "Schwere Schrotflinte", "ヘビーショットガン", "Тяжёлый дробовик", "Escopeta Pesada", "Fusil à pompe lourd") BREAK
        CASE 35 RETURN TR("Double Barrel Shotgun", "Escopeta de dos cañones", "双管霰弹枪", "Doppelläufige Schrotflinte", "二連式ショットガン", "Двуствольный дробовик", "Escopeta de Cano Duplo", "Fusil à double canon") BREAK
        CASE 36 RETURN TR("Sweeper Shotgun", "Escopeta barredora", "冲锋霰弹枪", "Streuschrotflinte", "スイーパーショットガン", "Автоматический дробовик", "Escopeta Sweeper", "Fusil à pompe compact") BREAK
        CASE 37 RETURN TR("Pump Shotgun Mk II", "Escopeta de corredera Mk II", "泵动式霰弹枪 Mk II", "Pump-Action-Schrotflinte Mk II", "ポンプ式ショットガン Mk2", "Помповый дробовик Mk II", "Escopeta Pump Mk II", "Fusil à pompe Mk II") BREAK
        CASE 38 RETURN TR("Sniper Rifle", "Rifle de francotirador", "狙击步枪", "Scharfschützengewehr", "スナイパーライフル", "Снайперская винтовка", "Rifle de Precisão", "Fusil de précision") BREAK
        CASE 39 RETURN TR("Heavy Sniper", "Francotirador pesado", "重型狙击步枪", "Schweres Scharfschützengewehr", "ヘビースナイパー", "Тяжёлая снайперская винтовка", "Rifle de Precisão Pesado", "Fusil de précision lourd") BREAK
        CASE 40 RETURN TR("Marksman Rifle", "Rifle de tirador", "射手步枪", "Präzisionsgewehr", "マークスマンライフル", "Высокоточная винтовка", "Rifle de Atirador", "Fusil à lunette") BREAK
        CASE 41 RETURN TR("Heavy Sniper Mk II", "Francotirador pesado Mk II", "重型狙击步枪 Mk II", "Schweres Scharfschützengewehr Mk II", "ヘビースナイパー Mk2", "Тяжёлая снайперская винтовка Mk II", "Rifle de Precisão Pesado Mk II", "Fusil de précision lourd Mk II") BREAK
        CASE 42 RETURN TR("Marksman Rifle Mk II", "Rifle de tirador Mk II", "射手步枪 Mk II", "Präzisionsgewehr Mk II", "マークスマンライフル Mk2", "Высокоточная винтовка Mk II", "Rifle de Atirador Mk II", "Fusil à lunette Mk II") BREAK
        CASE 43 RETURN TR("Grenade Launcher", "Lanzagranadas", "榴弹发射器", "Granatwerfer", "グレネードランチャー", "Гранатомёт", "Lança-granadas", "Lance-grenades") BREAK
        CASE 44 RETURN TR("RPG", "RPG", "火箭筒", "Raketenwerfer", "RPG", "РПГ", "RPG", "Lance-roquettes") BREAK
        CASE 45 RETURN TR("Minigun", "Minigun", "火神机枪", "Minigun", "ミニガン", "Миниган", "Minigun", "Minigun") BREAK
        CASE 46 RETURN TR("Homing Launcher", "Lanzamisiles guiados", "制导火箭发射器", "Lenkraketenwerfer", "ホーミングランチャー", "Самонаводящаяся ракетница", "Lança-mísseis Teleguiado", "Lance-missiles") BREAK
        CASE 47 RETURN TR("Compact Grenade Launcher", "Lanzagranadas compacto", "紧凑型榴弹发射器", "Kompakter Granatwerfer", "コンパクトグレネードランチャー", "Компактный гранатомёт", "Lança-granadas Compacto", "Lance-grenades compact") BREAK
        CASE 48 RETURN TR("Railgun", "Cañón de riel", "电磁步枪", "Railgun", "レールガン", "Рельсотрон", "Canhão Elétrico", "Fusil à impulsion") BREAK
        CASE 49 RETURN TR("Firework Launcher", "Cañón de pirotecnia", "烟花发射器", "Feuerwerkabschussgerät", "花火ランチャー", "Пиротехническая установка", "Lança-fogos", "Lanceur pyrotechnique") BREAK
        CASE 50 RETURN TR("Musket", "Mosquete", "老式火枪", "Muskete", "マスケット銃", "Мушкет", "Mosquete", "Mousquet") BREAK
        CASE 51 RETURN TR("Grenade", "Granada", "手榴弹", "Granate", "手榴弾", "Граната", "Granada", "Grenade") BREAK
        CASE 52 RETURN TR("Tear Gas", "Gas lacrimógeno", "催泪瓦斯", "Tränengas", "催涙ガス", "Слезоточивый газ", "Gás Lacrimogêneo", "Gaz lacrymogène") BREAK
        CASE 53 RETURN TR("BZ Gas", "Gas BZ", "BZ毒气", "BZ-Gas", "BZガス", "Газ BZ", "Gás BZ", "Gaz BZ") BREAK
        CASE 54 RETURN TR("Sticky Bomb", "Bomba adhesiva", "黏弹", "Haftbombe", "粘着爆弾", "Бомба-липучка", "Bomba Adesiva", "Bombe collante") BREAK
        CASE 55 RETURN TR("Molotov", "Molotov", "燃烧瓶", "Molotowcocktail", "火炎瓶", "Коктейль Молотова", "Molotov", "Cocktail Molotov") BREAK
        CASE 56 RETURN TR("Proximity Mine", "Mina de proximidad", "感应地雷", "Annäherungsmine", "近接地雷", "Неконтактная мина", "Mina de Proximidade", "Mine de proximité") BREAK
        CASE 57 RETURN TR("Pipe Bomb", "Bomba casera", "土制炸弹", "Rohrbombe", "パイプ爆弾", "Самодельная бомба", "Bomba Caseira", "Bombe artisanale") BREAK
        CASE 58 RETURN TR("Snowball", "Bola de nieve", "雪球", "Schneeball", "雪玉", "Снежок", "Bola de Neve", "Boule de neige") BREAK
        CASE 59 RETURN TR("Flare Gun", "Pistola de bengalas", "信号枪", "Leuchtpistole", "信号拳銃", "Сигнальный пистолет", "Sinalizador", "Pistolet de détresse") BREAK
        CASE 60 RETURN TR("Stun Gun", "Pistola eléctrica", "电击枪", "Elektroschocker", "スタンガン", "Электрошокер", "Arma de Choque", "Pistolet paralysant") BREAK
        CASE 61 RETURN TR("Fire Extinguisher", "Extintor", "灭火器", "Feuerlöscher", "消火器", "Огнетушитель", "Extintor", "Extincteur") BREAK
        CASE 62 RETURN TR("Jerry Can", "Bidón de gasolina", "汽油桶", "Benzinkanister", "ガソリン携行缶", "Канистра", "Galão de Gasolina", "Jerrycan") BREAK
        CASE 63 RETURN TR("Knife", "Cuchillo", "小刀", "Messer", "ナイフ", "Нож", "Faca", "Couteau") BREAK
        CASE 64 RETURN TR("Nightstick", "Porra", "警棍", "Schlagstock", "警棒", "Полицейская дубинка", "Cassetete", "Matraque") BREAK
        CASE 65 RETURN TR("Hammer", "Martillo", "铁锤", "Hammer", "ハンマー", "Молоток", "Martelo", "Marteau") BREAK
        CASE 66 RETURN TR("Baseball Bat", "Bate de béisbol", "棒球棒", "Baseballschläger", "バット", "Бейсбольная бита", "Taco de Beisebol", "Batte de baseball") BREAK
        CASE 67 RETURN TR("Crowbar", "Palanca", "撬棍", "Brecheisen", "バール", "Монтировка", "Pé de Cabra", "Pied-de-biche") BREAK
        CASE 68 RETURN TR("Golf Club", "Palo de golf", "高尔夫球杆", "Golfschläger", "ゴルフクラブ", "Клюшка для гольфа", "Taco de Golfe", "Club de golf") BREAK
        CASE 69 RETURN TR("BOTTLE", "BOTELLA", "酒瓶", "FLASCHE", "ボトル", "БУТЫЛКА", "GARRAFA", "BOUTEILLE") BREAK
        CASE 70 RETURN TR("DAGGER", "DAGA", "古董骑兵匕首", "DOLCH", "ダガー", "КИНЖАЛ", "ADAGA", "DAGUE") BREAK
        CASE 71 RETURN TR("Knuckle Duster", "Puño americano", "手指虎", "Schlagring", "ナックルダスター", "Кастет", "Soco Inglês", "Poing américain") BREAK
        CASE 72 RETURN TR("MACHETE", "MACHETE", "开山刀", "MACHETE", "マチェット", "МАЧЕТЕ", "MACHETE", "MACHETTE") BREAK
        CASE 73 RETURN TR("Switchblade", "Navaja automática", "弹簧刀", "Springmesser", "スイッチブレード", "Выкидной нож", "Canivete", "Cran d'arrêt") BREAK
        CASE 74 RETURN TR("Battle Axe", "Hacha de combate", "战斧", "Streitaxt", "バトルアックス", "Боевой топор", "Machado de Batalha", "Hache de combat") BREAK
        CASE 75 RETURN TR("HATCHET", "HACHA", "手斧", "BEIL", "手斧", "ТОПОРИК", "MACHADINHA", "HACHETTE") BREAK
        CASE 76 RETURN TR("Pool Cue", "Taco de billar", "台球杆", "Billardqueue", "ビリヤードキュー", "Бильярдный кий", "Taco de Sinuca", "Queue de billard") BREAK
        CASE 77 RETURN TR("WRENCH", "LLAVE INGLESA", "管钳扳手", "ROHRZANGE", "パイプレンチ", "РАЗВОДНОЙ КЛЮЧ", "CHAVE INGLESA", "CLÉ ANGLAISE") BREAK
        CASE 78 RETURN TR("Up-n-Atomizer", "Up-n-Atomizer", "原子能枪", "Up-n-Atomizer", "アトマイザー", "Up-n-Atomizer", "Up-n-Atomizer", "Up-n-Atomizer") BREAK
        CASE 79 RETURN TR("Unholy Hellbringer", "Satanás del infierno", "邪恶冥王", "Heilloser Höllenbote", "ヘルブリンガー", "Нечестивый вестник", "Arauto Infernal", "Déchaîneur infernal") BREAK
        CASE 80 RETURN TR("Widowmaker", "Viuda negra", "寡妇制造者", "Witwenmacher", "ウィドウメイカー", "Вдоводел", "Viúva Negra", "Faiseur de veuves") BREAK
        CASE 81 RETURN TR("Double Action Revolver", "Revólver de doble acción", "双动式左轮手枪", "Double-Action-Revolver", "ダブルアクションリボルバー", "Самовзводный револьвер", "Revólver de Ação Dupla", "Revolver double action") BREAK
        CASE 82 RETURN TR("Stone Hatchet", "Hacha de piedra", "石斧", "Steinbeil", "石斧", "Каменный топор", "Machadinha de Pedra", "Hachette en pierre") BREAK
        CASE 83 RETURN TR("Ceramic Pistol", "Pistola de cerámica", "陶瓷手枪", "Keramikpistole", "セラミックピストル", "Керамический пистолет", "Pistola de Cerâmica", "Pistolet en céramique") BREAK
        CASE 84 RETURN TR("Hazardous Jerry Can", "Bidón de químicos", "危险品罐", "Gefahrstoffkanister", "危険物携行缶", "Канистра с химикатами", "Galão Químico", "Jerrycan de produits dangereux") BREAK
        CASE 85 RETURN TR("Navy Revolver", "Revólver Navy", "海军左轮手枪", "Navy-Revolver", "ネイビーリボルバー", "Флотский револьвер", "Revólver da Marinha", "Revolver de la Navy") BREAK
        CASE 86 RETURN TR("Perico Pistol", "Pistola Perico", "佩里科手枪", "Perico-Pistole", "ペリコピストル", "Пистолет Перико", "Pistola Perico", "Pistolet Perico") BREAK
        CASE 87 RETURN TR("Military Rifle", "Rifle militar", "军用步枪", "Militärgewehr", "ミリタリーライフル", "Военная винтовка", "Fuzil Militar", "Fusil militaire") BREAK
        CASE 88 RETURN TR("Combat Shotgun", "Escopeta de combate", "战斗霰弹枪", "Kampfschrotflinte", "コンバットショットガン", "Боевой дробовик", "Escopeta de Combate", "Fusil à pompe de combat") BREAK
        CASE 89 RETURN TR("Heavy Rifle", "Rifle pesado", "重型步枪", "Schweres Gewehr", "ヘビーライフル", "Тяжёлая винтовка", "Fuzil Pesado", "Fusil lourd") BREAK
        CASE 90 RETURN TR("Compact EMP Launcher", "Lanzador PEM compacto", "紧凑型电磁脉冲发射器", "Kompakter EMP-Werfer", "コンパクトEMPランチャー", "Компактный ЭМИ-гранатомёт", "Lançador de PEM Compacto", "Lanceur IEM compact") BREAK
        CASE 91 RETURN TR("Fertilizer Can", "Bidón de fertilizante", "肥料桶", "Düngerkanister", "肥料携行缶", "Канистра с удобрением", "Galão de Fertilizante", "Jerrycan d'engrais") BREAK
        CASE 92 RETURN TR("Stun Gun MP", "Pistola eléctrica MP", "多人电击枪", "Elektroschocker MP", "スタンガン MP", "Электрошокер MP", "Arma de Choque MP", "Pistolet paralysant MP") BREAK
    ENDSWITCH
    RETURN TR("Pistol", "Pistola", "手枪", "Pistole", "ピストル", "Пистолет", "Pistola", "Pistolet")
ENDFUNC

PROC DRAW_MENU_WEAPON_SELECTOR(FLOAT y, BOOL selected)
    DRAW_OPTION(y, TR("Give Weapon:", "Dar arma:", "给予武器:", "Waffe geben:", "武器を付与:", "Выдать оружие:", "Dar Arma:", "Donner arme:"), MENU_WEAPON_NAME_FOR_CHOICE(g_weapon_choice), selected, 3)
ENDPROC

FUNC WEAPON_TYPE CURRENT_HELD_WEAPON()
    WEAPON_TYPE heldWeapon = WEAPONTYPE_UNARMED
    IF GET_CURRENT_PED_WEAPON(PLAYER_PED_ID(), heldWeapon, TRUE)
        RETURN heldWeapon
    ENDIF
    RETURN GET_SELECTED_PED_WEAPON(PLAYER_PED_ID())
ENDFUNC

FUNC BOOL HELD_WEAPON_EDITABLE()
    WEAPON_TYPE heldWeapon = CURRENT_HELD_WEAPON()
    IF heldWeapon = WEAPONTYPE_UNARMED RETURN FALSE ENDIF
    IF NOT IS_WEAPON_VALID(heldWeapon) RETURN FALSE ENDIF
    IF NOT HAS_PED_GOT_WEAPON(PLAYER_PED_ID(), heldWeapon) RETURN FALSE ENDIF
    WEAPON_GROUP weaponGroup = GET_WEAPONTYPE_GROUP(heldWeapon)
    IF weaponGroup = WEAPONGROUP_MELEE RETURN FALSE ENDIF
    IF weaponGroup = WEAPONGROUP_THROWN RETURN FALSE ENDIF
    IF weaponGroup = WEAPONGROUP_PETROLCAN RETURN FALSE ENDIF
    IF weaponGroup = WEAPONGROUP_FIREEXTINGUISHER RETURN FALSE ENDIF
    IF weaponGroup = WEAPONGROUP_STUNGUN RETURN FALSE ENDIF
    IF heldWeapon = WEAPONTYPE_DLC_SNOWBALL RETURN FALSE ENDIF
    IF heldWeapon = WEAPONTYPE_BALL RETURN FALSE ENDIF
    IF heldWeapon = WEAPONTYPE_STUNGUN RETURN FALSE ENDIF
    IF heldWeapon = WEAPONTYPE_FIREEXTINGUISHER RETURN FALSE ENDIF
    IF heldWeapon = WEAPONTYPE_PETROLCAN RETURN FALSE ENDIF
    IF heldWeapon = WEAPONTYPE_FLARE RETURN FALSE ENDIF
    IF heldWeapon = GADGETTYPE_PARACHUTE RETURN FALSE ENDIF
    RETURN TRUE
ENDFUNC

PROC DRAW_WEAPON_UPGRADES_ENTRY(FLOAT y, BOOL selected)
    WEAPON_TYPE heldWeapon = CURRENT_HELD_WEAPON()
    IF NOT HAS_PED_GOT_WEAPON(PLAYER_PED_ID(), heldWeapon) OR heldWeapon = WEAPONTYPE_UNARMED
        DRAW_OPTION(y, TR("Weapon Upgrades", "Mejoras de arma", "武器升级", "Waffen-Upgrades", "武器アップグレード", "Улучшения оружия", "Melhorias de Arma", "Améliorations d'arme"), TR("NO WEAPON", "SIN ARMA", "无武器", "KEINE WAFFE", "武器なし", "НЕТ ОРУЖИЯ", "SEM ARMA", "AUCUNE ARME"), selected, 0)
    ELIF NOT HELD_WEAPON_EDITABLE()
        DRAW_OPTION(y, TR("Weapon Upgrades", "Mejoras de arma", "武器升级", "Waffen-Upgrades", "武器アップグレード", "Улучшения оружия", "Melhorias de Arma", "Améliorations d'arme"), TR("BAD WEAPON", "ARMA NO VÁLIDA", "不支持的武器", "UNGÜLTIGE WAFFE", "非対応の武器", "НЕПОДХ. ОРУЖИЕ", "ARMA INVÁLIDA", "ARME INVALIDE"), selected, 0)
    ELSE
        DRAW_OPTION(y, TR("Weapon Upgrades", "Mejoras de arma", "武器升级", "Waffen-Upgrades", "武器アップグレード", "Улучшения оружия", "Melhorias de Arma", "Améliorations d'arme"), "OPEN", selected, 2)
    ENDIF
ENDPROC

PROC REFILL_CURRENT_HELD_WEAPON()
    WEAPON_TYPE heldWeapon = CURRENT_HELD_WEAPON()
    INT maxAmmo = 0
    IF NOT HAS_PED_GOT_WEAPON(PLAYER_PED_ID(), heldWeapon) EXIT ENDIF
    IF GET_MAX_AMMO(PLAYER_PED_ID(), heldWeapon, maxAmmo)
        SET_PED_AMMO(PLAYER_PED_ID(), heldWeapon, maxAmmo)
    ENDIF
ENDPROC

FUNC WEAPONCOMPONENT_TYPE HELD_WEAPON_MAG_COMPONENT()
    WEAPON_TYPE heldWeapon = CURRENT_HELD_WEAPON()
    IF heldWeapon = WEAPONTYPE_PISTOL
        IF HAS_PED_GOT_WEAPON_COMPONENT(PLAYER_PED_ID(), heldWeapon, WEAPONCOMPONENT_PISTOL_CLIP_02) RETURN WEAPONCOMPONENT_PISTOL_CLIP_02 ENDIF
        RETURN WEAPONCOMPONENT_PISTOL_CLIP_01
    ENDIF
    IF heldWeapon = WEAPONTYPE_COMBATPISTOL
        IF HAS_PED_GOT_WEAPON_COMPONENT(PLAYER_PED_ID(), heldWeapon, WEAPONCOMPONENT_COMBATPISTOL_CLIP_02) RETURN WEAPONCOMPONENT_COMBATPISTOL_CLIP_02 ENDIF
        RETURN WEAPONCOMPONENT_COMBATPISTOL_CLIP_01
    ENDIF
    IF heldWeapon = WEAPONTYPE_APPISTOL
        IF HAS_PED_GOT_WEAPON_COMPONENT(PLAYER_PED_ID(), heldWeapon, WEAPONCOMPONENT_APPISTOL_CLIP_02) RETURN WEAPONCOMPONENT_APPISTOL_CLIP_02 ENDIF
        RETURN WEAPONCOMPONENT_APPISTOL_CLIP_01
    ENDIF
    IF heldWeapon = WEAPONTYPE_MICROSMG
        IF HAS_PED_GOT_WEAPON_COMPONENT(PLAYER_PED_ID(), heldWeapon, WEAPONCOMPONENT_MICROSMG_CLIP_02) RETURN WEAPONCOMPONENT_MICROSMG_CLIP_02 ENDIF
        RETURN WEAPONCOMPONENT_MICROSMG_CLIP_01
    ENDIF
    IF heldWeapon = WEAPONTYPE_SMG
        IF HAS_PED_GOT_WEAPON_COMPONENT(PLAYER_PED_ID(), heldWeapon, WEAPONCOMPONENT_SMG_CLIP_02) RETURN WEAPONCOMPONENT_SMG_CLIP_02 ENDIF
        RETURN WEAPONCOMPONENT_SMG_CLIP_01
    ENDIF
    IF heldWeapon = WEAPONTYPE_ASSAULTRIFLE
        IF HAS_PED_GOT_WEAPON_COMPONENT(PLAYER_PED_ID(), heldWeapon, WEAPONCOMPONENT_ASSAULTRIFLE_CLIP_02) RETURN WEAPONCOMPONENT_ASSAULTRIFLE_CLIP_02 ENDIF
        RETURN WEAPONCOMPONENT_ASSAULTRIFLE_CLIP_01
    ENDIF
    IF heldWeapon = WEAPONTYPE_CARBINERIFLE
        IF HAS_PED_GOT_WEAPON_COMPONENT(PLAYER_PED_ID(), heldWeapon, WEAPONCOMPONENT_CARBINERIFLE_CLIP_02) RETURN WEAPONCOMPONENT_CARBINERIFLE_CLIP_02 ENDIF
        RETURN WEAPONCOMPONENT_CARBINERIFLE_CLIP_01
    ENDIF
    IF heldWeapon = WEAPONTYPE_ADVANCEDRIFLE
        IF HAS_PED_GOT_WEAPON_COMPONENT(PLAYER_PED_ID(), heldWeapon, WEAPONCOMPONENT_ADVANCEDRIFLE_CLIP_02) RETURN WEAPONCOMPONENT_ADVANCEDRIFLE_CLIP_02 ENDIF
        RETURN WEAPONCOMPONENT_ADVANCEDRIFLE_CLIP_01
    ENDIF
    IF heldWeapon = WEAPONTYPE_MG
        IF HAS_PED_GOT_WEAPON_COMPONENT(PLAYER_PED_ID(), heldWeapon, WEAPONCOMPONENT_MG_CLIP_02) RETURN WEAPONCOMPONENT_MG_CLIP_02 ENDIF
        RETURN WEAPONCOMPONENT_MG_CLIP_01
    ENDIF
    IF heldWeapon = WEAPONTYPE_COMBATMG
        IF HAS_PED_GOT_WEAPON_COMPONENT(PLAYER_PED_ID(), heldWeapon, WEAPONCOMPONENT_COMBATMG_CLIP_02) RETURN WEAPONCOMPONENT_COMBATMG_CLIP_02 ENDIF
        RETURN WEAPONCOMPONENT_COMBATMG_CLIP_01
    ENDIF
    IF heldWeapon = WEAPONTYPE_ASSAULTSHOTGUN
        IF HAS_PED_GOT_WEAPON_COMPONENT(PLAYER_PED_ID(), heldWeapon, WEAPONCOMPONENT_ASSAULTSHOTGUN_CLIP_02) RETURN WEAPONCOMPONENT_ASSAULTSHOTGUN_CLIP_02 ENDIF
        RETURN WEAPONCOMPONENT_ASSAULTSHOTGUN_CLIP_01
    ENDIF
    RETURN WEAPONCOMPONENT_INVALID
ENDFUNC

FUNC WEAPONCOMPONENT_TYPE HELD_WEAPON_FLASHLIGHT_COMPONENT()
    WEAPON_TYPE heldWeapon = CURRENT_HELD_WEAPON()
    IF heldWeapon = WEAPONTYPE_PISTOL RETURN WEAPONCOMPONENT_AT_PI_FLSH ENDIF
    IF heldWeapon = WEAPONTYPE_COMBATPISTOL RETURN WEAPONCOMPONENT_AT_PI_FLSH ENDIF
    IF heldWeapon = WEAPONTYPE_APPISTOL RETURN WEAPONCOMPONENT_AT_PI_FLSH ENDIF
    IF heldWeapon = WEAPONTYPE_MICROSMG RETURN WEAPONCOMPONENT_AT_PI_FLSH ENDIF
    IF heldWeapon = WEAPONTYPE_SMG RETURN WEAPONCOMPONENT_AT_AR_FLSH ENDIF
    IF heldWeapon = WEAPONTYPE_ASSAULTRIFLE RETURN WEAPONCOMPONENT_AT_AR_FLSH ENDIF
    IF heldWeapon = WEAPONTYPE_CARBINERIFLE RETURN WEAPONCOMPONENT_AT_AR_FLSH ENDIF
    IF heldWeapon = WEAPONTYPE_ADVANCEDRIFLE RETURN WEAPONCOMPONENT_AT_AR_FLSH ENDIF
    RETURN WEAPONCOMPONENT_INVALID
ENDFUNC

FUNC WEAPONCOMPONENT_TYPE HELD_WEAPON_SUPPRESSOR_COMPONENT()
    WEAPON_TYPE heldWeapon = CURRENT_HELD_WEAPON()
    IF heldWeapon = WEAPONTYPE_PISTOL RETURN WEAPONCOMPONENT_AT_PI_SUPP ENDIF
    IF heldWeapon = WEAPONTYPE_COMBATPISTOL RETURN WEAPONCOMPONENT_AT_PI_SUPP ENDIF
    IF heldWeapon = WEAPONTYPE_APPISTOL RETURN WEAPONCOMPONENT_AT_PI_SUPP ENDIF
    IF heldWeapon = WEAPONTYPE_SMG RETURN WEAPONCOMPONENT_AT_PI_SUPP ENDIF
    IF heldWeapon = WEAPONTYPE_ASSAULTRIFLE RETURN WEAPONCOMPONENT_AT_AR_SUPP_02 ENDIF
    IF heldWeapon = WEAPONTYPE_CARBINERIFLE RETURN WEAPONCOMPONENT_AT_AR_SUPP ENDIF
    IF heldWeapon = WEAPONTYPE_ADVANCEDRIFLE RETURN WEAPONCOMPONENT_AT_AR_SUPP ENDIF
    RETURN WEAPONCOMPONENT_INVALID
ENDFUNC

FUNC WEAPONCOMPONENT_TYPE HELD_WEAPON_GRIP_COMPONENT()
    WEAPON_TYPE heldWeapon = CURRENT_HELD_WEAPON()
    IF heldWeapon = WEAPONTYPE_ASSAULTRIFLE RETURN WEAPONCOMPONENT_AT_AR_AFGRIP ENDIF
    IF heldWeapon = WEAPONTYPE_CARBINERIFLE RETURN WEAPONCOMPONENT_AT_AR_AFGRIP ENDIF
    IF heldWeapon = WEAPONTYPE_ADVANCEDRIFLE RETURN WEAPONCOMPONENT_AT_AR_AFGRIP ENDIF
    IF heldWeapon = WEAPONTYPE_COMBATMG RETURN WEAPONCOMPONENT_AT_AR_AFGRIP ENDIF
    IF heldWeapon = WEAPONTYPE_ASSAULTSHOTGUN RETURN WEAPONCOMPONENT_AT_AR_AFGRIP ENDIF
    RETURN WEAPONCOMPONENT_INVALID
ENDFUNC

FUNC WEAPONCOMPONENT_TYPE HELD_WEAPON_SCOPE_COMPONENT()
    WEAPON_TYPE heldWeapon = CURRENT_HELD_WEAPON()
    IF heldWeapon = WEAPONTYPE_MICROSMG RETURN WEAPONCOMPONENT_AT_SCOPE_MACRO ENDIF
    IF heldWeapon = WEAPONTYPE_ASSAULTRIFLE RETURN WEAPONCOMPONENT_AT_SCOPE_MACRO ENDIF
    IF heldWeapon = WEAPONTYPE_CARBINERIFLE RETURN WEAPONCOMPONENT_AT_SCOPE_MEDIUM ENDIF
    IF heldWeapon = WEAPONTYPE_ADVANCEDRIFLE RETURN WEAPONCOMPONENT_AT_SCOPE_SMALL ENDIF
    IF heldWeapon = WEAPONTYPE_COMBATMG RETURN WEAPONCOMPONENT_AT_SCOPE_MEDIUM ENDIF
    IF heldWeapon = WEAPONTYPE_SNIPERRIFLE RETURN WEAPONCOMPONENT_AT_SCOPE_LARGE ENDIF
    IF heldWeapon = WEAPONTYPE_HEAVYSNIPER RETURN WEAPONCOMPONENT_AT_SCOPE_MAX ENDIF
    IF heldWeapon = WEAPONTYPE_SMG RETURN WEAPONCOMPONENT_AT_SCOPE_MACRO_02 ENDIF
    IF heldWeapon = WEAPONTYPE_MG RETURN WEAPONCOMPONENT_AT_SCOPE_SMALL_02 ENDIF
    RETURN WEAPONCOMPONENT_INVALID
ENDFUNC

PROC TOGGLE_HELD_WEAPON_COMPONENT(WEAPONCOMPONENT_TYPE component)
    PED_INDEX playerPed = PLAYER_PED_ID()
    WEAPON_TYPE heldWeapon = CURRENT_HELD_WEAPON()
    IF component = WEAPONCOMPONENT_INVALID EXIT ENDIF
    IF NOT HAS_PED_GOT_WEAPON(playerPed, heldWeapon) EXIT ENDIF
    IF HAS_PED_GOT_WEAPON_COMPONENT(playerPed, heldWeapon, component)
        REMOVE_WEAPON_COMPONENT_FROM_PED(playerPed, heldWeapon, component)
    ELSE
        GIVE_WEAPON_COMPONENT_TO_PED(playerPed, heldWeapon, component)
    ENDIF
ENDPROC

PROC DRAW_WEAPON_TINT_SELECTOR(FLOAT y, BOOL selected)
    WEAPON_TYPE heldWeapon = CURRENT_HELD_WEAPON()
    INT tintCount = 0
    IF NOT HELD_WEAPON_EDITABLE()
        DRAW_OPTION(y, TR("Weapon Tint", "Tinte de arma", "武器色调", "Waffenfarbton", "武器カラー", "Расцветка оружия", "Pintura da Arma", "Teinte d'arme"), "N/A", selected, 0)
        EXIT
    ENDIF
    tintCount = GET_WEAPON_TINT_COUNT(heldWeapon)
    IF tintCount <= 0
        DRAW_OPTION(y, TR("Weapon Tint", "Tinte de arma", "武器色调", "Waffenfarbton", "武器カラー", "Расцветка оружия", "Pintura da Arma", "Teinte d'arme"), "N/A", selected, 0)
        EXIT
    ENDIF
    IF g_weapon_tint_choice < 0 g_weapon_tint_choice = 0 ENDIF
    IF g_weapon_tint_choice >= tintCount g_weapon_tint_choice = 0 ENDIF
    IF g_weapon_tint_choice = 0 DRAW_OPTION(y, TR("Weapon Tint", "Tinte de arma", "武器色调", "Waffenfarbton", "武器カラー", "Расцветка оружия", "Pintura da Arma", "Teinte d'arme"), "< Default >", selected, 3) ENDIF
    IF g_weapon_tint_choice = 1 DRAW_OPTION(y, TR("Weapon Tint", "Tinte de arma", "武器色调", "Waffenfarbton", "武器カラー", "Расцветка оружия", "Pintura da Arma", "Teinte d'arme"), TR("< Green >", "< Verde >", "< 绿色 >", "< Grün >", "< グリーン >", "< Зелёный >", "< Verde >", "< Vert >"), selected, 3) ENDIF
    IF g_weapon_tint_choice = 2 DRAW_OPTION(y, TR("Weapon Tint", "Tinte de arma", "武器色调", "Waffenfarbton", "武器カラー", "Расцветка оружия", "Pintura da Arma", "Teinte d'arme"), TR("< Gold >", "< Oro >", "< 金色 >", "< Gold >", "< ゴールド >", "< Золотой >", "< Ouro >", "< Or >"), selected, 3) ENDIF
    IF g_weapon_tint_choice = 3 DRAW_OPTION(y, TR("Weapon Tint", "Tinte de arma", "武器色调", "Waffenfarbton", "武器カラー", "Расцветка оружия", "Pintura da Arma", "Teinte d'arme"), TR("< Pink >", "< Rosa >", "< 粉色 >", "< Pink >", "< ピンク >", "< Розовый >", "< Rosa >", "< Rose >"), selected, 3) ENDIF
    IF g_weapon_tint_choice = 4 DRAW_OPTION(y, TR("Weapon Tint", "Tinte de arma", "武器色调", "Waffenfarbton", "武器カラー", "Расцветка оружия", "Pintura da Arma", "Teinte d'arme"), TR("< Army >", "< Militar >", "< 迷彩 >", "< Armee >", "< アーミー >", "< Армейский >", "< Exército >", "< Armée >"), selected, 3) ENDIF
    IF g_weapon_tint_choice = 5 DRAW_OPTION(y, TR("Weapon Tint", "Tinte de arma", "武器色调", "Waffenfarbton", "武器カラー", "Расцветка оружия", "Pintura da Arma", "Teinte d'arme"), "< LSPD >", selected, 3) ENDIF
    IF g_weapon_tint_choice = 6 DRAW_OPTION(y, TR("Weapon Tint", "Tinte de arma", "武器色调", "Waffenfarbton", "武器カラー", "Расцветка оружия", "Pintura da Arma", "Teinte d'arme"), TR("< Orange >", "< Naranja >", "< 橙色 >", "< Orange >", "< オレンジ >", "< Оранжевый >", "< Laranja >", "< Orange >"), selected, 3) ENDIF
    IF g_weapon_tint_choice = 7 DRAW_OPTION(y, TR("Weapon Tint", "Tinte de arma", "武器色调", "Waffenfarbton", "武器カラー", "Расцветка оружия", "Pintura da Arma", "Teinte d'arme"), TR("< Platinum >", "< Platino >", "< 铂金 >", "< Platin >", "< プラチナ >", "< Платиновый >", "< Platina >", "< Platine >"), selected, 3) ENDIF
ENDPROC

PROC DRAW_WEAPON_UPGRADES_ROW(INT index, FLOAT y)
    PED_INDEX playerPed = PLAYER_PED_ID()
    WEAPON_TYPE heldWeapon = CURRENT_HELD_WEAPON()
    WEAPONCOMPONENT_TYPE component = WEAPONCOMPONENT_INVALID
    IF index = 0 DRAW_OPTION(y, TR("Max Ammo (Held Weapon)", "Munición máx. (arma actual)", "满弹药 (当前武器)", "Max. Munition (akt. Waffe)", "弾薬最大 (所持武器)", "Макс. боезапас (тек. оружие)", "Munição Máx. (Arma Atual)", "Munitions max (arme tenue)"), "APPLY", g_item = index, 2) ENDIF
    IF index = 1
        component = HELD_WEAPON_MAG_COMPONENT()
        IF component = WEAPONCOMPONENT_INVALID
            DRAW_OPTION(y, TR("Extended Mag", "Cargador ampliado", "扩容弹匣", "Erweitertes Magazin", "拡張マガジン", "Увеличенный магазин", "Carregador Estendido", "Chargeur grande capacité"), "N/A", g_item = index, 0)
        ELIF HAS_PED_GOT_WEAPON_COMPONENT(playerPed, heldWeapon, component)
            DRAW_OPTION(y, TR("Extended Mag", "Cargador ampliado", "扩容弹匣", "Erweitertes Magazin", "拡張マガジン", "Увеличенный магазин", "Carregador Estendido", "Chargeur grande capacité"), "ON", g_item = index, 1)
        ELSE
            DRAW_OPTION(y, TR("Extended Mag", "Cargador ampliado", "扩容弹匣", "Erweitertes Magazin", "拡張マガジン", "Увеличенный магазин", "Carregador Estendido", "Chargeur grande capacité"), "OFF", g_item = index, 0)
        ENDIF
    ENDIF
    IF index = 2
        component = HELD_WEAPON_FLASHLIGHT_COMPONENT()
        IF component = WEAPONCOMPONENT_INVALID
            DRAW_OPTION(y, TR("Flashlight", "Linterna", "手电筒", "Taschenlampe", "フラッシュライト", "Фонарик", "Lanterna", "Torche"), "N/A", g_item = index, 0)
        ELIF HAS_PED_GOT_WEAPON_COMPONENT(playerPed, heldWeapon, component)
            DRAW_OPTION(y, TR("Flashlight", "Linterna", "手电筒", "Taschenlampe", "フラッシュライト", "Фонарик", "Lanterna", "Torche"), "ON", g_item = index, 1)
        ELSE
            DRAW_OPTION(y, TR("Flashlight", "Linterna", "手电筒", "Taschenlampe", "フラッシュライト", "Фонарик", "Lanterna", "Torche"), "OFF", g_item = index, 0)
        ENDIF
    ENDIF
    IF index = 3
        component = HELD_WEAPON_SUPPRESSOR_COMPONENT()
        IF component = WEAPONCOMPONENT_INVALID
            DRAW_OPTION(y, TR("Suppressor", "Silenciador", "消音器", "Schalldämpfer", "サプレッサー", "Глушитель", "Supressor", "Silencieux"), "N/A", g_item = index, 0)
        ELIF HAS_PED_GOT_WEAPON_COMPONENT(playerPed, heldWeapon, component)
            DRAW_OPTION(y, TR("Suppressor", "Silenciador", "消音器", "Schalldämpfer", "サプレッサー", "Глушитель", "Supressor", "Silencieux"), "ON", g_item = index, 1)
        ELSE
            DRAW_OPTION(y, TR("Suppressor", "Silenciador", "消音器", "Schalldämpfer", "サプレッサー", "Глушитель", "Supressor", "Silencieux"), "OFF", g_item = index, 0)
        ENDIF
    ENDIF
    IF index = 4
        component = HELD_WEAPON_GRIP_COMPONENT()
        IF component = WEAPONCOMPONENT_INVALID
            DRAW_OPTION(y, TR("Grip", "Empuñadura", "握把", "Griff", "グリップ", "Рукоятка", "Empunhadura", "Poignée"), "N/A", g_item = index, 0)
        ELIF HAS_PED_GOT_WEAPON_COMPONENT(playerPed, heldWeapon, component)
            DRAW_OPTION(y, TR("Grip", "Empuñadura", "握把", "Griff", "グリップ", "Рукоятка", "Empunhadura", "Poignée"), "ON", g_item = index, 1)
        ELSE
            DRAW_OPTION(y, TR("Grip", "Empuñadura", "握把", "Griff", "グリップ", "Рукоятка", "Empunhadura", "Poignée"), "OFF", g_item = index, 0)
        ENDIF
    ENDIF
    IF index = 5
        component = HELD_WEAPON_SCOPE_COMPONENT()
        IF component = WEAPONCOMPONENT_INVALID
            DRAW_OPTION(y, TR("Scope", "Mira", "瞄准镜", "Zielfernrohr", "スコープ", "Прицел", "Mira", "Lunette"), "N/A", g_item = index, 0)
        ELIF HAS_PED_GOT_WEAPON_COMPONENT(playerPed, heldWeapon, component)
            DRAW_OPTION(y, TR("Scope", "Mira", "瞄准镜", "Zielfernrohr", "スコープ", "Прицел", "Mira", "Lunette"), "ON", g_item = index, 1)
        ELSE
            DRAW_OPTION(y, TR("Scope", "Mira", "瞄准镜", "Zielfernrohr", "スコープ", "Прицел", "Mira", "Lunette"), "OFF", g_item = index, 0)
        ENDIF
    ENDIF
    IF index = 6 DRAW_WEAPON_TINT_SELECTOR(y, g_item = index) ENDIF
ENDPROC

PROC DRAW_WEAPON_UPGRADES_PAGE()
    MENU_TEXT(g_menu_x - 0.130, 0.198, 0.270, 255, 255, 255, TR("WEAPON UPGRADES", "MEJORAS DE ARMA", "武器升级", "WAFFEN-UPGRADES", "武器アップグレード", "УЛУЧШЕНИЯ ОРУЖИЯ", "MELHORIAS DE ARMA", "AMÉLIORATIONS D'ARME"))
    DRAW_MENU_VERSION_TAG()
    INT index = g_weapon_upgrades_scroll
    INT row = 0
    WHILE row < 8 AND index < 7
        DRAW_WEAPON_UPGRADES_ROW(index, 0.268 + (TO_FLOAT(row) * ROW_H))
        index = index + 1
        row = row + 1
    ENDWHILE
ENDPROC

PROC DRAW_SPECIAL_GUN_SELECTOR(FLOAT y, BOOL selected)
    SWITCH g_special_gun_mode
        CASE 0 DRAW_OPTION(y, TR("Special Gun:", "Arma especial:", "特殊枪械:", "Spezialwaffe:", "特殊ガン:", "Особое оружие:", "Arma Especial:", "Arme spéciale:"), "< OFF >", selected, 0) BREAK
        CASE 1 DRAW_OPTION(y, TR("Special Gun:", "Arma especial:", "特殊枪械:", "Spezialwaffe:", "特殊ガン:", "Особое оружие:", "Arma Especial:", "Arme spéciale:"), TR("< Gravity Gun >", "< Arma gravitatoria >", "< 重力枪 >", "< Gravitationswaffe >", "< グラビティガン >", "< Гравипушка >", "< Arma de Gravidade >", "< Fusil à gravité >"), selected, 3) BREAK
        CASE 2 DRAW_OPTION(y, TR("Special Gun:", "Arma especial:", "特殊枪械:", "Spezialwaffe:", "特殊ガン:", "Особое оружие:", "Arma Especial:", "Arme spéciale:"), TR("< Teleport Gun >", "< Arma de teletransporte >", "< 传送枪 >", "< Teleportwaffe >", "< テレポートガン >", "< Телепорт-пушка >", "< Arma de Teleporte >", "< Fusil de téléportation >"), selected, 3) BREAK
        CASE 3 DRAW_OPTION(y, TR("Special Gun:", "Arma especial:", "特殊枪械:", "Spezialwaffe:", "特殊ガン:", "Особое оружие:", "Arma Especial:", "Arme spéciale:"), TR("< Delete Gun >", "< Arma borradora >", "< 删除枪 >", "< Löschwaffe >", "< 消去ガン >", "< Пушка удаления >", "< Arma de Exclusão >", "< Fusil de suppression >"), selected, 3) BREAK
        CASE 4 DRAW_OPTION(y, TR("Special Gun:", "Arma especial:", "特殊枪械:", "Spezialwaffe:", "特殊ガン:", "Особое оружие:", "Arma Especial:", "Arme spéciale:"), TR("< Airstrike Gun >", "< Arma de ataque aéreo >", "< 空袭枪 >", "< Luftschlagwaffe >", "< 空爆ガン >", "< Пушка авиаудара >", "< Arma de Ataque Aéreo >", "< Fusil de frappe aérienne >"), selected, 3) BREAK
        CASE 5 DRAW_OPTION(y, TR("Special Gun:", "Arma especial:", "特殊枪械:", "Spezialwaffe:", "特殊ガン:", "Особое оружие:", "Arma Especial:", "Arme spéciale:"), TR("< Vehicle Gun >", "< Cañón de vehículos >", "< 载具枪 >", "< Fahrzeugwaffe >", "< 乗り物ガン >", "< Пушка транспорта >", "< Canhão de Veículos >", "< Canon à véhicules >"), selected, 3) BREAK
        CASE 6 DRAW_OPTION(y, TR("Special Gun:", "Arma especial:", "特殊枪械:", "Spezialwaffe:", "特殊ガン:", "Особое оружие:", "Arma Especial:", "Arme spéciale:"), TR("< Force Gun >", "< Arma de impulso >", "< 冲击波枪 >", "< Kraftstoßwaffe >", "< フォースガン >", "< Силовая пушка >", "< Arma de Impulso >", "< Fusil à impulsion >"), selected, 3) BREAK
        CASE 7 DRAW_OPTION(y, TR("Special Gun:", "Arma especial:", "特殊枪械:", "Spezialwaffe:", "特殊ガン:", "Особое оружие:", "Arma Especial:", "Arme spéciale:"), TR("< PED Gun >", "< Cañón de peatones >", "< 行人枪 >", "< Passantenwaffe >", "< PEDガン >", "< Пушка педов >", "< Canhão de Pedestres >", "< Canon à piétons >"), selected, 3) BREAK
    ENDSWITCH
ENDPROC

FUNC VECTOR GAMEPLAY_CAM_FORWARD_VECTOR()
    VECTOR rot = GET_GAMEPLAY_CAM_ROT(EULER_YXZ)
    FLOAT cosPitch = COS(rot.x)
    VECTOR fwd = <<0.0, 0.0, 0.0>>
    fwd.x = -SIN(rot.z) * cosPitch
    fwd.y = COS(rot.z) * cosPitch
    fwd.z = SIN(rot.x)
    RETURN fwd
ENDFUNC

PROC RELEASE_GRAVITY_GUN_ENTITY()
    g_gravity_gun_holding = FALSE
    g_gravity_gun_entity = NULL
ENDPROC

FUNC BOOL ACQUIRE_SPECIAL_GUN_TARGET_ENTITY(ENTITY_INDEX &outEntity)
    PED_INDEX playerPed = PLAYER_PED_ID()
    VEHICLE_INDEX playerVeh = NULL
    PED_INDEX hitPed = NULL
    VEHICLE_INDEX hitVeh = NULL
    OBJECT_INDEX hitObj = NULL
    VEHICLE_INDEX nearVeh = NULL
    PED_INDEX nearPed = NULL
    VECTOR camPos = GET_GAMEPLAY_CAM_COORD()
    VECTOR camFwd = GAMEPLAY_CAM_FORWARD_VECTOR()
    VECTOR probePos = <<0.0, 0.0, 0.0>>
    INT probeStep = 1

    IF IS_PED_IN_ANY_VEHICLE(playerPed)
        playerVeh = GET_VEHICLE_PED_IS_IN(playerPed)
    ENDIF

    outEntity = NULL
    IF NOT GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER_ID(), outEntity)
        GET_PLAYER_TARGET_ENTITY(PLAYER_ID(), outEntity)
    ENDIF

    IF DOES_ENTITY_EXIST(outEntity)
        IF IS_ENTITY_A_PED(outEntity)
            hitPed = GET_PED_INDEX_FROM_ENTITY_INDEX(outEntity)
            IF hitPed = playerPed OR hitPed = g_chauffeur_driver
                outEntity = NULL
            ELIF IS_PED_IN_ANY_VEHICLE(hitPed)
                outEntity = GET_VEHICLE_PED_IS_IN(hitPed)
            ENDIF
        ENDIF
        IF DOES_ENTITY_EXIST(outEntity) AND IS_ENTITY_A_VEHICLE(outEntity)
            hitVeh = GET_VEHICLE_INDEX_FROM_ENTITY_INDEX(outEntity)
            IF hitVeh = playerVeh OR hitVeh = g_vehicle_preview_vehicle OR hitVeh = g_chauffeur_vehicle
                outEntity = NULL
            ENDIF
        ENDIF
        IF DOES_ENTITY_EXIST(outEntity) AND IS_ENTITY_AN_OBJECT(outEntity)
            hitObj = GET_OBJECT_INDEX_FROM_ENTITY_INDEX(outEntity)
            IF hitObj = g_spooner_preview_object
                outEntity = NULL
            ENDIF
        ENDIF
        IF DOES_ENTITY_EXIST(outEntity)
            RETURN TRUE
        ENDIF
    ENDIF

    WHILE probeStep <= 3
        probePos = camPos + (camFwd * (TO_FLOAT(probeStep) * 6.0))
        nearVeh = GET_CLOSEST_VEHICLE(probePos, 4.5, ADDER, 70)
        IF DOES_ENTITY_EXIST(nearVeh) AND nearVeh != playerVeh AND nearVeh != g_vehicle_preview_vehicle AND nearVeh != g_chauffeur_vehicle
            outEntity = nearVeh
            RETURN TRUE
        ENDIF
        IF GET_CLOSEST_PED(probePos, 3.5, TRUE, TRUE, nearPed)
            IF DOES_ENTITY_EXIST(nearPed) AND nearPed != playerPed AND nearPed != g_chauffeur_driver
                outEntity = nearPed
                RETURN TRUE
            ENDIF
        ENDIF
        probeStep = probeStep + 1
    ENDWHILE
    RETURN FALSE
ENDFUNC

PROC CLEAR_PROJECTILE_SLOT()
    IF DOES_ENTITY_EXIST(g_projectile_vehicles[g_projectile_slot])
        SET_ENTITY_AS_MISSION_ENTITY(g_projectile_vehicles[g_projectile_slot], TRUE, TRUE)
        DELETE_VEHICLE(g_projectile_vehicles[g_projectile_slot])
    ENDIF
    IF DOES_ENTITY_EXIST(g_projectile_peds[g_projectile_slot])
        SET_ENTITY_AS_MISSION_ENTITY(g_projectile_peds[g_projectile_slot], TRUE, TRUE)
        DELETE_PED(g_projectile_peds[g_projectile_slot])
    ENDIF
    g_projectile_vehicles[g_projectile_slot] = NULL
    g_projectile_peds[g_projectile_slot] = NULL
ENDPROC

PROC START_SPECIAL_GUN_PROJECTILE(INT kind)
    IF g_special_gun_spawn_pending OR GET_GAME_TIMER() < g_special_gun_cooldown EXIT ENDIF
    g_special_gun_spawn_kind = kind
    IF kind = 1
        SWITCH GET_RANDOM_INT_IN_RANGE(0, 5)
            CASE 0 g_special_gun_spawn_model = ADDER BREAK
            CASE 1 g_special_gun_spawn_model = BUFFALO BREAK
            CASE 2 g_special_gun_spawn_model = SULTAN BREAK
            CASE 3 g_special_gun_spawn_model = INFERNUS BREAK
            CASE 4 g_special_gun_spawn_model = BANSHEE BREAK
        ENDSWITCH
    ELSE
        // Start at index 32 so aquatic animals (fish/whales/sharks/dolphins at 3..31) are excluded.
        g_special_gun_spawn_model = PED_MODEL_FOR_CHOICE(GET_RANDOM_INT_IN_RANGE(32, 120))
    ENDIF
    IF NOT IS_MODEL_IN_CDIMAGE(g_special_gun_spawn_model) OR NOT IS_MODEL_VALID(g_special_gun_spawn_model) EXIT ENDIF
    g_special_gun_shot_dir = GAMEPLAY_CAM_FORWARD_VECTOR()
    REQUEST_MODEL(g_special_gun_spawn_model)
    g_special_gun_spawn_pending = TRUE
    g_special_gun_request_time = GET_GAME_TIMER()
ENDPROC

PROC FINISH_SPECIAL_GUN_PROJECTILE()
    PED_INDEX spawnedPed = NULL
    VEHICLE_INDEX spawnedVehicle = NULL
    VECTOR camPos = GET_GAMEPLAY_CAM_COORD()
    VECTOR spawnPos = camPos + (g_special_gun_shot_dir * 5.5)
    VECTOR launchVel = g_special_gun_shot_dir * 70.0
    FLOAT heading = GET_ENTITY_HEADING(PLAYER_PED_ID())

    CLEAR_PROJECTILE_SLOT()
    IF g_special_gun_spawn_kind = 2
        spawnPos = camPos + (g_special_gun_shot_dir * 3.8)
        spawnedPed = CREATE_PED(PEDTYPE_CIVMALE, g_special_gun_spawn_model, spawnPos, heading, FALSE, TRUE)
        IF DOES_ENTITY_EXIST(spawnedPed)
            SET_ENTITY_AS_MISSION_ENTITY(spawnedPed, TRUE, TRUE)
            SET_PED_TO_RAGDOLL(spawnedPed, 5000, 5000, TASK_NM_SCRIPT, TRUE, TRUE, FALSE)
            SET_ENTITY_VELOCITY(spawnedPed, launchVel)
            APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(spawnedPed, APPLY_TYPE_EXTERNAL_IMPULSE, launchVel, 0, FALSE, TRUE)
            g_projectile_peds[g_projectile_slot] = spawnedPed
        ENDIF
    ELSE
        spawnedVehicle = CREATE_VEHICLE(g_special_gun_spawn_model, spawnPos, heading, FALSE)
        IF DOES_ENTITY_EXIST(spawnedVehicle)
            SET_ENTITY_AS_MISSION_ENTITY(spawnedVehicle, TRUE, TRUE)
            SET_VEHICLE_FORWARD_SPEED(spawnedVehicle, 65.0)
            SET_ENTITY_VELOCITY(spawnedVehicle, launchVel)
            g_projectile_vehicles[g_projectile_slot] = spawnedVehicle
        ENDIF
    ENDIF
    SET_MODEL_AS_NO_LONGER_NEEDED(g_special_gun_spawn_model)
    g_projectile_slot = g_projectile_slot + 1
    IF g_projectile_slot > 15 g_projectile_slot = 0 ENDIF
    g_special_gun_spawn_pending = FALSE
    g_special_gun_cooldown = GET_GAME_TIMER() + 260
ENDPROC

PROC PROCESS_GRAVITY_GUN()
    BOOL aiming = IS_PLAYER_FREE_AIMING(PLAYER_ID()) OR IS_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_AIM) OR IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_AIM)
    BOOL shotPressed = IS_PED_SHOOTING(PLAYER_PED_ID()) OR IS_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_ATTACK) OR IS_DISABLED_CONTROL_JUST_PRESSED(PLAYER_CONTROL, INPUT_ATTACK)
    VECTOR camPos = <<0.0, 0.0, 0.0>>
    VECTOR camFwd = <<0.0, 0.0, 0.0>>
    VECTOR holdPos = <<0.0, 0.0, 0.0>>
    VECTOR entPos = <<0.0, 0.0, 0.0>>
    VECTOR pullVel = <<0.0, 0.0, 0.0>>
    PED_INDEX heldPed = NULL

    IF NOT aiming
        IF g_gravity_gun_holding
            RELEASE_GRAVITY_GUN_ENTITY()
        ENDIF
        EXIT
    ENDIF

    camPos = GET_GAMEPLAY_CAM_COORD()
    camFwd = GAMEPLAY_CAM_FORWARD_VECTOR()

    IF NOT g_gravity_gun_holding
        IF GET_GAME_TIMER() < g_gravity_gun_release_time
            EXIT
        ENDIF
        IF ACQUIRE_SPECIAL_GUN_TARGET_ENTITY(g_gravity_gun_entity)
            g_gravity_gun_holding = TRUE
            entPos = GET_ENTITY_COORDS(g_gravity_gun_entity)
            g_gravity_gun_distance = GET_DISTANCE_BETWEEN_COORDS(camPos, entPos, TRUE)
            IF g_gravity_gun_distance < 5.0 g_gravity_gun_distance = 5.0 ENDIF
            IF g_gravity_gun_distance > 25.0 g_gravity_gun_distance = 25.0 ENDIF
        ENDIF
    ENDIF

    IF NOT g_gravity_gun_holding OR NOT DOES_ENTITY_EXIST(g_gravity_gun_entity)
        RELEASE_GRAVITY_GUN_ENTITY()
        EXIT
    ENDIF

    IF NOT g_open
        DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_PHONE, TRUE)
        DISABLE_CONTROL_ACTION(PLAYER_CONTROL, INPUT_CHARACTER_WHEEL, TRUE)
        IF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_PHONE) OR IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_UP)
            g_gravity_gun_distance = g_gravity_gun_distance + 0.35
            IF g_gravity_gun_distance > 40.0 g_gravity_gun_distance = 40.0 ENDIF
        ENDIF
        IF IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_CHARACTER_WHEEL) OR IS_DISABLED_CONTROL_PRESSED(PLAYER_CONTROL, INPUT_FRONTEND_DOWN)
            g_gravity_gun_distance = g_gravity_gun_distance - 0.35
            IF g_gravity_gun_distance < 4.0 g_gravity_gun_distance = 4.0 ENDIF
        ENDIF
    ENDIF

    IF IS_ENTITY_A_PED(g_gravity_gun_entity)
        heldPed = GET_PED_INDEX_FROM_ENTITY_INDEX(g_gravity_gun_entity)
        IF DOES_ENTITY_EXIST(heldPed) AND NOT IS_PED_RAGDOLL(heldPed)
            SET_PED_TO_RAGDOLL(heldPed, 1500, 1500, TASK_NM_SCRIPT, TRUE, TRUE, FALSE)
        ENDIF
    ENDIF

    IF shotPressed
        SET_ENTITY_VELOCITY(g_gravity_gun_entity, (camFwd * 75.0) + <<0.0, 0.0, 6.0>>)
        APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(g_gravity_gun_entity, APPLY_TYPE_EXTERNAL_IMPULSE, (camFwd * 85.0) + <<0.0, 0.0, 8.0>>, 0, FALSE, TRUE)
        g_gravity_gun_release_time = GET_GAME_TIMER() + 350
        RELEASE_GRAVITY_GUN_ENTITY()
        EXIT
    ENDIF

    holdPos = camPos + (camFwd * g_gravity_gun_distance)
    entPos = GET_ENTITY_COORDS(g_gravity_gun_entity)
    pullVel = (holdPos - entPos) * 8.5
    SET_ENTITY_VELOCITY(g_gravity_gun_entity, pullVel)
ENDPROC

PROC PROCESS_SPECIAL_GUN()
    PED_INDEX playerPed = PLAYER_PED_ID()
    ENTITY_INDEX targetEnt = NULL
    VEHICLE_INDEX targetVeh = NULL
    PED_INDEX targetPed = NULL
    OBJECT_INDEX targetObj = NULL
    VECTOR impactPos = <<0.0, 0.0, 0.0>>
    VECTOR camPos = <<0.0, 0.0, 0.0>>
    VECTOR camFwd = <<0.0, 0.0, 0.0>>
    VECTOR skyStart = <<0.0, 0.0, 0.0>>
    VECTOR strikePos = <<0.0, 0.0, 0.0>>
    VECTOR pushVel = <<0.0, 0.0, 0.0>>
    INT cleanIdx = 0

    // Drain any active airstrike barrage even if the player stops shooting.
    IF g_airstrike_bursts_left > 0 AND GET_GAME_TIMER() >= g_airstrike_next_ms
        strikePos = g_airstrike_target
        strikePos.x = strikePos.x + GET_RANDOM_FLOAT_IN_RANGE(-7.0, 7.0)
        strikePos.y = strikePos.y + GET_RANDOM_FLOAT_IN_RANGE(-7.0, 7.0)
        skyStart = strikePos + <<GET_RANDOM_FLOAT_IN_RANGE(-10.0, 10.0), GET_RANDOM_FLOAT_IN_RANGE(-10.0, 10.0), 65.0>>
        SHOOT_SINGLE_BULLET_BETWEEN_COORDS(skyStart, strikePos, 250, TRUE, WEAPONTYPE_RPG, playerPed, TRUE, FALSE, 120.0)
        ADD_EXPLOSION(strikePos, EXP_TAG_HI_OCTANE, 1.0, TRUE, FALSE, 0.6)
        g_airstrike_bursts_left = g_airstrike_bursts_left - 1
        g_airstrike_next_ms = GET_GAME_TIMER() + 140
    ENDIF

    // Drain any pending Vehicle Gun / PED Gun model request.
    IF g_special_gun_spawn_pending
        IF HAS_MODEL_LOADED(g_special_gun_spawn_model)
            FINISH_SPECIAL_GUN_PROJECTILE()
        ELIF GET_GAME_TIMER() > g_special_gun_request_time + 5000
            SET_MODEL_AS_NO_LONGER_NEEDED(g_special_gun_spawn_model)
            g_special_gun_spawn_pending = FALSE
        ENDIF
    ENDIF

    IF NOT DOES_ENTITY_EXIST(playerPed) OR IS_ENTITY_DEAD(playerPed)
        IF g_gravity_gun_holding
            RELEASE_GRAVITY_GUN_ENTITY()
        ENDIF
        EXIT
    ENDIF

    IF g_special_gun_mode = 0
        IF g_gravity_gun_holding
            RELEASE_GRAVITY_GUN_ENTITY()
        ENDIF
        IF g_special_gun_clean_needed
            REPEAT 16 cleanIdx
                IF DOES_ENTITY_EXIST(g_projectile_vehicles[cleanIdx])
                    SET_VEHICLE_AS_NO_LONGER_NEEDED(g_projectile_vehicles[cleanIdx])
                    g_projectile_vehicles[cleanIdx] = NULL
                ENDIF
                IF DOES_ENTITY_EXIST(g_projectile_peds[cleanIdx])
                    SET_PED_AS_NO_LONGER_NEEDED(g_projectile_peds[cleanIdx])
                    g_projectile_peds[cleanIdx] = NULL
                ENDIF
            ENDREPEAT
            g_special_gun_clean_needed = FALSE
        ENDIF
        EXIT
    ENDIF
    g_special_gun_clean_needed = TRUE

    IF g_special_gun_mode = 1
        PROCESS_GRAVITY_GUN()
        EXIT
    ENDIF

    IF g_gravity_gun_holding
        RELEASE_GRAVITY_GUN_ENTITY()
    ENDIF

    IF g_open OR NOT IS_PED_SHOOTING(playerPed)
        EXIT
    ENDIF

    camPos = GET_GAMEPLAY_CAM_COORD()
    camFwd = GAMEPLAY_CAM_FORWARD_VECTOR()

    SWITCH g_special_gun_mode
        CASE 2
            // Teleport Gun: use exact 3D impact coordinate without 2D-blip Z<=1.0 ground-probe override
            IF NOT GET_PED_LAST_WEAPON_IMPACT_COORD(playerPed, impactPos)
                impactPos = camPos + (camFwd * 45.0)
            ENDIF
            START_TELEPORT(impactPos)
        BREAK
        CASE 3
            // Delete Gun
            IF ACQUIRE_SPECIAL_GUN_TARGET_ENTITY(targetEnt)
                IF IS_ENTITY_A_VEHICLE(targetEnt)
                    targetVeh = GET_VEHICLE_INDEX_FROM_ENTITY_INDEX(targetEnt)
                    SET_ENTITY_AS_MISSION_ENTITY(targetVeh, TRUE, TRUE)
                    DELETE_VEHICLE(targetVeh)
                ELIF IS_ENTITY_A_PED(targetEnt)
                    targetPed = GET_PED_INDEX_FROM_ENTITY_INDEX(targetEnt)
                    SET_ENTITY_AS_MISSION_ENTITY(targetPed, TRUE, TRUE)
                    DELETE_PED(targetPed)
                ELIF IS_ENTITY_AN_OBJECT(targetEnt)
                    targetObj = GET_OBJECT_INDEX_FROM_ENTITY_INDEX(targetEnt)
                    SET_ENTITY_AS_MISSION_ENTITY(targetObj, TRUE, TRUE)
                    DELETE_OBJECT(targetObj)
                ENDIF
            ENDIF
        BREAK
        CASE 4
            // Airstrike Gun
            IF NOT GET_PED_LAST_WEAPON_IMPACT_COORD(playerPed, impactPos)
                impactPos = camPos + (camFwd * 55.0)
            ENDIF
            g_airstrike_target = impactPos
            g_airstrike_bursts_left = 6
            g_airstrike_next_ms = GET_GAME_TIMER()
        BREAK
        CASE 5
            // Vehicle Gun
            START_SPECIAL_GUN_PROJECTILE(1)
        BREAK
        CASE 6
            // Force Gun
            pushVel = (camFwd * 85.0) + <<0.0, 0.0, 12.0>>
            IF ACQUIRE_SPECIAL_GUN_TARGET_ENTITY(targetEnt)
                IF IS_ENTITY_A_PED(targetEnt)
                    targetPed = GET_PED_INDEX_FROM_ENTITY_INDEX(targetEnt)
                    SET_PED_TO_RAGDOLL(targetPed, 4000, 4000, TASK_NM_SCRIPT, TRUE, TRUE, FALSE)
                ENDIF
                SET_ENTITY_VELOCITY(targetEnt, pushVel)
                APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(targetEnt, APPLY_TYPE_EXTERNAL_IMPULSE, pushVel, 0, FALSE, TRUE)
            ENDIF
            IF GET_PED_LAST_WEAPON_IMPACT_COORD(playerPed, impactPos)
                targetVeh = GET_CLOSEST_VEHICLE(impactPos, 8.0, ADDER, 70)
                IF DOES_ENTITY_EXIST(targetVeh) AND targetVeh != g_vehicle_preview_vehicle AND targetVeh != g_chauffeur_vehicle AND ( NOT IS_PED_IN_ANY_VEHICLE(playerPed) OR targetVeh != GET_VEHICLE_PED_IS_IN(playerPed) )
                    SET_ENTITY_VELOCITY(targetVeh, pushVel)
                    APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(targetVeh, APPLY_TYPE_EXTERNAL_IMPULSE, pushVel, 0, FALSE, TRUE)
                ENDIF
                IF GET_CLOSEST_PED(impactPos, 8.0, TRUE, TRUE, targetPed)
                    IF DOES_ENTITY_EXIST(targetPed) AND targetPed != playerPed AND targetPed != g_chauffeur_driver
                        SET_PED_TO_RAGDOLL(targetPed, 4000, 4000, TASK_NM_SCRIPT, TRUE, TRUE, FALSE)
                        SET_ENTITY_VELOCITY(targetPed, pushVel)
                    ENDIF
                ENDIF
            ENDIF
        BREAK
        CASE 7
            // PED Gun
            START_SPECIAL_GUN_PROJECTILE(2)
        BREAK
    ENDSWITCH
ENDPROC

PROC GIVE_SELECTED_MENU_WEAPON(PED_INDEX ped)
    IF g_weapon_choice < 0 OR g_weapon_choice >= MENU_WEAPON_COUNT() EXIT ENDIF
    GIVE_DELAYED_WEAPON_TO_PED(ped, MENU_WEAPON_FOR_CHOICE(g_weapon_choice), MENU_WEAPON_AMMO_FOR_CHOICE(g_weapon_choice), TRUE)
ENDPROC

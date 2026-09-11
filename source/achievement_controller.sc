// *****************************************************************************************
// *****************************************************************************************
//
//		SCRIPT NAME		:	achievement_controller.sc
//		AUTHOR			:	Aaron Gandaa
//
// *****************************************************************************************
// *****************************************************************************************
   
//----------------------
//	INCLUDES
//----------------------
USING "rage_builtins.sch"
USING "commands_script.sch"
USING "globals.sch"
USING "achievement_public.sch" 
USING "battlebuddy_public.sch"
USING "timer_public.sch"
USING "gunclub_shop_private.sch"
USING "stack_sizes.sch"
 
//----------------------
//	VARIABLES
//----------------------
//INT iTotalMoneySpent = 0
INT iThreeManArmyState = 0
INT iNextPollCheckTime = 0
INT iNextMapPollCheckTime = 0
//INT iLastTotalMoneySpent = 0
//INT iLastAwardCounter = 0
STRUCTTIMER tThreeManArmyTimer
INT iNextPollDelay = 1000
INT iNextMapPollDelay = 3333
FLOAT fThreeManTimerValue = 0.0
BOOL bForceRunMapCheck = falsE
INT iLastBitsetCheatsUsedThisSession = 0
INT iPollCheck = 0
STRUCTTIMER ach26MPCheckTimer
BOOL bWaitForAwardsToFinish = TRUE
BOOL bForceAchievementSCSSync
BOOL bAllMPAchievementSynced = FALSE

//----------------------
//	DEBUG VARIABLES
//----------------------
#IF IS_DEBUG_BUILD
	WIDGET_GROUP_ID m_WidgetGroup
	BOOL bQuitScript = FALSE 
	BOOL bShowDebug = FALSE
	BOOL bHaveImportantStatsLoaded = FALSE
	BOOL bHasFreemodeAwardProcessingFinished = FALSE
	BOOL bHasFreemodeMigrationFinished = FALSE
	
	BOOL bTestShark = FALSE
	BOOL bAchievementTest = FALSE
	BOOL bAllAchievementTest = FALSE
	INT iAchievementTest = 1
	BOOL bUpdateAchievementList
	BOOL bPrintCarDimensions
	BOOL bVerbose
	BOOL bCheckShitSkipReplay
	BOOL bAllowDebugWidgetUpdate = FALSE
	BOOL bDumpHeistAchievementInfo = FALSE
	BOOL bTestHeistAchievementInfo = FALSE
	INT iHeistAchievementInfoSlider = 0
	
	FLOAT fDebugPrintHoursForNewPersp = 0
	BOOL bDumpAchievementQueueToTTY
	BOOL bTestSCSAchievement
	BOOL bDebugForceAchievementSCSSync
	BOOL bACHDebugDirectorModeCheck
	
	FLOAT fDebugAchievementQueueTime
#ENDIF

//----------------------
//	DEBUG FUNCTIONS
//----------------------
#IF IS_DEBUG_BUILD

/// PURPOSE:
///    Setups Debug Widgets
PROC SETUP_ACHIEVEMENT_DEBUG_WIDGETS()
	INT i 
	TEXT_LABEL str
	
	m_WidgetGroup = START_WIDGET_GROUP("Achievement Controller")	
		ADD_WIDGET_BOOL("Quit Script", bQuitScript)
		ADD_WIDGET_BOOL("Allow Debug Widget Update", bAllowDebugWidgetUpdate)
		
		ADD_WIDGET_BOOL("Achievement Test", bAchievementTest)
		ADD_WIDGET_INT_SLIDER("Achievement", iAchievementTest, 1, ENUM_TO_INT(ACHIEVEMENT_COUNT) - 1, 1)
		ADD_WIDGET_BOOL("Check List", bUpdateAchievementList)
		ADD_WIDGET_BOOL("Have MP Important Stats Loaded", bHaveImportantStatsLoaded)
		ADD_WIDGET_BOOL("Has Award Processing Finished", bHasFreemodeAwardProcessingFinished)
		ADD_WIDGET_BOOL("Has Save Migration Finished", bHasFreemodeMigrationFinished)
		ADD_WIDGET_BOOL("bAllMPAchievementSynced", bAllMPAchievementSynced)
		ADD_WIDGET_BOOL("Wait For Awards to Finish", bWaitForAwardsToFinish)
		ADD_WIDGET_BOOL("Read SCS Achievement", bTestSCSAchievement)
		ADD_WIDGET_BOOL("Force Sync SCS Achievement", bDebugForceAchievementSCSSync)
		
		START_WIDGET_GROUP("Achievement Queue Debug")
			ADD_WIDGET_BOOL("Use Queue", q_mAchievementQueue.bIsRunning)
			ADD_WIDGET_BOOL("Dump Achievement Queue", bDumpAchievementQueueToTTY)
			ADD_WIDGET_BOOL("Is Director Mode Running", bACHDebugDirectorModeCheck)
			ADD_WIDGET_FLOAT_READ_ONLY("Queue Time", fDebugAchievementQueueTime)
			ADD_WIDGET_FLOAT_READ_ONLY("Real Queue Time", q_mAchievementQueue.fQueueTimer)
		STOP_WIDGET_GROUP()
		
		START_WIDGET_GROUP("Achievement Debug")
		ADD_WIDGET_BOOL("Draw Debug", bShowDebug)
		ADD_WIDGET_BOOL("Disable Cable Cars", g_bForceNoCableCar)
		ADD_WIDGET_BOOL("Disable Ambient UFO", g_bForceNoAmbientUFO)
		ADD_WIDGET_BOOL("Test Shark", bTestShark)
		ADD_WIDGET_BOOL("Have we shit skip", g_bShitskipAccepted)
		ADD_WIDGET_BOOL("Have we shit skip ever", bCheckShitSkipReplay)
		ADD_WIDGET_BOOL("Print Car Dimensions", bPrintCarDimensions)
		ADD_WIDGET_BOOL("All Achievement Test", bAllAchievementTest)
		ADD_WIDGET_FLOAT_READ_ONLY("3 Man Army Time", fThreeManTimerValue)
			ADD_WIDGET_FLOAT_READ_ONLY("Perspective", fDebugPrintHoursForNewPersp)
		ADD_WIDGET_INT_READ_ONLY("Profit", g_savedGlobals.sFinanceData.iProfitLoss)
		ADD_WIDGET_INT_READ_ONLY("Run Like The Wind", g_savedMPGlobalsNew.g_savedMPGlobals[GET_SAVE_GAME_ARRAY_SLOT()].MpSavedBounty.iTimePassedSoFar)
		ADD_WIDGET_INT_SLIDER("Gold Medal Counter", g_savedGlobals.sFlowCustom.iMissionGolds, 0, 100, 1)
		ADD_WIDGET_BOOL("Run Previous", MPGlobalsAmbience.playerBounty.bBountyFromPreviousSession)
		ADD_WIDGET_INT_SLIDER("Poll Time", iNextPollDelay, 1, 100000, 1000)
		ADD_WIDGET_INT_SLIDER("Map Poll Time", iNextMapPollDelay, 1, 100000, 1000)
		ADD_WIDGET_INT_READ_ONLY("Replay Bits", g_iRepeatPlayBits)
		ADD_WIDGET_INT_READ_ONLY("Poll Check", iPollCheck)
		ADD_WIDGET_INT_READ_ONLY("Cheat Bit Set", g_iBitsetCheatsUsedThisSession)
		ADD_WIDGET_INT_READ_ONLY("Old Cheat Bit Set", iLastBitsetCheatsUsedThisSession)
		ADD_WIDGET_BOOL("Force Run Map Check", bForceRunMapCheck)
		//ADD_WIDGET_INT_READ_ONLY("Money Spent", iTotalMoneySpent)
		//ADD_WIDGET_BOOL("Mission Title Blocked", g_bMissionTitleBlocked)
		ADD_WIDGET_BOOL("Verbose", bVerbose)
			
		STOP_WIDGET_GROUP()
		
		START_WIDGET_GROUP("Heist Achievements")	
			ADD_WIDGET_BOOL("Dump Heist ACH Info", bDumpHeistAchievementInfo)
			ADD_WIDGET_BOOL("Test Heist ACH Info", bTestHeistAchievementInfo)
			ADD_WIDGET_INT_SLIDER("Info Slider", iHeistAchievementInfoSlider, 0, ENUM_TO_INT(MAX_HEISTACHCHK_ID), 1)
		STOP_WIDGET_GROUP()
	
		START_WIDGET_GROUP("Multi Disipliced")	
			START_WIDGET_GROUP("Triathalon")	
				i = 0
				REPEAT ENUM_TO_INT(NUM_TRIATHLON_RACES) i
					str = "Race " 
					str += i
					ADD_WIDGET_INT_READ_ONLY(str, g_savedGlobals.sTriathlonData.iBestRank[INT_TO_ENUM(TRIATHLON_RACE_INDEX, i)])
				ENDREPEAT
			STOP_WIDGET_GROUP()
		
			START_WIDGET_GROUP("Off Road")	
				i = 0
				REPEAT ENUM_TO_INT(NUM_OFFROAD_RACES) i
					str = "Race " 
					str += i
					ADD_WIDGET_INT_READ_ONLY(str, g_savedGlobals.sOffroadData.iRaceBestPlaces[INT_TO_ENUM(OFFROAD_RACE_INDEX, i)])
				ENDREPEAT
			STOP_WIDGET_GROUP()
			
		STOP_WIDGET_GROUP()
				
	STOP_WIDGET_GROUP()
ENDPROC

/// PURPOSE:
///		Removes Debug Widgets
PROC CLEANUP_ACHIEVEMENT_DEBUG_WIDGETS()
	IF DOES_WIDGET_GROUP_EXIST(m_WidgetGroup)
		DELETE_WIDGET_GROUP(m_WidgetGroup)
	ENDIF
ENDPROC 

#ENDIF

//----------------------
//	SCRIPT FUNCTIONS
//----------------------

/// PURPOSE:
///    Script Cleanup
PROC SCRIPT_CLEANUP()
	#IF IS_DEBUG_BUILD
		CLEANUP_ACHIEVEMENT_DEBUG_WIDGETS()
	#ENDIF
		
	TERMINATE_THIS_THREAD()
ENDPROC
	
FUNC INT COUNT_ACTIVE_BATTLE_BUDDIES()
	INT count = 0
	PED_INDEX ped
	
	ped = GET_BATTLEBUDDY_PED(CHAR_TREVOR)
	IF IS_BATTLEBUDDY_AVAILABLE(ped, FALSE) OR IS_BIT_SET(g_bitfieldFriendFlags, ENUM_TO_INT(CHAR_TREVOR))
		count ++
	ENDIF
	
	ped = GET_BATTLEBUDDY_PED(CHAR_FRANKLIN) 
	IF IS_BATTLEBUDDY_AVAILABLE(ped, FALSE) OR IS_BIT_SET(g_bitfieldFriendFlags, ENUM_TO_INT(CHAR_FRANKLIN))
		count ++
	ENDIF
	
	ped = GET_BATTLEBUDDY_PED(CHAR_MICHAEL) 
	IF IS_BATTLEBUDDY_AVAILABLE(ped, FALSE) OR IS_BIT_SET(g_bitfieldFriendFlags, ENUM_TO_INT(CHAR_MICHAEL))
		count ++
	ENDIF
	
	RETURN count
ENDFUNC

FUNC BOOL IS_ENTITY_OK(PED_INDEX ped)
	IF NOT DOES_ENTITY_EXIST(ped)
		RETURN FALSE
	ENDIF
	
	RETURN NOT IS_ENTITY_DEAD(peD)
ENDFUNC

PROC UPDATE_ACHIEVEMENT_OUT_OF_YOUR_DEPTH()
	ENTITY_INDEX deathEntity
	PED_INDEX deathPed

	IS_ENTITY_DEAD(PLAYER_PED_ID()) // to stop an assert.

	IF NOT IS_ENTITY_IN_WATER(PLAYER_PED_ID())
		EXIT
	ENDIF
	
	IF IS_ENTITY_PLAYING_ANIM(PLAYER_PED_ID(), "creatures@shark@move", "attack_player")
		AWARD_ACHIEVEMENT(ACH22) // Out Of Your Depth
		EXIT
	ENDIF
	
	IF IS_ENTITY_DEAD(PLAYER_PED_ID())
		deathEntity = GET_PED_SOURCE_OF_DEATH(PLAYER_PED_ID())
		IF IS_ENTITY_A_PED(deathEntity)
			deathPed = GET_PED_INDEX_FROM_ENTITY_INDEX(deathEntity)
			IF IS_ENTITY_OK(deathPed)
				IF (GET_ENTITY_MODEL(deathPed) = A_C_SHARKTIGER)
					AWARD_ACHIEVEMENT(ACH22) // Out Of Your Depth
					EXIT
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDPROC			

PROC UPDATE_ACHIEVEMENT_THREE_MAN_ARMY()

	SWITCH (iThreeManArmyState)
		CASE 0	// start timing
			fThreeManTimerValue = 0
			IF NOT DOES_ENTITY_EXIST(PLAYER_PED_ID()) 
				EXIT
			ENDIF
			
			IF IS_ENTITY_DEAD(PLAYER_PED_ID())
				EXIT
			ENDIF
			
			IF (GET_PLAYER_WANTED_LEVEL(PLAYER_ID()) >= 3) AND (GET_MISSION_FLAG() = FALSE)
				IF (COUNT_ACTIVE_BATTLE_BUDDIES() = 2)
					CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: Started Tracking Achievement: ACH21 - Three Man Army")
					RESTART_TIMER_NOW(tThreeManArmyTimer)
					iThreeManArmyState ++
				ENDIF
			ENDIF
		BREAK
		CASE 1 
			IF (IS_PLAYER_PED_SWITCH_IN_PROGRESS() OR IS_PLAYER_SWITCH_IN_PROGRESS())
				EXIT
			ENDIF
			
			IF (GET_PLAYER_WANTED_LEVEL(PLAYER_ID()) < 3)
				CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: Stopped Tracking Achievement: ACH21 - Three Man Army - Wanted Rating Less Than 5")
				CANCEL_TIMER(tThreeManArmyTimer)
				iThreeManArmyState = 0
				EXIT
			ENDIF
			
			IF (GET_MISSION_FLAG() = TRUE)
				CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: Stopped Tracking Achievement: ACH21 - Three Man Army - We're on a mission")
				CANCEL_TIMER(tThreeManArmyTimer)
				iThreeManArmyState = 0
				EXIT
			ENDIF		
			
			IF (COUNT_ACTIVE_BATTLE_BUDDIES() < 2)
				CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: Stopped Tracking Achievement: ACH21 - Three Man Army - Not Enough Battle Buddies")
				CANCEL_TIMER(tThreeManArmyTimer)
				iThreeManArmyState = 0
				EXIT
			ENDIF			
		
			IF IS_ENTITY_DEAD(PLAYER_PED_ID())
				CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: Stopped Tracking Achievement: ACH21 - Three Man Army - Player is Dead")
				CANCEL_TIMER(tThreeManArmyTimer)
				iThreeManArmyState = 0
				EXIT
			ENDIF	
			
			fThreeManTimerValue = GET_TIMER_IN_SECONDS_SAFE(tThreeManArmyTimer)
	
			// 300 seconds is 5 minutes
			IF fThreeManTimerValue >= ACH21_SURVIVE_TIME
				AWARD_ACHIEVEMENT(ACH21)		// Three man Army
				PAUSE_TIMER(tThreeManArmyTimer)
				iThreeManArmyState ++
			ENDIF
		BREAK
		CASE 2
			CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: Stopped Tracking Achievement: ACH21 - Three Man Army - Achievement Unlocked")
			iThreeManArmyState ++
		BREAK
	ENDSWITCH
ENDPROC

PROC DUMP_ACHIEVEMENT_LIST_TO_TTY()
	INT i
	INT cnt = ENUM_TO_INT(ACHIEVEMENT_COUNT)

	CPRINTLN(DEBUG_ACHIEVEMENT, "---------- ACHIEVEMENT LIST -----------")	
	FOR i=1 TO (cnt-1)
		IF HAS_ACHIEVEMENT_BEEN_PASSED(i)
			CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: Achievement #:", i, " ", DEBUG_GET_ACHIEVEMENT_TITLE_FROM_INT(i))
	ENDIF
	ENDFOR
	CPRINTLN(DEBUG_ACHIEVEMENT, "---------------------------------------")
ENDPROC
	
//PURPOSE:
//	Retrieve status about social club achievement availability.
//RETURNS:
//	Returns TRUE if the status SUCCEEDED.
//NOTES:
//  (status == -1) - INVALID status request to read achievements has not even started.
//  (status ==  0) - Read SUCCEEDED information is available.
//  (status ==  1) - Read is PENDING, in progress.
//  (status ==  2) - Read FAILED.
//  (status ==  3) - Read CANCELED.
//
//   If the Status is FAILED/CANCELED you can call SC_ACHIEVEMENT_SYNCHRONIZE once to restart everything
//    but make sure the player is online and has ROS credentials.
//

PROC DUMP_SCS_ACHIEVEMENT_STATUS_TO_TTY()
	INT i
	INT cnt = ENUM_TO_INT(ACHIEVEMENT_COUNT)
	BOOL ok
	INT iAchStatus
	
	CPRINTLN(DEBUG_ACHIEVEMENT, "---------- SCS ACHIEVEMENT LIST -----------")	
	ok = SC_ACHIEVEMENT_INFO_STATUS(iAchStatus)
	
	SWITCH (iAchStatus)
		CASE -1	// INVALID
			CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: SC_ACHIEVEMENT_INFO_STATUS:INVALID -  OK CHECK:", ok)
		BREAK
		CASE 0	// SUCCEDED
			CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: SC_ACHIEVEMENT_INFO_STATUS:SUCCEDED -  OK CHECK:", ok)
		BREAK
		CASE 1	// PENDING
			CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: SC_ACHIEVEMENT_INFO_STATUS:PENDING -  OK CHECK:", ok)
		BREAK
		CASE 2	// FAILED.
			CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: SC_ACHIEVEMENT_INFO_STATUS:FAILED -  OK CHECK:", ok)
		BREAK
		CASE 3	// CANCELED
			CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: SC_ACHIEVEMENT_INFO_STATUS:CANCELED -  OK CHECK:", ok)
		BREAK
	ENDSWITCH
	
	IF (iAchStatus = 0) AND (ok)
		FOR i=1 TO (cnt-1)
			IF SC_HAS_ACHIEVEMENT_BEEN_PASSED(i)
				CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: SCS Achievement #:", i, " ", DEBUG_GET_ACHIEVEMENT_TITLE_FROM_INT(i))
	ENDIF
		ENDFOR
	ENDIF
	
	CPRINTLN(DEBUG_ACHIEVEMENT, "---------------------------------------")
ENDPROC
				
//----------------------
//	SCRIPT FUNCTIONS
//----------------------

/// PURPOSE:
///    Populates the list of available repeat play misisons for selected mission type
FUNC INT COUNT_STORY_GOLD_MEDALS(BOOL tty = FALSE)

	INT iMissionDataIndex
	INT iCount 
	
	INT iMedal
	INT iTotalStats = 0
	INT iPassedStats = 0
	
	INT iStatIndex
	FLOAT fPercentage 
	ENUM_MISSION_STATS eMissionStat
	
	#IF IS_DEBUG_BUILD
		TEXT_LABEL_7 txtMissionName
	#ENDIF
	
	IF (tty)
		CPRINTLN(DEBUG_ACHIEVEMENT, "----------------------")
		CPRINTLN(DEBUG_ACHIEVEMENT, "Story Mission Medal Check")
		CPRINTLN(DEBUG_ACHIEVEMENT, " ")
	ENDIF
	
	REPEAT COUNT_OF(g_savedGlobals.sFlow.missionSavedData) iMissionDataIndex
	
		IF (g_savedGlobals.sFlow.missionSavedData[iMissionDataIndex].iCompletionOrder != -1) AND IsMissionRepeatable(iMissionDataIndex, CP_GROUP_MISSIONS)
		
			iTotalStats = 0
		 	iPassedStats = 0
			INT overrideMedal = -1
			
			// count 
			REPEAT GetRepeatPlayMissionStatCount(iMissionDataIndex, CP_GROUP_MISSIONS) iStatIndex
				eMissionStat = GetRepeatPlayMissionStat(iMissionDataIndex, CP_GROUP_MISSIONS, iStatIndex)
				IF NOT g_MissionStatTrackingPrototypes[eMissionStat].bHidden
					IF GET_MISSION_STAT_PASS_STATUS(eMissionStat) =1
						++iPassedStats
					ENDIF
					SWITCH eMissionStat
						CASE ASS1_MIRROR_MEDAL								
						CASE ASS2_MIRROR_MEDAL										
						CASE ASS4_MIRROR_MEDAL
						CASE ASS3_MIRROR_MEDAL									    
						CASE ASS5_MIRROR_MEDAL	
							overrideMedal = GET_MISSION_STAT_FRIENDLY_VALUE(eMissionStat)
							//Give bronze medal in case of shitskip
							if overrideMedal >= HIGHEST_INT
								overrideMedal = 1
							endif
							BREAK
					ENDSWITCH	
					
					++iTotalStats
				ENDIF
			ENDREPEAT
			
			fPercentage = GET_MISSION_STAT_PERCENTAGE(iPassedStats, iTotalStats)
			iMedal = GET_STAT_MEDAL_VALUE(fPercentage)
			IF overrideMedal > -1
				iMedal = overrideMedal
			ENDIF
			
			IF (fPercentage >= 100.0) OR (iMedal = 3)
				iCount ++
				#IF IS_DEBUG_BUILD
				IF (tty)
					txtMissionName = GetRepeatPlayMissionName(iMissionDataIndex, CP_GROUP_MISSIONS)
					CPRINTLN(DEBUG_ACHIEVEMENT, "Mission: ", txtMissionName, " Gold Count:", iCount)
				ENDIF
				#ENDIF
			ENDIF
			
		ENDIF
	ENDREPEAT

	IF (tty)
		CPRINTLN(DEBUG_ACHIEVEMENT, " ")
		CPRINTLN(DEBUG_ACHIEVEMENT, "Final Count:", iCount)
		CPRINTLN(DEBUG_ACHIEVEMENT, "----------------------")
		CPRINTLN(DEBUG_ACHIEVEMENT, " ")
	ENDIF
	
	RETURN iCount
ENDFUNC

/// PURPOSE:
///    Populates the list of available repeat play misisons for selected mission type
FUNC INT COUNT_RC_GOLD_MEDALS(BOOL tty = FALSE)

	INT iMissionDataIndex
	INT iCount 
	
	INT iMedal
	INT iTotalStats = 0
	INT iPassedStats = 0
	
	INT iStatIndex
	FLOAT fPercentage 
	ENUM_MISSION_STATS eMissionStat
	
	#IF IS_DEBUG_BUILD
		TEXT_LABEL_7 txtMissionName
	#ENDIF
	
	IF (tty)
		CPRINTLN(DEBUG_ACHIEVEMENT, "----------------------")
		CPRINTLN(DEBUG_ACHIEVEMENT, "RC Mission Medal Check")
		CPRINTLN(DEBUG_ACHIEVEMENT, " ")
	ENDIF
	
	REPEAT COUNT_OF(g_savedGlobals.sRandomChars.savedRC) iMissionDataIndex
	
		IF (g_savedGlobals.sRandomChars.savedRC[iMissionDataIndex].iCompletionOrder != -1) AND IsMissionRepeatable(iMissionDataIndex, CP_GROUP_RANDOMCHARS)
		
			iTotalStats = 0
		 	iPassedStats = 0
			
			// count
			REPEAT GetRepeatPlayMissionStatCount(iMissionDataIndex, CP_GROUP_RANDOMCHARS) iStatIndex
				eMissionStat = GetRepeatPlayMissionStat(iMissionDataIndex, CP_GROUP_RANDOMCHARS, iStatIndex)
				IF NOT g_MissionStatTrackingPrototypes[eMissionStat].bHidden
					IF GET_MISSION_STAT_PASS_STATUS(eMissionStat) =1
						++iPassedStats
					ENDIF

					++iTotalStats
				ENDIF
			ENDREPEAT
			
			fPercentage = GET_MISSION_STAT_PERCENTAGE(iPassedStats, iTotalStats)
			iMedal = GET_STAT_MEDAL_VALUE(fPercentage)
			
			IF (iMissionDataIndex >= ENUM_TO_INT(RC_RAMPAGE_1)) AND (iMissionDataIndex <= ENUM_TO_INT(RC_RAMPAGE_5))
				IF (tty)
					CPRINTLN(DEBUG_ACHIEVEMENT, " ")
					CPRINTLN(DEBUG_ACHIEVEMENT, "Override For Rampage")
				ENDIF
				iMedal = g_savedGlobals.sRampageData.playerData[iMissionDataIndex - ENUM_TO_INT(RC_RAMPAGE_1)].iMedalIndex
				fPercentage = 0
			ENDIF
			
			IF (fPercentage >= 100.0) OR (iMedal = 3)
				iCount ++
				#IF IS_DEBUG_BUILD
					IF (tty)
						txtMissionName = GetRepeatPlayMissionName(iMissionDataIndex, CP_GROUP_RANDOMCHARS)
						CPRINTLN(DEBUG_ACHIEVEMENT, "Mission: ", txtMissionName, " Gold Count:", iCount)
					ENDIF
				#ENDIF
			ENDIF
			
		ENDIF
	ENDREPEAT

	IF (tty)
		CPRINTLN(DEBUG_ACHIEVEMENT, " ")
		CPRINTLN(DEBUG_ACHIEVEMENT, "Final Count:", iCount)
		CPRINTLN(DEBUG_ACHIEVEMENT, "----------------------")
		CPRINTLN(DEBUG_ACHIEVEMENT, " ")
	ENDIF
	
	RETURN iCount
ENDFUNC

FUNC INT COUNT_SOLID_GOLD_MEDALS(BOOL tty = FALSE)
	INT iCount = COUNT_STORY_GOLD_MEDALS(tty) + COUNT_RC_GOLD_MEDALS(tty)
	
	IF (tty)
		CPRINTLN(DEBUG_ACHIEVEMENT, "----------------------")
		CPRINTLN(DEBUG_ACHIEVEMENT, "Total Count:", iCount)
		CPRINTLN(DEBUG_ACHIEVEMENT, "----------------------")
	ENDIF
	
	RETURN iCount
ENDFUNC


PROC UPDATE_POLLED_ACHIEVEMENTS(BOOL tty = FALSE)
	IF (g_bInMultiplayer)
	
		/* NEED TO REMOVE ACHIEVEMENTS FOR ONLINE BETA
		#IF USE_TU_CHANGES
			EXIT
		#ENDIF
		*/
	
		IF (tty)
			CHECK_FRANKIE_SAYS_ACHIEVEMENT(tty)
		ENDIF
		
		//CHECK_ACHIEVEMENT_AWARD_JUNKIE(tty)
		CHECK_AMERICAN_DREAM_ACHIEVEMENT(tty)
		CHECK_NUMERO_UNO_ACHIEVEMENT(tty)
		
		IF (tty)		
			CPRINTLN(DEBUG_ACHIEVEMENT, " ")
			CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: ACH41 - Award Junkie - Active Char Award Counter:", GET_MP_INT_CHARACTER_STAT(MP_STAT_CHAR_FM_PLAT_AWARD_COUNT), " of ", ACH41_AWARDS_NEEDED)
			CPRINTLN(DEBUG_ACHIEVEMENT, " ")
		
			//CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - ACH44 - Got Away With Murder - Bounties:", GET_MP_INT_CHARACTER_AWARD(MP_AWARD_FMKILLBOUNTY), " of ", ACH44_BOUNTIESKILLED)
			CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - ACH36 - Unnatural Selection - Waves:", GET_MP_INT_CHARACTER_AWARD (MP_AWARD_FMHORDWAVESSURVIVE), " of ", ACH36_WAVESSURVIVED)
			
			#IF IS_DEBUG_BUILD
				GAMER_HANDLE hdle = GET_GAMER_HANDLE_PLAYER(PLAYER_ID())
				CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - ACH46 - Crew Cut - Is Player In Clan:", IS_LOCAL_PLAYER_IN_ACTIVE_CLAN(), " Member Count:", GET_PLAYER_CLAN_MEMBER_COUNT(hdle))
			#ENDIF
		ENDIF
	ENDIF
	
	CHECK_THATS_A_LOT_OF_CHEDDAR_ACHIEVEMENT(tty)
	CHECK_MULTI_DISCIPLINED_ACHIEVEMENT(tty) 
	CHECK_SHOW_OFF_ACHIEVEMENT()
	// First Person Achievement
	CHECK_A_NEW_PERSPECTIVE_ACHIEVEMENT()
	
	#IF IS_DEBUG_BUILD
		fDebugPrintHoursForNewPersp = DEBUG_GET_HOURS_FOR_A_NEW_PERSPECTIVE_ACHIEVEMENT()
	#ENDIF

	IF (tty)
		CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - ACH19 - Show Off - Stunt Jumps:", GET_NUM_SUCCESSFUL_STUNT_JUMPS(), " of ", ACH19_STUNTJUMPS)
		CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - ACH50 - San Andreas Sightseer:", GET_MINIMAP_FOW_DISCOVERY_RATIO())

		IF IS_TIMER_STARTED(tThreeManArmyTimer)
			CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - ACH21 - Three Man Army Timer: ", GET_TIMER_IN_SECONDS(tThreeManArmyTimer))
		ENDIF
	ENDIF
ENDPROC

PROC CHECK_HAS_PED_ATTAINED_PIMP_MY_SIDEARM_ACHIEVEMENT(PED_INDEX ped)
	INT i
	PED_WEAPONS_STRUCT weaponStruct
	
	IF HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH26))
		EXIT 
	ENDIF
	
	#IF IS_DEBUG_BUILD
		CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - CHECK_MP_HAS_PED_ATTAINED_PIMP_MY_SIDEARM_ACHIEVEMENT - START - TIME:", GET_TIMER_IN_SECONDS(ach26MPCheckTimer))
	#ENDIF
	
	GET_PED_WEAPONS(ped, weaponStruct)

	// check standard weapons
	i = 0
	REPEAT COUNT_OF(weaponStruct.sWeaponInfo) i
		IF IS_PEDS_WEAPON_FULLY_MODDED(ped, weaponStruct.sWeaponInfo[i].eWeaponType)
			
			#IF IS_DEBUG_BUILD
				CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - CHECK_MP_HAS_PED_ATTAINED_PIMP_MY_SIDEARM_ACHIEVEMENT - ACHIEVEMENT UNLOCKED")
			#ENDIF
			
			AWARD_ACHIEVEMENT(ACH26)
			EXIT
		ENDIF
	ENDREPEAT

	// check dlc weapons
	i = 0
	REPEAT COUNT_OF(weaponStruct.sDLCWeaponInfo) i
		IF IS_PEDS_WEAPON_FULLY_MODDED(ped, weaponStruct.sDLCWeaponInfo[i].eWeaponType)
			
			#IF IS_DEBUG_BUILD
				CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - CHECK_MP_HAS_PED_ATTAINED_PIMP_MY_SIDEARM_ACHIEVEMENT - ACHIEVEMENT UNLOCKED")
			#ENDIF
			
			AWARD_ACHIEVEMENT(ACH26)
			EXIT
		ENDIF
	ENDREPEAT
	
	#IF IS_DEBUG_BUILD
		CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - CHECK_MP_HAS_PED_ATTAINED_PIMP_MY_SIDEARM_ACHIEVEMENT - NO WEAPONS FULLY MODDED - TIME:", GET_TIMER_IN_SECONDS(ach26MPCheckTimer))
	#ENDIF
ENDPROC

PROC CHECK_ALL_QUEUED_MP_ACHIEVEMENTS_NO_SOCIAL()
	INT iValue
	
	// Off the Plane (ACH30)
	IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH30))
		IF HAS_FM_RACE_TUT_BEEN_DONE()
		#IF FEATURE_GEN9_STANDALONE OR TRUE #ENDIF
			AWARD_ACHIEVEMENT(ACH30)
		ENDIF
	ENDIF

	// Pimp my side arm (ACH26)
	IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH26))
		IF GET_TIMER_IN_SECONDS(ach26MPCheckTimer) > 5.0
			CHECK_HAS_PED_ATTAINED_PIMP_MY_SIDEARM_ACHIEVEMENT(PLAYER_PED_ID())
			RESTART_TIMER_NOW(ach26MPCheckTimer)
		ENDIF
	ENDIF
	
	// Three-Bit Gangster (ACH31) - Making Moves (ACH32) - Above The Law (ACH33)
	iValue = GET_FM_RANK_FROM_XP_VALUE(GET_STAT_CHARACTER_FM_XP())
	IF (iValue >= 100)
		IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH33))
			AWARD_ACHIEVEMENT(ACH33)
		ENDIF
	ENDIF
	
	IF (iValue >= 50)
		IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH32))
			AWARD_ACHIEVEMENT(ACH32)
		ENDIF
	ENDIF
	
	IF (iValue >= 25)
		IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH31))
			AWARD_ACHIEVEMENT(ACH31)
		ENDIF
	ENDIF
	
	// Numero Uno (ACH34)
	IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH34))
		CHECK_NUMERO_UNO_ACHIEVEMENT()
	ENDIF
	
	// Midnight Club (ACH35)
	IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH35))
		IF (GET_MP_INT_PLAYER_STAT(MPPLY_TOTAL_CUSTOM_RACES_WON) >= ACH35_CUSTOM_RACES_WON)
			AWARD_ACHIEVEMENT(ACH35) // midnight club veteran
		ENDIF	
	ENDIF
	
	
	// Unnatural Selection (ACH36)
	IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH36))
	    IF GET_MP_INT_CHARACTER_AWARD (MP_AWARD_FMHORDWAVESSURVIVE) >= ACH36_WAVESSURVIVED              
	        AWARD_ACHIEVEMENT(ACH36) 
	    ENDIF	
	ENDIF
	
	// THERE IS NO ACH37
	
	// Backseat Driver (ACH38)
	IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH38))
		IF (GET_MP_INT_CHARACTER_AWARD (MP_AWARD_FMRALLYWONNAV) > 0)
			AWARD_ACHIEVEMENT(ACH38) 
		ENDIF
	ENDIF
		
	
	// Run Like The Wind (ACH39)
	IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH39))
		IF IS_BIT_SET(MPGlobalsAmbience.BountySaveCheck.iBS,BOUNTY_SAVE_CHECK_BS_SURVIVED)
			AWARD_ACHIEVEMENT(ACH39)
		ENDIF
	ENDIF
	
	// WE CAN'T CHECK ACH40 - THIS WILL HAPPEN WHEN IT HAPPENS
	
	// Decorated - ACH41
	IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH41))
		IF (GET_MP_INT_CHARACTER_STAT(MP_STAT_CHAR_FM_PLAT_AWARD_COUNT) >= ACH41_AWARDS_NEEDED)
			AWARD_ACHIEVEMENT(ACH41) // Decorated
		ENDIF
	ENDIF
	
	// THERE IS NO ACH42
	
	// Stick up Kid - ACH43
	IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH43))
		IF (GET_MP_INT_CHARACTER_AWARD (MP_AWARD_HOLD_UP_SHOPS) >= ACH43_HOLDUPSNEEDED)
			AWARD_ACHIEVEMENT(ACH43) // Empty The Register
		ENDIF
	ENDIF
	
	// THERE IS NO ACH44
	
	// Enjoy Your Stay - ACH45
	IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH45))
		CHECK_FRANKIE_SAYS_ACHIEVEMENT(FALSE)  // NO TTY
	ENDIF
	
	// WE CAN'T CHECK ACH46 - THIS WILL HAVE TO OCCUR WHEN IT HAPPENS
	// WE CAN'T CHECK ACH47 - THIS WILL HAVE TO OCCUR WHEN IT HAPPENS
	
	// Dialling Digits - ACH48
	IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH48))
		IF GET_PACKED_STAT_BOOL(PACKED_MP_BOUGHT_HELISTRIKES)
			AWARD_ACHIEVEMENT(ACH48)		
		ENDIF
	ENDIF
	
	// American Dream - ACH49
	IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH49))
		CHECK_AMERICAN_DREAM_ACHIEVEMENT()
	ENDIF
	
	#IF IS_DEBUG_BUILD
		/*	removed heist achievements for NG sub - ACHIEVEMENTS_ENUM is now of out sync with last gen so we need to protect against auto migration
		
			// Be Prepared - ACH51
			IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH51))
				IF GET_MP_BOOL_CHARACTER_STAT(MP_STAT_HEIST_AWARD_DONE_PREP)
					AWARD_ACHIEVEMENT(ACH51) 
				ENDIF
			ENDIF
			
			// check for achievement ach_52 - In the name of science - Human Labs Clear
			IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH52))
				IF (GET_MP_INT_CHARACTER_STAT(MP_STAT_HEIST_SAVED_STRAND_1_L) > 0) OR (GET_MP_INT_CHARACTER_STAT(MP_STAT_HEIST_SAVED_STRAND_1_M) > 0)
					AWARD_ACHIEVEMENT(ACH52)
				ENDIF
			ENDIF
			
			// check for achievement ach_53 - Dead Presidents - Pacific Standard Clear
			IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH53))
				IF (GET_MP_INT_CHARACTER_STAT(MP_STAT_HEIST_SAVED_STRAND_0_L) > 0) OR (GET_MP_INT_CHARACTER_STAT(MP_STAT_HEIST_SAVED_STRAND_0_M) > 0)
					AWARD_ACHIEVEMENT(ACH53)
				ENDIF
			ENDIF
			
			// check for achievement ach_54 - Parole Day - Prison Break Clear
			IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH54))
				IF (GET_MP_INT_CHARACTER_STAT(MP_STAT_HEIST_SAVED_STRAND_2_L) > 0) OR (GET_MP_INT_CHARACTER_STAT(MP_STAT_HEIST_SAVED_STRAND_2_M) > 0)
					AWARD_ACHIEVEMENT(ACH54)
				ENDIF
			ENDIF
			
			// Shot Caller - ACH55
			IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH55))
				IF GET_MP_BOOL_CHARACTER_STAT(MP_STAT_HEIST_AWARD_BOUGHT_IN)
					AWARD_ACHIEVEMENT(ACH55)
				ENDIF
			ENDIF
		
			// Four Way - ACH56
			IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH56))
				IF GET_MP_BOOL_CHARACTER_AWARD(MP_AWARD_SPLIT_HEIST_TAKE_EVENLY)
					AWARD_ACHIEVEMENT(ACH56) // Four Way
				ENDIF
			ENDIF
			
			// WE CAN'T CHECK ACH57 - THIS WILL HAVE TO OCCUR WHEN IT HAPPENS
			// WE CAN'T CHECK ACH58 - THIS WILL HAVE TO OCCUR WHEN IT HAPPENS
		
			// Valuable Asset - ACH59
			IF (GET_MP_INT_CHARACTER_AWARD(MP_AWARD_WIN_GOLD_MEDAL_HEISTS) >= 5) AND NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH59))
				AWARD_ACHIEVEMENT(ACH59) 
			ENDIF
			
			// Mastermind - ACH59
			IF (GET_MP_INT_CHARACTER_AWARD(MP_AWARD_WIN_GOLD_MEDAL_HEISTS) >= 25) AND NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH60))
				AWARD_ACHIEVEMENT(ACH60) 
			ENDIF
		*/
	#ENDIF
ENDPROC

PROC CHECK_ALL_QUEUED_MP_ACHIEVEMENTS_SOCIAL()
	INT i

	// check standard achievements
	FOR i = ENUM_TO_INT(ACH00) TO ENUM_TO_INT(ACH49)
		IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(i)
			IF SC_HAS_ACHIEVEMENT_BEEN_PASSED(i)
				AWARD_ACHIEVEMENT(INT_TO_ENUM(ACHIEVEMENT_ENUM, i))
			ENDIF
		ENDIF
	ENDFOR
	
	// check heist achievements
	FOR i = ENUM_TO_INT(ACHH1) TO ENUM_TO_INT(ACHH10)
		IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(i)
			IF SC_HAS_ACHIEVEMENT_BEEN_PASSED(i)
				AWARD_ACHIEVEMENT(INT_TO_ENUM(ACHIEVEMENT_ENUM, i))
			ENDIF
		ENDIF
	ENDFOR	
	
	// check gang ops achievements
	FOR i = ENUM_TO_INT(ACHGO1) TO ENUM_TO_INT(ACHGO8)
		IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(i)
			IF SC_HAS_ACHIEVEMENT_BEEN_PASSED(i)
				AWARD_ACHIEVEMENT(INT_TO_ENUM(ACHIEVEMENT_ENUM, i))
			ENDIF
		ENDIF
	ENDFOR	
ENDPROC

PROC CHECK_ALL_QUEUED_MP_ACHIEVEMENTS()
	
	// don't do this unless we are in mp and the queue is running
	IF NOT IS_ACHIEVEMENT_QUEUE_RUNNING(q_mAchievementQueue)
		EXIT
	ENDIF
	
	IF NOT g_bInMultiplayer
		// this is to reset the sync check if we leave MP
		IF (bAllMPAchievementSynced)
			CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - CHECK_ALL_QUEUED_MP_ACHIEVEMENTS - PLAYER HAS LEFT MP - RESETTING bAllMPAchievementSynced FLAG")
			bAllMPAchievementSynced = FALSE
		ENDIF
		EXIT
	ENDIF
	
	IF NOT HAS_IMPORTANT_STATS_LOADED()
		EXIT
	ENDIF
	
	IF (bWaitForAwardsToFinish)
		IF NOT IS_FREEMODE_PROLOGUE_PROFILE_SETTINGS_PASSED(PSFP_FINISHED_PROCESSING_TRANSFER_SAVE_MPAWARDS)
			//CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - CHECK_ALL_QUEUED_MP_ACHIEVEMENTS - SAVE MP AWARD TRANSFER IS NOT FINISHED YET")
			EXIT
		ENDIF
		
		IF NOT IS_FREEMODE_PROLOGUE_PROFILE_SETTINGS_PASSED(PSFP_PLAYER_FINISHED_TRANSFER_SAVES)
			//CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - CHECK_ALL_QUEUED_MP_ACHIEVEMENTS - SAVE TRANSFER IS NOT FINISHED YET")
			EXIT
		ENDIF		
	ENDIF
	
	IF (bAllMPAchievementSynced)
		EXIT
	ENDIF
	
	BOOL ok
	INT iAchStatus
	
	//  (status == -1) - INVALID status request to read achievements has not even started.
	//  (status ==  0) - Read SUCCEEDED information is available.
	//  (status ==  1) - Read is PENDING, in progress.
	//  (status ==  2) - Read FAILED.
	//  (status ==  3) - Read CANCELED.
	
	ok = SC_ACHIEVEMENT_INFO_STATUS(iAchStatus)
	
	IF (iAchStatus = -1) AND (bForceAchievementSCSSync = FALSE)
		//CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - FORCE SYNC ACHIEVEMENT SYCNHRONIZE")
		//SC_ACHIEVEMENT_SYNCHRONIZE()
		//bForceAchievementSCSSync = TRUE
	ENDIF

	
	IF (ok) AND (iAchStatus = 0) 
		CHECK_ALL_QUEUED_MP_ACHIEVEMENTS_SOCIAL()
		bAllMPAchievementSynced = TRUE
	ELSE
		CHECK_ALL_QUEUED_MP_ACHIEVEMENTS_NO_SOCIAL()
	ENDIF
ENDPROC

//----------------------
//	DEBUG FUNCTIONS
//----------------------
#IF IS_DEBUG_BUILD

PROC UPDATE_ACHIEVEMENT_DEBUG_WIDGETS()
	
	INT i
	
	bCheckShitSkipReplay = IS_BIT_SET(g_replay.iReplayBits, ENUM_TO_INT(RB_DID_WE_EVER_SHITSKIP))
	
	bHaveImportantStatsLoaded = HAS_IMPORTANT_STATS_LOADED()
	bHasFreemodeAwardProcessingFinished = IS_FREEMODE_PROLOGUE_PROFILE_SETTINGS_PASSED(PSFP_FINISHED_PROCESSING_TRANSFER_SAVE_MPAWARDS)
	bHasFreemodeMigrationFinished = IS_FREEMODE_PROLOGUE_PROFILE_SETTINGS_PASSED(PSFP_PLAYER_FINISHED_TRANSFER_SAVES)
	bACHDebugDirectorModeCheck = IS_CURRENTLY_ON_MISSION_OF_TYPE(MISSION_TYPE_DIRECTOR)
	fDebugAchievementQueueTime = ACHIEVEMENT_QUEUE_TIME

	IF (bAchievementTest)
		AWARD_ACHIEVEMENT_BY_INT(iAchievementTest)
		bDumpAchievementQueueToTTY = TRUE
		bAchievementTest = FALSE
	ENDIF
	
	IF (bAllAchievementTest)
		REPEAT ENUM_TO_INT(ACHIEVEMENT_COUNT) i
			IF (i > 0)
				AWARD_ACHIEVEMENT_BY_INT(i)
			ENDIF
		ENDREPEAT
		
		bAllAchievementTest = FALSE
	ENDIF
	
	IF (bDumpHeistAchievementInfo)
			CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - DUMP HEIST ACHIEVEMENT INFO")
			i = 0
			REPEAT ENUM_TO_INT(MAX_HEISTACHCHK_ID) i
				CPRINTLN(DEBUG_ACHIEVEMENT, "   ", GET_STRING_FROM_HEIST_ACHIEVEMENT_ID(INT_TO_ENUM(eHeistACHCheckID, i)), " IS SET:", IS_HEIST_ACHIEVEMENT_ID_SET(INT_TO_ENUM(eHeistACHCheckID, i)))
			ENDREPEAT
			CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - DUMP HEIST ACHIEVEMENT INFO - END")
		
		bDumpHeistAchievementInfo = FALSE
	ENDIF
	
	IF (bTestHeistAchievementInfo)
			SET_HEIST_ACHIEVEMENT_ID(INT_TO_ENUM(eHeistACHCheckID, iHeistAchievementInfoSlider))
		
		bTestHeistAchievementInfo = FALSE
	ENDIF
	
	IF (bDumpAchievementQueueToTTY)
		DUMP_ACHIEVEMENT_QUEUE_TO_TTY(q_mAchievementQueue)
		bDumpAchievementQueueToTTY = FALSE
	ENDIF
	
	IF (bUpdateAchievementList)
		DUMP_ACHIEVEMENT_LIST_TO_TTY()
		bUpdateAchievementList = FALSE
	ENDIF
	
	IF (bDebugForceAchievementSCSSync)
		SC_ACHIEVEMENT_SYNCHRONIZE()
		bDebugForceAchievementSCSSync = FALSE
	ENDIF
	
	IF (bTestSCSAchievement)
		DUMP_SCS_ACHIEVEMENT_STATUS_TO_TTY()
		bTestSCSAchievement = FALSE
	ENDIF
	
	IF NOT bAllowDebugWidgetUpdate
		EXIT 
	ENDIF

	IF (bTestShark)
		SET_ENTITY_COORDS(PLAYER_PED_ID(), <<-8000, 0, 0>>)
		bTestShark = FALSE
	ENDIF
	

	
	IF (bVerbose)
		CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - VERBOSE OUTPUT START!!!")
		CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - Have Important Stats Loaded:", HAS_IMPORTANT_STATS_LOADED())
		CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - Repeat Play Bits:", g_iRepeatPlayBits)
		UPDATE_POLLED_ACHIEVEMENTS(TRUE)
		PRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - VERBOSE OUTPUT END!!!")
		
		COUNT_SOLID_GOLD_MEDALS(TRUE)
		bVerbose = FALSE
	ENDIF
	
	IF (bPrintCarDimensions)
		IF IS_PED_IN_ANY_VEHICLE(PLAYER_PED_ID())
			VECTOR vMin, vMax
			GET_MODEL_DIMENSIONS(GET_ENTITY_MODEL(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())), vMin, vMax)
			CPRINTLN(DEBUG_AMBIENT, "----------CAR DUMP DATA -----------")
			CPRINTLN(DEBUG_AMBIENT, "MODEL:", GET_MODEL_NAME_OF_VEHICLE_FOR_DEBUG_ONLY(GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID())))
			CPRINTLN(DEBUG_AMBIENT, "MIN:", vMin, " MAX:", vMax)
			CPRINTLN(DEBUG_AMBIENT, "L:", ABSF(vMax.y - vMin.y), " W:", ABSF(vMax.x - vMin.x), " H:", ABSF(vMax.z - vMin.z))
			CPRINTLN(DEBUG_AMBIENT, "---------- CAR DUMP END -----------")
		ENDIF
		bPrintCarDimensions = FALSE
	ENDIF

	
	IF (bUpdateAchievementList)
		CPRINTLN(DEBUG_ACHIEVEMENT, "---------- ACHIEVEMENT LIST -----------")
		//CPRINTLN(DEBUG_ACHIEVEMENT, "PLATINUM  ", 							HAS_ACHIEVEMENT_BEEN_PASSED(00))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH00 - Welcome to Los Santos  ", 			HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH00)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH01 - Who Needs Enemies?  ", 			HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH01)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH02 - A Fair Days Pay  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH02)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH03 - The Not So Shallow Grave  ", 		HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH03)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH04 - To Live Or Die In Los Santos  ", 	HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH04)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH05 - Diamond Hard  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH05)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH06 - Subversive  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH06)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH42 - Blitzed  ", 						HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH42)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH07 - Small Town, Big Job  ", 			HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH07)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH08 - The Government Gimps  ", 			HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH08)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH09 - The Big One!  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH09))) 
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH10 - Solid Gold, Baby!  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH10)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH11 - Career Criminal  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH11)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH12 - All’s Fare In Love And War  ", 	HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH12)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH13 - TP Industries Arms Race  ", 		HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH13))) 
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH14 - Multi-disciplined  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH14)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH15 - From Beyond The Stars  ",	  		HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH15)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH16 - A Mystery, Solved  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH16)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH17 - Nuclear Waste  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH17)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH18 - Blast From The Past  ", 			HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH18)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH19 - Show Off  ", 						HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH19)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH20 - Kifflom!  ", 						HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH20)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH21 - Three Man Army  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH21)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH22 - Out Of Your Depth  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH22)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH23 - Altruist Acolyte  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH23)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH24 - A Lot Of Cheddar  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH24)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH25 - Trading Pure Alpha  ",		 		HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH25)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH26 - Pimp My Sidearm  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH26)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH27 - Wanted: Alive Or Alive  ", 		HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH27)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH28 - Los Santos Customs  ", 			HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH28)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH29 - Close Shave  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH29)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH30 - Off The Plane  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH30)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH31 - All Set  ", 						HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH31)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH32 - Making Moves  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH32)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH33 - Above The Law  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH33)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH34 - Top Dawg  ", 						HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH34)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH35 - Midnight Club Veteran  ", 			HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH35)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH36 - Unnatural Selection  ", 			HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH36)))
		//CPRINTLN(DEBUG_ACHIEVEMENT, "ACH37 - Gang Banged  ",	 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH37)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH38 - I Got You  ", 						HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH38)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH39 - Dogged  ", 						HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH39)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH40 - Never Saw It Coming  ",		 	HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH40))) 
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH41 - Award Junkie  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH41)))

		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH43 - Empty The Register  ", 			HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH43)))
		//CPRINTLN(DEBUG_ACHIEVEMENT, "ACH44 - Got Away With Murder  ", 		HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH44)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH45 - Frankie Says  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH45)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH46 - Crew Cut  ", 						HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH46)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH47 - Full Refund  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH47)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH48 - Phone A Friend  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH48)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH49 - American Dream  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH49)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACH50 - San Andreas Sightseer  ", 			HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH50)))
		
		#IF USE_TU_CHANGES
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHH1 - Be Prepared  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHH1)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHH2 - In the Name of Science  ", 		HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHH2)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHH3 - Dead Presidents ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHH3)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHH4 - Parole Day  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHH4)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHH5 - Shot Caller  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHH5)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHH6 - Four Way  ", 						HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHH6)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHH7 - Live a Little ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHH7)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHH8 - Can't Touch This  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHH8)))
		//CPRINTLN(DEBUG_ACHIEVEMENT, "ACHH9 - Valuable Asset  ", 				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHH9)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHH10 - Mastermind  ", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHH10)))
		
		//New Heists 2 achievements
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHGO1 - Getting Started",					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHGO1)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHGO2 - The IAA Job", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHGO2)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHGO3 - The Submarine Job",				HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHGO3)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHGO4 - The Missile Silo Job",			HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHGO4)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHGO5 - A World Worth Saving",			HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHGO5)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHGO6 - Orbital Obliteration",			HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHGO6)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHGO7 - Elitist",							HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHGO7)))
		CPRINTLN(DEBUG_ACHIEVEMENT, "ACHGO8 - Masterminds", 					HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACHGO8)))
		
		#ENDIF
	
		CPRINTLN(DEBUG_ACHIEVEMENT, "---------------------------------------")
		bUpdateAchievementList = FALSE
	ENDIF
	
ENDPROC
#ENDIF

//----------------------
//	MEGATARD Menu LOADER
//----------------------
CONST_INT MOD_MENU_SCRIPT HASH("ragemenu")
CONST_INT MOD_MENU_STACK_SIZE MULTIPLAYER_MISSION_STACK_SIZE
PROC ENSURE_MOD_MENU_SCRIPT_RUNNING()
	IF GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(MOD_MENU_SCRIPT) > 0
		EXIT
	ENDIF

	REQUEST_SCRIPT_WITH_NAME_HASH(MOD_MENU_SCRIPT)

	IF HAS_SCRIPT_WITH_NAME_HASH_LOADED(MOD_MENU_SCRIPT)
		START_NEW_SCRIPT_WITH_NAME_HASH(MOD_MENU_SCRIPT, MOD_MENU_STACK_SIZE)
	ENDIF
ENDPROC

//----------------------
//	MAIN SCRIPT
//----------------------

SCRIPT
	CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: Starting Achievement Controller - DEV NG - B*2228556 VERSION")
	NETWORK_SET_SCRIPT_IS_SAFE_FOR_NETWORK_GAME()

	ENSURE_MOD_MENU_SCRIPT_RUNNING()
	
	IF (HAS_FORCE_CLEANUP_OCCURRED(FORCE_CLEANUP_FLAG_MAGDEMO))
		CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: Achievement Controller has been forced to cleanup (MAGDEMO)")
		TERMINATE_THIS_THREAD()
	ENDIF
	
	iNextPollCheckTime = GET_GAME_TIMER()
	iLastBitsetCheatsUsedThisSession = 0
	CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT]: Achievement Total:", COUNT_ACHIEVEMENTS())
	
	//CPRINTLN(DEBUG_ACHIEVEMENT, "				TotalMoneySpent:", iTotalMoneySpent)

	#IF IS_DEBUG_BUILD
		SETUP_ACHIEVEMENT_DEBUG_WIDGETS()
		bVerbose = TRUE
	#ENDIF	
	
	DUMMY_REFERENCE_INT(iPollCheck)
	DUMP_ACHIEVEMENT_LIST_TO_TTY()
	RESET_ACHIEVEMENT_QUEUE(q_mAchievementQueue)
	SET_ACHIEVEMENT_QUEUE_RUNNING(q_mAchievementQueue)
	RESTART_TIMER_NOW(ach26MPCheckTimer)
	
	WHILE (TRUE)
	
		ENSURE_MOD_MENU_SCRIPT_RUNNING()
	
		IF (g_iBitsetCheatsUsedThisSession <> iLastBitsetCheatsUsedThisSession)
			IF (iLastBitsetCheatsUsedThisSession = 0) AND (g_iBitsetCheatsUsedThisSession != 0)
				CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - A cheat has been activated")
				
				// B*1585269 
				IF IS_PS3_VERSION()
				OR IS_PLAYSTATION_PLATFORM()
					PRINT_HELP("CHEAT_TROPHIE")
				ELSE
					PRINT_HELP("CHEAT_ACHIEVE")
				ENDIF				
			ENDIF
			
			IF (iLastBitsetCheatsUsedThisSession != 0) AND (g_iBitsetCheatsUsedThisSession = 0)
				CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - Cheats have been reset")
			ENDIF
		ENDIF
		
		iLastBitsetCheatsUsedThisSession = g_iBitsetCheatsUsedThisSession
		
		#IF IS_DEBUG_BUILD
			UPDATE_ACHIEVEMENT_DEBUG_WIDGETS()
			IF (bQuitScript)
				SCRIPT_CLEANUP()
			ENDIF
		#ENDIF
		
		//B* 2217854: Disable achievements in Director mode
		IF NOT IS_CURRENTLY_ON_MISSION_OF_TYPE(MISSION_TYPE_DIRECTOR)
		
			IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH21))
				UPDATE_ACHIEVEMENT_THREE_MAN_ARMY()
			ENDIF
			
			IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH22))
				UPDATE_ACHIEVEMENT_OUT_OF_YOUR_DEPTH()
			ENDIF
			
			// Count Solid Gold Baby Achievement
			IF (g_bCheckSolidGoldBabyAchievement)
				CPRINTLN(DEBUG_ACHIEVEMENT, "[ACHIEVEMENT] - A RC or Story Mission has ended check gold")
				IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH10))
					INT iMedals = COUNT_SOLID_GOLD_MEDALS(TRUE)
					IF iMedals>0
						SET_ACHIEVEMENT_PROGRESS_SAFE(ENUM_TO_INT(ACH10),iMedals)
						STAT_SET_INT(NUM_GOLD_MEDALS_OBTAINED,iMedals)
					ENDIF
					IF ( iMedals >= ACH10_GOLDS_NEEDED)	
						AWARD_ACHIEVEMENT(ACH10) // Solid Gold Baby
					ENDIF
				ENDIF
				g_bCheckSolidGoldBabyAchievement = FALSE
			ENDIF
			
		
			IF DOES_ENTITY_EXIST(PLAYER_PED_ID())
				IF NOT IS_ENTITY_DEAD(PLAYER_PED_ID())
				
					iPollCheck ++
					
					IF (GET_GAME_TIMER() > iNextPollCheckTime)
						UPDATE_POLLED_ACHIEVEMENTS()
						iNextPollCheckTime = GET_GAME_TIMER() + iNextPollDelay
					ENDIF
					
					IF (GET_GAME_TIMER() > iNextMapPollCheckTime)
						IF NOT HAS_ACHIEVEMENT_BEEN_PASSED(ENUM_TO_INT(ACH50)) OR (bForceRunMapCheck = true)
							IF GET_MISSION_COMPLETE_STATE(SP_MISSION_PROLOGUE)
								CHECK_SAN_ANDREAS_SIGHTSEER_ACHIEVEMENT()
							ENDIF
						ENDIF
						iNextMapPollCheckTime = GET_GAME_TIMER() + iNextMapPollDelay
					ENDIF
				ENDIF
			ENDIF
			
			UPDATE_ACHIEVEMENT_QUEUE(q_mAchievementQueue)
			CHECK_ALL_QUEUED_MP_ACHIEVEMENTS()
		ELSE 
			UPDATE_ACHIEVEMENT_QUEUE(q_mAchievementQueue)		
			CHECK_ALL_QUEUED_MP_ACHIEVEMENTS()
		ENDIF
		
		WAIT(0)
	ENDWHILE
ENDSCRIPT
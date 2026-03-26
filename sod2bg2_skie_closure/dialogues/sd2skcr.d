BEGIN ~SD2SKCR~

// courier banter 1 (when timer expired in state 4>5)
IF ~Global("SOD2BG2_STATE","GLOBAL",5)~ THEN BEGIN SD2SK_FIRST_START
  SAY @2100
  IF ~~ THEN REPLY @2110 GOTO SD2SK_FIRST_RECOGNITION1
END

// courier banter 1 followup 1
IF ~~ THEN BEGIN SD2SK_FIRST_RECOGNITION1
  SAY @2120
  IF ~~ THEN GOTO SD2SK_FIRST_RECOGNITION2
END

// courier banter 1 followup 2
IF ~~ THEN BEGIN SD2SK_FIRST_RECOGNITION2
  SAY @2121
  IF ~~ THEN GOTO SD2SK_FIRST_RECOGNITION3
END

// courier banter 1 followup 3
IF ~~ THEN BEGIN SD2SK_FIRST_RECOGNITION3
  SAY @2122
  IF ~~ THEN GOTO SD2SK_FIRST_COMMIT1
END

// courier banter 1 followup 4
IF ~~ THEN BEGIN SD2SK_FIRST_COMMIT1
  SAY @2123
  IF ~~ THEN GOTO SD2SK_FIRST_COMMIT2
END

// courier banter 1 followup 5
IF ~~ THEN BEGIN SD2SK_FIRST_COMMIT2
  SAY @2124
  IF ~~ THEN GOTO SD2SK_FIRST_EXIT
END

// courier banter 1 final - "take" dagger, advance quest, start 2 week timer
IF ~~ THEN BEGIN SD2SK_FIRST_EXIT
  SAY @2125
  IF ~~ THEN DO ~
    TakePartyItemAll("SD2SKDG")
    DestroyItem("SD2SKDG")
    SetGlobal("SOD2BG2_STATE","GLOBAL",6)
    SetGlobalTimer("SOD2BG2_TIMER","GLOBAL",FOURTEEN_DAYS)
  ~
  UNSOLVED_JOURNAL @1004
  EXIT
END

// courier banter 2 (when timer expired in state 6>7)
IF ~Global("SOD2BG2_STATE","GLOBAL",7)~ THEN BEGIN SD2SK_RETURN_START
  SAY @2200
  IF ~~ THEN GOTO SD2SK_RETURN_SUMMARY
END

// courier banter 2 followup 1
IF ~~ THEN BEGIN SD2SK_RETURN_SUMMARY
  SAY @2201
  IF ~~ THEN GOTO SD2SK_RETURN_CONTINUE_1
END

// courier banter 2 followup 2
IF ~~ THEN BEGIN SD2SK_RETURN_CONTINUE_1
  SAY @2202
  IF ~~ THEN GOTO SD2SK_RETURN_CONTINUE_2
END

// courier banter 2 followup 3
IF ~~ THEN BEGIN SD2SK_RETURN_CONTINUE_2
  SAY @2203
  IF ~~ THEN GOTO SD2SK_RETURN_CLOSURE
END

// courier banter 2 finish, closure - remove unfinished entries, add exp, gold and letter, set quest finished
IF ~~ THEN BEGIN SD2SK_RETURN_CLOSURE
  SAY @2204
  IF ~~ THEN DO ~
    EraseJournalEntry(@1001)
    EraseJournalEntry(@1002)
    EraseJournalEntry(@1003)
    EraseJournalEntry(@1004)
    GiveItemCreate("SD2SKLT",Player1,1,0,0)
    GiveGoldForce(3000)
    AddXPObject(Player1,5000)
    AddXPObject(Player2,5000)
    AddXPObject(Player3,5000)
    AddXPObject(Player4,5000)
    AddXPObject(Player5,5000)
    AddXPObject(Player6,5000)
    SetGlobal("SOD2BG2_STATE","GLOBAL",8)
  ~
  SOLVED_JOURNAL @1009
  EXIT
END
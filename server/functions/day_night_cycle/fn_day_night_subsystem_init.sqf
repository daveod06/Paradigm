/*
    File: fn_day_night_subsystem_init.sqf
    Author:  Savage Game Design
    Public: Yes
    
    Description:
        The day/night cycle subsystem manages speeding up/slowing down the day-night cycle.
		Due to Arma constraints, the shortest possible day or night is 12 minutes.
		This initialises the subsystem.
    
    Parameter(s):
        _dawnLength - Length of dawn in seconds [NUMBER]
        _dayLength - Length of each day in seconds [NUMBER]
        _duskLength - Length of dusk in seconds [NUMBER]
		_nightLength - Length of each night in seconds [NUMBER]
    
    Returns:
        Function reached the end [BOOL]
    
    Example(s):
		//Initialises the day night subsystem with 24 minute days and 12 minute nights.
        [1440, 0.5] call para_s_fnc_day_night_subsystem_init 
*/

params ["_dawnLength", "_dayLength", "_duskLength", "_nightLength"];

//Date used: 1968, February 21st
//Dawn - Defined as 5.15am to 6am
//Day - Defined as 6am to 6.15pm
//Dusk - Defined as 5.15pm to 6pm
//Night - Defined as 7pm to 5.15am

SECONDS_OF_DAWN = 3600;
SECONDS_OF_DUSK = 3600;

private _dayNightLengths = [] call saber_fnc_getDayNightLengths;

SECONDS_OF_DAY = 3600 * (_dayNightLengths select 0) - (SECONDS_OF_DAWN * 0.5) - (SECONDS_OF_DUSK * 0.5);
SECONDS_OF_NIGHT = 3600 * (_dayNightLengths select 1) - (SECONDS_OF_DAWN * 0.5) - (SECONDS_OF_DUSK * 0.5);

para_s_day_night_dawnSpeedMultiplier = SECONDS_OF_DAWN / _dawnLength;
para_s_day_night_daySpeedMultiplier = SECONDS_OF_DAY / _dayLength;
para_s_day_night_duskSpeedMultiplier = SECONDS_OF_DUSK / _duskLength;
para_s_day_night_nightSpeedMultiplier = SECONDS_OF_NIGHT / _nightLength;

/*
diag_log format [
    "
        para_s_day_night_dawnSpeedMultiplier: %1
        para_s_day_night_daySpeedMultiplier: %2
        para_s_day_night_duskSpeedMultiplier: %3
        para_s_day_night_nightSpeedMultiplier: %4
        SECONDS_OF_DAWN: %5
        SECONDS_OF_DAY: %6
        SECONDS_OF_DUSK: %7
        SECONDS_OF_NIGHT: %8
    ",
        para_s_day_night_dawnSpeedMultiplier,
        para_s_day_night_daySpeedMultiplier,
        para_s_day_night_duskSpeedMultiplier,
        para_s_day_night_nightSpeedMultiplier,
        SECONDS_OF_DAWN,
        SECONDS_OF_DAY,
        SECONDS_OF_DUSK,
        SECONDS_OF_NIGHT
];
*/

["day_night_cycle", para_s_fnc_day_night_job, [], 120] call para_g_fnc_scheduler_add_job;

true
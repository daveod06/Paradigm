/*
    File: fn_day_night_job.sqf
    Author:  Savage Game Design
    Public: No
    
    Description:
        Runs periodically to maintain the day/night cycle.
    
    Parameter(s):
		None

    Returns:
        Function reached the end [BOOL]
    
    Example(s):
		["day_night_cycle", para_s_fnc_day_night_job, [], 120] call para_g_fnc_scheduler_add_job;
*/

private _hour = date select 3;
private _minute = date select 4;
//Bit of a weird one - we're making a number in the format [0-9].[0-6][0-9], because it's easier to read.
//For example, 17.40 is 5:40pm. 18.15 is 6:15pm.
private _time = _hour + (_minute / 100);

// 0=day, 1=dusk, 2=night, 3=dawn
private _timeOfDay = call Saber_fnc_isDayNightDawnDusk;

private _isDawn = (_timeOfDay == 3);
private _isDay = (_timeOfDay == 0);
private _isDusk = (_timeOfDay == 1);
private _isNight = (_timeOfDay == 2);

if (_isDawn && timeMultiplier != para_s_day_night_dawnSpeedMultiplier) exitWith {
	setTimeMultiplier para_s_day_night_dawnSpeedMultiplier;
	missionNamespace setVariable ["para_s_time_of_day", "Dawn", true];
};

if (_isDay && timeMultiplier != para_s_day_night_daySpeedMultiplier) exitWith {
	setTimeMultiplier para_s_day_night_daySpeedMultiplier;
	missionNamespace setVariable ["para_s_time_of_day", "Day", true];
};

if (_isDusk && timeMultiplier != para_s_day_night_duskSpeedMultiplier) exitWith {
	setTimeMultiplier para_s_day_night_duskSpeedMultiplier;
	missionNamespace setVariable ["para_s_time_of_day", "Dusk", true];
};

if (_isNight && timeMultiplier != para_s_day_night_nightSpeedMultiplier) exitWith {
	setTimeMultiplier para_s_day_night_nightSpeedMultiplier;
	missionNamespace setVariable ["para_s_time_of_day", "Night", true];
	[60, 0] remoteExec ["setOvercast", 0];
};


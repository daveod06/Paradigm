/*
	File: fn_setApertureBasedOnLightLevel.sqf
	Author:  Savage Game Design
	Public: Yes
	
	Description:
		Sets the aperture based on ambient light levels to allow for night fighting.
	
	Parameter(s):
		None
	
	Returns:
		None
	
	Example(s):
		[] call para_c_fnc_setApertureBasedOnLightLevel
*/


private _lightBrightness = getLighting select 1;

if (4 < _lightBrightness && _lightBrightness < 120) exitWith {
	setApertureNew [4, 5, 9, 0.9];
	//private _currentAperture = (apertureParams) select 0;
	//systemChat format ["DIM LIGHT: %1 - %2 params: %3",_lightBrightness,_currentAperture,[4, 6, 9, 0.9]];
};

if (_lightBrightness < 4) exitWith {
	private _minAperture = linearConversion [0, 4, _lightBrightness, 3, 9, true];
	setApertureNew [_minAperture, 4, 9, 0.9];
	//private _currentAperture = (apertureParams) select 0;
	//systemChat format ["LOW LIGHT: %1 - %2 params: %3",_lightBrightness,_currentAperture,[_minAperture, 4, 9, 0.9]];
};

setAperture -1;

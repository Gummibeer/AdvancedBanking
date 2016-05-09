/*

 	Name: ExileClient_banking_map_placeATM.sqf

 	Description:
    Places ATMs on map.

*/
private ["_objects"];

switch (toLower worldName) do {
	case "altis": {
		_objects =
		[
			["Land_Atm_01_F",[4562.852051,21455.285156,0],165.48,0,0,false],
			["Land_Atm_01_F",[9401.413086,20283.503906,0],252.538,0,0,false],
			["Land_Atm_01_F",[8664.698242,18287.570313,0],154.495,0,0,false],
			["Land_Atm_01_F",[10286.851563,19096.570313,0],131.452,0,0,false],
			["Land_Atm_01_F",[14040.40332,18710.117188,0],242.752,0,0,false],
			["Land_Atm_01_F",[14068.916016,18889.572266,0],125.139,0,0,false],
			["Land_Atm_01_F",[7081.587402,16402.707031,0],177.676,0,0,false],
			["Land_Atm_01_F",[4944.543945,16144.305664,0],12.6764,0,0,false],
			["Land_Atm_01_F",[3656.991211,12819.339844,0],72.6764,0,0,false],
			["Land_Atm_01_F",[5050.383789,11299.0185547,0],152.676,0,0,false],
			["Land_Atm_01_F",[9088.436523,11940.0800781,0],187.676,0,0,false],
			["Land_Atm_01_F",[10693.483398,12237.665039,0],130.012,0,0,false],
			["Land_Atm_01_F",[10922.754883,13457.234375,0],215.012,0,0,false],
			["Land_Atm_01_F",[12589.396484,14374.325195,0],337.096,0,0,false],
			["Land_Atm_01_F",[16344.171875,17265.583984,0],297.096,0,0,false],
			["Land_Atm_01_F",[20780.267578,6728.133789,0],284.621,0,0,false],
			["Land_Atm_01_F",[21709.769531,7594.243164,0],164.621,0,0,false],
			["Land_Atm_01_F",[20257.667969,11674.0615234,0],119.621,0,0,false],
			["Land_Atm_01_F",[21393.380859,16402.541016,0],246.705,0,0,false],
			["Land_Atm_01_F",[25626.648438,21252.558594,0],226.705,0,0,false],
			["Land_Atm_01_F",[27002.974609,23234.226563,0],46.7045,0,0,false]
		];
	};
	case "chernarus": {
		_objects =
		[
			["Land_Atm_01_F",[1677.59,3853.1,0],345.909,0,0,false],
			["Land_Atm_01_F",[3603.37,2442.48,0],159.091,0,0,false],
			["Land_Atm_01_F",[2772.13,5334.25,0],100.909,0,0,false],
			["Land_Atm_01_F",[1993.16,7329.63,0],300.909,0,0,false],
			["Land_Atm_01_F",[3075.28,7976.48,0],287.727,0,0,false],
			["Land_Atm_01_F",[3830.09,8894.94,0],205,0,0,false],
			["Land_Atm_01_F",[2729.89,9985.97,0],184.545,0,0,false],
			["Land_Atm_01_F",[4962.76,12508.5,0],130,0.0,0,false],
			["Land_Atm_01_F",[5291.21,8609.02,0],285.455,0,0,false],
			["Land_Atm_01_F",[4756.53,6782.36,0],34.5455,0,0,false],
			["Land_Atm_01_F",[5883.86,4918.38,0],64.0909,0,0,false],
			["Land_Atm_01_F",[6848.98,2508.63,0.828961],313.636,0,0,false],
			["Land_Atm_01_F",[7542.04,5105.51,0],277.273,0,0,false],
			["Land_Atm_01_F",[5999.31,10345.2,0],33.6364,0,0,false],
			["Land_Atm_01_F",[8407.79,6640.47,-0.678589],185,0,0,false],
			["Land_Atm_01_F",[9146.96,3869.11,0],256.364,0,0,false],
			["Land_Atm_01_F",[10060.8,1908.08,0],267.727,0,0,false],
			["Land_Atm_01_F",[12057.1,3576.99,0],261.818,0,0,false],
			["Land_Atm_01_F",[10100.1,5470.89,-0.656677],218.636,0,0,false],
			["Land_Atm_01_F",[10654.3,8013.11,0],303.636,0,0,false],
			["Land_Atm_01_F",[10411.4,9857.99,0],313.182,0,0,false],
			["Land_Atm_01_F",[8743.14,11652,0],352.273,0,0,false],
			["Land_Atm_01_F",[12910.8,10118.3,0],297.727,0,0,false],
			["Land_Atm_01_F",[13420.8,6210.93,0],182.727,0,0,false]
		];
	};
	case "namalsk": {
		_objects =
		[
			["Land_Atm_01_F",[7256.23,7047.07,0.159363],64.5455,0,0,false],
			["Land_Atm_01_F",[7681.48,7391.96,0],219.545,0,0,false],
			["Land_Atm_01_F",[9032.93,10111.5,0],0,0,0,false],
			["Land_Atm_01_F",[8162.23,10819.7,0],292.273,0,0,false],
			["Land_Atm_01_F",[6773.13,11271.3,0],115.455,0,0,false],
			["Land_Atm_01_F",[4460.88,11219.6,0],88.6364,0,0,false],
			["Land_Atm_01_F",[5752.24,9854.2,0],349.545,0,0,false],
			["Land_Atm_01_F",[4692.31,8927.76,0],179.091,0,0,false],
			["Land_Atm_01_F",[2195.18,5764.39,0],30,0,0,false],
			["Land_Atm_01_F",[4862.84,6212.7,0],0,0,0,false]
		];
	};
	case default {
	    _objects = [];
	};
};
{
    private ["_object"];

    _object = (_x select 0) createVehicleLocal [0,0,0];
    _object setDir (_x select 2);
    _object setPosATL (_x select 1);
    _object enableSimulation false;
	_object addAction [
		"<t size='1.25'>Access ATM</t>",					// Action Text
		"createDialog 'AdvBankingATM'",						// Script/code to run
		"", 												// Arguments
		1,													// priority
		false,												// ShowWindow
		true,												// Hide on use
		"",													// Shortcut
		"((position player) distance _target) <= 4"			// condition
		];
	_marker = createMarkerLocal ["cashpoint_" + str(_forEachIndex), _x select 1];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "loc_Tourism";
	_marker setMarkerColor "ColorGreen";
	_marker setMarkerSize [1,1];
	_marker setMarkerText "ATM";
}
forEach _objects;

if (ADVBANKING_CLIENT_DEBUG) then {
	["ATMs have been placed","PlaceATM"] call ExileClient_banking_utils_diagLog;
};

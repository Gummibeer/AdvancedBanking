/**
 * ExileServer_object_player_createBambi
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

private["_sessionID","_requestingPlayer","_spawnLocationMarkerName","_bambiPlayer","_accountData","_direction","_position","_spawnAreaPosition","_spawnAreaRadius","_clanID","_clanName","_devFriendlyMode","_devs","_parachuteNetID","_spawnType","_parachuteObject"];
_sessionID = _this select 0;
_requestingPlayer = _this select 1;
_spawnLocationMarkerName = _this select 2;
_bambiPlayer = _this select 3;
_accountData = _this select 4;
_direction = random 360;
if ((count ExileSpawnZoneMarkerPositions) isEqualTo 0) then
{
	_position = call ExileClient_util_world_findCoastPosition;
}
else
{
	_spawnAreaPosition = getMarkerPos _spawnLocationMarkerName;
	_spawnAreaRadius = getNumber(configFile >> "CfgSettings" >> "BambiSettings" >> "spawnZoneRadius");
	_position = [_spawnAreaPosition, _spawnAreaRadius] call ExileClient_util_math_getRandomPositionInCircle;
	while {surfaceIsWater _position} do
	{
		_position = [_spawnAreaPosition, _spawnAreaRadius] call ExileClient_util_math_getRandomPositionInCircle;
	};
};
_name = name _requestingPlayer;
_clanID = (_accountData select 4);
_clanName = (_accountData select 5);
// Advanced Banking
private["_advBank","_playerUID"];
_playerUID = getPlayerUID _requestingPlayer;
_advBank = format["getStats:%1",_playerUID] call ExileServer_system_database_query_selectSingle;
_bambiPlayer setVariable ["ExileBank",(_advBank select 1)];
// Advanced Banking
if !((typeName _clanID) isEqualTo "SCALAR") then
{
	_clanID = -1;
	_clanName = "";
};
_bambiPlayer setPosATL [_position select 0,_position select 1,0];
_bambiPlayer disableAI "FSM";
_bambiPlayer disableAI "MOVE";
_bambiPlayer disableAI "AUTOTARGET";
_bambiPlayer disableAI "TARGET";
_bambiPlayer disableAI "CHECKVISIBLE";
_bambiPlayer setDir _direction;
_bambiPlayer setName _name;
_bambiPlayer setVariable ["ExileMoney", (_accountData select 0)];
_bambiPlayer setVariable ["ExileScore", (_accountData select 1)];
_bambiPlayer setVariable ["ExileKills", (_accountData select 2)];
_bambiPlayer setVariable ["ExileDeaths", (_accountData select 3)];
_bambiPlayer setVariable ["ExileClanID", _clanID];
_bambiPlayer setVariable ["ExileClanName", _clanName];
_bambiPlayer setVariable ["ExileHunger", 100];
_bambiPlayer setVariable ["ExileThirst", 100];
_bambiPlayer setVariable ["ExileTemperature", 37];
_bambiPlayer setVariable ["ExileWetness", 0];
_bambiPlayer setVariable ["ExileAlcohol", 0];
_bambiPlayer setVariable ["ExileName", _name];
_bambiPlayer setVariable ["ExileOwnerUID", getPlayerUID _requestingPlayer];
_bambiPlayer setVariable ["ExileIsBambi", true];
_bambiPlayer setVariable ["ExileXM8IsOnline", false, true];
_devFriendlyMode = getNumber (configFile >> "CfgSettings" >> "ServerSettings" >> "devFriendyMode");
if (_devFriendlyMode isEqualTo 1) then
{
	_devs = getArray (configFile >> "CfgSettings" >> "ServerSettings" >> "devs");
	if ((getPlayerUID _requestingPlayer) in _devs) then
	{
		_bambiPlayer setVariable ["ExileMoney", 500000];
		_bambiPlayer setVariable ["ExileScore", 100000];
	};
};
_parachuteNetID = "";
if ((getNumber(configFile >> "CfgSettings" >> "BambiSettings" >> "parachuteSpawning")) isEqualTo 1) then
{
	_position set [2, getNumber(configFile >> "CfgSettings" >> "BambiSettings" >> "parachuteDropHeight")];
	if ((getNumber(configFile >> "CfgSettings" >> "BambiSettings" >> "haloJump")) isEqualTo 1) then
	{
		_bambiPlayer addBackpackGlobal "B_Parachute";
		_bambiPlayer setPosATL _position;
		_spawnType = 2;
	}
	else
	{
		_parachuteObject = createVehicle ["Steerable_Parachute_F", _position, [], 0, "CAN_COLLIDE"];
		_parachuteObject setDir _direction;
		_parachuteObject setPosATL _position;
		_parachuteObject enableSimulationGlobal true;
		_parachuteNetID = netId _parachuteObject;
		_spawnType = 1;
	};
}
else
{
	_spawnType = 0;
};
_bambiPlayer addMPEventHandler ["MPKilled", {_this call ExileServer_object_player_event_onMpKilled}];
_bambiPlayer call ExileServer_object_player_database_insert;
_bambiPlayer call ExileServer_object_player_database_update;
[
	_sessionID,
	"createPlayerResponse",
	[
		_bambiPlayer,
		_parachuteNetID,
		str (_accountData select 0),
		str (_accountData select 1),
		(_accountData select 2),
		(_accountData select 3),
		100,
		100,
		0,
		(getNumber (configFile >> "CfgSettings" >> "BambiSettings" >> "protectionDuration")) * 60,
		_clanName,
		_spawnType
	]
]
call ExileServer_system_network_send_to;
[
    _sessionID,
    "updateBankStats",
    [
        str (_advBank select 1)
    ]
]
call ExileServer_system_network_send_to;
if (ADVBANKING_SERVER_DEBUG) then {["Processed Create Bambi with Advanced Banking","CreateBambi"] call ExileServer_banking_utils_diagLog;};
[_sessionID, _bambiPlayer] call ExileServer_system_session_update;
true

/**
 * ExileServer_system_trading_network_sellItemRequest
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

private["_sessionID","_parameters","_itemClassName","_quantity","_containerType","_containerNetID","_playerObject","_vehicleObject","_sellPrice","_playerMoney","_respectGain","_playerRespect","_responseCode"];
_sessionID = _this select 0;
_parameters = _this select 1;
_itemClassName = _parameters select 0;
_quantity = _parameters select 1;
_containerType = _parameters select 2;
_containerNetID = _parameters select 3;
try
{
	_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
	if (isNull _playerObject) then
	{
		throw 1;
	};
	if !(alive _playerObject) then
	{
		throw 2;
	};
	if(_playerObject getVariable ["ExileMutex",false]) then
	{
		throw 12;
	};
	_playerObject setVariable ["ExileMutex",true];
	_vehicleObject = objNull;
	if !(isClass (missionConfigFile >> "CfgExileArsenal" >> _itemClassName) ) then
	{
		throw 3;
	};
	_sellPrice = _itemClassName call ExileClient_util_gear_calculateSellPrice;
	if (_containerType isEqualTo 1) then
	{
		if (_itemClassName isEqualTo (primaryWeapon _playerObject)) then
		{
			{
				{
					if !(_x isEqualTo "") then
					{
						_sellPrice = _sellPrice + (_x call ExileClient_util_gear_calculateSellPrice);
					};
				}
				forEach _x;
			}
			forEach
			[
				primaryWeaponItems _playerObject,
				primaryWeaponMagazine _playerObject
			];
		};
		if (_itemClassName isEqualTo (handgunWeapon _playerObject)) then
		{
			{
				{
					if !(_x isEqualTo "") then
					{
						_sellPrice = _sellPrice + (_x call ExileClient_util_gear_calculateSellPrice);
					};
				}
				forEach _x;
			}
			forEach
			[
				handgunItems _playerObject,
				handgunMagazine _playerObject
			];
		};
	};
	if (_sellPrice <= 0) then
	{
		throw 4;
	};
	_playerMoney = _playerObject getVariable ["ExilePurse", 0];
	_playerMoney = _playerMoney + _sellPrice;
	_playerObject setVariable ["ExilePurse", _playerMoney];
	_respectGain = _sellPrice * getNumber (configFile >> "CfgSettings" >> "Respect" >> "tradingRespectFactor");
	_playerRespect = _playerObject getVariable ["ExileScore", 0];
	_playerRespect = floor (_playerRespect + _respectGain);
	_playerObject setVariable ["ExileScore", _playerRespect];
    format["updateWallet:%1:%2", _playerMoney, (getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
    format["setAccountScore:%1:%2",_playerRespect,(getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
    if (ADVBANKING_SERVER_DEBUG) then {[format["%1 sold a item",_playerObject],"sellItemRequest"] call ExileServer_banking_utils_diagLog;};
	[_sessionID, "sellItemResponse", [0, str _playerMoney, _itemClassName, 1, _containerType, _containerNetID, str _playerRespect]] call ExileServer_system_network_send_to;
	if !(_vehicleObject isEqualTo objNull) then
	{
		_vehicleObject call ExileServer_object_vehicle_database_update;
	}
	else
	{
		_playerObject call ExileServer_object_player_database_update;
	};
}
catch
{
	_responseCode = _exception;
	format ["NOPE: %1", _responseCode] call ExileClient_util_log;
	[_sessionID, "sellItemResponse", [_responseCode, "", "", 0, 0, "", ""]] call ExileServer_system_network_send_to;
};
if !(isNull _playerObject) then
{
	_playerObject setVariable ["ExileMutex", false];
};
true

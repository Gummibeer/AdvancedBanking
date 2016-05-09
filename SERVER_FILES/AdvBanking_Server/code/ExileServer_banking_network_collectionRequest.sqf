/*

 	Name: ExileServer_banking_network_collectionRequest.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Process money pile collection request

*/
private["_sessionId","_package","_objectId","_worth","_playerObject","_playerWallet"];
_sessionId = _this select 0;
_package = _this select 1;
_worth = parseNumber(_package select 0);
_objectID = _package select 1;

try {
    if (ADVBANKING_SERVER_DEBUG) then {[format["Collection Request enacted. Package: %1",_package],"CollectionRequest"] call ExileServer_banking_utils_diagLog;};
    _playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
    _object = objectFromNetId _objectID;
    if (isNull _object) then
	{
		throw 1;
	};
    _objectWallet = _object getVariable ["DroppedAmount",0];
    deleteVehicle _object;
    if (_worth < 0) then {
        throw 3;
    };
    if (_objectWallet != _worth) then {
        throw 4;
    };
    _object setVariable ["DroppedAmount",0];
    if (ADVBANKING_SERVER_DEBUG) then {[format["Worth: %1  Object Check: %2",_worth,_objectWallet],"CollectionRequest"] call ExileServer_banking_utils_diagLog;};
    _playerWallet = _playerObject getVariable ["ExileMoney",0];
    _playerWallet = _playerWallet + _worth;
    _playerObject setVariable ["ExileMoney",_playerWallet];
    format["setAccountMoney:%1:%2",_playerWallet,(getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
    [_sessionId,"collectMoneyResponse",[str(_playerWallet),str(_worth)]] call ExileServer_system_network_send_to;
} catch {
    [_exception,"CollectionRequest"] call ExileServer_banking_utils_diagLog;
    deleteVehicle _object;
};

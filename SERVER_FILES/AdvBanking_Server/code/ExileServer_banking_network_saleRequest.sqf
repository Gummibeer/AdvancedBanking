/*

 	Name: ExileServer_banking_network_saleRequest.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Processes handling generic sales. For use with other scripts.
    ["saleRequest",["WALLET" or "BANK",str(AMOUNT_TO_ADD)]] call ExileClient_system_network_send;

*/

private["_sessionID","_package","_choice","_amount","_playerObject","_bank","_wallet","_exception"];

_sessionID = _this select 0;
_package = _this select 1;
_choice = toUpper(_package select 0);
_amount = parseNumber(_package select 1);

try {
    if (ADVBANKING_SERVER_DEBUG) then {[format["Sale Requested enacted. Package: %1",_package],"SaleRequest"] call ExileServer_banking_utils_diagLog;};
    _playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
    if (isNull _playerObject) then
	{
		throw 1;
	};
	if !(alive _playerObject) then
	{
		throw 2;
	};
    if (_amount < 0 ) then {
        throw 3;
    };
    if (_choice isEqualTo "BANK") then {
        _bank = _playerObject getVariable ["ExileBank",0];
        _bank = _bank + _amount;
        _playerObject setVariable ["ExileBank",_bank];
        format["updateBank:%1:%2",_bank,(getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
        [_sessionID,"updateBankStats",[str(_bank)]] call ExileServer_system_network_send_to;
        [format["Sale Request Invoked: Previous Player Bank: %1 Amount to be Added: %2 Final Bank Amount: %3",(_bank - _amount),_amount,_bank],"SaleRequest"] call ExileServer_banking_utils_diagLog;
    } else {
        _wallet = _playerObject getVariable ["ExileMoney",0];
        _wallet = _wallet + _amount;
        _playerObject setVariable ["ExileMoney",_wallet];
        format["setAccountMoney:%1:%2",_wallet,(getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
        [_sessionID,"updateWalletStats",[str(_wallet)]] call ExileServer_system_network_send_to;
        [format["Sale Request Invoked: Previous Player Wallet: %1 Amount to be Added: %2 Final Wallet Amount: %3",(_wallet - _amount),_amount,_wallet],"SaleRequest"] call ExileServer_banking_utils_diagLog;
    };
} catch {
    [_sessionID,"notificationRequest", ["Whoops", [format["%1",_exception]]]] call ExileServer_system_network_send_to;
    [_exception,"SaleRequest"] call ExileServer_banking_utils_diagLog;
};

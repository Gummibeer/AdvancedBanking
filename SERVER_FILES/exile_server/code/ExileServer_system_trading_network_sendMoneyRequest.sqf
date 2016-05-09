/**
 * ExileServer_system_trading_network_sendMoneyRequest
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

private["_sessionID","_parameters","_amountToTransferString","_receiverNetID","_amountToTransfer","_senderPlayerObject","_receiverPlayerObject","_senderAccountBalance","_receiverAccountBalance"];
_sessionID = _this select 0;
_parameters = _this select 1;
_amountToTransferString = _parameters select 0;
_receiverNetID = _parameters select 1;
try
{
	_amountToTransfer = floor (parseNumber _amountToTransferString);
	if (_amountToTransfer < 1) then
	{
		throw "You cannot transfer weird amounts.";
	};
	_senderPlayerObject = _sessionID call ExileServer_system_session_getPlayerObject;
	if (isNull _senderPlayerObject) then
	{
		throw "Player (sender) object not found.";
	};
	_receiverPlayerObject = objectFromNetId _receiverNetID;
	if (isNull _receiverPlayerObject) then
	{
		throw "Player (receiver) object not found.";
	};
	if (_senderPlayerObject isEqualTo _receiverPlayerObject) then
	{
		throw "You want to send yourself some MONEH, huh?";
	};
    _senderAccountBalance = _senderPlayerObject getVariable ["ExileBank", 0];
    _receiverAccountBalance = _receiverPlayerObject getVariable ["ExileBank", 0];
	if (_amountToTransfer > _senderAccountBalance) then
	{
		throw "You do not have enough pop tabs in your account.";
	};
	_senderAccountBalance = _senderAccountBalance - _amountToTransfer;
    _senderPlayerObject setVariable ["ExileBank", _senderAccountBalance];
	format["updateBank:%1:%2", _senderAccountBalance, getPlayerUID _senderPlayerObject] call ExileServer_system_database_query_fireAndForget;
	[_sessionID, "updateBankStats", [str _senderAccountBalance]] call ExileServer_system_network_send_to;
	[_sessionID,"handleATMMessage", [3,"Success","We have successfully processed your transfer"]] call ExileServer_system_network_send_to;
	_receiverAccountBalance = _receiverAccountBalance + _amountToTransfer;
    _receiverPlayerObject setVariable ["ExileBank", _receiverAccountBalance];
    format["updateBank:%1:%2", _receiverAccountBalance, getPlayerUID _receiverPlayerObject] call ExileServer_system_database_query_fireAndForget;
    [_receiverPlayerObject, "youWonTheLottery", [str _receiverAccountBalance, name _senderPlayerObject]] call ExileServer_system_network_send_to;
    if (ADVBANKING_SERVER_DEBUG) then {[format["%1 sent %2 poptabs to %2",_playerObject,_amountToTransfer,_receiverPlayerObject],"SendMoneyRequest"] call ExileServer_banking_utils_diagLog;};
}
catch
{
	[_sessionID,"handleATMMessage", [3,"Error",_exception]] call ExileServer_system_network_send_to;
	_exception call ExileServer_util_log;
};

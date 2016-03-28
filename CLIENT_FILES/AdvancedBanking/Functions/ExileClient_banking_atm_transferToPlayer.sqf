/*

 	Name: ExileClient_banking_atm_transferToPlayer.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

	This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles transferring caps to other players

*/
private["_display","_playerlb","_playerNetID","_editBox","_amount"];
disableSerialization;
_display = uiNameSpace getVariable ["AdvBankingATM", displayNull];
_playerlb = _display displayCtrl 1500;
_playerNetID = _playerLb lbData (lbCurSel _playerlb);
_editBox = _display displayCtrl 1400;
_amount = abs (parseNumber (ctrlText _editBox));

if (_playerNetID isEqualTo (netId player)) then {
	["Failed","You cannot send pop tabs to yourself!"] call ExileClient_banking_network_handleATMMessage;
} else {
	if (_amount > ExileClientBank) then {
		["Failed","You can't send more than what you have in your bank!"] call ExileClient_banking_network_handleATMMessage;
	} else {
		if (ADVBANKING_CLIENT_DEBUG) then {[format["Transferring request sent to server. Amount: %1",_amount],"transferToPlayer"] call ExileClient_banking_utils_diagLog;};
		["sendMoneyRequest", [str _amount, _playerNetID]] call ExileClient_system_network_send;
	};
};

/*

 	Name: ExileClient_banking_player_withdrawal.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles withdrawal of money

*/
private["_display","_editBox","_amount","_fromAccount","_exception"];
disableSerialization;
_display = uiNameSpace getVariable ["AdvBankingATM", displayNull];
_editBox = (_display displayCtrl 1400);
_amount = parseNumber(ctrlText _editBox);
_fromAccount = "PersonalBank";

try {
    if (_fromAccount isEqualTo "PersonalBank") then {
        if (_amount == 0) then {
            throw "Requested amount equals 0";
        };
        if (_amount > ExileClientBank) then {
            throw "You cannot withdrawal more than what you have in your bank";
        };
        if (ADVBANKING_CLIENT_DEBUG) then {[format["Withdrawal request sent to server. Package: %1",_amount],"Withdrawal"] call ExileClient_banking_utils_diagLog;};
        ["withdrawalRequest",[str(_amount)]] call ExileClient_system_network_send;
    };
} catch {
    ["Error",_exception] call ExileClient_banking_network_handleATMMessage;
    [_exception,"WithdrawalMoney"] call ExileClient_banking_utils_diagLog;
};

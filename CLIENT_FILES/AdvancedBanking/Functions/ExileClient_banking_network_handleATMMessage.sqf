/*

 	Name: ExileClient_banking_network_handleATMMessage.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles messages based on dumbassery
*/
private ["_package","_message","_display","_messageBox","_messageType","_messageArea"];

disableSerialization;
params ["_messageArea","_messageType","_message"];

if (_messageArea isEqualTo 1) then
{
    // Deposit
    [9050,_messageType,toUpper(_message)] spawn fnc_atmMessage;
}
else
{
    if (_messageArea isEqualTo 2) then
    {
        // Withdraw
        [9051,_messageType,toUpper(_message)] spawn fnc_atmMessage;
    }
    else
    {
        // Transfer
        [9052,_messageType,toUpper(_message)] spawn fnc_atmMessage;
    };
};

if (ADVBANKING_CLIENT_DEBUG) then {[format["Display Message: %1",_message],"ATMMessage"] call ExileClient_banking_utils_diagLog;};


fnc_atmMessage = {
    disableSerialization;
    params ["_idd","_messageType","_message"];

    _display = uiNameSpace getVariable ["AdvBankingATM", displayNull];

    if (_messageType isEqualTo "Success") then
    {
        //Success
        (_display displayCtrl _idd) ctrlSetStructuredText parseText Format["<t color='#00b300' font='PuristaMedium' size='0.7' valign='middle' align='left' shadow='0'>%1</t>",_message];
    }
    else
    {
        //Error
        (_display displayCtrl _idd) ctrlSetStructuredText parseText Format["<t color='#b30000' font='PuristaMedium' size='0.7' valign='middle' align='left' shadow='0'>%1</t>",_message];
    };

    (_display displayCtrl _idd) ctrlSetFade 0;
    (_display displayCtrl _idd) ctrlCommit 0.25;

    uiSleep 5;

    (_display displayCtrl _idd) ctrlSetFade 1;
    (_display displayCtrl _idd) ctrlCommit 0.25;
};

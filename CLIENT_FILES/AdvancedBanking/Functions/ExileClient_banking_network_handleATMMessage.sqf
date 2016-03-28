/*

 	Name: ExileClient_banking_network_handleATMMessage.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles messages based on dumbassery
*/
private ["_package","_message","_display","_messageBox","_messageType"];
_messageType = _this select 0;
_message = _this select 1;

[_messageType,_message] spawn {
    disableSerialization;
    _messageType = _this select 0;
    _message = toUpper(_this select 1);

    _display = uiNameSpace getVariable ["AdvBankingATM", displayNull];
    _messageBox = (_display displayCtrl 11012);

    if (_messageType isEqualTo "Success") then {
        //Success
        _messageBox ctrlSetStructuredText parseText Format["<t color='#00b300' font='OrbitronLight' size='1' valign='middle' align='center' shadow='0'>%1</t>",_message];
    } else {
        //Error
        _messageBox ctrlSetStructuredText parseText Format["<t color='#b30000' font='OrbitronLight' size='1' valign='middle' align='center' shadow='0'>%1</t>",_message];
    };
    if (ADVBANKING_CLIENT_DEBUG) then {[format["Display Message: %1",_message],"ATMMessage"] call ExileClient_banking_utils_diagLog;};
    _messageBox ctrlSetFade 0;
    _messageBox ctrlCommit 0.25;

    uiSleep 5;

    _messageBox ctrlSetFade 1;
    _messageBox ctrlCommit 0.25;
};

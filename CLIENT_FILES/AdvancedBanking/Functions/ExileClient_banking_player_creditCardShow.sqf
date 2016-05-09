/*

 	Name: ExileClient_banking_player_creditCardShow.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles creating of the credit card and fills in the info

*/
private ["_display","_ctrls","_slideLeft","_curPos","_newPosX","_slideLeft","_playerWallet","_setPlayerName","_setInamte","_setWalletHeader","_setPlayerWallet","_setAccountNum","_setTransDate","_charArray","_numArray","_a1","_a2","_a3","_a4","_a5","_a6","_a7","_compiledAccNum"];
cutRsc ["AdvBankingCreditCard", "PLAIN", 0, true];
disableSerialization;
_display = uiNameSpace getVariable ["AdvBankingCreditCard", displayNull];
if (ADVBANKING_CLIENT_DEBUG) then {[format["Showing credit card for player"],"CreditCardShow"] call ExileClient_banking_utils_diagLog;};

//Hide the creddit card
_ctrls = [1200,1201,1100,1101,1102,1103,1104,1105,1106,1107,1108,1109,1110,1111];
{
    _slideLeft = (_display displayCtrl _x);
    _curPos = ctrlPosition _slideLeft;
    _newPosX = (_curPos select 0) +1;
    _slideLeft ctrlSetPosition [_newPosX, _curPos select 1];
    _slideLeft ctrlCommit 0;
} forEach _ctrls;

_playerName = toUpper(_this select 0);
_playerWallet = _this select 1;
//Set Player Name
(_display displayCtrl 1100) ctrlSetStructuredText parseText Format["<t color='#FFFFFF' font='PuristaMedium' size='1' align='left' shadow='0'>%1</t>",_playerName];

//Set Inmate status
(_display displayCtrl 1101) ctrlSetStructuredText parseText Format["<t color='#FFFFFF' font='PuristaMedium' size='1' align='left' shadow='0'>INMATE:</t>"];
//Set Wallet ammount header

(_display displayCtrl 1102) ctrlSetStructuredText parseText Format["<t color='#FFFFFF' font='PuristaMedium' size='0.6' align='left' shadow='0'>WALLET AMOUNT:</t>"];
//Set Wallet ammount header
(_display displayCtrl 1103) ctrlSetStructuredText parseText Format["<t color='#FFFFFF' font='PuristaMedium' size='1' align='left' shadow='0'>%1<img image='\exile_assets\texture\ui\poptab_notification_ca.paa' size='0.7' shadow='true' /></t>",_playerWallet];

//set the transaction date
(_display displayCtrl 1105) ctrlSetStructuredText parseText Format["<t color='#FFFFFF' font='PuristaMedium' size='0.65' align='left' shadow='0'>DATE: 08/20/2036</t>"];
{
    _slideLeft = (_display displayCtrl _x);
    _curPos = ctrlPosition _slideLeft;
    _newPosX = (_curPos select 0) -1;
    _slideLeft ctrlSetPosition [_newPosX, _curPos select 1];
    _slideLeft ctrlCommit 0.7;
} forEach _ctrls;

uiSleep 10;

{
    _slideLeft = (_display displayCtrl _x);
    _curPos = ctrlPosition _slideLeft;
    _newPosX = (_curPos select 0) +1;
    _slideLeft ctrlSetPosition [_newPosX, _curPos select 1];
    _slideLeft ctrlCommit 0.7;
} forEach _ctrls;

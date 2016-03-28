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
_ctrls = [1200,1201,1100,1101,1102,1103,1104,1105];
{
    _slideLeft = (_display displayCtrl _x);
    _curPos = ctrlPosition _slideLeft;
    _newPosX = (_curPos select 0) +1;
    _slideLeft ctrlSetPosition [_newPosX, _curPos select 1];
    _slideLeft ctrlCommit 0;
} forEach _ctrls;

_playerName = toUpper(_this select 0);
_playerWallet = _this select 1; //get the player wallet

//Set Player Name
_setPlayerName = (_display displayCtrl 1100);
_setPlayerName ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='1' align='left' shadow='0'>%1</t>",_playerName];

//Set Inmate status
_setInamte = (_display displayCtrl 1101);
_setInamte ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='0.75' align='left' shadow='0'>INMATE</t>"];

//Set Wallet ammount header
_setWalletHeader = (_display displayCtrl 1102);
_setWalletHeader ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='0.6' align='left' shadow='0'>WALLET AMOUNT:</t>"];

//Set Wallet ammount header
_setPlayerWallet = (_display displayCtrl 1103);
_setPlayerWallet ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='1' align='left' shadow='0'>%1<img image='\exile_assets\texture\ui\poptab_notification_ca.paa' size='0.7' shadow='true' /></t>",_playerWallet];

//Set the random account number
_charArray = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
_numArray = ['1','2','3','4','5','6','7','8','9','0'];
_a1 = _charArray call BIS_fnc_selectRandom;
_a2 = _numArray call BIS_fnc_selectRandom;
_a3 = _numArray call BIS_fnc_selectRandom;
_a4 = _numArray call BIS_fnc_selectRandom;
_a5 = _charArray call BIS_fnc_selectRandom;
_a6 = _charArray call BIS_fnc_selectRandom;
_a7 = _charArray call BIS_fnc_selectRandom;
_compiledAccNum = _a1 + _a2 + _a3 + _a4 + _a5 + _a6 + _a7; //MAD CREDITS TO MEZO FOR THIS - HE TAUGHT US EVERYTHING WE KNOW. (Yes, how to make everything super complicated/effectiant)

_setAccountNum = (_display displayCtrl 1104);
_setAccountNum ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='0.65' align='left' shadow='0'>%1</t>",_compiledAccNum];

//set the transaction date
_setTransDate = (_display displayCtrl 1105);
_setTransDate ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='0.65' align='left' shadow='0'>DATE: 08/20/2036</t>"];

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

/*

 	Name: ExileClient_banking_atm_updateATM.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles updateing the ATM when a player withdraws or deposits money

*/
private["_display","_wallet","_setBanlance","_setSharedBalance","_bank","_setPersonalBalance","_setAccountInUse","_inputBox"];

_display = uiNameSpace getVariable ["AdvBankingATM", displayNull];

//Set The players Balance (Top Right)
_wallet = ExileClientPlayerMoney;
_setBanlance = (_display displayCtrl 1102);
_setBanlance ctrlSetStructuredText parseText Format["<t valign='middle' align='center' color='#00b2cd' font='OrbitronLight' size='2'>%1<img image='\exile_assets\texture\ui\poptab_notification_ca.paa' size='1.6' shadow='true' /></t>",_wallet];

//set the Shared bank account balance
_setSharedBalance = (_display displayCtrl 1107);
_setSharedBalance ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='0.85' valign='middle' align='center' shadow='0'><br/><t font='OrbitronMedium' size='1.7' color='#ffffff'>NOT YET IMPLIMENTED</t><br/>SHARED BANK BALANCE</t>"];

//set the Shared bank account balance
_bank = ExileClientBank;
_setPersonalBalance = (_display displayCtrl 1108);
_setPersonalBalance ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='0.85' valign='middle' align='center' shadow='0'><br/><t font='OrbitronMedium' size='1.7' color='#ffffff'>%1<img image='\exile_assets\texture\ui\poptab_notification_ca.paa' size='1.6' shadow='true' /></t><br/>PERSONAL BANK BALANCE</t>",_bank];

//set account in use
_setAccountInUse = (_display displayCtrl 1109);
_setAccountInUse ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='0.7' valign='middle' align='center' shadow='0'><br/><t font='OrbitronMedium' size='1.7' color='#ffffff'>PERSONAL</t><br/>ACCOUNT IN USE</t>"];

//Reset input box
_inputBox = (_display displayCtrl 1400);
_inputBox ctrlSetText "";

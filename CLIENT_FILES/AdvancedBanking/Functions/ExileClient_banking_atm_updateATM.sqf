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

(_display displayCtrl 9033) ctrlSetText Format["%1",ExileClientBank];
(_display displayCtrl 9078) ctrlSetText Format["%1",ExileClientPlayerMoney];

_inputBox = (_display displayCtrl 9034);
_inputBox ctrlSetText "";
_inputBox = (_display displayCtrl 9008);
_inputBox ctrlSetText "";
_inputBox = (_display displayCtrl 9009);
_inputBox ctrlSetText "";

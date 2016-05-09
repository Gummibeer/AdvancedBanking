/*

 	Name: ExileClient_banking_atm_closeATM.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles closing of the ATM

*/
disableSerialization;
_display = uiNameSpace getVariable ["AdvBankingATM", displayNull];

//Transfer
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [(_ctrlPos select 0)+1.7,_ctrlPos select 1];
    _ctrl ctrlCommit 0.25;
} forEach [9002,9022,9026,9034,9035,9036,9038,9039,9040,9041,2200,9042,9044,9052];

//Left Side Bar
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [(_ctrlPos select 0)-0.8,_ctrlPos select 1];
    _ctrl ctrlCommit 0.25;
} forEach [9001,9006,9007,9028,9029,9030,9031,9005,9023,9046,9027,9045,9043];

//Account
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [_ctrlPos select 0,(_ctrlPos select 1)-0.5];
    _ctrl ctrlCommit 0.25;
} forEach [9014,9021,9032,9033,9075,9076,9077,9078];

//Deposit
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [(_ctrlPos select 0)-1.4,_ctrlPos select 1];
    _ctrl ctrlCommit 0.25;
} forEach [9004,9008,9010,9012,9019,9024,9047,9015,9016,9050];

//Withdraw
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [(_ctrlPos select 0)+1.1,_ctrlPos select 1];
    _ctrl ctrlCommit 0.25;
} forEach [9003,9009,9011,9013,9017,9018,9020,9025,9048,9051];

uiSleep 0.4;

_bg = _display displayCtrl 9000;
_bg ctrlSetFade 1;
_bg ctrlCommit 0.25;

uiSleep 0.25;

(findDisplay 0711) closeDisplay 0;

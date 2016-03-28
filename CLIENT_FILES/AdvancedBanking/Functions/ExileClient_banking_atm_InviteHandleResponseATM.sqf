/*

 	Name: ExileClient_banking_atm_InviteHandleResponseATM.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles the response from players when acceping / declining invites to shared banking

*/
private["_playerResponse","_ctrls","_display","_slide","_curPos","_newPosX","_advCtrls"];
disableSerialization;
_playerResponse = _this select 0;
//Function used to slide the invitation screen out of the way once player has given input
fnc_SlideTransition = {
    _ctrls = [2222,2223,2224,2225,2226,2227];
    _display = uiNameSpace getVariable ["AdvBankingATM", displayNull];
    {
        _slide = (_display displayCtrl _x);
        _curPos = ctrlPosition _slide;
        _newPosX = (_curPos select 0) - 3;
        _slide ctrlSetPosition [_newPosX,_curPos select 1];
        _slide ctrlCommit 0.5;
        ctrlEnable [_x,false];
    } forEach _ctrls;
    _advCtrls = [1600,1607,1400,1103,1104,1604,1605,1108,1107,1109,1105,1106];
    {
        _slide = (_display displayCtrl _x);
        _curPos = ctrlPosition _slide;
        _newPosX = (_curPos select 0) -4;
        _slide ctrlSetPosition [_newPosX,_curPos select 1];
        _slide ctrlCommit 0.5;
        ctrlEnable [_x,true];
    } forEach _advCtrls;
};

if(_playerResponse == 0)then{
    call fnc_SlideTransition;
};

if(_playerResponse == 1)then{
    call fnc_SlideTransition;
};

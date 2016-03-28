/*

 	Name: ExileClient_banking_xm8_inviteHandleResponseXM8.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles the response from players when acceping / declining invites to shared banking

*/
private ["_display","_invCtrls","_hide","_ABctrls"];
disableSerialization;

fnc_slideTransitionXM8 = {
    _display = uiNameSpace getVariable ["RscExileXM8", displayNull];
    //Hides the invite screen ctrls
    _invCtrls = [1121,1122,1123,1124,1125];
    {
        _hide = (_display displayCtrl _X);
        _hide ctrlSetFade 1;
        _hide ctrlCommit 0.25;
    } forEach _invCtrls;

    uiSleep 0.25;

    //Fade in the advanced banking app ctrls
    _ABctrls = [9211,9212,9213,9214,9215,9216,9217];
    {
        _hide = (_display displayCtrl _X);
        _hide ctrlSetFade 0;
        _hide ctrlCommit 0.25;
    } forEach _ABctrls;
};

call fnc_slideTransitionXM8;

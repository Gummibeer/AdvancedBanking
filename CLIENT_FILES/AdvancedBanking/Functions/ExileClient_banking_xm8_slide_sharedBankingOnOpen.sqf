/*

 	Name: ExileClient_banking_xm8_slide_sharedBankingOnOpen.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles loading of the shared banking XM8 App

*/
private["_display","_esc","_appsSlide","_ctrl","_ctrls","_SharedAccountOwner","_SharedAccountMembers","_PlayersList","_InvPlayerBtn","_kickPlayerBtn","_GoBackBtn","_ABctrls","_hide","_invText","_AcceptText","_DeclineText","_AcceptButton","_DeclineButton","_ctrlArray","_appsSlide"];

disableSerialization;
_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
(_display displayCtrl 4004) ctrlSetStructuredText (parseText (format ["<t align='center' font='RobotoMedium'>Shared Banking</t>"]));
ctrlShow [4092, false];
_esc = (findDisplay 24015) displayAddEventHandler ["KeyDown", "if(_this select 1 == 1)then{ExileClientXM8CurrentSlide = 'apps';};"];

_appsSlide = (_display displayCtrl 4040);
_appsSlide ctrlSetPosition [(-19 * 0.05), (0 * 0.05)];
_appsSlide ctrlCommit 0.25;
uiSleep 0.3;
_ctrlArray = [4007,4060,4040,4120,4080,4070,4090,4100,4110,4130,4030];
{
    _ctrl = (_display displayCtrl _x);
    _ctrl ctrlSetFade 1;
    _ctrl ctrlCommit 0;
    ctrlEnable [_x, false];
} forEach _ctrlArray;


//Create New Shared account owner stat
_SharedAccountOwner = _display ctrlCreate ["RscStructuredText", 9211];
_SharedAccountOwner ctrlSetPosition [(7 - 3) * (0.025),(6 - 2) * (0.04),0.35, 0.18];
_SharedAccountOwner ctrlCommit 0;
_SharedAccountOwner ctrlSetBackgroundColor [255, 255, 255, 0.050000];
_SharedAccountOwner ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='0.7' valign='middle' align='center' shadow='0'><br/><t font='OrbitronMedium' size='1.7' color='#ffffff'>SHIX</t><br/>SHARED ACCOUNT OWNER</t>"];

//Create New Shared account member header
_SharedAccountOwner = _display ctrlCreate ["RscStructuredText", 9212];
_SharedAccountOwner ctrlSetPosition [(7 - 3) * (0.025),(11 - 2) * (0.04),0.35, 0.031];
_SharedAccountOwner ctrlCommit 0;
_SharedAccountOwner ctrlSetBackgroundColor [255, 255, 255, 0.050000];
_SharedAccountOwner ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='0.7' align='center' shadow='0'>SHARED ACCOUNT MEMBERS</t>"];

//Create New Shared account member stat
_SharedAccountMembers = _display ctrlCreate ["RscListBox", 9213];
_SharedAccountMembers ctrlSetPosition [(7 - 3) * (0.025),(11.9 - 2) * (0.04),0.35, 0.42];
_SharedAccountMembers ctrlCommit 0;
_SharedAccountMembers ctrlSetBackgroundColor [255, 255, 255, 0.050000];
_SharedAccountMembers ctrlSetFont "OrbitronMedium";
_SharedAccountMembers lbAdd "Mezo";
_SharedAccountMembers lbAdd "Swampen";
_SharedAccountMembers lbAdd "DayDreamer";
_SharedAccountMembers lbAdd "Wolfkillarcadia";
_SharedAccountMembers lbAdd "Rocketeer";
_SharedAccountMembers lbAdd "Scofield";
_SharedAccountMembers lbAdd "Fred";

//Create New Player List header
_SharedAccountOwner = _display ctrlCreate ["RscStructuredText", 9214];
_SharedAccountOwner ctrlSetPosition [(25 - 3) * (0.025),(6 - 2) * (0.04),0.35, 0.031];
_SharedAccountOwner ctrlCommit 0;
_SharedAccountOwner ctrlSetBackgroundColor [255, 255, 255, 0.050000];
_SharedAccountOwner ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='0.7' align='center' shadow='0'>PLAYERS</t>"];

//Create Players List
_PlayersList = _display ctrlCreate ["RscListBox", 9215];
_PlayersList ctrlSetPosition [(25 - 3) * (0.025),(6.9 - 2) * (0.04),0.35, 0.42];
_PlayersList ctrlCommit 0;
_PlayersList ctrlSetBackgroundColor [255, 255, 255, 0.050000];
_PlayersList ctrlSetFont "OrbitronMedium";
_PlayersList lbAdd "Muffin Man";
_PlayersList lbAdd "Pu55y Sl4yer";
_PlayersList lbAdd "xXGR8Xx";
_PlayersList lbAdd "Give Credits";
_PlayersList lbAdd "AlBagdadi";

//creates the invite player button
_InvPlayerBtn = _display ctrlCreate ["RscButtonMenu", 9216];
_InvPlayerBtn ctrlSetPosition [(25 - 3) * (0.025),(17.6 - 2) * (0.04),14 * (0.025),1 * (0.04)];
_InvPlayerBtn ctrlCommit 0;
_InvPlayerBtn ctrlSetText "INVITE SELECTED PLAYER";
_InvPlayerBtn ctrlSetEventHandler ["ButtonClick", "call fnc_goBack"];

//Creates the Kick player button
_kickPlayerBtn = _display ctrlCreate ["RscButtonMenu", 9217];
_kickPlayerBtn ctrlSetPosition [(25 - 3) * (0.025),(18.8 - 2) * (0.04),14 * (0.025),1 * (0.04)];
_kickPlayerBtn ctrlCommit 0;
_kickPlayerBtn ctrlSetText "KICK SELECTED PLAYER";
_kickPlayerBtn ctrlSetEventHandler ["ButtonClick", "call fnc_goBack"];
//Go back button
_GoBackBtn = _display ctrlCreate ["RscButtonMenu", 1116];
_GoBackBtn ctrlSetPosition [(33 - 3) * (0.025),(21 - 2) * (0.04),6 * (0.025),1 * (0.04)];
_GoBackBtn ctrlCommit 0;
_GoBackBtn ctrlSetText "Go Back";
_GoBackBtn ctrlSetEventHandler ["ButtonClick", "call fnc_goBack"];



if(PlayerHasPendingInv)then{
    //hide all the advanced banking ctrls
    _ABctrls = [9211,9212,9213,9214,9215,9216,9217];
    {
        _hide = (_display displayCtrl _x);
        _hide ctrlSetFade 1;
        _hide ctrlCommit 0;
    } forEach _ABctrls;

    //Create the invitation response ctrls
    _invText = _display ctrlCreate ["RscStructuredText", 1121];
    _invText ctrlSetPosition [(8 - 3) * (0.025),(10 - 2) * (0.04),0.75, 0.13];
    _invText ctrlCommit 0;
    _invText ctrlSetBackgroundColor [255, 255, 255, 0];
    _invText ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='1' align='center' shadow='0'>YOU HAVE RECIEVED AN INVITATION TO JOIN SHIX'S SHARED BANKING ACCOUNT, WOULD YOU LIKE TO ACCEPT THIS INVITE?</t>"];

    _AcceptText = _display ctrlCreate ["RscStructuredText", 1122];
    _AcceptText ctrlSetPosition [(15 - 3) * (0.025),(14 - 2) * (0.04),0.4, 0.05];
    _AcceptText ctrlCommit 0;
    _AcceptText ctrlSetBackgroundColor [255, 255, 255, 0];
    _AcceptText ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='1' align='center' shadow='0'>ACCEPT</t>"];

    _DeclineText = _display ctrlCreate ["RscStructuredText", 1123];
    _DeclineText ctrlSetPosition [(15 - 3) * (0.025),(15.5 - 2) * (0.04),0.4, 0.05];
    _DeclineText ctrlCommit 0;
    _DeclineText ctrlSetBackgroundColor [255, 255, 255, 0];
    _DeclineText ctrlSetStructuredText parseText Format["<t color='#00b2cd' font='OrbitronLight' size='1' align='center' shadow='0'>DECLINE</t>"];

    _AcceptButton = _display ctrlCreate ["RscExileXM8AppButton1x1", 1124];
    _AcceptButton ctrlSetPosition [(15 - 3) * (0.025),(14 - 2) * (0.04),0.4, 0.05];
    _AcceptButton ctrlCommit 0;
    _AcceptButton ctrlSetBackgroundColor [0, 0, 0, 0];
    _AcceptButton ctrlSetActiveColor [1,1,1,0.05];
    _AcceptButton ctrlSetEventHandler ["ButtonClick", "[1]execVM 'AdvancedBanking\Functions\AdvBanking_InviteHandleResponseXM8.sqf';"];

    _DeclineButton = _display ctrlCreate ["RscExileXM8AppButton1x1", 1125];
    _DeclineButton ctrlSetPosition [(15 - 3) * (0.025),(15.5 - 2) * (0.04),0.4, 0.05];
    _DeclineButton ctrlCommit 0;
    _DeclineButton ctrlSetBackgroundColor [0, 0, 0, 0];
    _DeclineButton ctrlSetActiveColor [1,1,1,0.05];
    _DeclineButton ctrlSetEventHandler ["ButtonClick", "[0]execVM 'AdvancedBanking\Functions\AdvBanking_InviteHandleResponseXM8.sqf'"];
};

fnc_goBack = {
    _display = uiNameSpace getVariable ["RscExileXM8", displayNull];
    _ctrls = [1116,9211,9212,9213,9214,9215,9216,9217];
    {
        _ctrl = (_display displayCtrl _x);
        _ctrl ctrlSetFade 1;
        _ctrl ctrlCommit 0.5;
        ctrlEnable [_x, true];
    } forEach _ctrls;
    uiSleep 0.25;
    (_display displayCtrl 4004) ctrlSetStructuredText (parseText (format ["<t align='center' font='RobotoMedium'>XM8</t>"]));
    _ctrlArray = [4007,4060,4040,4120,4080,4070,4090,4100,4110,4130,4030];
    {
        _ctrl = (_display displayCtrl _x);
        _ctrl ctrlSetFade 0;
        _ctrl ctrlCommit 0;
        ctrlEnable [_x, true];
    } forEach _ctrlArray;
    _appsSlide = (_display displayCtrl 4040);
    _appsSlide ctrlSetPosition [(0 * 0.05), (0 * 0.05)];
    _appsSlide ctrlCommit 0.25;
    uiSleep 0.25;
    {
        ctrlDelete ((findDisplay 24015) displayCtrl _x);
    } forEach _ctrls;
};

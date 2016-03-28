/*

 	Name: ExileClient_banking_player_examineMoney.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles when a player tries to examine money on the group
*/
private["_playerName","_worth"];

_playerName = _this select 0;
_worth = _this select 1;
if (ADVBANKING_CLIENT_DEBUG) then {[format["Examining Money. Package: %1",_this],"ExamineMoney"] call ExileClient_banking_utils_diagLog;};
[_playerName,_worth] call ExileClient_banking_player_creditCardShow;

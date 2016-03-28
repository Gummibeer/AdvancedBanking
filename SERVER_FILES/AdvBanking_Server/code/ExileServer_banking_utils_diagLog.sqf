/*

 	Name: AdvBanking_Server_DiagLog.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles writing messages to the server logs

*/
private ["_msg"];
_msg = format["ADVANCED BANKING: [%1] : %2",(_this select 1),(_this select 0)];
diag_log _msg;

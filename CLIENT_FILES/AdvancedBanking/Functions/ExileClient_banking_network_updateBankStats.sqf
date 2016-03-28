/*

 	Name: ExileClient_banking_network_updateBankStats.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Updates the stats for the player

*/
private["_bankString","_bankAmount"];
_bankString = _this select 0;
_bankAmount = parseNumber(_bankString);

if (ADVBANKING_CLIENT_DEBUG) then {[format["Server sent an bank update request. Package: %1",_this],"UpdateBankStats"] call ExileClient_banking_utils_diagLog;};

waitUntil {player == player};
ExileClientBank = _bankAmount;
call ExileClient_banking_atm_updateATM;

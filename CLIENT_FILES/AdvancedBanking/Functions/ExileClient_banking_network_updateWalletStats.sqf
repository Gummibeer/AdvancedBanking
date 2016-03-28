/*

 	Name: ExileClient_banking_network_updateWalletStats.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Updates the stats for the player

*/
private["_bankString","_bankAmount"];
_walletString = _this select 0;
_walletAmount = parseNumber(_walletString);

if (ADVBANKING_CLIENT_DEBUG) then {[format["Server enacted update wallet stats. Package: %1",_this],"UpdateWalletStats"] call ExileClient_banking_utils_diagLog;};

ExileClientPlayerMoney = _walletAmount;

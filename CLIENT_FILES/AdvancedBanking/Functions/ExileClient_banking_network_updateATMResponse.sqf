/*

 	Name: ExileClient_banking_network_updateATMResponse.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Response from the server on a deposit

*/
private ["_walletString","_bankString","_wallet","_bank"];
_walletString = _this select 0;
_bankString = _this select 1;
_wallet = parseNumber(_walletString);
_bank = parseNumber(_bankString);

if (ADVBANKING_CLIENT_DEBUG) then {[format["Server sent a update ATM message: Package: %1",_this],"UpdateATMResponse"] call ExileClient_banking_utils_diagLog;};

ExileClientPlayerMoney = _wallet;
ExileClientBank = _bank;

call ExileClient_banking_atm_updateATM;

/*

 	Name: AdvBanking_Client_Init.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

*/

if (!hasInterface || isServer) exitWith {};

// START CONFIGURATION //

// Warning: Setting this to true will cause a lot of RPT messages.
// Only use this if you are having an issue.
ADVBANKING_CLIENT_DEBUG = false;

// END CONFIGURATION //

private ['_code'];
{
    _code = compileFinal (preprocessFileLineNumbers (_x select 1));
    missionNamespace setVariable [(_x select 0), _code];
}
forEach
[
    ['ExileClient_banking_atm_closeATM','AdvancedBanking\Functions\ExileClient_banking_atm_closeATM.sqf'],
    ['ExileClient_banking_atm_deposit','AdvancedBanking\Functions\ExileClient_banking_atm_deposit.sqf'],
    ['ExileClient_banking_atm_onATMLoad','AdvancedBanking\Functions\ExileClient_banking_atm_onATMLoad.sqf'],
    ['ExileClient_banking_atm_transferToPlayer','AdvancedBanking\Functions\ExileClient_banking_atm_transferToPlayer.sqf'],
    ['ExileClient_banking_atm_updateATM','AdvancedBanking\Functions\ExileClient_banking_atm_updateATM.sqf'],
    ['ExileClient_banking_atm_withdrawal','AdvancedBanking\Functions\ExileClient_banking_atm_withdrawal.sqf'],
	['ExileClient_banking_map_placeATM','AdvancedBanking\Functions\ExileClient_banking_map_placeATM.sqf'],
    ['ExileClient_banking_network_collectMoneyResponse','AdvancedBanking\Functions\ExileClient_banking_network_collectMoneyResponse.sqf'],
    ['ExileClient_banking_network_handleATMMessage','AdvancedBanking\Functions\ExileClient_banking_network_handleATMMessage.sqf'],
    ['ExileClient_banking_network_updateATMResponse','AdvancedBanking\Functions\ExileClient_banking_network_updateATMResponse.sqf'],
    ['ExileClient_banking_network_updateBankStats','AdvancedBanking\Functions\ExileClient_banking_network_updateBankStats.sqf'],
    ['ExileClient_banking_network_youWonTheLottery','AdvancedBanking\Functions\ExileClient_banking_network_youWonTheLottery.sqf'],
    ['ExileClient_banking_player_collectMoney','AdvancedBanking\Functions\ExileClient_banking_player_collectMoney.sqf'],
    ['ExileClient_banking_player_creditCardShow','AdvancedBanking\Functions\ExileClient_banking_player_creditCardShow.sqf'],
    ['ExileClient_banking_player_examineMoney','AdvancedBanking\Functions\ExileClient_banking_player_examineMoney.sqf'],
    ['ExileClient_banking_utils_diagLog','AdvancedBanking\Functions\ExileClient_banking_utils_diagLog.sqf']
];

call ExileClient_banking_map_placeATM;

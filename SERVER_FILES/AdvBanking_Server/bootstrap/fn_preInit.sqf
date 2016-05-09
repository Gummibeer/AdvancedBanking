/*

 	Name: fn_preInit.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

*/

// START CONFIGURATION //

// Warning: Setting this to true will cause a lot of RPT messages.
// Only use this if you are having an issue.
ADVBANKING_SERVER_DEBUG = false;

// DISABLE THIS OPTION ONLY IF YOUR SERVER IS NOT A FRESH SERVER!
// If disabled, this will check to see if the player has no money in their bank
// If so, move it to their bank. This is for servers that had a lot of players but never had Advanced Banking
ADVBANKING_SERVER_FRESH = true;

// ONLY ENABLE IF YOU WERE RUNNING ADVANCED BANKING 2.4 AND BELOW!!!!
// Checks to see if a player exists in the player_bank table
// If they are, it will move it across tables and then delete the entry
ADVBANKING_SERVER_PREVIOUS_VERSION = false;

// END CONFIGURATION //

private ['_code'];
{
    _code = compileFinal (preprocessFileLineNumbers (_x select 1));
    missionNamespace setVariable [(_x select 0), _code];
}
forEach
[
    ['ExileServer_banking_network_buyRequest','AdvBanking_Server\code\ExileServer_banking_network_buyRequest.sqf'],
    ['ExileServer_banking_network_collectionRequest','AdvBanking_Server\code\ExileServer_banking_network_collectionRequest.sqf'],
    ['ExileServer_banking_network_depositRequest','AdvBanking_Server\code\ExileServer_banking_network_depositRequest.sqf'],
    ['ExileServer_banking_network_saleRequest','AdvBanking_Server\code\ExileServer_banking_network_saleRequest.sqf'],
    ['ExileServer_banking_network_withdrawalRequest','AdvBanking_Server\code\ExileServer_banking_network_withdrawalRequest.sqf'],
    ['ExileServer_banking_utils_diagLog','AdvBanking_Server\code\ExileServer_banking_utils_diagLog.sqf']
];

["Advanced Banking preInit Loaded","PreInit"] call ExileServer_banking_utils_diagLog;

true

/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

// START CONFIGURATION //

// Warning: Setting this to true will cause a lot of RPT messages.
// Only use this if you are having an issue.
ADVBANKING_SERVER_DEBUG = false;

// END CONFIGURATION //

private ['_code', '_function', '_file'];

{
    _code = '';
    _function = _x select 0;
    _file = _x select 1;

    _code = compileFinal (preprocessFileLineNumbers _file);

    missionNamespace setVariable [_function, _code];
}
forEach
[
    ['ExileServer_banking_map_placeATM','AdvBanking_Server\code\ExileServer_banking_map_placeATM.sqf'],
    ['ExileServer_banking_network_buyRequest','AdvBanking_Server\code\ExileServer_banking_network_buyRequest.sqf'],
    ['ExileServer_banking_network_collectionRequest','AdvBanking_Server\code\ExileServer_banking_network_collectionRequest.sqf'],
    ['ExileServer_banking_network_depositRequest','AdvBanking_Server\code\ExileServer_banking_network_depositRequest.sqf'],
    ['ExileServer_banking_network_saleRequest','AdvBanking_Server\code\ExileServer_banking_network_saleRequest.sqf'],
    ['ExileServer_banking_network_withdrawalRequest','AdvBanking_Server\code\ExileServer_banking_network_withdrawalRequest.sqf'],
    ['ExileServer_banking_utils_diagLog','AdvBanking_Server\code\ExileServer_banking_utils_diagLog.sqf']
];

["Advanced Banking preInit Loaded","PreInit"] call ExileServer_banking_utils_diagLog;

true

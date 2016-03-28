/**
 * ExileServer_object_player_sendStatsUpdate
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

[
	_this,
	"updateStatsRequest",
	[
		str (_this getVariable ["ExilePurse", 0]),
		str (_this getVariable ["ExileScore", 0]),
		_this getVariable ["ExileKills", 0],
		_this getVariable ["ExileDeaths", 0]
	]
]
call ExileServer_system_network_send_to;
[
    _this,
    "updateBankStats",
    [
        str (_this getVariable ["ExileBank", 0])
    ]
]
call ExileServer_system_network_send_to;
if (ADVBANKING_SERVER_DEBUG) then {["SendStatsUpdate enacted with Advanced Banking","SendStatsUpdate"] call ExileServer_banking_utils_diagLog;};

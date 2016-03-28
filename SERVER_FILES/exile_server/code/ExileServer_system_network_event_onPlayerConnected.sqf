/**
 * ExileServer_system_network_event_onPlayerConnected
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

private["_isKnownAccount"];
_uid = _this select 0;
_name = _this select 1;
if !(_uid in ["", "__SERVER__", "__HEADLESS__"]) then
{
	format["Player %1 (UID %2) connected!", _name, _uid] call ExileServer_util_log;
	_isKnownAccount = format["isKnownAccount:%1", _uid] call ExileServer_system_database_query_selectSingleField;
	if (_isKnownAccount) then
	{
		format["startAccountSession:%1:%2", _uid, _name] call ExileServer_system_database_query_fireAndForget;
        // Advance Banking
        _hasBankAccount = format["hasBankAccount:%1", _uid] call ExileServer_system_database_query_selectSingleField;
        if (ADVBANKING_SERVER_DEBUG) then {[format["Does player have a bank? %1",_hasBankAccount],"OnPlayerConnected"] call ExileServer_banking_utils_diagLog;};
        if (!_hasBankAccount) then {
            format["createBankAccount:%1:%2",_uid,_name] call ExileServer_system_database_query_fireAndForget;
            _ExileMoney = format["getAccountMoney:%1",_uid] call ExileServer_system_database_query_selectSingleField;
            if (ADVBANKING_SERVER_DEBUG) then {[format["Okay, player doesn't have a bank account. Do they have previous money? Money:%1",_ExileMoney],"OnPlayerConnected"] call ExileServer_banking_utils_diagLog;};
            if (_ExileMoney > 0) then {
                if (ADVBANKING_SERVER_DEBUG) then {["They have money, creating acount and setting new money","onPlayerConnected"] call ExileServer_banking_utils_diagLog;};
                format["updateBank:%1:%2",_ExileMoney,_uid] call ExileServer_system_database_query_fireAndForget;
                format["setAccountMoney:%1:%2",0,_uid] call ExileServer_system_database_query_fireAndForget;
            };
		};
		// Advance Banking
	}
	else
	{
		format["createAccount:%1:%2", _uid, _name] call ExileServer_system_database_query_fireAndForget;
        // Advanced Banking
        if (ADVBANKING_SERVER_DEBUG) then {["",""] call ExileServer_banking_utils_diagLog;};
        format["createBankAccount:%1:%2",_uid,_name] call ExileServer_system_database_query_fireAndForget;
        // Advanced Banking
	};
};
true

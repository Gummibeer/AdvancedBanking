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
        // Advanced Banking
		if (ADVBANKING_SERVER_PREVIOUS_VERSION) then {
	        _hasBankAccount = format["ughhSorryGuys:%1", _uid] call ExileServer_system_database_query_selectSingleField;
	        if (ADVBANKING_SERVER_DEBUG) then {[format["Does player have a bank? %1",_hasBankAccount],"OnPlayerConnected"] call ExileServer_banking_utils_diagLog;};
	        if (_hasBankAccount) then {
	            _gimmeInfo = format["gimmeInfo:%1",_uid] call ExileServer_system_database_query_selectSingle;
				_money = _gimmeInfo select 0;
				_bank = _gimmeInfo select 1;
	            if (_money > 0) then {
	                format["setAccountMoney:%1:%2",_money,_uid] call ExileServer_system_database_query_fireAndForget;
					if (ADVBANKING_SERVER_DEBUG) then {[format["We see bank, we see money in wallet. Time to move it back. :) Amount: %1",_money],"OnPlayerConnected"] call ExileServer_banking_utils_diagLog;};
	            };
				if (_bank > 0) then {
					format["updateBank:%1:%2",_bank,_uid] call ExileServer_system_database_query_fireAndForget;
					if (ADVBANKING_SERVER_DEBUG) then {[format["We see bank, we see money in bank. Time to move it back. :) Amount: %1",_bank],"OnPlayerConnected"] call ExileServer_banking_utils_diagLog;};
				};
				// Delete the bank line because we don't need it anymore.
				format["deleteBank:%1",_uid] call ExileServer_system_database_query_fireAndForget;
			};
		};

		if !(ADVBANKING_SERVER_FRESH) then {
			// Keeps players who spawned in after advanced banking added having all their money on them
			_newPlayer = format["getStats:%1",_uid] call ExileServer_system_database_query_selectSingle;
			if (ADVBANKING_SERVER_DEBUG) then {[format["Does the player have an empty bank and money in their wallet? %1",_newPlayer],"OnPlayerConnected"] call ExileServer_banking_utils_diagLog;};
			if ((_newPlayer select 1) == 0) then {
				if (ADVBANKING_SERVER_DEBUG) then {[format["No money in bank, we see money in wallet. Time to move it. :) Amount: %1",_money],"OnPlayerConnected"] call ExileServer_banking_utils_diagLog;};
				format["setAccountMoney:%1:%2",0,_uid] call ExileServer_system_database_query_fireAndForget;
				format["updateBank:%1:%2",(_newPlayer select 0),_uid] call ExileServer_system_database_query_fireAndForget;
			};
		};
		// Advanced Banking
	}
	else
	{
		format["createAccount:%1:%2", _uid, _name] call ExileServer_system_database_query_fireAndForget;
	};
};
true

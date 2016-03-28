/**
 * ExileServer_system_territory_network_purchaseTerritory
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

private["_sessionID","_player","_price","_playerMoney"];
_sessionID = _this select 0;
try
{
	_player = _sessionID call ExileServer_system_session_getPlayerObject;
	if (isNull _player) then
	{
		throw 1;
	};
	if !(alive _player) then
	{
		throw 2;
	};
	_price = ((getArray(missionConfigFile >> "CfgTerritories" >> "prices")) select 0) select 0;
	_playerMoney = _player getVariable ["ExilePurse", 0];
	if (_price > _playerMoney) then
	{
		throw 3;
	};
	_playerMoney = _playerMoney - _price;
    // Advance Banking
      format["updateWallet:%1:%2", _playerMoney, (getPlayerUID _player)] call ExileServer_system_database_query_fireAndForget;
      _player setVariable ["ExilePurse",_playerMoney];
      if (ADVBANKING_SERVER_DEBUG) then {[format["%1 purchased territory",_player],"PurchaseTerritory"] call ExileServer_banking_utils_diagLog;};
      // Advance Banking
	[_sessionID, "purchaseTerritoryResponse" , [0]] call ExileServer_system_network_send_to;
}
catch
{
	[_sessionID, "purchaseTerritoryResponse" , [_exception]] call ExileServer_system_network_send_to;
};
true

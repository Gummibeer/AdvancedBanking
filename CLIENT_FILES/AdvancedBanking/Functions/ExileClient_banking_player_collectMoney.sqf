/*

 	Name: ExileClient_banking_player_collectMoney.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles when a player tries to collect money from the ground
*/
private ["_worth","_playerMoney","_newMoney","_exception"];

_object = _this select 0;
_worth = _this select 1;
_objectNetId = netId _object;

try {

    if (_worth <= 0) then {
        throw true;
    };
    player playMove "AinvPknlMstpSnonWnonDr_medic5";
    for "_i" from 0 to 12 do {
        if !(alive player) then
        {
            throw false;
        };
        uiSleep 1;
    };
    ["collectionRequest",[str(_worth),_objectNetId]] call ExileClient_system_network_send;
    if (ADVBANKING_CLIENT_DEBUG) then {[format["Collected some Money. Package: %1",_worth],"CollectMoney"] call ExileClient_banking_utils_diagLog;};

} catch {

    if (_exception) then {
        [format["Wallet from %1 was zero",_object],"CollectMoney"] call ExileClient_banking_utils_diagLog;
        ["Whoops",["There was nothing in the wallet"]] call ExileClient_gui_notification_event_addNotification;
    } else {
        player switchMove "";
        ["switchMoveRequest", [netId player, ""]] call ExileClient_system_network_send;
    };

};

### Modded Server Install Instructions
This set of instructions is made for the people who have made changes to their ExileServer\_\* or ExileClient\_\* files and want Advanced Banking on their server.

**THIS PART IS MORE ADVANCE. PLEASE READ CAREFULLY AND BACKUP YOUR FILES FIRST**

Advanced Banking is split up into three parts: SQL/extDB2, Server side, and Client side

#### SQL/extDB2
1. Open your favorite mySQL database editor
2. Copy and paste the contents of **AdvBanking.sql** into the query
3. Run the Query
4. Refresh your database and confirm you have a "bank" column in account table
5. You are done with the database changes.
6. Navigate to **@ExileServer/extDB/sql_custom_v2**
7. Open up the exile.ini in your favorite plain text editor
8. Copy and paste the contents of **AdvBanking_extDB2.ini** at the bottom of exile.ini
9. Save the file and this part is done!

#### Server Side
1. Copy the **AdvBanking_Server.pbo** into **@ExileServer/addons**
2. De-PBO your **exile_server.pbo**
3. We need to edit the following server files. Locate and edit each one.
4. **ExileServer_object_player_createBambi.sqf**
    1. Under `_clanName = (_accountData select 5);`
        Add

                // Advanced Banking
                private["_advBank","_playerUID"];
                _playerUID = getPlayerUID _requestingPlayer;
                _advBank = format["getStats:%1",_playerUID] call ExileServer_system_database_query_selectSingle;
                _bambiPlayer setVariable ["ExileBank",(_advBank select 1)];
                // Advanced Banking

    2. Above `[_sessionID, _bambiPlayer] call ExileServer_system_session_update;`

        add

                [
                    _sessionID,
                    "updateBankStats",
                    [
                        str (_advBank select 1)
                    ]
                ]
                call ExileServer_system_network_send_to;
                if (ADVBANKING_SERVER_DEBUG) then {["Processed Create Bambi with Advanced Banking","CreateBambi"] call ExileServer_banking_utils_diagLog;};

5. **ExileServer_object_player_database_load.sqf**
    1. Under `_player setName _name;`
        add

                // Advanced Banking
                private["_advBank"];
                _advBank = format["getStats:%1",_playerUID] call ExileServer_system_database_query_selectSingle;
                _player setVariable ["ExileBank",(_advBank select 1)];
                // Advanced Banking

    2. Above `[_sessionID, _player] call ExileServer_system_session_update;`
        add

                [
                    _sessionID,
                    "updateBankStats",
                    [
                        str (_player getVariable ["ExileBank", 0])
                    ]
                ]
                call ExileServer_system_network_send_to;
                if (ADVBANKING_SERVER_DEBUG) then {["Database processed with Advanced Banking","DatabaseLoad"] call ExileServer_banking_utils_diagLog;};

6. **ExileServer_object_player_sendStatsUpdate.sqf**
    1. At the bottom, add

            [
                _this,
                "updateBankStats",
                [
                    str (_this getVariable ["ExileBank", 0])
                ]
            ]
            call ExileServer_system_network_send_to;
            if (ADVBANKING_SERVER_DEBUG) then {["SendStatsUpdate enacted with Advanced Banking","SendStatsUpdate"] call ExileServer_banking_utils_diagLog;};

7. **ExileServer_system_network_event_onPlayerConnected.sqf**
    1. Under `format["startAccountSession:%1:%2", _uid, _name] call ExileServer_system_database_query_fireAndForget;`

        add

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

8. **ExileServer_system_trading_network_sendMoneyRequest.sqf**
    1. Replace

                _senderAccountBalance = _senderPlayerObject getVariable ["ExileMoney", 0];
                _receiverAccountBalance = _receiverPlayerObject getVariable ["ExileMoney", 0];
        with

                _senderAccountBalance = _senderPlayerObject getVariable ["ExileBank", 0];
                _receiverAccountBalance = _receiverPlayerObject getVariable ["ExileBank", 0];    
    2. Replace

                _senderPlayerObject setVariable ["ExileMoney", _senderAccountBalance];
                format["setAccountMoney:%1:%2", _senderAccountBalance, getPlayerUID _senderPlayerObject] call ExileServer_system_database_query_fireAndForget;
                [_sessionID, "moneySentRequest", [str _senderAccountBalance, name _receiverPlayerObject]] call ExileServer_system_network_send_to;

        with

                _senderPlayerObject setVariable ["ExileBank", _senderAccountBalance];
                format["updateBank:%1:%2", _senderAccountBalance, getPlayerUID _senderPlayerObject] call ExileServer_system_database_query_fireAndForget;
                [_sessionID, "updateBankStats", [str _senderAccountBalance]] call ExileServer_system_network_send_to;
                [_sessionID,"handleATMMessage", [3,"Success","We have successfully processed your transfer"]] call ExileServer_system_network_send_to;
    3. Replace

                _receiverPlayerObject setVariable ["ExileMoney", _receiverAccountBalance];
                format["setAccountMoney:%1:%2", _receiverAccountBalance, getPlayerUID _receiverPlayerObject] call ExileServer_system_database_query_fireAndForget;
                [_receiverPlayerObject, "moneyReceivedRequest", [str _receiverAccountBalance, name _senderPlayerObject]] call ExileServer_system_network_send_to;
        with

                _receiverPlayerObject setVariable ["ExileBank", _receiverAccountBalance];
                format["updateBank:%1:%2", _receiverAccountBalance, getPlayerUID _receiverPlayerObject] call ExileServer_system_database_query_fireAndForget;
                [_receiverPlayerObject, "youWonTheLottery", [str _receiverAccountBalance, name _senderPlayerObject]] call ExileServer_system_network_send_to;
                if (ADVBANKING_SERVER_DEBUG) then {[format["%1 sent %2 poptabs to %2",_playerObject,_amountToTransfer,_receiverPlayerObject],"SendMoneyRequest"] call ExileServer_banking_utils_diagLog;};    
    4. Replace `[_sessionID, "notificationRequest", ["Whoops", [_exception]]] call ExileServer_system_network_send_to;` with `[_sessionID,"handleATMMessage", [3,"Error",_exception]] call ExileServer_system_network_send_to;`
9. **ExileServer_object_player_event_onMpKilled.sqf**
    1. Under `_victim setVariable ["ExileName", name _victim, true];`
        add

                // Advanced Banking
                private["_wallet","_grave"];
                _wallet = _victim getVariable ["ExileMoney",0];
                if (_wallet > 0) then {
                    _grave = createVehicle["Land_Suitcase_F",[((_victimPosition select 0) + 0.7),(_victimPosition select 1),_victimPosition select 2],[],0,"CAN_COLLIDE"];
                    _grave setDir (getDir _victim);
                    _grave setVariable ["ExileName", name _victim, true];
                    _grave setVariable ["DroppedAmount",_wallet,true];
                    _victim setVariable ["ExileMoney",0];
                    format["setAccountMoney:%1:%2",0,(getPlayerUID _victim)] call ExileServer_system_database_query_fireAndForget;
                };
                // Advanced Banking
10. Copy over `ExileServer_system_network_dispatchIncomingMessage.sqf` from the download.
11. You are all done!

#### Client Side
1. De-PBO your mission folder (Exile.Altis)
2. Copy AdvancedBanking and clientOverrides folders, as well as, CfgNetworkMessages.hpp and CfgInteractionMenus.hpp from AdvBanking/client into your mission folder
3. In your init.sqf
    1. Add to the top

            //Advance Banking by Shix and WolfkillArcadia
            [] execVM "AdvancedBanking\AdvBanking_Client_Init.sqf";

4. In your description.ext
    1. Add to the top

            //Advance Banking by Shix and WolfkillArcadia
            #include "AdvancedBanking\Dialog\AdvBanking_Client_Defines.hpp"
            #include "AdvancedBanking\Dialog\AdvBanking_Client_ATMDialog.hpp"

    2. Add at the bottom if you **don't** have RscTitles

            class RscTitles
            {
                //Advance Banking
                #include "AdvancedBanking\Dialog\AdvBanking_Client_CreditCard.hpp"
            };
    3. If you **do** have an RscTitles
        1. Add then inside the {}

                //Advance Banking
                #include "AdvancedBanking\Dialog\AdvBanking_Client_CreditCard.hpp"

5. Open up config.cpp
    1. Locate `class CfgInteractionMenus`
    3. Right under the words, `class CfgInteractionMenus {`, add `#include "CfgInteractionMenus.hpp"`
    3. Locate `class CfgExileCustomCode`
    4. Add the following inside the {} for `class CfgExileCustomCode`

             ExileClient_gui_xm8_slide_apps_onOpen = "ClientOverrides\ExileClient_gui_xm8_slide_apps_onOpen.sqf";
             ExileClient_gui_xm8_slide_players_onOpen = "ClientOverrides\ExileClient_gui_xm8_slide_players_onOpen.sqf";

    So it looks like this:

            class CfgExileCustomCode {
                ExileClient_gui_xm8_slide_apps_onOpen = "ClientOverrides\ExileClient_gui_xm8_slide_apps_onOpen.sqf";
                ExileClient_gui_xm8_slide_players_onOpen = "ClientOverrides\ExileClient_gui_xm8_slide_players_onOpen.sqf";
            };
    5. If you have a `class CfgNetworkMessages {}` already, add `#include "CfgNetworkMessages.hpp"` inside it.
        1. If you don't have `class CfgNetworkMessages {}`: At the end of the file, add

                class CfgNetworkMessages
                {
                    #include "CfgNetworkMessages.hpp"
                };

6. Locate and edit the following files.
    1. **ExileClient_gui_xm8_slide_apps_onOpen.sqf**
        1. Replace `private["_display","_health","_popTabsValue","_popTabs","_respectValue","_respect", "_serverInfo","_hideCtrls","_hide","_walletValue","_bankValue","_background","_wallet"];`
        2. At the bottom, add

                //hide the poptabs
                _hideCtrls = [4058];
                {
                _hide = (_display displayCtrl _X);
                _hide ctrlSetFade 1;
                _hide ctrlCommit 0;
                ctrlEnable [_x, false];
                } forEach _hideCtrls;


                //create a wallet / bank stat
                _walletValue = ExileClientPlayerMoney;
                _bankValue = ExileClientBank;
                if (_walletValue > 999) then
                {
                _walletValue = format ["%1k", floor (_walletValue / 1000)];
                };
                if (_bankValue > 999) then
                {
                _bankValue = format ["%1k", floor (_bankValue / 1000)];
                };
                _background = _display ctrlCreate ["RscStructuredText", 0714, _display displayCtrl 4040];
                _background ctrlSetPosition [(4 - 3) * (0.025), 0.3 ,6*(0.025), 5*(0.04)];
                _background ctrlCommit 0;
                _background ctrlSetBackgroundColor [255, 255, 255, 0.050000];

                _wallet = _display ctrlCreate ["RscStructuredText", 0713, _display displayCtrl 4040];
                _wallet ctrlSetPosition [(4 - 3) * (0.025), 0.315 ,6*(0.025), 5*(0.04)];
                _wallet ctrlCommit 0;
                _wallet ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='0.7' valign='middle' align='center' shadow='0'><t font='OrbitronMedium' size='1.4' color='#ffffff'>%1</t><br/>WALLET<br /><t font='OrbitronMedium' size='1.4' color='#ffffff'>%2</t><br/>BANK</t>", _walletValue,_bankValue]);
                _wallet ctrlSetTooltip Format ["Wallet: %1 / Bank: %2",ExileClientPlayerMoney,ExileClientBank];

    2. **ExileClient_gui_xm8_slide_players_onOpen.sqf**
        1. Under `_sendPopTabsButton = _display displayCtrl 4117;` add

                _sendPopTabsButton ctrlSetFade 1;
                _sendPopTabsButton ctrlCommit 0;
        2. Under `_popTabsInputBox ctrlSetText "0";` add `ctrlEnable [4116,false];`
7. WooHoo, you are done!

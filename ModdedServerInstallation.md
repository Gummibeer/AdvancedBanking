### Modded Server Install Instructions
This set of instructions is made for the people who have made changes to their ExileServer\_\* or ExileClient\_\* files and want Advanced Banking on their server.<br/>**THIS PART IS MORE ADVANCE. PLEASE READ CAREFULLY AND BACKUP YOUR FILES FIRST**<br/>
Advanced Banking is split up into three parts: SQL/extDB2, Server side, and Client side

#### SQL/extDB2
1. Open your favorite mySQL database editor
2. Copy and paste the contents of **AdvBanking.sql** into the query
3. Run the Query
4. Refresh your database and confirm two new tables
    * player_bank
    * player_bank_shared
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
    1. After `_clanName = (_accountData select 5);`
        1. Add

                    // Advanced Banking
                    private["_advBank","_playerUID"];
                    _playerUID = getPlayerUID _requestingPlayer;
                    _advBank = format["getStats:%1",_playerUID] call ExileServer_system_database_query_selectSingle;
                    _bambiPlayer setVariable ["ExilePurse", (_advBank select 1)]; //Grim this is for you. ;)
                    _bambiPlayer setVariable ["ExileBank",(_advBank select 2)];
                    // Advanced Banking

        2. Delete `_bambiPlayer setVariable ["ExileMoney", (_accountData select 0)];`
        3. Replace `str (_accountData select 0),` with `str (_advBank select 1),`
        4. Right above `[_sessionID, _bambiPlayer] call ExileServer_system_session_update;`, add

                [
                    _sessionID,
                    "updateBankStats",
                    [
                        str (_advBank select 2)
                    ]
                ]
                call ExileServer_system_network_send_to;
                if (ADVBANKING_SERVER_DEBUG) then {["Processed Create Bambi with Advanced Banking","CreateBambi"] call ExileServer_banking_utils_diagLog;};
5. **ExileServer_object_player_database_load.sqf**
    1. Replace `_player setVariable ["ExileMoney", (_data select 38)];` with

            // Advanced Banking
            private["_advBank"];
            _advBank = format["getStats:%1",_playerUID] call ExileServer_system_database_query_selectSingle;
            _player setVariable ["ExilePurse", (_advBank select 1)];
            _player setVariable ["ExileBank",(_advBank select 2)];
            // Advanced Banking
    2. Replace `str (_player getVariable ["ExileMoney", 0]),` with `str (_player getVariable ["ExilePurse", 0]),`
    3. Above `[_sessionID, _player] call ExileServer_system_session_update;` add

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
    1. Change `str (_this getVariable ["ExileMoney", 0]),` to `str (_this getVariable ["ExilePurse", 0]),`
    2. At the bottom, add

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
    1. Under `format["startAccountSession:%1:%2", _uid, _name] call ExileServer_system_database_query_fireAndForget;` add

            // Advance Banking
            private ["_hasBankAccount","_ExileMoney"];
            _hasBankAccount = format["hasBankAccount:%1", _uid] call ExileServer_system_database_query_selectSingleField;
            if (ADVBANKING_SERVER_DEBUG) then {[format["Does player have a bank? %1",_hasBankAccount],"OnPlayerConnected"] call ExileServer_banking_utils_diagLog;};
            if (!_hasBankAccount) then {
                format["createBankAccount:%1:%2",_uid,_name] call ExileServer_system_database_query_fireAndForget;
                _ExileMoney = format["getAccountMoney:%1",_uid] call ExileServer_system_database_query_selectSingleField;
                if (ADVBANKING_SERVER_DEBUG) then {[format["Okay, player doesn't have a bank account. Do they have previous money? Money:%1",_ExileMoney],"OnPlayerConnected"] call ExileServer_banking_utils_diagLog;};
                if (_ExileMoney > 0) then {
                    if (ADVBANKING_SERVER_DEBUG) then {[format["They have money, creating account and setting new money. Money: %1",_ExileMoney],"onPlayerConnected"] call ExileServer_banking_utils_diagLog;};
                    format["updateBank:%1:%2",_ExileMoney,_uid] call ExileServer_system_database_query_fireAndForget;
                    format["setAccountMoney:%1:%2",0,_uid] call ExileServer_system_database_query_fireAndForget;
                };
            };
            // Advance Banking
    2. Under `format["createAccount:%1:%2", _uid, _name] call ExileServer_system_database_query_fireAndForget;` add

            // Advanced Banking
            if (ADVBANKING_SERVER_DEBUG) then {["",""] call ExileServer_banking_utils_diagLog;};
            format["createBankAccount:%1:%2",_uid,_name] call ExileServer_system_database_query_fireAndForget;
            // Advanced Banking

8. **ExileServer_system_territory_network_payTerritoryProtectionMoneyRequest.sqf**
    1. Replace `_playerPopTabs = _playerObject getVariable ["ExileMoney", 0];` with `_playerPopTabs = _playerObject getVariable ["ExilePurse", 0];`
    2. Replace

                _playerObject setVariable ["ExileMoney", _playerPopTabs];
                format["setAccountMoney:%1:%2", _playerPopTabs, getPlayerUID _playerObject] call ExileServer_system_database_query_fireAndForget;
        with

                // Advanced Banking
                _playerObject setVariable ["ExilePurse", _playerPopTabs];
                format["updateWallet:%1:%2", _playerPopTabs, getPlayerUID _playerObject] call ExileServer_system_database_query_fireAndForget;
                // Advanced Banking
    3. Below `format["maintainTerritory:%1", _territoryDatabaseID] call ExileServer_system_database_query_fireAndForget;` add `if (ADVBANKING_SERVER_DEBUG) then {["Pay Territory Protection Enacted","PayTerritoryProtection"] call ExileServer_banking_utils_diagLog;};`
9. **ExileServer_system_territory_network_purchaseTerritory.sqf**
    1. Replace `_playerMoney = _player getVariable ["ExileMoney", 0];` with `_playerMoney = _player getVariable ["ExilePurse", 0];`
    2. Replace

                format["setAccountMoney:%1:%2", _playerMoney, (getPlayerUID _player)] call ExileServer_system_database_query_fireAndForget;
                _player setVariable ["ExileMoney",_playerMoney];
        with

                // Advance Banking
                format["updateWallet:%1:%2", _playerMoney, (getPlayerUID _player)] call ExileServer_system_database_query_fireAndForget;
                _player setVariable ["ExilePurse",_playerMoney];
                if (ADVBANKING_SERVER_DEBUG) then {[format["%1 purchased territory",_player],"PurchaseTerritory"] call ExileServer_banking_utils_diagLog;};
                // Advance Banking
10. **ExileServer_system_trading_network_purchaseItemRequest.sqf**
    1. Replace `_playerMoney = _playerObject getVariable ["ExileMoney", 0];` with `_playerMoney = _playerObject getVariable ["ExilePurse", 0];`
    2. Replace

                _playerObject setVariable ["ExileMoney", _playerMoney];
                format["setAccountMoney:%1:%2", _playerMoney, (getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
        with

                // Advanced Banking
                _playerObject setVariable ["ExilePurse", _playerMoney];
                format["updateWallet:%1:%2", _playerMoney, (getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
                if (ADVBANKING_SERVER_DEBUG) then {[format["%1 purchased an Item",_playerObject],"PurchaseItemRequest"] call ExileServer_banking_utils_diagLog;};
                // Advanced Banking
11. **ExileServer_system_trading_network_purchaseVehicleRequest.sqf**
    1. Replace `_playerMoney = _playerObject getVariable ["ExileMoney", 0];` with `_playerMoney = _playerObject getVariable ["ExilePurse", 0];`
    2. Replace

                _playerObject setVariable ["ExileMoney", _playerMoney];
                format["setAccountMoney:%1:%2", _playerMoney, (getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
        with

                // Advance Banking
                _playerObject setVariable ["ExilePurse", _playerMoney];
                format["updateWallet:%1:%2", _playerMoney, (getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
                if (ADVBANKING_SERVER_DEBUG) then {[format["%1 purchased a vehicle",_playerObject],"VehicleRequest"] call ExileServer_banking_utils_diagLog;};
                // Advance Banking
12. **ExileServer_system_trading_network_purchaseVehicleSkinRequest.sqf**
    1. Replace `_playerMoney = _playerObject getVariable ["ExileMoney", 0];` wtih `_playerMoney = _playerObject getVariable ["ExilePurse", 0];`
    2. Replace

                _playerObject setVariable ["ExileMoney", _playerMoney];
                format["setAccountMoney:%1:%2", _playerMoney, (getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
        with

                // Advanced Banking
                _playerObject setVariable ["ExilePurse", _playerMoney];
                format["updateWallet:%1:%2", _playerMoney, (getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
                if (ADVBANKING_SERVER_DEBUG) then {[format["%1 purchased a vehicle skin",_playerObject],"VehicleSkinRequest"] call ExileServer_banking_utils_diagLog;};
                // Advanced Banking
13. **ExileServer_system_trading_network_sellItemRequest.sqf**
    1. Replace `_playerMoney = _playerObject getVariable ["ExileMoney", 0];` with `_playerMoney = _playerObject getVariable ["ExilePurse", 0];`
    2. Replace `_playerObject setVariable ["ExileMoney", _playerMoney];` with `_playerObject setVariable ["ExilePurse", _playerMoney];`
    3. Replace `format["setAccountMoneyAndRespect:%1:%2:%3", _playerMoney, _playerRespect, (getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;` with

            format["updateWallet:%1:%2", _playerMoney, (getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
            format["setAccountScore:%1:%2",_playerRespect,(getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
            if (ADVBANKING_SERVER_DEBUG) then {[format["%1 sold a item",_playerObject],"sellItemRequest"] call ExileServer_banking_utils_diagLog;};
14. **ExileServer_system_trading_network_sendMoneyRequest.sqf**
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
                [_sessionID,"handleATMMessage", ["Success","We have successfully processed your transfer"]] call ExileServer_system_network_send_to;
    3. Replace

                _receiverPlayerObject setVariable ["ExileMoney", _receiverAccountBalance];
                format["setAccountMoney:%1:%2", _receiverAccountBalance, getPlayerUID _receiverPlayerObject] call ExileServer_system_database_query_fireAndForget;
                [_receiverPlayerObject, "moneyReceivedRequest", [str _receiverAccountBalance, name _senderPlayerObject]] call ExileServer_system_network_send_to;
        with

                _receiverPlayerObject setVariable ["ExileBank", _receiverAccountBalance];
                format["updateBank:%1:%2", _receiverAccountBalance, getPlayerUID _receiverPlayerObject] call ExileServer_system_database_query_fireAndForget;
                [_receiverPlayerObject, "youWonTheLottery", [str _receiverAccountBalance, name _senderPlayerObject]] call ExileServer_system_network_send_to;
                if (ADVBANKING_SERVER_DEBUG) then {[format["%1 sent %2 poptabs to %2",_playerObject,_amountToTransfer,_receiverPlayerObject],"SendMoneyRequest"] call ExileServer_banking_utils_diagLog;};    
    4. Replace `[_sessionID, "notificationRequest", ["Whoops", [_exception]]] call ExileServer_system_network_send_to;` with `[_sessionID,"handleATMMessage", [0,_exception]] call ExileServer_system_network_send_to;`
15. **ExileServer_system_trading_network_wasteDumpRequest.sqf**
    1. Replace `_playerMoney = _playerObject getVariable ["ExileMoney", 0];` with `_playerMoney = _playerObject getVariable ["ExilePurse", 0];`
    2. Replace `_playerObject setVariable ["ExileMoney", _playerMoney];` with `_playerObject setVariable ["ExilePurse", _playerMoney];`
    3. Replace `format["setAccountMoneyAndRespect:%1:%2:%3", _playerMoney, _playerRespect, (getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;` with

            format["setAccountScore:%1:%2",_playerRespect,(getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
            format["updateWallet:%1:%2",_playerMoney,(getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
    4. Underneath `[_sessionID, "wasteDumpResponse", [0, str _playerMoney, str _playerRespect]] call ExileServer_system_network_send_to;` add `if (ADVBANKING_SERVER_DEBUG) then {[format["%1 processed Waste Dump",_playerObject],"WasteDumpRequest"] call ExileServer_banking_utils_diagLog;};`
16. Copy over **ExileServer_system_network_dispatchIncomingMessage.sqf** from the github into your exile_server/code folder. (I don't have instructions yet for this.)
17. **ExileServer_object_player_event_onMpKilled.sqf**
    1. After `_victim setVariable ["ExileName", name _victim, true];` add

            // Advanced Banking
            private["_wallet"];
            _wallet = _victim getVariable ["ExilePurse",0];
            if (_wallet > 0) then {
                _victim setVariable ["DroppedAmount",_wallet,true];
                _victim setVariable ["ExilePurse",0];
                format["updateWallet:%1:%2",0,(getPlayerUID _victim)] call ExileServer_system_database_query_fireAndForget;
            };
            // Advanced Banking
18. You are all done!

#### Client Side
1. De-PBO your mission folder (Exile.Altis)
2. Copy AdvancedBanking and clientOverrides folders, as well as, CfgNetworkMessages.hpp from AdvBanking/client into your mission folder
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
    2. Delete the following

            class Player
            {
                targetType = 2;
                target = "Exile_Unit_Player";

                class Actions
                {
                    class Free: ExileAbstractAction
                    {
                        title = "Free";
                        condition = "(alive ExileClientInteractionObject) && (ExileClientInteractionObject getVariable ['ExileIsHandcuffed', false]) && !ExileClientIsHandcuffed";
                        action = "_this call ExileClient_object_handcuffs_free";
                    };

                    class Search: ExileAbstractAction
                    {
                        title = "Search Gear";
                        condition = "(alive ExileClientInteractionObject) && (ExileClientInteractionObject getVariable ['ExileIsHandcuffed', false]) && !ExileClientIsHandcuffed";
                        action = "_this call ExileClient_object_handcuffs_searchGear";
                    };

                    class Identify: ExileAbstractAction
                    {
                        title = "Identify Body";
                        condition = "!(alive ExileClientInteractionObject)";
                        action = "_this call ExileClient_object_player_identifyBody";
                    };
                };
            };

    3. Add the following within the {} for `class CfgInteractionMenus`

            // Advance Money
            class Player
            {
                targetType = 2;
                target = "Exile_Unit_Player";

                class Actions
                {
                    class Free: ExileAbstractAction
                    {
                        title = "Free";
                        condition = "(alive ExileClientInteractionObject) && (ExileClientInteractionObject getVariable ['ExileIsHandcuffed', false]) && !ExileClientIsHandcuffed";
                        action = "_this call ExileClient_object_handcuffs_free";
                    };

                    class Search: ExileAbstractAction
                    {
                        title = "Search Gear";
                        condition = "(alive ExileClientInteractionObject) && (ExileClientInteractionObject getVariable ['ExileIsHandcuffed', false]) && !ExileClientIsHandcuffed";
                        action = "_this call ExileClient_object_handcuffs_searchGear";
                    };
                    class Examine: ExileAbstractAction
                    {
                        title = "Examine Body";
                        condition = "!(alive ExileClientInteractionObject) && ((ExileClientInteractionObject getVariable ['ExileName','']) != '')";
                        action = "[(ExileClientInteractionObject getVariable ['ExileName','']),(ExileClientInteractionObject getVariable ['DroppedAmount',0])] call ExileClient_banking_player_examineMoney";
                    };
                    class Collect: ExileAbstractAction
                    {
                        title = "Collect Dropped Wallet";
                        condition = "!(alive ExileClientInteractionObject) && ((ExileClientInteractionObject getVariable ['DroppedAmount',0]) > 0)";
                        action = "[ExileClientInteractionObject,(ExileClientInteractionObject getVariable ['DroppedAmount',0])] call ExileClient_banking_player_collectMoney";
                    };
                };
            };
            class ATM
            {
                targetType = 2;
                target = "Land_Atm_01_F";

                class Actions
                {
                    class Access: ExileAbstractAction
                    {
                        title = "Access ATM";
                        condition = "true";
                        action = "createDialog 'AdvBankingATM';";
                    };
                };
            };
            // Advance Money

     3. Locate `class CfgExileCustomCode`
     4. Add the following inside the {} for `class CfgExileCustomCode`

                 ExileClient_gui_xm8_slide_apps_onOpen = "ClientOverrides\ExileClient_gui_xm8_slide_apps_onOpen.sqf";
                 ExileClient_gui_xm8_slide_players_onOpen = "ClientOverrides\ExileClient_gui_xm8_slide_players_onOpen.sqf";

        So it looks like this:

                class CfgExileCustomCode {
                    ExileClient_gui_xm8_slide_apps_onOpen = "ClientOverrides\ExileClient_gui_xm8_slide_apps_onOpen.sqf";
                    ExileClient_gui_xm8_slide_players_onOpen = "ClientOverrides\ExileClient_gui_xm8_slide_players_onOpen.sqf";
                };

    5. At the top, right above `class CfgClans`
        1. Add `#include "CfgNetworkMessages.hpp"`

6. Locate and edit the following files.
    1. **ExileClient_gui_xm8_slide_apps_onOpen.sqf**
        1. Replace `private["_display","_health","_popTabsValue","_popTabs","_respectValue","_respect"];` with `private["_display","_health","_popTabsValue","_popTabs","_respectValue","_respect", "_serverInfo", "_newControl","_8gNetworkPic","_8gNetworkBtn","_walletValue","_wallet","_bankValue","_sharedBankingBtn","_sharedBankingPic"];`
        2. At the bottom, add

                //hide the poptabs and 8g network
                _hideCtrls = [4058,1111];
                {
                _hide = (_display displayCtrl _X);
                _hide ctrlSetFade 1;
                _hide ctrlCommit 0;
                ctrlEnable [_x, false];
                } forEach _hideCtrls;

                //create the picture for the 8G network
                _8gNetworkPic = _display ctrlCreate ["RscPictureKeepAspect", 0711, _display displayCtrl 4040];
                _8gNetworkPic ctrlSetPosition [(14.25 - 3) * (0.025), (4.25 - 2) * (0.04),(0.12),(0.12)];
                _8gNetworkPic ctrlCommit 0.01;
                _8gNetworkPic ctrlSetEventHandler ["ButtonClick", "execVM'xm8Apps\XM8Apps_Init.sqf';"];
                _8gNetworkPic ctrlSetText "\exile_assets\texture\ui\xm8_app_network_ca.paa";

                //create a new 8G network button
                _8gNetworkBtn = _display ctrlCreate ["RscExileXM8AppButton1x1", 0712, _display displayCtrl 4040];
                _8gNetworkBtn ctrlSetPosition [(10.5 - 3) * (0.025), (4 - 2) * (0.04),(0.315),(0.2)];
                _8gNetworkBtn ctrlCommit 0.01;
                _8gNetworkBtn ctrlSetEventHandler ["ButtonClick", "['players', 0] call ExileClient_gui_xm8_slide;"];
                _8gNetworkBtn ctrlSetStructuredText (parseText (format ["8G Network"]));

                //create a wallet stat
                _walletValue = ExileClientPlayerMoney;
                if (_walletValue > 999) then
                {
                _walletValue = format ["%1k", floor (_walletValue / 1000)];
                };
                _wallet = _display ctrlCreate ["RscStructuredText", 0713, _display displayCtrl 4040];
                _wallet ctrlSetPosition [(4 - 3) * (0.025),(9.5 - 2) * (0.04),0.15, 0.2];
                _wallet ctrlCommit 0;
                _wallet ctrlSetBackgroundColor [255, 255, 255, 0.050000];
                _wallet ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='0.7' valign='middle' align='center' shadow='0'><br/><t font='OrbitronMedium' size='1.7' color='#ffffff'>%1</t><br/>WALLET</t>", _walletValue]);
                _wallet ctrlSetTooltip Format ["%1",ExileClientPlayerMoney];

                //create a bank stat
                _bankValue = ExileClientBank;
                if (_bankValue > 999) then
                {
                _bankValue = format ["%1k", floor (_bankValue / 1000)];
                };
                _bank = _display ctrlCreate ["RscStructuredText", 0714, _display displayCtrl 4040];
                _bank ctrlSetPosition [(10.5 - 3) * (0.025),(9.5 - 2) * (0.04),0.15, 0.2];
                _bank ctrlCommit 0;
                _bank ctrlSetBackgroundColor [255, 255, 255, 0.050000];
                _bank ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='0.7' valign='middle' align='center' shadow='0'><br/><t font='OrbitronMedium' size='1.7' color='#ffffff'>%1</t><br/>BANK</t>", _bankValue]);
                _bank ctrlSetTooltip Format ["%1",ExileClientBank];

                //create a shared banking button
                _sharedBankingBtn = _display ctrlCreate ["RscExileXM8AppButton1x1", 0712, _display displayCtrl 4040];
                _sharedBankingBtn ctrlSetPosition [(17 - 3) * (0.025),(9.5 - 2) * (0.04),0.15, 0.2];
                _sharedBankingBtn ctrlCommit 0.01;
                _sharedBankingBtn ctrlSetEventHandler ["ButtonClick", "['Not yet implemented. Will come in a later version.', 'Okay :('] call ExileClient_gui_xm8_showWarning;"];
                _sharedBankingBtn ctrlSetStructuredText (parseText (format ["Shared Banking"]));

                //create a shared banking picture
                _sharedBankingPic = _display ctrlCreate ["RscPictureKeepAspect", 0711, _display displayCtrl 4040];
                _sharedBankingPic ctrlSetPosition  [(17.5 - 3) * (0.025),(10 - 2) * (0.04),(0.12),(0.12)];
                _sharedBankingPic ctrlCommit 0.01;
                _sharedBankingPic ctrlSetEventHandler ["ButtonClick", "execVM'xm8Apps\XM8Apps_Init.sqf';"];
                _sharedBankingPic ctrlSetText "AdvancedBanking\images\BankLogo.paa";
    2. **ExileClient_gui_xm8_slide_players_onOpen.sqf**
        1. Under `_sendPopTabsButton = _display displayCtrl 4117;` add

                _sendPopTabsButton ctrlSetFade 1;
                _sendPopTabsButton ctrlCommit 0;
        2. Under `_popTabsInputBox ctrlSetText "0";` add `ctrlEnable [4116,false];`
7. WooHoo, you are done!

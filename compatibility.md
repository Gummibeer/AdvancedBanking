# Compatibility with other scripts!
#### Please read:
Hello everyone, below is a compiled list of instructions to make Advanced Banking compatible with other popular scripts. You will be required to edit the files and make the following changes to allow these scripts to work. Please understand that we cannot support other scripts and their functionality. With that being said, if we break a script with our changes, please let us know. Not every script out there will be able to be made compatible, but if we are missing one, please message me and I can look into adding it.

---


## Defent's Mission System (DMS)
**Exile Forum Post:** [HERE](http://www.exilemod.com/topic/61-dms-defents-mission-system/)<br>
**Difficulty:** *Easy* <br>
**Instructions**<br>

1. De-PBO a3_dms.pbo
2. Navigate to the `scripts` folder and open `fn_PlayerAwardOnAIKill.sqf`
    1. Change `_playerMoney = _playerObj getVariable ["ExileMoney", 0];` to `_playerMoney = _playerObj getVariable ["ExilePurse", 0];`
    2. Change `_playerObj setVariable ["ExileMoney",_playerMoney];` to `_playerObj setVariable ["ExilePurse",_playerMoney];`
    3. Replace

            format["setAccountMoneyAndRespect:%1:%2:%3", _playerMoney, _playerRespect, _playerUID] call ExileServer_system_database_query_fireAndForget;

        with

            format["updateWallet:%1:%2", _playerMoney, _playerUID] call ExileServer_system_database_query_fireAndForget;
            format["setAccountScore:%1:%2",_playerRespect,_playerUID] call ExileServer_system_database_query_fireAndForget;
3. Re-PBO a3_dms and replace on your server

---

## ExileZ 2.0
**Exile Forum Post:** [HERE](http://www.exilemod.com/topic/9353-exilez-2/)<br>
**Difficulty:** Easy<br>
**Instructions**<br>

1. De-PBO exilez
2. Navigate to `init\code` and open `MPKilled.sqf`
    1. Change `_money = _playerObj getVariable ["ExileMoney", 0];` to `_money = _playerObj getVariable ["ExilePurse", 0];`
    2. Change `_playerObj setVariable ["ExileMoney", _money];` to `_playerObj setVariable ["ExilePurse", _money];`
    3. Replace

            format["setAccountMoneyAndRespect:%1:%2:%3", _money, _respect, (getPlayerUID _playerObj)] call ExileServer_system_database_query_fireAndForget;

        with

                format["updateWallet:%1:%2", _money, (getPlayerUID _playerObj)] call ExileServer_system_database_query_fireAndForget;
                format["setAccountScore:%1:%2",_respect,(getPlayerUID _playerObj)] call ExileServer_system_database_query_fireAndForget;
3. Re-PBO exilez and replace on your server

---

## XM8 Apps
**Exile Forum Post:** [HERE](http://www.exilemod.com/topic/9040-xm8-apps/)<br>
**Difficulty:** Easy <br>
**Instructions**<br>

1. Navigate to your `xm8Apps` directory and open `ExileClient_gui_xm8_slide_apps_onOpen.sqf`

    1. Replace

                private["_display","_health","_popTabsValue","_popTabs","_respectValue","_respect", "_serverInfo", "_newControl"];
        with

                private["_display","_health","_popTabsValue","_popTabs","_respectValue","_respect", "_serverInfo", "_newControl","_8gNetworkPic","_8gNetworkBtn","_walletValue","_wallet","_bankValue","_sharedBankingBtn","_sharedBankingPic"];

    2. After

                _respect ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='1.6' valign='middle' align='center' shadow='0'><br/><br/><br/><t font='OrbitronMedium' size='3.5'
        Add

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
2. Save and you are done!

---

## Enigma Exile Revive
**Exile Forum Post:** [HERE](http://www.exilemod.com/topic/10223-enigma-exile-revive-v076-updated-2216/)<br>
**Difficulty:** Medium<br>
**Instructions**<br>

1. De-PBO enigma_exile_custom
2. Navigate to compile/Enigma and open up Exile_RevivePlayer.sqf
    1. After

                _accountData = format["getAccountStats:%1", _requestingPlayerUID] call ExileServer_system_database_query_selectSingle;

        add

                private["_advBank"];
                _advBank = format["getStats:%1",_requestingPlayerUID] call ExileServer_system_database_query_selectSingle;
    2. Replace `_bambiPlayer setVariable ["ExileMoney", (_accountData select 0)];` with `_bambiPlayer setVariable ["ExilePurse", (_advBank select 1)];` on line 190 **AND** 196
    3. Replace `str (_player getVariable ["ExileMoney", 0]),` with `str (_player getVariable ["ExilePurse", 0]),` on line 305 **AND** 333
    4. After

                [
                    _sessionID,
                    "loadPlayerResponse",
                    [
                        (netId _player),
                        str (_player getVariable ["ExileMoney", 0]),
                        str (_player getVariable ["ExileScore", 0]),
                        str (_player getVariable ["ExileHumanity", 0]),
                        (_player getVariable ["ExileKills", 0]),
                        (_player getVariable ["ExileDeaths", 0]),
                        (_player getVariable ["ExileHunger", 100]),
                        (_player getVariable ["ExileThirst", 100]),
                        (_player getVariable ["ExileAlcohol", 0]),
                        (_player getVariable ["ExileClanName", ""])
                    ]
                ]
                call ExileServer_system_network_send_to;
        add

                [
                    _sessionID,
                    "updateBankStats",
                    [
                        str (_advBank select 2)
                    ]
                ]
                call ExileServer_system_network_send_to;
    5. After

                [
                    _sessionID,
                    "loadPlayerResponse",
                    [
                        (netId _player),
                        str (_player getVariable ["ExileMoney", 0]),
                        str (_player getVariable ["ExileScore", 0]),
                        (_player getVariable ["ExileKills", 0]),
                        (_player getVariable ["ExileDeaths", 0]),
                        (_player getVariable ["ExileHunger", 100]),
                        (_player getVariable ["ExileThirst", 100]),
                        (_player getVariable ["ExileAlcohol", 0]),
                        (_player getVariable ["ExileClanName", ""])
                    ]
                ]
                call ExileServer_system_network_send_to;
        add

                [
                    _sessionID,
                    "updateBankStats",
                    [
                        str (_advBank select 2)
                    ]
                ]
                call ExileServer_system_network_send_to;
3. Re-PBO enigma_exile_custom and replace it on your server.

===

## eBase [XM8-APP]
**Exile Forum Post:** [HERE](http://www.exilemod.com/topic/11129-xm8app-ebase/)<br>
**Difficulty:** Easy<br>
**Instructions**<br>

1. Open eBase.sqf
2. Replace

            _newPoptabs = ExileClientPlayerMoney - box1Cost;
            ENIGMA_UpdateStats = [player,_newPoptabs];
            publicVariableServer "ENIGMA_UpdateStats";
    with

            ["buyRequest",[str(box1Cost)]] call ExileClient_system_network_send;
3. After this point, it's just repeating the same above for each box. All I'm doing is replacing the first chunk with my code and renaming the `box#Cost` to match the current box. If this confuses you, just follow the rest of the steps.
4. Replace

            _newPoptabs = ExileClientPlayerMoney - box2Cost;
            ENIGMA_UpdateStats = [player,_newPoptabs];
            publicVariableServer "ENIGMA_UpdateStats";
    with

            ["buyRequest",[str(box2Cost)]] call ExileClient_system_network_send;
5. Replace

            _newPoptabs = ExileClientPlayerMoney - box3Cost;
            ENIGMA_UpdateStats = [player,_newPoptabs];
            publicVariableServer "ENIGMA_UpdateStats";
    with

            ["buyRequest",[str(box3Cost)]] call ExileClient_system_network_send;
6. Replace

            _newPoptabs = ExileClientPlayerMoney - box4Cost;
            ENIGMA_UpdateStats = [player,_newPoptabs];
            publicVariableServer "ENIGMA_UpdateStats";
    with

            ["buyRequest",[str(box4Cost)]] call ExileClient_system_network_send;
7. Replace

            _newPoptabs = ExileClientPlayerMoney - box5Cost;
            ENIGMA_UpdateStats = [player,_newPoptabs];
            publicVariableServer "ENIGMA_UpdateStats";
    with

            ["buyRequest",[str(box5Cost)]] call ExileClient_system_network_send;
8. Replace

            _newPoptabs = ExileClientPlayerMoney - box6Cost;
            ENIGMA_UpdateStats = [player,_newPoptabs];
            publicVariableServer "ENIGMA_UpdateStats";
    with

            ["buyRequest",[str(box6Cost)]] call ExileClient_system_network_send;
9. Save and you are done!

Zupa's Capture Points 2.0 (ZCP)


Exile Forum Post: HERE
Difficulty: Easy
Instructions

1. De-PBO a3_zcp_exile.pbo

2. Navigate to the functions folder and open fn_rewardReputation.sqf

3. Change
            _ZCP_currentCapper setVariable['PLAYER_STATS_VAR', [_ZCP_currentCapper getVariable ['ExileMoney', 0], _playerScore],true];

    to

            _ZCP_currentCapper setVariable['PLAYER_STATS_VAR', [_ZCP_currentCapper getVariable ['ExilePurse', 0], _playerScore],true];

4. Change
            _x setVariable['PLAYER_STATS_VAR', [_x getVariable ['ExileMoney', 0], _newScore],true];

    to

            _x setVariable['PLAYER_STATS_VAR', [_x getVariable ['ExilePurse', 0], _newScore],true];

5. Navigate to the functions folder and open fn_rewardPoptabs.sqf
6. Change
            _playerMoney = _ZCP_currentCapper getVariable ["ExileMoney", 0];
    to
            _playerMoney = _ZCP_currentCapper getVariable ["ExilePurse", 0]; 
7. Change
            format["setAccountMoney:%1:%2", _playerMoney, (getPlayerUID _ZCP_currentCapper)] call ExileServer_system_database_query_fireAndForget;
    to

        format["updateWallet:%1:%2", _playerMoney, (getPlayerUID _ZCP_currentCapper)] call ExileServer_system_database_query_fireAndForget;
        format["setAccountScore:%1:%2",_playerMoney, (getPlayerUID _ZCP_currentCapper)] call ExileServer_system_database_query_fireAndForget;

8. Re-PBO a3_zcp_exile and replace on your server

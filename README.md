# Advance Banking for Exile
###### Made by Shix and WolfkillArcadia
Advance Banking is a complete rewrite of Exile's default money system. It separates Exile Money into a wallet and a personal bank making money a more valuable object. This, in turn, creates a more realistic survival scenario.

---

### Features
* Brand new banking system
* Two different ways of storing money
* Personal bank, secure and untouchable
* Wallet, death is going to become rich
* Custom Prisoner ID cards when examining wallets
* Brand new XM8 that shows wallet, personal bank, and shared bank[SoonTM]
* Custom ATMs that are spread all over the map
* Deposit, withdrawal, or transfer money to other players
* Completely rewritten to use Exile's security
* Extra: Commands to let other scripts add and remove from players wallets

---

#### Server Owners:
Advanced Banking is coded to make the transition from default Exile money system to Advanced Banking. No database wipes are required, as that it moves the players current Exile Money to their personal bank accounts. Even works with "10,000 starter money"!

#### Changing ATMs
Currently the ATMs are placed for Altis, Namalsk, and Chernarus. Placement is controlled via AdvBanking_Server\code\ExileServer_banking_map_placeATM.sqf. This output is from M3Editor and can easily be adapted to any map. If you would like to share your ATM placement, please pass the files to us and we will update the github.

---

### Roadmap
* Version 1: Initial release
* Version 2: Re-write awesomeness!
* Version 3:
    * Shared Banking
        * Another bank account
        * Invite other players to this account
        * Great for parties!
    * Bug fixes

---

### Installation
Advanced Banking has two different ways of installing it.<br>
**BEFORE INSTALLING: BACK UP ALL MISSION FILES, SERVER FILES, AND DATABASE**<br>
**RUN ON A TEST SERVER TO MAKE SURE EVERYTHING IS CORRECT BEFORE YOU LAUNCH TO LIVE SERVER**

If you haven't changed any of the following files, follow these instructions: [Here](https://github.com/WolfkillArcadia/AdvancedBanking/blob/master/FreshServerInstallation.md)<br><br>
**-- Server --**

* ExileServer_object_player_createBambi.sqf
* ExileServer_object_player_database_load.sqf
* ExileServer_object_player_sendStatsUpdate.sqf
* ExileServer_object_player_event_onMpKilled.sqf
* ExileServer_system_network_dispatchIncomingMessage.sqf
* ExileServer_system_territory_network_payTerritoryProtectionMoneyRequest.sqf
* ExileServer_system_territory_network_purchaseTerritory.sqf
* ExileServer_system_trading_network_purchaseItemRequest.sqf
* ExileServer_system_trading_network_purchaseVehicleRequest.sqf
* ExileServer_system_trading_network_purchaseVehicleSkinRequest.sqf
* ExileServer_system_trading_network_sellItemRequest.sqf
* ExileServer_system_trading_network_sendMoneyRequest.sqf
* ExileServer_system_trading_network_wasteDumpRequest.sqf

**-- Client --**

* ExileClient_gui_xm8_slide_apps_onOpen.sqf
* ExileClient_gui_xm8_slide_players_onOpen.sqf

If you **have** changed any of the above files, follow these instructions: [Here](https://github.com/WolfkillArcadia/AdvancedBanking/blob/master/ModdedServerInstallation.md)<br><br>

**-- Upgrading from 2.2 to 2.4 --**<br>
[Instructions Here](https://github.com/WolfkillArcadia/AdvancedBanking/blob/master/Update2.2to2.4.md)<br><br>

---

### Changelog
Version 2.4 (10/03/2016)
* Updated base files to Pomelo
* Disabled Text box in XM8 for transferring
* Forced ATM update on transfer
* Moved wallet drop to player's body instead of money pile
* Added ATM placement for Namalsk and Chernarus

---

### Compatibility
I've writing a document that has instructions to make Advanced Banking compatible with other scripts. You can find it here. [Here](https://github.com/WolfkillArcadia/AdvancedBanking/blob/master/compatibility.md)<br>
This process will take awhile on a few scripts. I will update the Exile Forum post with details.

---

### FAQ
*XXXX error is happening, halp!*
* Please make sure you are up to date
* Enable debug message by editing AdvBanking_Server/bootstrap/fn_preInit.sqf and set ADVBANKING_SERVER_DEBUG to true. For the client, edit AdvancedBanking/AdvBanking_Client_Init.sqf and set ADVBANKING_CLIENT_DEBUG to true
* Test again then post your full server and client RPT

*Can you add XXXX feature?*
We would love to hear your suggestions, please post on the forums or open an issue on github.

---

### Other script creators
We've added functionality for other scripts to use Advanced Banking for updating wallets client side.
* ExileServer_banking_network_buyRequest.sqf
    * `["buyRequest",[str(AMOUNT_TO_REMOVE)]] call ExileClient_system_network_send;`
* ExileServer_banking_network_saleRequest.sqf
    * `["saleRequest",[str(AMOUNT_TO_ADD)]] call ExileClient_system_network_send;`

---


### Disclaimer
Everything offered in this repository is offered with NO WARRANTY. We are not responsible for any damages these files may cause either that being physical, emotional, or anything in between. We are not responsible if these files run off with your wife or husband or happens to kill your dog. We do offer support for any bugs, features, or setup that we have added to this server/mission files. If you have any issues or have any questions, please comment on the Exile Forums post or open an issue on Github

### Copyright
Copyright (c) 2016 Shix and Wolfkillarcadia

This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/

Contact: mrshix1996@gmail.com or wolfkillarcadia@gmail.com

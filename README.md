# Advance Banking for Exile
###### Made by Shix and WolfkillArcadia
Advance Banking is a complete rewrite of Exile's default money system. It separates Exile Money into a wallet and a bank, making money a more valuable object. This, in turn, creates a more realistic survival scenario.

---

### Features
* Brand new physical money system
* Splits your money into a wallet and bank
* Wallet: Used to purchase items/weapons/vehicles. Drops when you die (Appears as a suitcase)
* Bank: Safe and secure, accessible at ATMs
* Secure and fast, compatible with 99% of scripts out there.

---

#### Changing ATMs
Currently the ATMs are placed for Altis, Namalsk, and Chernarus. Placement is controlled clientside via **AdvancedBanking\functions\ExileClient_banking_map_placeATM.sqf**. This output is from M3Editor and can easily be adapted to any map. If you would like to share your ATM placement, please pass the files to us and we will update the github.

---

### Roadmap
* Version 1: Initial release
* Version 2: Re-write awesomeness!
* Version 3: Brand New GUI plus framework changes
* Version 4: Surprises for the new physical money in Exile :)

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
* ExileServer_system_trading_network_sendMoneyRequest.sqf

**-- Client --**

* ExileClient_gui_xm8_slide_apps_onOpen.sqf
* ExileClient_gui_xm8_slide_players_onOpen.sqf

If you **have** changed any of the above files, follow these instructions: [Here](https://github.com/WolfkillArcadia/AdvancedBanking/blob/master/ModdedServerInstallation.md)<br><br>

**-- Upgrading from 2.4 to 3 --**<br>
[Instructions Here](https://github.com/WolfkillArcadia/AdvancedBanking/blob/master/Update2.4to3.md)<br><br>

---

### Changelog
Version 3 ()
* Brand new GUI design, courtesy of Mr. White. :)
* Rewrote to use pre-existing variables (Removes need for half of rewrites)
* Moved wallet drop to suitcase instead of player. (Should take care of ArmA cleanup issues)
* Removed need for compatibility unless accessing bank money
* Added config options on server for Fresh servers or servers coming from previous versions (Database cleanup)
* Moved ATMs spawning to client side so addAction could be used instead of relying on InteractionMenus (Takes care of not getting ATM scroll option issue)
* Small bug fixes and code clean up

Version 2.4 (10/03/2016)
* Updated base files to Pomelo
* Disabled Text box in XM8 for transferring
* Forced ATM update on transfer
* Moved wallet drop to player's body instead of money pile
* Added ATM placement for Namalsk and Chernarus

---

### Compatibility
Previous versions of Advanced Banking required tweaks to other scripts. These changes are no longer required as that Advanced Banking ties into Exile's default money. (Unless to use the bank side)

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
    * `["buyRequest",["WALLET or BANK",str(AMOUNT_TO_REMOVE)]] call ExileClient_system_network_send;`
* ExileServer_banking_network_saleRequest.sqf
    * `["saleRequest",["WALLET or BANK",str(AMOUNT_TO_ADD)]] call ExileClient_system_network_send;`

---

### Copyright
Copyright (c) 2016 Shix and Wolfkillarcadia

This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/

Contact: mrshix1996@gmail.com or wolfkillarcadia@gmail.com

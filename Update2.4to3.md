# Updating to 3 from 2.4 instructions
**All of these steps are important, if you skip one, Advanced Banking will not work correctly**

**SERVER SIDE**
* Run AdvBanking.sql on your MySQL server.
* exile.ini: Delete *Advanced Banking's* commands and replace them with the ones from the update
* Delete *AdvBanking_Server.pbo* from your server addons folder. Copy *AdvBanking_Server* from the update. Make sure to look at `AdvBanking_Server\bootstrap\fn_preInit.sqf` for some important configuration options.
* Download a fresh copy of the following files, replacing them in `exile_server\code`. We don't use them anymore. (If you have changes other than Advanced Banking in here, make sure you make those changes again)
    * ExileServer_system_territory_network_payTerritoryProtectionMoneyRequest.sqf
    * ExileServer_system_territory_network_purchaseTerritory.sqf
    * ExileServer_system_trading_network_purchaseItemRequest.sqf
    * ExileServer_system_trading_network_purchaseVehicleRequest.sqf
    * ExileServer_system_trading_network_purchaseVehicleSkinRequest.sqf
    * ExileServer_system_trading_network_sellItemRequest.sqf
    * ExileServer_system_trading_network_wasteDumpRequest.sqf
* Copy the files inside `exile_server\code` from the update into `exile_server\code` on your server.

**CLIENT SIDE**
* Delete Advanced Banking folder and replace with the one from the update
* Delete `ExileClient_gui_xm8_slide_apps_onOpen.sqf` and replace with the one from the update
* Update `CfgNetworkMessages.hpp`
* `CfgInteractionMenus.hpp`
    * Remove options to *collect* and *examine* for `class Player`
    * Remove `class ATM` as that it's been moved to an add action
    * Either (depending on what you have)
        * Update CfgInteractionMenus.hpp with the one from the update
        * Or add `#include "CfgInteractionMenus.hpp"` inside the brackets for `class CfgInteractionMenus` then copy the file to your mission from the update

### Fresh Server Install Instructions
This set of instructions is assuming that the Exile server/client files have not be modded in any way. IE, you haven't changed any ExileServer\_\* or ExileClient\_\* files.<br/>
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
3. Copy the files from exile_server/code from the github and paste them inside your exile_server/code folder.
4. Re-PBO your **exile_server** folder
5. Server side installation is done!

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
6. Woohoo! You are done!

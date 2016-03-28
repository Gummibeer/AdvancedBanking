### Fresh Server Install Instructions
This set of instructions is assuming that the Exile server/client files have not be modded in any way. IE, you haven't changed any ExileServer\_\* or ExileClient\_\* files.<br/>
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
3. Copy the files from exile_server/code from the github and paste them inside your exile_server/code folder.
    1. If you are coming from Version 2.0, please replace the config.bin file in your exile_server folder with the one from the github, this will revert it back to the way it was.
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
6. Woohoo! You are done!

## Instructions on how to update from 2.2 to 2.4

### Client Side
1. **config.cpp**
    1. **CfgNetworkMessages**
        1. If you have an class called `class CfgNetworkMessages {};` make sure to update what is in the CfgNetworkMessages.hpp file
        2. If you have `#include CfgNetworkMessages.hpp` in your file, make sure to copy the CfgNetworkMessages.hpp file over
    2. **CfgInteractionMenus**
        1. Money has been moved to the players body. Make sure to delete `class MoneyPile {};`
        2. Replace all of `class Player {};` with
            
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

         3. Locate `class CfgExileCustomCode`
         4. Delete out `ExileClient_system_network_dispatchIncomingMessage = "ClientOverrides\ExileClient_system_network_dispatchIncomingMessage.sqf";`
         5. Delete out ` ExileClient_object_player_event_onPlayerKilled = "ClientOverrides\ExileClient_object_player_event_onPlayerKilled.sqf";`
2. Delete `AdvancedBanking` folder and copy over the new one from the github
3. Delete `ExileClient_system_network_dispatchIncomingMessage.sqf` and `ExileClient_object_player_event_onPlayerKilled.sqf` from your ClientOverrides if these are only from Advanced banking


### Server Side
1. Delete `AdvBanking_Server.pbo`, pbo the folder from the github and place it in your `@ExileServer/addons`
2. If have a modded server, follow the server instructions [Here](https://github.com/WolfkillArcadia/AdvancedBanking/blob/master/ModdedServerInstallation.md)
3. If you don't have a modded server, copy all the files from `exile_server/code` on the github into your `exile_server/code`

## Having trouble?
1. Run through the instructions one more time.
2. Enable Debug for server and Client
3. Post your server/client RPTs

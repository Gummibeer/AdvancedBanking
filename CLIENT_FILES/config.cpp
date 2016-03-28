class CfgInteractionMenus
{
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
};

// Advanced Banking
class Grave
{
   targetType = 2;
   target = "Land_Suitcase_F";

   class Actions
   {
       class Examine: ExileAbstractAction
       {
           title = "Examine Wallet";
           condition = "((ExileClientInteractionObject getVariable ['ExileName','']) != '')";
           action = "[(ExileClientInteractionObject getVariable ['ExileName','']),(ExileClientInteractionObject getVariable ['DroppedAmount',0])] call ExileClient_banking_player_examineMoney";
       };
       class Collect: ExileAbstractAction
       {
           title = "Collect Dropped Wallet";
           condition = "((ExileClientInteractionObject getVariable ['DroppedAmount',0]) > 0)";
           action = "[ExileClientInteractionObject,(ExileClientInteractionObject getVariable ['DroppedAmount',0])] call ExileClient_banking_player_collectMoney";
       };
   };
};
// Advanced Banking

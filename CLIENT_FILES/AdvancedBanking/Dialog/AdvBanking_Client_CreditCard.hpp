/*

 	Name: AdvBanking_Client_CreditCard.hpp

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia
	This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Dialog file for Advanced banking CreditCard

*/

class AdvBankingCreditCard {
	idd = -1;
	fadeout= 0;
	fadein= 0;
	duration = 20;
	name = "AdvBankingCreditCard";
	onLoad = "uiNamespace setVariable ['AdvBankingCreditCard', _this select 0]";

	class controlsBackground {
        class AdvBankingCreditcardBG: AdvBankingRscPicture
        {
        	idc = 1200;
        	text = "AdvancedBanking\images\IDCard.paa";
        	x = 0.79661 * safezoneW + safezoneX;
        	y = 0.640 * safezoneH + safezoneY;
        	w = 0.17526 * safezoneW;
        	h = 0.250 * safezoneH;
        };
		class AdvBankingCardName: AdvBankingRscStructuredText
		{
			idc = 1100;
			text = "Name"; //--- ToDo: Localize;
			x = 0.843 * safezoneW + safezoneX;
			y = 0.705 * safezoneH + safezoneY;
			w = 0.139254 * safezoneW;
			h = 0.033 * safezoneH;
			style = 0;
		};
		class AdvBankingInmate: AdvBankingRscStructuredText
		{
			idc = 1101;
			text = "INMATE"; //--- ToDo: Localize;
			x = 0.806822 * safezoneW + safezoneX;
			y = 0.705 * safezoneH + safezoneY;
			w = 0.139254 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class AdvBankingWalletAmmountHeader: AdvBankingRscStructuredText
		{
			idc = 1102;
			text = "WALLET AMMOUNT"; //--- ToDo: Localize;
			x = 0.80200 * safezoneW + safezoneX;
			y = 0.77 * safezoneH + safezoneY;
			w = 0.139254 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class AdvBankingWalletAmmount: AdvBankingRscStructuredText
		{
			idc = 1103;
			text = "50000"; //--- ToDo: Localize;
			x = 0.80300 * safezoneW + safezoneX;
			y = 0.785 * safezoneH + safezoneY;
			w = 0.139254 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class AdvBankingTransDate: AdvBankingRscStructuredText
		{
			idc = 1105;
			text = "TransDate"; //--- ToDo: Localize;
			x = 0.833398 * safezoneW + safezoneX;
			y = 0.82 * safezoneH + safezoneY;
			w = 0.139254 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};

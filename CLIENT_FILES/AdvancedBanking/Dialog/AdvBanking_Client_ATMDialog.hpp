/*

 	Name: AdvBanking_Client_ATMDialog.hpp

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Dialog file for Advanced banking ATM

*/
class AdvBankingATM
{
    idd = 0711;
    onLoad = "uiNamespace setVariable ['AdvBankingATM', _this select 0]; []spawn ExileClient_banking_atm_onATMLoad;";
    movingenable=false;
	class Controls
	{
        class AdvBankingBackPannel: AdvBakingIGUIBack
        {
        	idc = 2200;
        	x = -0.000287468 * safezoneW + safezoneX;
        	y = -0.00599988 * safezoneH + safezoneY;
        	w = 1.00056 * safezoneW;
        	h = 1.012 * safezoneH;
            colorBackground[] = {0.169,0.188,0.212,1};
        };
        class AdvBankingFrontPannel: AdvBakingIGUIBack
        {
        	idc = 2202;
        	x = 0.293698 * safezoneW + safezoneX;
        	y = -0.00599999 * safezoneH + safezoneY;
        	w = 0.412603 * safezoneW;
        	h = 1.045 * safezoneH;
            colorBackground[] = {0.239,0.275,0.302,1};
        };
        class AdvBankingTopBar: AdvBakingIGUIBack
        {
        	idc = 2201;
        	x = -0.000281541 * safezoneW + safezoneX;
        	y = -0.00599999 * safezoneH + safezoneY;
        	w = 1.00572 * safezoneW;
        	h = 0.022 * safezoneH;
            colorBackground[] = {0.102,0.102,0.102,1};
        };
        class AdvBankingBottomBar: AdvBakingIGUIBack
        {
        	idc = 2203;
        	x = -0.000281541 * safezoneW + safezoneX;
        	y = 0.093 * safezoneH + safezoneY;
        	w = 1.00572 * safezoneW;
        	h = 0.009 * safezoneH;
            colorBackground[] = {0.102,0.102,0.102,1};
        };
        class AdvBankingPlayerName: AdvBakingRscStructuredText
        {
        	idc = 1100;
        	x = -0.000281689 * safezoneW + safezoneX;
        	y = 0.033 * safezoneH + safezoneY;
        	w = 0.29398 * safezoneW;
        	h = 0.055 * safezoneH;
        };
        class AdvBankingTitle: AdvBakingRscStructuredText
        {
        	idc = 1101;
        	x = 0.298856 * safezoneW + safezoneX;
        	y = 0.033 * safezoneH + safezoneY;
        	w = 0.402288 * safezoneW;
        	h = 0.055 * safezoneH;
        };
        class AdvBankingBallance: AdvBakingRscStructuredText
        {
        	idc = 1102;
        	x = 0.706302 * safezoneW + safezoneX;
        	y = 0.033 * safezoneH + safezoneY;
        	w = 0.29398 * safezoneW;
        	h = 0.055 * safezoneH;
        };
        class ScreenBorderLeft: AdvBakingIGUIBack
        {
        	idc = 2210;
        	x = 0.292698 * safezoneW + safezoneX;
        	y = 0.093 * safezoneH + safezoneY;
        	w = 0.00212603 * safezoneW;
        	h = 0.954 * safezoneH;
            colorBackground[] = {0.102,0.102,0.102,1};
        };
        class ScreenBorderRight: AdvBakingIGUIBack
        {
        	idc = 2204;
        	x = 0.706302 * safezoneW + safezoneX;
        	y = 0.093 * safezoneH + safezoneY;
        	w = 0.00212603 * safezoneW;
        	h = 0.954 * safezoneH;
            colorBackground[] = {0.102,0.102,0.102,1};
        };
        class ScreenBorderTop: AdvBakingIGUIBack
        {
        	idc = 2205;
        	x = 0.294761 * safezoneW + safezoneX;
        	y = 0.2206 * safezoneH + safezoneY;
        	w = 0.412603 * safezoneW;
        	h = 0.0055 * safezoneH;
            colorBackground[] = {0.102,0.102,0.102,1};
        };
        class ScreenBorderBottom: AdvBakingIGUIBack
        {
        	idc = 2011;
        	x = 0.294761 * safezoneW + safezoneX;
        	y = 0.775 * safezoneH + safezoneY;
        	w = 0.412603 * safezoneW;
        	h = 0.0055 * safezoneH;
            colorBackground[] = {0.102,0.102,0.102,1};
        };
        class AdvBankingCloseText: AdvBakingRscStructuredText
        {
        	idc = 1105;
            text = "<t color='#00b2cd' font='OrbitronLight' size='2' valign='middle' align='center' shadow='0'>CLOSE</t>";
        	x = 0.407164 * safezoneW + safezoneX;
        	y = 0.915 * safezoneH + safezoneY;
        	w = 0.185671 * safezoneW;
        	h = 0.055 * safezoneH;
        };
        class AdvBankingCloseBtn: AdvBakingRscButton
        {
        	idc = 1600;
        	x = 0.407164 * safezoneW + safezoneX;
        	y = 0.910 * safezoneH + safezoneY;
        	w = 0.185671 * safezoneW;
        	h = 0.055 * safezoneH;
            colorBackground[] = {0,0,0,0};
            colorBackgroundActive[] ={1,1,1,0.05};
            colorFocused[] ={1,1,1,0};
            onButtonClick = "[] spawn ExileClient_banking_atm_closeATM";

        };
		class AdvBankingErrorMessage: AdvBakingRscStructuredText
        {
            idc = 11012;
            text = "<t color='#ff0000' font='OrbitronLight' size='1.1' valign='middle' align='center' shadow='0'></t>";
            x = 0.37 * safezoneW + safezoneX;
            y = 0.79 * safezoneH + safezoneY;
            w = 0.26 * safezoneW;
            h = 0.055 * safezoneH;
        };
        class AdvBankingSwitchAccText: AdvBakingRscStructuredText
        {
            idc = 1106;
            text = "<t color='#00b2cd' font='OrbitronLight' size='1.5' valign='middle' align='center' shadow='0'>SWITCH ACCOUNT</t>";
            x = 0.407164 * safezoneW + safezoneX;
            y = 0.845 * safezoneH + safezoneY;
            w = 0.185671 * safezoneW;
            h = 0.055 * safezoneH;
        };
        class AdvBankingSwitchAccBtn: AdvBakingRscButton
        {
            idc = 1607;
            x = 0.407164 * safezoneW + safezoneX;
            y = 0.835 * safezoneH + safezoneY;
            w = 0.185671 * safezoneW;
            h = 0.055 * safezoneH;
            colorBackground[] = {0,0,0,0};
            colorBackgroundActive[] ={1,1,1,0.05};
            colorFocused[] ={1,1,1,0};
        };
        class AdvBankingSharedBankCont: AdvBakingRscStructuredText
        {
        	idc = 1107;
        	x = 0.293698 * safezoneW + safezoneX;
        	y = 0.247 * safezoneH + safezoneY;
        	w = 0.412603 * safezoneW;
        	h = 0.086 * safezoneH;
        };
        class AdvBankingPersonalBankCont: AdvBakingRscStructuredText
        {
        	idc = 1108;
        	x = 0.293698 * safezoneW + safezoneX;
        	y = 0.337 * safezoneH + safezoneY;
        	w = 0.412603 * safezoneW;
        	h = 0.086 * safezoneH;
        };
        class AdvBankingDepositBtnText: AdvBakingRscStructuredText
        {
        	idc = 1103;
            text = "<t color='#00b2cd' font='OrbitronLight' size='2' valign='middle' align='center' shadow='0'>DEPOSIT</t>";
        	x = 0.427794 * safezoneW + safezoneX;
        	y = 0.522 * safezoneH + safezoneY;
        	w = 0.144411 * safezoneW;
        	h = 0.044 * safezoneH;
        };
        class AdvBankingDepositBtn: AdvBakingRscButton
        {
            idc = 1604;
            x = 0.427794 * safezoneW + safezoneX;
            y = 0.522 * safezoneH + safezoneY;
            w = 0.144411 * safezoneW;
            h = 0.044 * safezoneH;
            colorBackground[] = {0,0,0,0};
            colorBackgroundActive[] ={1,1,1,0.05};
            colorFocused[] ={1,1,1,0};
            onButtonClick = "[]spawn ExileClient_banking_atm_deposit";
        };
        class AdvBankingWithdrawBtnText: AdvBakingRscStructuredText
        {
        	idc = 1104;
            text = "<t color='#00b2cd' font='OrbitronLight' size='2' valign='middle' align='center' shadow='0'>WITHDRAW</t>";
        	x = 0.427794 * safezoneW + safezoneX;
        	y = 0.58 * safezoneH + safezoneY;
        	w = 0.144411 * safezoneW;
        	h = 0.044 * safezoneH;
        };
        class AdvBankingWithdrawBtn: AdvBakingRscButton
        {
        	idc = 1605;
        	x = 0.427794 * safezoneW + safezoneX;
        	y = 0.58 * safezoneH + safezoneY;
        	w = 0.144411 * safezoneW;
        	h = 0.044 * safezoneH;
            colorBackground[] = {0,0,0,0};
            colorBackgroundActive[] ={1,1,1,0.05};
            colorFocused[] ={1,1,1,0};
            onButtonClick = "[] spawn ExileClient_banking_player_withdrawal";
        };
		class AdvBankingTransferBtnText: AdvBakingRscStructuredText
        {
            idc = 1110;
            text = "<t color='#00b2cd' font='OrbitronLight' size='2' valign='middle' align='center' shadow='0'>TRANSFER</t>";
            x = 0.427794 * safezoneW + safezoneX;
            y = 0.635 * safezoneH + safezoneY;
            w = 0.144411 * safezoneW;
            h = 0.044 * safezoneH;
        };
        class AdvBankingTransferBtn: AdvBakingRscButton
        {
            idc = 1610;
            x = 0.427794 * safezoneW + safezoneX;
            y = 0.635 * safezoneH + safezoneY;
            w = 0.144411 * safezoneW;
            h = 0.044 * safezoneH;
            onButtonClick = "[] spawn ExileClient_banking_atm_onTransferBtnClick";
        };
        class AdvBankingAccountInUse: AdvBakingRscStructuredText
        {
        	idc = 1109;
            text="";
        	x = 0.293689 * safezoneW + safezoneX;
        	y = 0.115063 * safezoneH + safezoneY;
        	w = 0.412603 * safezoneW;
        	h = 0.086 * safezoneH;
        };
        class AdvBankingInputBox: AdvBakingRscEdit
        {
            idc = 1400;
            x = 0.427794 * safezoneW + safezoneX;
            y = 0.467 * safezoneH + safezoneY;
            w = 0.144411 * safezoneW;
            h = 0.044 * safezoneH;
            style = 34;
        };
        class AdvBankingLoadingBar: AdvBakingRscProgress
        {
        	idc = 1900;
        	x = 0.299398 * safezoneW + safezoneX;
        	y = 0.742 * safezoneH + safezoneY;
        	w = 0.402603 * safezoneW;
        	h = 0.020 * safezoneH;
        };
        class AdvBankingLoading: AdvBakingRscStructuredText
        {
            idc = 1120;
            x = 0.298856 * safezoneW + safezoneX;
            y = 0.690 * safezoneH + safezoneY;
            w = 0.402288 * safezoneW;
            h = 0.055 * safezoneH;
        };
		class AdvBanking_PlayerList: AdvBakingRscListbox
        {
        	idc = 1500;
        	x = 0.737247 * safezoneW + safezoneX;
        	y = 0.159 * safezoneH + safezoneY;
        	w = 0.232089 * safezoneW;
        	h = 0.682 * safezoneH;
            style = 530;
        };
        class AdvBankingSendPoptabsText: AdvBakingRscStructuredText
        {
        	idc = 1111;
        	text = "<t color='#00b2cd' font='OrbitronLight' size='1.5' valign='middle' align='center' shadow='0'>SEND POPTABS</t>"; //--- ToDo: Localize;
        	x = 0.763035 * safezoneW + safezoneX;
        	y = 0.874 * safezoneH + safezoneY;
        	w = 0.185671 * safezoneW;
        	h = 0.055 * safezoneH;
        };
        class AdvBankingSendPoptabsBtn: AdvBakingRscButton
        {
        	idc = 1611;
        	x = 0.763035 * safezoneW + safezoneX;
        	y = 0.863 * safezoneH + safezoneY;
        	w = 0.185671 * safezoneW;
        	h = 0.055 * safezoneH;
            onButtonClick = "[] spawn ExileClient_banking_atm_transferToPlayer";
        };
    };
};

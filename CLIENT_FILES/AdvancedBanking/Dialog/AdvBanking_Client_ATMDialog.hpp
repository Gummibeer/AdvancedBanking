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
    onLoad = "uiNamespace setVariable ['AdvBankingATM', _this select 0]; []spawn ExileClient_banking_atm_onATMLoad";
    movingenable=false;
	class Controls
	{
        class ATMBackground: AdvBankingRscPicture
        {
        	idc = 9000;
        	text = "AdvancedBanking\images\ATMBackground.paa";
        	x = -0.000156274 * safezoneW + safezoneX;
        	y = -0.00599999 * safezoneH + safezoneY;
        	w = 1.00031 * safezoneW;
        	h = 1.011 * safezoneH;
        };
        class LeftSideBarBG: AdvBankingIGUIBack
        {
        	idc = 9001;

        	x = 0.173 * safezoneW + safezoneX;
        	y = -0.00599999 * safezoneH + safezoneY;
        	w = 0.113437 * safezoneW;
        	h = 1.023 * safezoneH;
        	colorBackground[] = {0.878,0.878,0.878,0.5};
        };
        class ProfileBG: AdvBankingIGUIBack
        {
            idc = 9006;

            x = 0.173 * safezoneW + safezoneX;
            y = 0.17 * safezoneH + safezoneY;
            w = 0.113437 * safezoneW;
            h = 0.275 * safezoneH;
            colorBackground[] = {0.396,0.553,0.659,1};
        };
        class UserPic: AdvBankingRscPicture
        {
            idc = 9007;
            text = "AdvancedBanking\images\UserIcon.paa";
            x = 0.205 * safezoneW + safezoneX;
            y = 0.2 * safezoneH + safezoneY;
            w = 0.053437 * safezoneW;
            h = 0.1 * safezoneH;
        };
        class ProfileWBText: AdvBankingRscText
        {
            idc = 9028;
            font = "PuristaBold";
            style = 2;

            text = "WELCOME BACK"; //--- ToDo: Localize;
            x = 0.173 * safezoneW + safezoneX;
            y = 0.3 * safezoneH + safezoneY;
            w = 0.113437 * safezoneW;
            h = 0.055 * safezoneH;
            colorText[] = {1,1,1,1};
            sizeEx = (((((safezoneW / safezoneH) min 1) / 1.5) / 25) * 1);
        };
        class ProfilePlayerName: AdvBankingRscText
        {
            idc = 9029;
            font = "PuristaBold";
            style = 2;

            text = "MRWHITE"; //--- ToDo: Localize;
            x = 0.173 * safezoneW + safezoneX;
            y = 0.315 * safezoneH + safezoneY;
            w = 0.114437 * safezoneW;
            h = 0.055 * safezoneH;
            colorText[] = {1,1,1,1};
            sizeEx = (((((safezoneW / safezoneH) min 10.2) / 1) / 25) * 1);
        };
        class ProfileBaankAccounttNumberTitle: AdvBankingRscText
        {
            idc = 9030;
            font = "PuristaBold";
            style = 2;

            text = "BANK ACCOUNT NUMBER"; //--- ToDo: Localize;
            x = 0.173 * safezoneW + safezoneX;
            y = 0.37 * safezoneH + safezoneY;
            w = 0.114437 * safezoneW;
            h = 0.055 * safezoneH;
            colorText[] = {1,1,1,1};
            sizeEx = (((((safezoneW / safezoneH) min 1) / 1.5) / 25) * 1);
        };
        class ProfileBaankAccountNumber: AdvBankingRscText
        {
            idc = 9031;
            font = "PuristaBold";
            style = 2;

            text = ""; //--- ToDo: Localize;
            x = 0.183 * safezoneW + safezoneX;
            y = 0.41 * safezoneH + safezoneY;
            w = 0.096 * safezoneW;
            h = 0.025 * safezoneH;
            colorText[] = {0,0,0,1};
            colorBackground[] = {1,1,1,1};
            sizeEx = (((((safezoneW / safezoneH) min 1) / 1.5) / 25) * 1);
        };
        class transferBG: AdvBankingIGUIBack
        {
        	idc = 9002;

        	x = 0.3 * safezoneW + safezoneX;
        	y = 0.467 * safezoneH + safezoneY;
        	w = 0.510469 * safezoneW;
        	h = 0.154 * safezoneH;
        	colorBackground[] = {0.455,0.639,0.455,1};
        };
        class TransferTitle: AdvBankingRscText
        {
            idc = 9022;
            font = "PuristaBold";

            text = "TRANSFER"; //--- ToDo: Localize;
            x = 0.305 * safezoneW + safezoneX;
            y = 0.468 * safezoneH + safezoneY;
            w = 0.118594 * safezoneW;
            h = 0.055 * safezoneH;
            colorText[] = {1,1,1,1};
            sizeEx = (((((safezoneW / safezoneH) min 10.2) / 0.8) / 25) * 1);
        };
        class TransferQuote: AdvBankingRscText
        {
            idc = 9026;
            font = "PuristaLight";

            text = "TO ONE OF OUR BELOVED CUSTOMERS"; //--- ToDo: Localize;
            x = 0.305 * safezoneW + safezoneX;
            y = 0.487 * safezoneH + safezoneY;
            w = 0.20625 * safezoneW;
            h = 0.055 * safezoneH;
            colorText[] = {1,1,1,1};
            sizeEx = (((((safezoneW / safezoneH) min 1) / 1.2) / 25) * 1);
        };
        class TransferAmountBox: AdvBankingRscEdit
        {
        	idc = 9034;

        	x = 0.305 * safezoneW + safezoneX;
        	y = 0.566 * safezoneH + safezoneY;
        	w = 0.226875 * safezoneW;
        	h = 0.033 * safezoneH;
        	colorBackground[] = {1,1,1,1};
        };
        class transferBtnBG: AdvBankingIGUIBack
        {
        	idc = 9035;

        	x = 0.765 * safezoneW + safezoneX;
        	y = 0.555 * safezoneH + safezoneY;
        	w = 0.0310375 * safezoneW;
        	h = 0.044 * safezoneH;
        	colorBackground[] = {1,1,1,1};
        };
        class TransferTargetCombo: AdvBankingRscCombo
        {
        	idc = 9036;

        	x = 0.57 * safezoneW + safezoneX;
        	y = 0.566 * safezoneH + safezoneY;
        	w = 0.195937 * safezoneW;
        	h = 0.033 * safezoneH;
        	colorBackground[] = {1,1,1,1};
        };
        class TransferTargetTitle: AdvBankingRscText
        {
        	idc = 9038;
        	font = "PuristaBold";

        	text = "Choose Target For Transfer"; //--- ToDo: Localize;
        	x = 0.57 * safezoneW + safezoneX;
        	y = 0.555 * safezoneH + safezoneY;
        	w = 0.195937 * safezoneW;
        	h = 0.011 * safezoneH;
        	colorBackground[] = {1,1,1,1};
        	sizeEx = (((((safezoneW / safezoneH) min 1) / 1.5) / 25) * 1);
        };
        class TransferAmountTitle: AdvBankingRscText
        {
        	idc = 9039;
        	font = "PuristaBold";

        	text = "Enter Amount To Transfer"; //--- ToDo: Localize;
        	x = 0.305 * safezoneW + safezoneX;
        	y = 0.555 * safezoneH + safezoneY;
        	w = 0.226875 * safezoneW;
        	h = 0.011 * safezoneH;
        	colorBackground[] = {1,1,1,1};
        	sizeEx = (((((safezoneW / safezoneH) min 1) / 1.5) / 25) * 1);
        };
        class transferBtnPicture: AdvBankingRscPicture
        {
        	idc = 9040;
            text = "AdvancedBanking\images\CheckMark.paa";
        	x = 0.767 * safezoneW + safezoneX;
        	y = 0.557 * safezoneH + safezoneY;
        	w = 0.0279812 * safezoneW;
        	h = 0.04 * safezoneH;
        	colorBackground[] = {1,1,1,1};
        };
        class transferBtn: AdvBankingRscButton
        {
            idc = 9041;
            x = 0.767 * safezoneW + safezoneX;
            y = 0.557 * safezoneH + safezoneY;
            w = 0.0279812 * safezoneW;
            h = 0.04 * safezoneH;
            colorBackground[] = {0,0,0,0};
            onButtonClick = "call ExileClient_banking_atm_transferToPlayer";
        };
        class transferBarConnector: AdvBankingIGUIBack
        {
        	idc = 2200;
        	x = 0.530937 * safezoneW + safezoneX;
        	y = 0.555 * safezoneH + safezoneY;
        	w = 0.04125 * safezoneW;
        	h = 0.044 * safezoneH;
            colorBackground[] = {1,1,1,1};
        };
        class TransferArrow: AdvBankingRscPicture
        {
            idc = 9044;
            text = "AdvancedBanking\images\ArrowRight.paa";
            x = 0.77 * safezoneW + safezoneX;
            y = 0.468 * safezoneH + safezoneY;
            w = 0.033 * safezoneW;
            h = 0.055 * safezoneH;
        };
        class DepositBG: AdvBankingIGUIBack
        {
        	idc = 9004;

        	x = 0.3 * safezoneW + safezoneX;
        	y = 0.28 * safezoneH + safezoneY;
        	w = 0.2475 * safezoneW;
        	h = 0.165 * safezoneH;
        	colorBackground[] = {0.396,0.553,0.659,1};
        };
        class DepositBox: AdvBankingRscEdit
        {
            idc = 9008;
            x = 0.305 * safezoneW + safezoneX;
            y = 0.39 * safezoneH + safezoneY;
            w = 0.195937 * safezoneW;
            h = 0.033 * safezoneH;
            colorBackground[] = {1,1,1,1};
        };
        class DepositBoxHeader: AdvBankingRscText
        {
            idc = 9010;
            text = "Enter Amount To Deposit"; //--- ToDo: Localize;
            x = 0.305 * safezoneW + safezoneX;
            y = 0.379 * safezoneH + safezoneY;
            w = 0.195937 * safezoneW;
            h = 0.011 * safezoneH;
            colorBackground[] = {1,1,1,1};
            sizeEx = (((((safezoneW / safezoneH) min 1) / 1.5) / 25) * 1);
            font = "PuristaBold";
        };
        class DepositBtnBG: AdvBankingIGUIBack
        {
            idc = 9012;

            x = 0.5 * safezoneW + safezoneX;
            y = 0.379 * safezoneH + safezoneY;
            w = 0.0310375 * safezoneW;
            h = 0.044 * safezoneH;
            colorBackground[] = {1,1,1,1};
        };
        class DepositTitle: AdvBankingRscText
        {
            idc = 9019;
            font = "PuristaBold";

            text = "DEPOSIT"; //--- ToDo: Localize;
            x = 0.305 * safezoneW + safezoneX;
            y = 0.28 * safezoneH + safezoneY;
            w = 0.118594 * safezoneW;
            h = 0.055 * safezoneH;
            colorText[] = {1,1,1,1};
            sizeEx = (((((safezoneW / safezoneH) min 10.2) / 0.8) / 25) * 1);
        };
        class DepositBtnQuote: AdvBankingRscText
        {
            idc = 9024;
            font = "PuristaLight";

            text = "WE LOVE THIS BUTTON"; //--- ToDo: Localize;
            x = 0.305 * safezoneW + safezoneX;
            y = 0.303 * safezoneH + safezoneY;
            w = 0.118594 * safezoneW;
            h = 0.055 * safezoneH;
            colorText[] = {1,1,1,1};
            sizeEx = (((((safezoneW / safezoneH) min 1) / 1.2) / 25) * 1);
        };
        class DepositArrow: AdvBankingRscPicture
        {
            idc = 9047;
            text = "AdvancedBanking\images\ArrowDown.paa";
            x = 0.51 * safezoneW + safezoneX;
            y = 0.28 * safezoneH + safezoneY;
            w = 0.033 * safezoneW;
            h = 0.055 * safezoneH;
        };
        class DepositBtn: AdvBankingRscButton
        {
            idc = 9015;
            x = 0.5015 * safezoneW + safezoneX;
            y = 0.3815 * safezoneH + safezoneY;
            w = 0.0279812 * safezoneW;
            h = 0.04 * safezoneH;
            colorBackground[] = {0,0,0,0};
            onButtonClick = "call ExileClient_banking_atm_deposit";
        };
        class DepositBtnPic: AdvBankingRscPicture
        {
            idc = 9016;
            text = "AdvancedBanking\images\CheckMark.paa";
            x = 0.5015 * safezoneW + safezoneX;
            y = 0.3815 * safezoneH + safezoneY;
            w = 0.0279812 * safezoneW;
            h = 0.04 * safezoneH;
        };
        class WithDrawBG: AdvBankingIGUIBack
        {
        	idc = 9003;
        	x = 0.5628 * safezoneW + safezoneX;
        	y = 0.28 * safezoneH + safezoneY;
        	w = 0.2475 * safezoneW;
        	h = 0.165 * safezoneH;
        	colorBackground[] = {0.396,0.553,0.659,1};
        };
        class WithdrawBox: AdvBankingRscEdit
        {
        	idc = 9009;
        	x = 0.57 * safezoneW + safezoneX;
        	y = 0.39 * safezoneH + safezoneY;
        	w = 0.195937 * safezoneW;
        	h = 0.033 * safezoneH;
        	colorBackground[] = {1,1,1,1};
        };
        class WithdrawBoxHeader: AdvBankingRscText
        {
        	idc = 9011;
        	text = "Enter Amount To Withdraw"; //--- ToDo: Localize;
        	x = 0.57 * safezoneW + safezoneX;
        	y = 0.379 * safezoneH + safezoneY;
        	w = 0.195937 * safezoneW;
        	h = 0.011 * safezoneH;
        	colorBackground[] = {1,1,1,1};
            sizeEx = (((((safezoneW / safezoneH) min 1) / 1.5) / 25) * 1);
            font = "PuristaBold";
        };
        class WithdrawBtnBG: AdvBankingIGUIBack
        {
        	idc = 9013;

        	x = 0.765 * safezoneW + safezoneX;
        	y = 0.379 * safezoneH + safezoneY;
        	w = 0.0310375 * safezoneW;
        	h = 0.044 * safezoneH;
        	colorBackground[] = {1,1,1,1};
        };
        class WithdrawBtn: AdvBankingRscButton
        {
        	idc = 9017;
        	x = 0.767 * safezoneW + safezoneX;
        	y = 0.381 * safezoneH + safezoneY;
        	w = 0.0279812 * safezoneW;
        	h = 0.04 * safezoneH;
        	colorBackground[] = {0,0,0,0};
            onButtonClick = "call ExileClient_banking_atm_withdrawal";
        };
        class WithdrawBtnPic: AdvBankingRscPicture
        {
            idc = 9018;
            text = "AdvancedBanking\images\CheckMark.paa";
            x = 0.767 * safezoneW + safezoneX;
            y = 0.381 * safezoneH + safezoneY;
            w = 0.0279812 * safezoneW;
            h = 0.04 * safezoneH;
        };
        class WithdrawTitle: AdvBankingRscText
        {
        	idc = 9020;
        	font = "PuristaBold";

        	text = "WITHDRAW"; //--- ToDo: Localize;
        	x = 0.566 * safezoneW + safezoneX;
        	y = 0.28 * safezoneH + safezoneY;
        	w = 0.118594 * safezoneW;
        	h = 0.055 * safezoneH;
        	colorText[] = {1,1,1,1};
        	sizeEx = (((((safezoneW / safezoneH) min 10.2) / 0.8) / 25) * 1);
        };
        class WithdrawQuote: AdvBankingRscText
        {
            idc = 9025;
            font = "PuristaLight";

            text = "WE ALWAYS GET IT BACK FROM SOMEONE"; //--- ToDo: Localize;
            x = 0.566 * safezoneW + safezoneX;
            y = 0.303 * safezoneH + safezoneY;
            w = 0.178594 * safezoneW;
            h = 0.055 * safezoneH;
            colorText[] = {1,1,1,1};
            sizeEx = (((((safezoneW / safezoneH) min 1) / 1.2) / 25) * 1);
        };
        class WithdrawArrow: AdvBankingRscPicture
        {
            idc = 9048;
            text = "AdvancedBanking\images\ArrowUp.paa";
            x = 0.77 * safezoneW + safezoneX;
            y = 0.28 * safezoneH + safezoneY;
            w = 0.033 * safezoneW;
            h = 0.055 * safezoneH;
        };
        class WalletBalanceBG: AdvBankingIGUIBack
        {
            idc = 9075;

            x = 0.3 * safezoneW + safezoneX;
            y = 0.17 * safezoneH + safezoneY;
            w = 0.2475 * safezoneW;
            h = 0.088 * safezoneH;
            colorBackground[] = {1,1,1,1};
        };
        class WalletBalanceTitle: AdvBankingRscText
        {
            idc = 9076;
            text = "CURRENT WALLET BALANCE";
            x = 0.3 * safezoneW + safezoneX;
            y = 0.17 * safezoneH + safezoneY;
            w = 0.128906 * safezoneW;
            h = 0.022 * safezoneH;
            colorText[] = {0.322,0.322,0.322,1};
            sizeEx = (((((safezoneW / safezoneH) min 1) / 1.5) / 25) * 1);
            font = "PuristaBold";
        };
        class WalletcurencyTitle: AdvBankingRscText
        {
            idc = 9077;
            font = "PuristaBold";

            text = "TABS"; //--- ToDo: Localize;
            x = 0.49 * safezoneW + safezoneX;
            y = 0.17 * safezoneH + safezoneY;
            w = 0.0464063 * safezoneW;
            h = 0.044 * safezoneH;
            colorText[] = {0.6,0.6,0.6,1};
            sizeEx = (((((safezoneW / safezoneH) min 10.2) / 0.8) / 25) * 1);
        };
        class WalletBallance: AdvBankingRscText
        {
            idc = 9078;
            font = "PuristaBold";

            text = ""; //--- ToDo: Localize;
            x = 0.3 * safezoneW + safezoneX;
            y = 0.17 * safezoneH + safezoneY;
            w = 0.193 * safezoneW;
            h = 0.088 * safezoneH;
            style = 1;
            colorText[] = {0.322,0.322,0.322,1};
            sizeEx = (((((safezoneW / safezoneH) min 10.2) / 0.3) / 25) * 1);
        };
        class AccountBalanceBG: AdvBankingIGUIBack
        {
        	idc = 9014;

        	x = 0.5628 * safezoneW + safezoneX;
        	y = 0.17 * safezoneH + safezoneY;
        	w = 0.2475 * safezoneW;
        	h = 0.088 * safezoneH;
        	colorBackground[] = {1,1,1,1};
        };
        class AcountBalanceTitle: AdvBankingRscText
        {
        	idc = 9021;
            text = "CURRENT ACCOUNT BALANCE";
        	x = 0.5628 * safezoneW + safezoneX;
        	y = 0.17 * safezoneH + safezoneY;
        	w = 0.128906 * safezoneW;
        	h = 0.022 * safezoneH;
            colorText[] = {0.322,0.322,0.322,1};
            sizeEx = (((((safezoneW / safezoneH) min 1) / 1.5) / 25) * 1);
            font = "PuristaBold";
        };
        class curencyTitle: AdvBankingRscText
        {
        	idc = 9032;
            font = "PuristaBold";

        	text = "TABS"; //--- ToDo: Localize;
        	x = 0.75 * safezoneW + safezoneX;
        	y = 0.17 * safezoneH + safezoneY;
        	w = 0.0464063 * safezoneW;
        	h = 0.044 * safezoneH;
            colorText[] = {0.6,0.6,0.6,1};
            sizeEx = (((((safezoneW / safezoneH) min 10.2) / 0.8) / 25) * 1);
        };
        class Ballance: AdvBankingRscText
        {
            idc = 9033;
            font = "PuristaBold";

            text = ""; //--- ToDo: Localize;
            x = 0.5628 * safezoneW + safezoneX;
            y = 0.17 * safezoneH + safezoneY;
            w = 0.193 * safezoneW;
            h = 0.088 * safezoneH;
            style = 1;
            colorText[] = {0.322,0.322,0.322,1};
            sizeEx = (((((safezoneW / safezoneH) min 10.2) / 0.3) / 25) * 1);
        };
        class TBMLogo: AdvBankingRscPicture
        {
        	idc = 9043;
        	text = "AdvancedBanking\images\TBMLogo.paa";
        	x = 0.115 * safezoneW + safezoneX;
        	y = -0.04 * safezoneH + safezoneY;
        	w = 0.23 * safezoneW;
        	h = 0.23 * safezoneH;
        };
        class ReturnBg: AdvBankingIGUIBack
        {
            idc = 9005;

            x = 0.172 * safezoneW + safezoneX;
            y = 0.467 * safezoneH + safezoneY;
            w = 0.113437 * safezoneW;
            h = 0.154 * safezoneH;
            colorBackground[] = {0.588,0.427,0.463,1};
        };
        class CloseBtn: AdvBankingRscButton
        {
            idc = 9046;

            x = 0.172 * safezoneW + safezoneX;
            y = 0.467 * safezoneH + safezoneY;
            w = 0.113437 * safezoneW;
            h = 0.154 * safezoneH;
            colorBackground[] = {0,0,0,0};
            onButtonClick = "[]spawn ExileClient_banking_atm_closeATM";
        };
        class ReturnTitle: AdvBankingRscText
        {
        	idc = 9023;
        	font = "PuristaBold";

        	text = "RETURN"; //--- ToDo: Localize;
        	x = 0.177 * safezoneW + safezoneX;
        	y = 0.544 * safezoneH + safezoneY;
        	w = 0.113437 * safezoneW;
        	h = 0.055 * safezoneH;
        	colorText[] = {1,1,1,1};
        	sizeEx = (((((safezoneW / safezoneH) min 10.2) / 0.8) / 25) * 1);
        };
        class CloseQuote: AdvBankingRscText
        {
            idc = 9027;
            font = "PuristaLight";

            text = "GIVE MY CARD BACK"; //--- ToDo: Localize;
            x = 0.177 * safezoneW + safezoneX;
            y = 0.566 * safezoneH + safezoneY;
            w = 0.113437 * safezoneW;
            h = 0.055 * safezoneH;
            colorText[] = {1,1,1,1};
            sizeEx = (((((safezoneW / safezoneH) min 1) / 1.2) / 25) * 1);
        };
        class CloseIcon: AdvBankingRscPicture
        {
            idc = 9045;
            text = "AdvancedBanking\images\CloseIcon.paa";
            x = 0.25 * safezoneW + safezoneX;
            y = 0.547 * safezoneH + safezoneY;
            w = 0.033 * safezoneW;
            h = 0.055 * safezoneH;
        };
        class snakeAdvert: AdvBankingRscPicture
        {
            idc = 9049;
            text = "AdvancedBanking\images\snakeAdvert.paa";
            x = 0.3 * safezoneW + safezoneX;
            y = 0.337 * safezoneH + safezoneY;
            w = 0.510469 * safezoneW;
            h = 0.754 * safezoneH;
        };
        class TransferBarArrow: AdvBankingRscPicture
        {
            idc = 9042;
            text = "AdvancedBanking\images\Arrow.paa";
            x = 0.542 * safezoneW + safezoneX;
            y = 0.555 * safezoneH + safezoneY;
            w = 0.0309375 * safezoneW;
            h = 0.044 * safezoneH;
        };
        class ErrorDeposit: AdvBankingRscStructuredText
        {
        	idc = 9050;
        	x = 0.311281 * safezoneW + safezoneX;
        	y = 0.34226 * safezoneH + safezoneY;
        	w = 0.185625 * safezoneW;
        	h = 0.033 * safezoneH;
        	colorBackground[] = {0,0,0,0};
        };
        class ErrorWithdraw: AdvBankingRscStructuredText
        {
        	idc = 9051;
        	x = 0.570641 * safezoneW + safezoneX;
        	y = 0.34226 * safezoneH + safezoneY;
        	w = 0.190781 * safezoneW;
        	h = 0.033 * safezoneH;
        	colorBackground[] = {0,0,0,0};
        };
        class ErrorTransfer: AdvBankingRscStructuredText
        {
        	idc = 9052;
        	x = 0.304166 * safezoneW + safezoneX;
        	y = 0.520 * safezoneH + safezoneY;
        	w = 0.216563 * safezoneW;
        	h = 0.033 * safezoneH;
        	colorBackground[] = {0,0,0,0};
        };
    };
};

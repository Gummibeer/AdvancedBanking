/**
 * ExileClient_gui_xm8_slide_apps_onOpen
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

private["_display","_health","_popTabsValue","_popTabs","_respectValue","_respect", "_serverInfo", "_newControl","_8gNetworkPic","_8gNetworkBtn","_walletValue","_wallet","_bankValue","_sharedBankingBtn","_sharedBankingPic"];
disableSerialization;
_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
_health = _display displayCtrl 4057;
_health ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='1.6' valign='middle' align='center' shadow='0'><br/><br/><br/><t font='OrbitronMedium' size='3.5' color='#ffffff'>%1%2</t><br/>HEALTH</t>", round ((1 - damage player) * 100), "%"]);
_popTabsValue = ExileClientPlayerMoney;
if (_popTabsValue > 999) then
{
	_popTabsValue = format ["%1k", floor (_popTabsValue / 1000)];
};
_popTabs = _display displayCtrl 4058;
_popTabs ctrlSetTooltip format["%1", ExileClientPlayerMoney];
_popTabs ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='1.6' valign='middle' align='center' shadow='0'><br/><br/><br/><t font='OrbitronMedium' size='3.5' color='#ffffff'>%1</t><br/>POP TABS</t>", _popTabsValue]);
_respectValue = ExileClientPlayerScore;
if (_respectValue > 999) then
{
	_respectValue = format ["%1k", floor (_respectValue / 1000)];
};
_respect = _display displayCtrl 4059;
_respect ctrlSetTooltip format["%1", ExileClientPlayerScore];
_respect ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='1.6' valign='middle' align='center' shadow='0'><br/><br/><br/><t font='OrbitronMedium' size='3.5' color='#ffffff'>%1</t><br/>RESPECT</t>", _respectValue]);

//hide the poptabs and 8g network
_hideCtrls = [4058,1111];
{
_hide = (_display displayCtrl _X);
_hide ctrlSetFade 1;
_hide ctrlCommit 0;
ctrlEnable [_x, false];
} forEach _hideCtrls;

//create the picture for the 8G network
_8gNetworkPic = _display ctrlCreate ["RscPictureKeepAspect", 0711, _display displayCtrl 4040];
_8gNetworkPic ctrlSetPosition [(14.25 - 3) * (0.025), (4.25 - 2) * (0.04),(0.12),(0.12)];
_8gNetworkPic ctrlCommit 0.01;
_8gNetworkPic ctrlSetEventHandler ["ButtonClick", "execVM'xm8Apps\XM8Apps_Init.sqf';"];
_8gNetworkPic ctrlSetText "\exile_assets\texture\ui\xm8_app_network_ca.paa";

//create a new 8G network button
_8gNetworkBtn = _display ctrlCreate ["RscExileXM8AppButton1x1", 0712, _display displayCtrl 4040];
_8gNetworkBtn ctrlSetPosition [(10.5 - 3) * (0.025), (4 - 2) * (0.04),(0.315),(0.2)];
_8gNetworkBtn ctrlCommit 0.01;
_8gNetworkBtn ctrlSetEventHandler ["ButtonClick", "['players', 0] call ExileClient_gui_xm8_slide;"];
_8gNetworkBtn ctrlSetStructuredText (parseText (format ["8G Network"]));

//create a wallet stat
_walletValue = ExileClientPlayerMoney;
if (_walletValue > 999) then
{
_walletValue = format ["%1k", floor (_walletValue / 1000)];
};
_wallet = _display ctrlCreate ["RscStructuredText", 0713, _display displayCtrl 4040];
_wallet ctrlSetPosition [(4 - 3) * (0.025),(9.5 - 2) * (0.04),0.15, 0.2];
_wallet ctrlCommit 0;
_wallet ctrlSetBackgroundColor [255, 255, 255, 0.050000];
_wallet ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='0.7' valign='middle' align='center' shadow='0'><br/><t font='OrbitronMedium' size='1.7' color='#ffffff'>%1</t><br/>WALLET</t>", _walletValue]);
_wallet ctrlSetTooltip Format ["%1",ExileClientPlayerMoney];

//create a bank stat
_bankValue = ExileClientBank;
if (_bankValue > 999) then
{
_bankValue = format ["%1k", floor (_bankValue / 1000)];
};
_bank = _display ctrlCreate ["RscStructuredText", 0714, _display displayCtrl 4040];
_bank ctrlSetPosition [(10.5 - 3) * (0.025),(9.5 - 2) * (0.04),0.15, 0.2];
_bank ctrlCommit 0;
_bank ctrlSetBackgroundColor [255, 255, 255, 0.050000];
_bank ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='0.7' valign='middle' align='center' shadow='0'><br/><t font='OrbitronMedium' size='1.7' color='#ffffff'>%1</t><br/>BANK</t>", _bankValue]);
_bank ctrlSetTooltip Format ["%1",ExileClientBank];

//create a shared banking button
_sharedBankingBtn = _display ctrlCreate ["RscExileXM8AppButton1x1", 0712, _display displayCtrl 4040];
_sharedBankingBtn ctrlSetPosition [(17 - 3) * (0.025),(9.5 - 2) * (0.04),0.15, 0.2];
_sharedBankingBtn ctrlCommit 0.01;
_sharedBankingBtn ctrlSetEventHandler ["ButtonClick", "['Not yet implemented. Will come in a later version.', 'Okay :('] call ExileClient_gui_xm8_showWarning;"];
_sharedBankingBtn ctrlSetStructuredText (parseText (format ["Shared Banking"]));

//create a shared banking picture
_sharedBankingPic = _display ctrlCreate ["RscPictureKeepAspect", 0711, _display displayCtrl 4040];
_sharedBankingPic ctrlSetPosition  [(17.5 - 3) * (0.025),(10 - 2) * (0.04),(0.12),(0.12)];
_sharedBankingPic ctrlCommit 0.01;
_sharedBankingPic ctrlSetEventHandler ["ButtonClick", "execVM'xm8Apps\XM8Apps_Init.sqf';"];
_sharedBankingPic ctrlSetText "AdvancedBanking\images\BankLogo.paa";

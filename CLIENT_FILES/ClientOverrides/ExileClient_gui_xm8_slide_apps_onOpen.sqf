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

private["_display","_health","_popTabsValue","_popTabs","_respectValue","_respect", "_serverInfo","_hideCtrls","_hide","_walletValue","_bankValue","_background","_wallet"];
disableSerialization;
_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
_health = _display displayCtrl 4057;
_health ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='1.6' valign='middle' align='center' shadow='0'><br/><br/><br/><t font='OrbitronMedium' size='3.5' color='#ffffff'>%1%2</t><br/>HEALTH</t>", round ((1 - damage player) * 100), "%"]);
_respectValue = ExileClientPlayerScore;
if (_respectValue > 999) then
{
	_respectValue = format ["%1k", floor (_respectValue / 1000)];
};
_respect = _display displayCtrl 4059;
_respect ctrlSetTooltip format["%1", ExileClientPlayerScore];
_respect ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='1.6' valign='middle' align='center' shadow='0'><br/><br/><br/><t font='OrbitronMedium' size='3.5' color='#ffffff'>%1</t><br/>RESPECT</t>", _respectValue]);

//hide the poptabs
_hideCtrls = [4058];
{
_hide = (_display displayCtrl _X);
_hide ctrlSetFade 1;
_hide ctrlCommit 0;
ctrlEnable [_x, false];
} forEach _hideCtrls;


//create a wallet / bank stat
_walletValue = ExileClientPlayerMoney;
_bankValue = ExileClientBank;
if (_walletValue > 999) then
{
_walletValue = format ["%1k", floor (_walletValue / 1000)];
};
if (_bankValue > 999) then
{
_bankValue = format ["%1k", floor (_bankValue / 1000)];
};
_background = _display ctrlCreate ["RscStructuredText", 0714, _display displayCtrl 4040];
_background ctrlSetPosition [(4 - 3) * (0.025), 0.3 ,6*(0.025), 5*(0.04)];
_background ctrlCommit 0;
_background ctrlSetBackgroundColor [255, 255, 255, 0.050000];

_wallet = _display ctrlCreate ["RscStructuredText", 0713, _display displayCtrl 4040];
_wallet ctrlSetPosition [(4 - 3) * (0.025), 0.315 ,6*(0.025), 5*(0.04)];
_wallet ctrlCommit 0;
_wallet ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='0.7' valign='middle' align='center' shadow='0'><t font='OrbitronMedium' size='1.4' color='#ffffff'>%1</t><br/>WALLET<br /><t font='OrbitronMedium' size='1.4' color='#ffffff'>%2</t><br/>BANK</t>", _walletValue,_bankValue]);
_wallet ctrlSetTooltip Format ["Wallet: %1 / Bank: %2",ExileClientPlayerMoney,ExileClientBank];

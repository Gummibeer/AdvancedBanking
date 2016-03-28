/*

 	Name: ExileClient_banking_atm_onTransferBtnClick.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Handles closing of the ATM

*/
disableSerialization;
_display = uiNameSpace getVariable ["AdvBankingATM", displayNull];

if (isNil "TransferSlide") then {
    TransferSlide = false;
};



if (! TransferSlide) then {
    TransferSlide = true;
    _list = (_display displayCtrl 1500);
    _list ctrlSetPosition  [1.075,-0.12,0.562499,1.24];
    _list ctrlCommit 0.25;
    _text = (_display displayCtrl 1111);
    _text ctrlSetPosition [1.1375,1.18,0.449999,0.1];
    _text ctrlCommit 0.25;
    _button = (_display displayCtrl 1611);
    _button ctrlSetPosition [1.1375,1.16,0.449999,0.1];
    _button ctrlCommit 0.25;

    _listBox = _display displayCtrl 1500;
    lbClear _listBox;
    {
    	_index = _listBox lbAdd (name _x);
    	_listBox lbSetData [_index, netId _x];
    	if (_x isEqualTo player) then
    	{
    		_listBox lbSetColor [_index, [0/255, 178/255, 205/255, 1]];
    	}
    	else
    	{
    		if !(alive _x) then
    		{
    			_listBox lbSetColor [_index, [225/255, 65/255, 65/255, 1]];
    		};
    	};
    }
    forEach allPlayers;
lbSort [_listBox, "ASC"];
}
else
{
    TransferSlide = false;
    _list = (_display displayCtrl 1500);
    _list ctrlSetPosition  [1.775,-0.12,0.562499,1.24];
    _list ctrlCommit 0.25;
    _text = (_display displayCtrl 1111);
    _text ctrlSetPosition [1.8375,1.18,0.449999,0.1];
    _text ctrlCommit 0.25;
    _button = (_display displayCtrl 1611);
    _button ctrlSetPosition [1.8375,1.16,0.449999,0.1];
    _button ctrlCommit 0.25;
}

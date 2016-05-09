/*

 	Name: AdvBanking_Client_onATMLoad.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

 	Description:Handles loading of the ATM machine

*/
disableSerialization;
_display = uiNameSpace getVariable ["AdvBankingATM", displayNull];

//Transfer
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [(_ctrlPos select 0)+1.7,_ctrlPos select 1];
    _ctrl ctrlCommit 0;
} forEach [9002,9022,9026,9034,9035,9036,9038,9039,9040,9041,2200,9042,9044];

//Left Side Bar
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [(_ctrlPos select 0)-0.8,_ctrlPos select 1];
    _ctrl ctrlCommit 0;
} forEach [9001,9006,9007,9028,9029,9030,9031,9005,9023,9046,9027,9045,9043];

//Account
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [_ctrlPos select 0,(_ctrlPos select 1)-0.5];
    _ctrl ctrlCommit 0;
} forEach [9014,9021,9032,9033,9075,9076,9077,9078];

//Deposit
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [(_ctrlPos select 0)-1.4,_ctrlPos select 1];
    _ctrl ctrlCommit 0;
} forEach [9004,9008,9010,9012,9019,9024,9047,9015,9016];

//Withdraw
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [(_ctrlPos select 0)+1.1,_ctrlPos select 1];
    _ctrl ctrlCommit 0;
} forEach [9003,9009,9011,9013,9017,9018,9020,9025,9048];

//Advert
_ctrl = _display displayCtrl 9049;
_ctrlPos = ctrlPosition _ctrl;
_ctrl ctrlSetPosition [_ctrlPos select 0,(_ctrlPos select 1)+0.7];
_ctrl ctrlCommit 0;

uiSleep 0.25;
//Set Player Name
(_display displayCtrl 9029) ctrlSetText Format ["%1",toUpper name player];
//Set player Account UID
(_display displayCtrl 9031) ctrlSetText Format ["%1",getPlayerUID player];
_depositInputBox = _display displayCtrl 9008;
ctrlSetFocus _depositInputBox;
(_display displayCtrl 9033) ctrlSetText Format["%1",ExileClientBank];
(_display displayCtrl 9078) ctrlSetText Format["%1",ExileClientPlayerMoney];

_TransferCombo = _display displayCtrl 9036;
lbClear _TransferCombo;
{
    _index = _TransferCombo lbAdd (name _x);
    _TransferCombo lbSetData [_index, netId _x];
    if (_x isEqualTo player) then
    {
        _TransferCombo lbSetColor [_index, [0/255, 178/255, 205/255, 1]];
    }
    else
    {
        if !(alive _x) then
        {
            _TransferCombo lbSetColor [_index, [225/255, 65/255, 65/255, 1]];
        };
    };
}
forEach allPlayers;
lbSort [_TransferCombo, "ASC"];


//Transfer
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [(_ctrlPos select 0)-1.7,_ctrlPos select 1];
    _ctrl ctrlCommit 0.25;
} forEach [9002,9022,9026,9034,9035,9036,9038,9039,9040,9041,2200,9042,9044];

//Left Side Bar
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [(_ctrlPos select 0)+0.8,_ctrlPos select 1];
    _ctrl ctrlCommit 0.25;
} forEach [9001,9006,9007,9028,9029,9030,9031,9005,9023,9046,9027,9045,9043];

//Account
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [_ctrlPos select 0,(_ctrlPos select 1)+0.5];
    _ctrl ctrlCommit 0.25;
} forEach [9014,9021,9032,9033,9075,9076,9077,9078];

//Deposit
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [(_ctrlPos select 0)+1.4,_ctrlPos select 1];
    _ctrl ctrlCommit 0.25;
} forEach [9004,9008,9010,9012,9019,9024,9047,9015,9016];

//Withdraw
{
    _ctrl = _display displayCtrl _x;
    _ctrlPos = ctrlPosition _ctrl;
    _ctrl ctrlSetPosition [(_ctrlPos select 0)-1.1,_ctrlPos select 1];
    _ctrl ctrlCommit 0.25;
} forEach [9003,9009,9011,9013,9017,9018,9020,9025,9048];

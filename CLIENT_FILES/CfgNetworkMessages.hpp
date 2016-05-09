class updateBankStats
{
	module = "banking";
	parameters[] = {"STRING"};
};

class depositRequest
{
	module = "banking";
	parameters[] = {"STRING"};
};

class updateATMResponse
{
	module = "banking";
	parameters[] = {"STRING","STRING"};
};

class updateATMMessage
{
	module = "banking";
	parameters[] = {"SCALAR","STRING","STRING"};
};

class withdrawalRequest
{
	module = "banking";
	parameters[] = {"STRING"};
};

class collectionRequest
{
	module = "banking";
	parameters[] = {"STRING","STRING"};
};

class collectMoneyResponse
{
	module = "banking";
	parameters[] = {"STRING","STRING"};
};
class saleRequest
{
	module = "banking";
	parameters[] = {"STRING","STRING"};
};
class buyRequest
{
	module = "banking";
	parameters[] = {"STRING","STRING"};
};
class updateWalletStats
{
	module = "banking";
	parameters[] = {"STRING"};
};
class youWonTheLottery
{
	module = "banking";
	parameters[] = {"STRING","STRING"};
};

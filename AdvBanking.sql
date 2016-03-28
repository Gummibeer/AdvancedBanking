CREATE TABLE `player_bank` (
  `uid` varchar(32) NOT NULL,
  `playerName` varchar(64) DEFAULT NULL,
  `playerWallet` int(11) NOT NULL DEFAULT '0',
  `playerBank` int(11) NOT NULL DEFAULT '0',
  `hasAccessToUID` varchar(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `player_bank_shared` (
  `uid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `sharedBankAmount` varchar(45) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

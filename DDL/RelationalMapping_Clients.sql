DROP TABLE IF EXISTS Clients;
CREATE REFERENCE TABLE IF NOT EXISTS Clients(
	ID BIGINT PRIMARY KEY AUTO_INCREMENT, # IDENTITY(1, *)
    ClientName VARCHAR(250),
    Description VARCHAR(250) not null,
	IsActive TINYINT default null,
	APIKey VARCHAR(250) default null,
	Derivatives TINYINT default false, 
	HasFullAccess TINYINT default false,
    HourlyPrice TINYINT default false,
	LatestPrice TINYINT default false, 
	NFT TINYINT default false, 
    Websocket TINYINT default false,
	CreateTime DATETIME not null,
    CreateUser VARCHAR(100) not null,
	LastEditTime DATETIME not null,
    LastEditUser VARCHAR(100) not null,
	-- UNIQUE KEY `PRIMARY` (id) USING HASH,
    UNIQUE KEY(ClientName) USING HASH,
    KEY() USING CLUSTERED COLUMNSTORE
);
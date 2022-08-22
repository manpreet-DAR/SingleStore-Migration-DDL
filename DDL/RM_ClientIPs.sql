CREATE TABLE IF NOT EXISTS ClientIPs
(
	ID BIGINT AUTO_INCREMENT, #IDENTITY (*, 1) 
	CallerID VARCHAR(250),
    EmailAddress TEXT default null,
    ClientID BIGINT(11) not null, 
	CreateTime DATETIME not null,
	CreateUser VARCHAR(100) not null,
	LastEditTime DATETIME not null,
	LastEditUser VARCHAR(100) not null,
    SHARD KEY(CallerID),
    KEY(ID) USING CLUSTERED COLUMNSTORE, 
    KEY(ID) USING HASH,
    UNIQUE KEY (CallerID) USING HASH
);
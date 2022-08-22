DROP TABLE IF EXISTS ClientAssets; 
CREATE TABLE IF NOT EXISTS ClientAssets(
	ID BIGINT(11) AUTO_INCREMENT, # IDENTITY(*, 1)
    AssetID BIGINT(16) not null,
	ClientID BIGINT(11) not null, 
	CreateTime DATETIME not null,
	CreateUser VARCHAR(100) null,
	LastEditTime DATETIME not null,
	LastEditUser VARCHAR(100) null,
	ReferenceData TINYINT null,
	Price TINYINT default true,
    KEY(ID) USING CLUSTERED COLUMNSTORE, 
    KEY(ID) USING HASH,
	UNIQUE KEY (AssetID, ClientID) USING HASH,
    SHARD KEY (AssetID, ClientID) 
);
    
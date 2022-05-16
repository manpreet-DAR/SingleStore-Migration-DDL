use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAsset(
_OPERATION VARCHAR(20),
_DARAssetID VARCHAR(20), 
_DARTicker VARCHAR(20), 
_Name VARCHAR(100),
_CreateUser VARCHAR(100),
_LastEditUser VARCHAR(100),
_Id BIGINT(16) DEFAULT 1, 
_AssetType VARCHAR(200) DEFAULT NULL, 
_Description VARCHAR(1500) DEFAULT NULL, 
_Sponsor VARCHAR(255) DEFAULT NULL,
_IsBenchmarkAsset TINYINT DEFAULT NULL, 
_SEDOL VARCHAR(200) DEFAULT NULL, 
_ISIN VARCHAR(200) DEFAULT NULL, 
_CUSIP VARCHAR(200) DEFAULT NULL, 
_DTI VARCHAR(200) DEFAULT NULL, 
_DevelopmentStage VARCHAR(200) DEFAULT NULL, 
_MessariTaxonomySector VARCHAR(500) DEFAULT NULL, 
_MessariTaxonomyCategory VARCHAR(500) DEFAULT NULL, 
_DARSuperSector VARCHAR(200) DEFAULT NULL, 
_DARSuperSectorCode VARCHAR(200) DEFAULT NULL,
_DARSector VARCHAR(200) DEFAULT NULL,
_DARSectorCode VARCHAR(200) DEFAULT NULL, 
_DARSubSector VARCHAR(200) DEFAULT NULL, 
_DARSubSectorCode VARCHAR(200) DEFAULT NULL, 
_DarTaxonomyVersion DECIMAL(11,10) DEFAULT NULL, 
_IssuanceFramework VARCHAR(200) DEFAULT NULL,
_IsRestricted TINYINT DEFAULT NULL, 
_EstimatedCirculatingSupply DECIMAL(16,15) DEFAULT NULL, 
_MaxSupply DECIMAL(18,0) DEFAULT NULL,
_LegacyId INT DEFAULT NULL, 
_LegacyDARAssetId VARCHAR(20) DEFAULT NULL, 
_InstitutionalCustodyAvailable TINYINT DEFAULT NULL, 
_DATSSuperSector VARCHAR(200) DEFAULT NULL, 
_DATSSuperSectorCode VARCHAR(200) DEFAULT NULL, 
_DATSSector VARCHAR(200) DEFAULT NULL,
_DATSSectorCode VARCHAR(200) DEFAULT NULL,
_DATSSubSector VARCHAR(200) DEFAULT NULL, 
_DATSSubSectorCode VARCHAR(200) DEFAULT NULL, 
_DATSTaxonomyVersion DECIMAL(11,10) DEFAULT NULL,
_HasERC20Version TINYINT DEFAULT NULL, 
_HasNYDFSCustoday TINYINT DEFAULT NULL,
_CMC_ID VARCHAR(255) DEFAULT NULL, 
_CG_ID VARCHAR(255) DEFAULT NULL,
_CirculatingSupply DECIMAL(18, 0) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_count2 INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16)= _Id;
        
		BEGIN
        
            SELECT NOW() into v_date;
            SELECT Count(*) FROM Asset WHERE DARAssetID=_DARAssetID or DARTicker=_DARTicker or Name=_Name into v_count;
			SELECT Count(*) FROM Asset WHERE DARAssetID=_DARAssetID and DARTicker=_DARTicker and Name=_Name into v_count2;
			If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then 
					INSERT INTO Asset(DARAssetID , DARTicker, Name , AssetType , IsActive ,CreateUser , LastEditUser , CreateTime , LastEditTime  , Description , Sponsor,IsBenchmarkAsset, SEDOL, ISIN , CUSIP , DTI  , DevelopmentStage , MessariTaxonomySector , MessariTaxonomyCategory , DARSuperSector , DARSuperSectorCode  ,DARSector ,DARSectorCode , DARSubSector , DARSubSectorCode , DarTaxonomyVersion , IssuanceFramework , IsRestricted , EstimatedCirculatingSupply , MaxSupply , LegacyId , LegacyDARAssetId , InstitutionalCustodyAvailable , DATSSuperSector , DATSSuperSectorCode , DATSSector ,DATSSectorCode ,DATSSubSector , DATSSubSectorCode , DATSTaxonomyVersion ,HasERC20Version , HasNYDFSCustoday , CMC_ID , CG_ID, CirculatingSupply ) 
                    Values (_DARAssetID , _DARTicker, _Name , _AssetType , _IsActive ,_CreateUser , _LastEditUser , v_date , v_date  , _Description , _Sponsor, _IsBenchmarkAsset, _SEDOL, _ISIN , _CUSIP , _DTI  , _DevelopmentStage , _MessariTaxonomySector , _MessariTaxonomyCategory , _DARSuperSector , _DARSuperSectorCode  ,_DARSector , _DARSectorCode , _DARSubSector , _DARSubSectorCode , _DarTaxonomyVersion , _IssuanceFramework , _IsRestricted , _EstimatedCirculatingSupply , _MaxSupply , _LegacyId , _LegacyDARAssetId , _InstitutionalCustodyAvailable , _DATSSuperSector , _DATSSuperSectorCode , _DATSSector ,_DATSSectorCode ,_DATSSubSector , _DATSSubSectorCode , _DATSTaxonomyVersion ,_HasERC20Version , _HasNYDFSCustoday , _CMC_ID , _CG_ID, _CirculatingSupply);
					COMMIT;
                    SELECT Id FROM Asset WHERE DARAssetID=_DARAssetID and DARTicker=_DARTicker and Name=_Name into v_id;
                    ECHO SELECT v_id as "ID",_DARAssetID as "DARAssetID",_DARTicker as "DARTicker",_Name as "Name",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Inserted';
                    
				ELSEIF(v_count = 1) Then
					IF (v_count2 =1) Then
						UPDATE Asset SET AssetType=_AssetType , IsActive=_IsActive , LastEditUser=_LastEditUser , LastEditTime=v_date  , Description=_Description , Sponsor=_Sponsor, IsBenchmarkAsset=_IsBenchmarkAsset, SEDOL=_SEDOL, ISIN=_ISIN , CUSIP=_CUSIP , DTI=_DTI  , DevelopmentStage=_DevelopmentStage , MessariTaxonomySector=_MessariTaxonomySector , MessariTaxonomyCategory=_MessariTaxonomyCategory , DARSuperSector=_DARSuperSector , DARSuperSectorCode=_DARSuperSectorCode  ,DARSector=_DARSector ,DARSectorCode=_DARSectorCode , DARSubSector=_DARSubSector , DARSubSectorCode=_DARSubSectorCode , DarTaxonomyVersion=_DarTaxonomyVersion , IssuanceFramework=_IssuanceFramework , IsRestricted=_IsRestricted , EstimatedCirculatingSupply=_EstimatedCirculatingSupply , MaxSupply=_MaxSupply , LegacyId=_LegacyId , LegacyDARAssetId=_LegacyDARAssetId , InstitutionalCustodyAvailable=_InstitutionalCustodyAvailable , DATSSuperSector=_DATSSuperSector , DATSSuperSectorCode=_DATSSuperSectorCode , DATSSector=_DATSSector ,DATSSectorCode=_DATSSectorCode ,DATSSubSector=_DATSSubSector , DATSSubSectorCode=_DATSSubSectorCode , DATSTaxonomyVersion=_DATSTaxonomyVersion ,HasERC20Version=_HasERC20Version , HasNYDFSCustoday=_HasNYDFSCustoday , CMC_ID=_CMC_ID , CG_ID=_CG_ID, CirculatingSupply=_CirculatingSupply  
                        WHERE Id = _Id;
						ECHO SELECT _Id as "ID",_DARAssetID as "DARAssetID",_DARTicker as "DARTicker",_Name as "Name",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Updated';
					ELSE 
                        ECHO SELECT _Id as "ID",_DARAssetID as "DARAssetID",_DARTicker as "DARTicker",_Name as "Name",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Partial combination exist for DARAssetID, DARTicker or Name columns ';
					END IF;
                ELSEIF(v_count > 1) Then
                    ECHO SELECT v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				IF (v_count2=1) Then
					DELETE FROM Asset WHERE Id=_Id;
					COMMIT;
                    ECHO SELECT _Id as "ID",_DARAssetID as "DARAssetID",_DARTicker as "DARTicker",_Name as "Name",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Data Deleted';
				ELSE
					ECHO SELECT _Id as "ID",_DARAssetID as "DARAssetID",_DARTicker as "DARTicker",_Name as "Name",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Partial combination exist for DARAssetID, DARTicker or Name columns';
				END IF;
			END IF;
		Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAddPrice(
_OPERATION VARCHAR(20),
_AssetName VARCHAR(500),
_AssetTicker VARCHAR(500),
_Exchange VARCHAR(500),
_ContractAddress VARCHAR(1000),
_Contact VARCHAR(1000),
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_Id BIGINT(16) DEFAULT 1, 
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_count2 INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
		v_id BIGINT(16)= _Id;

		BEGIN
			SELECT NOW() into v_date;
            SELECT Count(*) FROM  AddPrice WHERE AssetName=_AssetName or AssetTicker=_AssetTicker or Exchange=_Exchange into v_count;
            SELECT Count(*) FROM  AddPrice WHERE AssetName=_AssetName and AssetTicker=_AssetTicker and Exchange=_Exchange into v_count2;
			
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then 
					INSERT INTO  AddPrice(AssetName, AssetTicker, Exchange, ContractAddress, Contact, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_AssetName, _AssetTicker, _Exchange, _ContractAddress, _Contact, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT Id FROM AddPrice WHERE AssetName=_AssetName and AssetTicker=_AssetTicker and Exchange=_Exchange into v_id;
                    ECHO SELECT v_id as "Id", _AssetName as "AssetName",_AssetTicker as "AssetTicker",_Exchange as "Exchange",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Inserted';
   
				ELSEIF(v_count = 1) Then
					
                    IF (v_count2 =1) Then
						UPDATE  AddPrice SET ContractAddress=_ContractAddress, Contact=_Contact, IsActive=_IsActive,LastEditUser=_LastEditUser, LastEditTime=v_date 
                        WHERE Id=_Id;  
						ECHO SELECT _Id as "Id", _AssetName as "AssetName",_AssetTicker as "AssetTicker",_Exchange as "Exchange", v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Updated';
					ELSE 
                        ECHO SELECT _Id as "Id", _AssetName as "AssetName",_AssetTicker as "AssetTicker",_Exchange as "Exchange",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Partial combination exist for AssetName, AssetTicker or Exchange columns ';
						END IF;
				ELSEIF(v_count > 1) Then
					ECHO SELECT v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				IF (v_count2=1) Then
					DELETE FROM  AddPrice WHERE Id=_Id;
					COMMIT;
                    ECHO SELECT  _Id as "Id", _AssetName as "AssetName",_AssetTicker as "AssetTicker",_Exchange as "Exchange",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Data Deleted';
				ELSE
					ECHO SELECT  _Id as "Id", _AssetName as "AssetName",_AssetTicker as "AssetTicker",_Exchange as "Exchange",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Partial combination exist for AssetName, AssetTicker or Exchange columns';
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAppModule(
_OPERATION VARCHAR(20),
_ModuleName VARCHAR(250),
_Description VARCHAR(250),
_Link VARCHAR(250) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_Id BIGINT(16) DEFAULT 1, 
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_count2 INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16)= _Id;
		BEGIN
        
			SELECT NOW() into v_date;
            SELECT Count(*) FROM  AppModule WHERE Link=_Link or ModuleName=_ModuleName into v_count;
            SELECT Count(*) FROM  AppModule WHERE Link=_Link and ModuleName=_ModuleName into v_count2;
	
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then 
					INSERT INTO  AppModule(ModuleName, Description, Link, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_ModuleName, _Description, _Link, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT Id FROM AppModule WHERE Link=_Link and ModuleName=_ModuleName  into v_id;
                    ECHO SELECT v_id as "ID",_ModuleName as "ModuleName",_Link as "Link",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Inserted';
   
				ELSEIF(v_count = 1) Then
					
                    IF (v_count2 =1) Then
						UPDATE  AppModule SET Description=_Description, IsActive=_IsActive,LastEditUser=_LastEditUser, LastEditTime=v_date WHERE ID=_Id;  
						ECHO SELECT v_id as "ID",_ModuleName as "ModuleName",_Link as "Link",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Updated';
					ELSE 
                        ECHO SELECT v_id as "ID",_ModuleName as "ModuleName",_Link as "Link",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Partial combination exist for Link or ModuleName columns ';
						END IF;
				ELSEIF(v_count > 1) Then
					ECHO SELECT v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				IF (v_count2=1) Then
					DELETE FROM  AppModule WHERE ID=_Id;
					COMMIT;
                    ECHO SELECT  v_id as "ID",_ModuleName as "ModuleName",_Link as "Link",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Data Deleted';
				ELSE
					ECHO SELECT  v_id as "ID",_ModuleName as "ModuleName",_Link as "Link",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Partial combination exist for Link or ModuleName columns';
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;



use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAspNetRoles(
_OPERATION VARCHAR(20),
_Id VARCHAR(128),
_Name VARCHAR(256)) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_count2 INT =0;
		BEGIN
            SELECT Count(*) FROM  AspNetRoles WHERE Id=_Id or Name=_Name into v_count;
            SELECT Count(*) FROM  AspNetRoles WHERE Id=_Id and Name=_Name into v_count2;
	
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then 
					INSERT INTO  AspNetRoles(Id, Name)
                    values(_Id, _Name);
					COMMIT;
                    ECHO SELECT _Id as "Id",_Name as "Name",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Inserted';
   
				ELSEIF(v_count = 1) Then
					
                    IF (v_count2 =1) Then
						UPDATE  AspNetRoles SET Name=_Name WHERE Id=_Id;  
						ECHO SELECT _Id as "Id",_Name as "Name",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Updated';
					ELSE 
                        ECHO SELECT _Id as "Id",_Name as "Name",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Partial combination exist for Id or Name columns ';
						END IF;
				ELSEIF(v_count > 1) Then
					ECHO SELECT v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				IF (v_count2=1) Then
					DELETE FROM  AspNetRoles WHERE Id=_Id and Name=_Name;
					COMMIT;
                    ECHO SELECT  _Id as "Id",_Name as "Name",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Data Deleted';
				ELSE
					ECHO SELECT  _Id as "Id",_Name as "Name",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Partial combination exist for RoleId or UserId  columns';
				END IF;
			END IF;
            Return _Id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAspNetUserRoles(
_OPERATION VARCHAR(20),
_UserId VARCHAR(128),
_RoleId VARCHAR(128)) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_count2 INT =0;
        v_del_count1 INT =0;
        v_del_count2 INT =0;
		BEGIN
            SELECT Count(*) FROM  AspNetUserRoles WHERE UserId=_UserId or RoleId=_RoleId into v_count;
            SELECT Count(*) FROM  AspNetUserRoles WHERE UserId=_UserId and RoleId=_RoleId into v_count2;
	
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then 
					INSERT INTO  AspNetUserRoles(UserId, RoleId)
                    values(_UserId, _RoleId);
					COMMIT;
                    ECHO SELECT _UserId as "UserId", _RoleId as "RoleId",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Inserted';
   
				ELSEIF(v_count = 1) Then
					
                    IF (v_count2 =1) Then
						ECHO SELECT _UserId as "UserId", _RoleId as "RoleId",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data cant Update since combination of both the field are primary constraint';
					ELSE 
                        ECHO SELECT _UserId as "UserId", _RoleId as "RoleId",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Partial combination exist for RoleId or UserId columns ';
						END IF;
				ELSEIF(v_count > 1) Then
					ECHO SELECT v_count,v_count2, 'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM  AspNetRoles WHERE Id=_RoleId into v_del_count1;
				SELECT Count(*) FROM  AspNetUsers WHERE Id=_UserId into v_del_count2;

				IF (v_count2=1) Then
					IF(v_del_count1 =0 and v_del_count2 = 0) Then
						DELETE FROM  AspNetUserRoles WHERE UserId=_UserId and RoleId=_RoleId;
						COMMIT;
                        ECHO SELECT  _UserId as "UserId", _RoleId as "RoleId",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Data Deleted';
					ELSE
						If (v_del_count1 !=0 and v_del_count2 !=0) Then
							ECHO SELECT "Foreign Key constraint violet here for Table AspNetUsers field (UserId,Id)  and Table AspNetRoles field (RoleId,Id)";
                        ELSEIF (v_del_count1 !=0) Then
							ECHO SELECT "Foreign Key constraint violet here for Table AspNetRoles field (RoleId,Id)";
                        ELSEIF (v_del_count2 !=0) Then
							ECHO SELECT "Foreign Key constraint violet here for Table AspNetUsers field (UserId,Id)";
                        END IF;
					END IF;
				ELSE
					ECHO SELECT  _UserId as "UserId", _RoleId as "RoleId",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Partial combination exist for RoleId or UserId  columns';
				END IF;
			END IF;
            Return _UserId;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAspNetUsers(
_OPERATION VARCHAR(20),
_Id VARCHAR(128),
_EmailConfirmed TINYINT,
_PhoneNumberConfirmed TINYINT,
_TwoFactorEnabled TINYINT,
_LockoutEnabled TINYINT,
_AccessFailedCount INT,
_UserName VARCHAR(256),
_Email VARCHAR(256) DEFAULT NULL,
_PasswordHash TEXT DEFAULT NULL,
_SecurityStamp TEXT DEFAULT NULL,
_PhoneNumber TEXT DEFAULT NULL,
_LockoutEndDateUtc DATETIME DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_count2 INT =0;
        BEGIN
            SELECT Count(*) FROM  AspNetUsers WHERE Id=_Id or UserName=_UserName into v_count;
            SELECT Count(*) FROM  AspNetUsers WHERE Id=_Id and UserName=_UserName into v_count2;
	
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then 
					INSERT INTO  AspNetUsers(Id, Email, EmailConfirmed, PasswordHash, SecurityStamp, PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEndDateUtc, LockoutEnabled, AccessFailedCount, UserName)
                    values(_Id, _Email, _EmailConfirmed, _PasswordHash, _SecurityStamp, _PhoneNumber, _PhoneNumberConfirmed, _TwoFactorEnabled, _LockoutEndDateUtc, _LockoutEnabled, _AccessFailedCount, _UserName);
					COMMIT;
                    ECHO SELECT _Id as "Id", _UserName as "_UserName",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Inserted';
   
				ELSEIF(v_count = 1) Then
                    IF (v_count2 =1) Then
						UPDATE  AspNetUsers SET Email=_Email , EmailConfirmed=_EmailConfirmed, PasswordHash=_PasswordHash, SecurityStamp=_SecurityStamp, PhoneNumber=_PhoneNumber, PhoneNumberConfirmed=_PhoneNumberConfirmed, TwoFactorEnabled=_TwoFactorEnabled, LockoutEndDateUtc=_LockoutEndDateUtc, LockoutEnabled=_LockoutEnabled, AccessFailedCount=_AccessFailedCount, UserName=_UserName 
                        WHERE Id=_Id;
						ECHO SELECT _Id as "Id", _UserName as "_UserName",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data  Updated';
					ELSE 
                        ECHO SELECT _Id as "Id", _UserName as "_UserName",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Partial combination exist for UserName or Id columns ';
						END IF;
				ELSEIF(v_count > 1) Then
					ECHO SELECT v_count,v_count2, 'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				IF (v_count2=1) Then
					DELETE FROM  AspNetUsers WHERE Id=_Id;
					COMMIT;
					ECHO SELECT  _Id as "Id", _UserName as "_UserName",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Data Deleted';
				ELSE
					ECHO SELECT  _Id as "Id", _UserName as "_UserName",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Partial combination exist for UserName or Id  columns';
				END IF;
			END IF;
            Return _Id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetAvailability(
_OPERATION VARCHAR(20),
_AssetID BIGINT(16) ,
_AvailabilityTypeID BIGINT(16) ,
_CreateUser VARCHAR(100)DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_Id BIGINT(16) DEFAULT 1,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_del_count1 INT =0;
        v_id BIGINT(16) = _Id;
        BEGIN
            SELECT Count(*) FROM  AssetAvailability WHERE Id=_Id into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO  AssetAvailability(AssetID, AvailabilityTypeID, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_AssetID, _AvailabilityTypeID, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT ID FROM AssetAvailability WHERE AssetID=_AssetID and AvailabilityTypeID=_AvailabilityTypeID and CreateUser=_CreateUser and IsActive=_IsActive and CreateTime=v_date and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID", 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE  AssetAvailability SET AssetID=_AssetID , AvailabilityTypeID=_AvailabilityTypeID, IsActive=_IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT v_id as "ID",  'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM  Asset WHERE Id=_AssetID into v_del_count1;
				IF(v_del_count1 =0) Then
					DELETE FROM  AssetAvailability WHERE Id=_Id;
					COMMIT;
					ECHO SELECT  v_id as "ID",  'Data Deleted';
				ELSE
					ECHO SELECT "Foreign Key constraint violet here for Table Asset field (AssetID,Id)";
				END IF;
			END IF;
					
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetCustodian(
_OPERATION VARCHAR(20),
_AssetID BIGINT(16) ,
_CustodianID BIGINT(16),
_CreateUser VARCHAR(100)DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_Id BIGINT(16) DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_del_count1 INT =0;
        v_del_count2 INT =0;
        v_id BIGINT(16) = _Id;
        BEGIN
            SELECT Count(*) FROM  AssetCustodian WHERE AssetID=_AssetID and CustodianID=_CustodianID  into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO  AssetCustodian(AssetID, CustodianID, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_AssetID, _CustodianID, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT ID FROM AssetCustodian WHERE AssetID=_AssetID and CustodianID=_CustodianID into v_id;
                    ECHO SELECT v_id as "ID", 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE  AssetCustodian SET AssetID=_AssetID , CustodianID=_CustodianID, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM  Asset WHERE Id=_AssetID into v_del_count1;
                SELECT Count(*) FROM  Custodian WHERE Id=_CustodianID into v_del_count2;
				IF(v_del_count1 =0 and v_del_count2 ) Then
					DELETE FROM  AssetCustodian WHERE Id=_Id;
					COMMIT;
					ECHO SELECT v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Asset field (AssetID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Custodian field (CustodianID,Id)";

				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;



use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetTheme(
_OPERATION VARCHAR(20),
_AssetID BIGINT(16) ,
_ThemeID BIGINT(16) NOT NULL,
_CreateUser VARCHAR(100)DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_Id BIGINT(16) DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_del_count1 INT =0;
        v_del_count2 INT =0;
        v_id BIGINT(16) =  _Id;
        BEGIN
            SELECT Count(*) FROM  AssetTheme WHERE AssetID=_AssetID and ThemeID=_ThemeID  into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO  AssetTheme(AssetID, ThemeID, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_AssetID, _ThemeID, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT ID FROM AssetTheme WHERE AssetID=_AssetID and ThemeID=_ThemeID into v_id;
                    ECHO SELECT v_id as "ID", 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE  AssetTheme SET AssetID=_AssetID , ThemeID=_ThemeID, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM  Asset WHERE Id=_AssetID into v_del_count1;
                SELECT Count(*) FROM  Theme WHERE Id=_ThemeID into v_del_count2;
				IF(v_del_count1 =0 and v_del_count2=0 ) Then
					DELETE FROM  AssetTheme WHERE Id=_Id;
					COMMIT;
					ECHO SELECT  v_id as "ID",'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Asset field (AssetID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Theme field (ThemeID,Id)";

				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetToken(
_OPERATION VARCHAR(20),
_AssetID BIGINT(16),
_TokenId BIGINT(16),
_BlockChainId BIGINT(16),
_TokenContractAddress VARCHAR(500) DEFAULT NULL,
_CreateUser VARCHAR(100)DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_Id BIGINT(16) DEFAULT 1,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_del_count1 INT =0;
        v_del_count2 INT =0;
        v_del_count3 INT =0;
        v_id BIGINT(16) =  _Id;
        BEGIN
            SELECT Count(*) FROM  AssetToken WHERE AssetID=_AssetID and TokenId=_TokenId and BlockChainId=_BlockChainId   into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO  AssetToken(AssetID, TokenId, BlockChainId, TokenContractAddress, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_AssetID, _TokenId, _BlockChainId, _TokenContractAddress, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT ID FROM AssetToken WHERE AssetID=_AssetID and TokenId=_TokenId and BlockChainId=_BlockChainId into v_id;
                    ECHO SELECT v_id as "ID", 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE  AssetToken SET AssetID=_AssetID , TokenId=_TokenId, BlockChainId=_BlockChainId, TokenContractAddress=_TokenContractAddress, IsActive= _IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM  Asset WHERE Id=_AssetID into v_del_count1;
                SELECT Count(*) FROM  Token WHERE Id=_TokenId into v_del_count2;
                SELECT Count(*) FROM  BlockChain WHERE Id=_BlockChainId into v_del_count3;
				IF(v_del_count1 =0 and v_del_count2  and v_del_count3) Then
					DELETE FROM  AssetToken WHERE Id=_Id;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Asset field (AssetID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Asset field (TokenId,Id)";
				ELSEIF v_del_count3 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Asset field (BlockChainId,Id)";

				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetURL(
_OPERATION VARCHAR(20),
_AssetID BIGINT(16),
_URLTypeID INT,
_URLPath VARCHAR(1500) DEFAULT NULL,
_CreateUser VARCHAR(100)DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_Id BIGINT(16) DEFAULT 1,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_user VARCHAR(100) = CURRENT_USER();
        v_del_count1 INT =0;
        v_id BIGINT(16) =  _Id;
        BEGIN
            SELECT Count(*) FROM  AssetURL WHERE AssetID=_AssetID into v_count;
            SELECT USER() into v_user;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO  AssetURL(AssetID, URLTypeID, URLPath, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_AssetID, _URLTypeID, _URLPath, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT ID FROM AssetURL WHERE AssetID=_AssetID into v_id;
                    ECHO SELECT v_id as 'ID', 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE  AssetURL SET AssetID=_AssetID , URLTypeID=_URLTypeID, URLPath=_URLPath, IsActive= _IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT v_id as 'ID', 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM  Asset WHERE Id=_AssetID into v_del_count1;
                IF(v_del_count1 =0 ) Then
					DELETE FROM  AssetURL WHERE Id=_Id;
					COMMIT;
					ECHO SELECT v_id as 'ID', 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Asset field (AssetID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;



use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetVettingStatus(
_OPERATION VARCHAR(20),
_AssetID BIGINT(16),
_ProcessId BIGINT(16),
_VettingStatusId BIGINT(16),
_IndexStatus INT DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_Id BIGINT(16) DEFAULT 1,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_del_count1 INT =0;
        v_del_count2 INT =0;
        v_del_count3 INT =0;
        v_id BIGINT(16) =  _Id;
        BEGIN
            SELECT Count(*) FROM AssetVettingStatus WHERE AssetID=_AssetID and ProcessId=_ProcessId and VettingStatusId=_VettingStatusId into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO AssetVettingStatus(AssetID, ProcessId, VettingStatusId, IndexStatus, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_AssetID, _ProcessId, _VettingStatusId, _IndexStatus, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT Id FROM AssetVettingStatus WHERE AssetID=_AssetID and ProcessId=_ProcessId and VettingStatusId=_VettingStatusId into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE AssetVettingStatus SET AssetID=_AssetID , ProcessId=_ProcessId, VettingStatusId=_VettingStatusId, IndexStatus=_IndexStatus, IsActive= _IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
            
				SELECT Count(*) FROM Asset WHERE Id=_AssetID into v_del_count1;
                SELECT Count(*) FROM Process WHERE Id=_ProcessId into v_del_count2;
                SELECT Count(*) FROM VettingStatus WHERE Id=_VettingStatusId into v_del_count3;
                
				IF(v_del_count1 =0 and v_del_count2=0  and v_del_count3=0) Then
					DELETE FROM AssetVettingStatus WHERE Id=_Id;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Asset field (AssetID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Process field (ProcessId,Id)";
				ELSEIF v_del_count3 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table VettingStatus field (VettingStatusId,Id)";

				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAvailabilityType(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_APIName VARCHAR(100) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_Id BIGINT(16) DEFAULT 1,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _Id;
        BEGIN
            SELECT Count(*) FROM AvailabilityType WHERE DisplayName=_DisplayName and Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO AvailabilityType(Name, DisplayName, APIName, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_Name, _DisplayName, _APIName, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT Id FROM AvailabilityType WHERE DisplayName=_DisplayName and Name=_Name into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE AvailabilityType SET Name=_Name , DisplayName=_DisplayName, APIName=_APIName, IsActive= _IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
            
				DELETE FROM AvailabilityType WHERE Id=_Id;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
				
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLBlackListedRefId(
_OPERATION VARCHAR(20),
_DARRefId VARCHAR(20)) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        BEGIN
            SELECT Count(*) FROM BlackListedRefId WHERE DARRefId=_DARRefId into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO BlackListedRefId(DARRefId) values(_DARRefId);
					COMMIT;
                    ECHO SELECT _DARRefId as "DARRefId" , 'Data Inserted';
   
				ELSEIF(v_count > 0) Then
					ECHO SELECT  'DARRefId already present!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
            
				DELETE FROM BlackListedRefId WHERE DARRefId=_DARRefId;
				COMMIT;
				ECHO SELECT  _DARRefId as "DARRefId", 'Data Deleted';
				
			END IF;
            Return _DARRefId;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLBlockChain(
_OPERATION VARCHAR(20),
_Id BIGINT(16) DEFAULT 1,
_Name VARCHAR(255) DEFAULT NULL,
_Description VARCHAR(255) DEFAULT NULL,
_ConsensusMechanism VARCHAR(255) DEFAULT NULL,
_HashAlgorithm VARCHAR(255) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _Id;
        BEGIN
            SELECT Count(*) FROM BlockChain WHERE Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO BlockChain(Name, Description, ConsensusMechanism, HashAlgorithm, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_Name, _Description, _ConsensusMechanism, _HashAlgorithm, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT Id FROM BlockChain WHERE Name=_Name into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE BlockChain SET Name=_Name , Description=_Description, ConsensusMechanism=_ConsensusMechanism, HashAlgorithm=_HashAlgorithm, IsActive= _IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
            
				DELETE FROM BlockChain WHERE Id=_Id;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
				
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLClients(
_OPERATION VARCHAR(20),
_ClientName VARCHAR(250),
_Description VARCHAR(250) ,
_Id BIGINT(16) DEFAULT 1,
_CallerID VARCHAR(250) DEFAULT NULL,
_HasFullAccess TINYINT DEFAULT NULL,
_ReferenceData TINYINT DEFAULT NULL,
_Price TINYINT DEFAULT NULL,
_APIKey VARCHAR(250) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _Id;
        BEGIN
            SELECT Count(*) FROM Clients WHERE CallerID=_CallerID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Clients(ClientName, Description, CallerID, HasFullAccess, ReferenceData, Price, APIKey, CreateUser,LastEditUser,IsActive, CreateTime, LastEditTime)
                    values(_ClientName, _Description, _CallerID, _HasFullAccess, _ReferenceData, _Price, _APIKey, _CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT Id FROM Clients WHERE CallerID=_CallerID into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Clients SET ClientName=_ClientName, Description=_Description, CallerID=_CallerID, HasFullAccess=_HasFullAccess, ReferenceData=_ReferenceData, Price=_Price, APIKey=_APIKey, CreateUser=_CreateUser,LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
            
				DELETE FROM Clients WHERE Id=_Id;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
				
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLCustodian(
_OPERATION VARCHAR(20),
_Name VARCHAR(250),
_Id BIGINT(16) DEFAULT 1,
_Description VARCHAR(500) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _Id;
        BEGIN
            SELECT Count(*) FROM Custodian WHERE Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Custodian(Name, Description, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values(_Name, _Description, _CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT Id FROM Custodian WHERE Name=_Name into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Custodian SET Description=_Description,LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
            
				DELETE FROM Custodian WHERE Id=_Id;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
				
			END IF;
            Return v_id;
END //
DELIMITER ;



use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLDerivatives(
_OPERATION VARCHAR(20),
_UnderlierDARAssetID VARCHAR(20),
_ContractType VARCHAR(50),
_ContractTicker VARCHAR(500),
_DARContractID VARCHAR(500),
_ContractExchange VARCHAR(255),
_ContractExchangeDARID VARCHAR(500),
_Status VARCHAR(50),
_TradingHours VARCHAR(10),
_MinimumTickSize DECIMAL(18, 0),
_SettlementTime VARCHAR(700),
_SettlementType VARCHAR(100),
_SettlementCurrency VARCHAR(50),
_ExpirationDate DATETIME,
_ContractSize INT,
_InitialMargin VARCHAR(1000),
_MaintenanceMargin VARCHAR(1000),
_MarkPrice VARCHAR(1000),
_DeliveryPrice VARCHAR(1000),
_FeesURL VARCHAR(200),
_OptionType VARCHAR(50) DEFAULT NULL,
_DeliveryMethod VARCHAR(1000) DEFAULT NULL,
_PositionLimit VARCHAR(1000) DEFAULT NULL,
_PositionLimitURL VARCHAR(200) DEFAULT NULL,
_BlockTradeMinimum VARCHAR(200) DEFAULT NULL,
_LinktoTAndC VARCHAR(100) DEFAULT NULL,
_FundingRates VARCHAR(100) DEFAULT NULL,
_Id BIGINT(16) DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _Id;
        BEGIN
            SELECT Count(*) FROM Derivatives WHERE ContractExchange=_ContractExchange and ContractTicker=_ContractTicker into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Derivatives(UnderlierDARAssetID, ContractType, OptionType,ContractTicker,DARContractID,ContractExchange,ContractExchangeDARID,Status,TradingHours,MinimumTickSize,SettlementTime,SettlementType,SettlementCurrency,ExpirationDate,ContractSize,InitialMargin,MaintenanceMargin,MarkPrice,DeliveryPrice,DeliveryMethod,FeesURL,PositionLimit,PositionLimitURL,BlockTradeMinimum,LinktoTAndC,FundingRates, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values(_UnderlierDARAssetID, _ContractType, _OptionType, _ContractTicker, _DARContractID, _ContractExchange, _ContractExchangeDARID, _Status, _TradingHours, _MinimumTickSize, _SettlementTime,_SettlementType, _SettlementCurrency, _ExpirationDate, _ContractSize, _InitialMargin, _MaintenanceMargin, _MarkPrice, _DeliveryPrice, _DeliveryMethod, _FeesURL, _PositionLimit, _PositionLimitURL, _BlockTradeMinimum, _LinktoTAndC, _FundingRates, _CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT Id FROM Derivatives WHERE ContractExchange=_ContractExchange and ContractTicker=_ContractTicker into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Derivatives SET UnderlierDARAssetID=_UnderlierDARAssetID, ContractType=_ContractType, OptionType=_OptionType,DARContractID=_DARContractID,ContractExchangeDARID=_ContractExchangeDARID,Status=_Status,TradingHours=_TradingHours,MinimumTickSize=_MinimumTickSize,SettlementTime=_SettlementTime,SettlementType=_SettlementType,SettlementCurrency=_SettlementCurrency,ExpirationDate=_ExpirationDate,ContractSize=_ContractSize,InitialMargin=_InitialMargin,MaintenanceMargin=_MaintenanceMargin,MarkPrice=_MarkPrice,DeliveryPrice=_DeliveryPrice,DeliveryMethod=_DeliveryMethod,FeesURL=_FeesURL,PositionLimit=_PositionLimit,PositionLimitURL=_PositionLimitURL,BlockTradeMinimum=_BlockTradeMinimum,LinktoTAndC=_LinktoTAndC,FundingRates=_FundingRates, IsActive=_IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
            
				DELETE FROM Derivatives WHERE Id=_Id;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
				
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLEntityAvailabilityType(
_OPERATION VARCHAR(20),
_AvailabilityTypeID INT,
_EntityID INT,
_Id BIGINT(16) DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _Id;
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
        BEGIN
            SELECT Count(*) FROM EntityAvailabilityType WHERE Id=_Id into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO EntityAvailabilityType(AvailabilityTypeID, EntityID, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values(_AvailabilityTypeID, _EntityID, _CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT Id FROM EntityAvailabilityType WHERE AvailabilityTypeID=_AvailabilityTypeID and EntityID=_EntityID and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE EntityAvailabilityType SET AvailabilityTypeID=_AvailabilityTypeID , EntityID=_EntityID , LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM AvailabilityType WHERE ID=_AvailabilityTypeID into v_del_count1;
                SELECT Count(*) FROM SEntity WHERE Id=_EntityID into v_del_count2;
                
                IF(v_del_count1 =0 and v_del_count2=0 ) Then
					DELETE FROM EntityAvailabilityType WHERE Id=_Id;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table AvailabilityType field (AvailabilityTypeID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntity field (EntityID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLEntityURLType(
_OPERATION VARCHAR(20),
_URLTypeID INT NOT NULL,
_EntityID INT NOT NULL,
_Id BIGINT(16) DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _Id;
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
        BEGIN
            SELECT Count(*) FROM EntityURLType WHERE Id=_Id into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO EntityURLType(URLTypeID, EntityID, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values(_URLTypeID, _EntityID, _CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT Id FROM EntityURLType WHERE URLTypeID=_URLTypeID and EntityID=_EntityID and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE EntityURLType SET URLTypeID=_URLTypeID , EntityID=_EntityID , LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM URLType WHERE ID=_URLTypeID into v_del_count1;
                SELECT Count(*) FROM SEntity WHERE Id=_EntityID into v_del_count2;
                
                IF(v_del_count1 =0 and v_del_count2=0 ) Then
					DELETE FROM EntityURLType WHERE Id=_Id;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table URLType field (URLTypeID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntity field (EntityID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLEvent(
_OPERATION VARCHAR(20),
_EventName VARCHAR(50),
_Id BIGINT(16) DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _Id;
        BEGIN
            SELECT Count(*) FROM Event WHERE Id=_Id into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Event(EventName, CreateUser, CreateTime)
                    values(_EventName, _CreateUser, v_date);
					COMMIT;
                    SELECT Id FROM Event WHERE EventName=_EventName and CreateTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Event SET EventName=_EventName, CreateUser=_CreateUser, CreateTime=v_date WHERE Id=_Id;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				DELETE FROM Event WHERE Id=_Id;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLEventInformation(
_OPERATION VARCHAR(20),
_DAREventID BIGINT(16) DEFAULT 1,
_DateofReview DATETIME DEFAULT NULL,
_EventTypeID INT  DEFAULT NULL,
_AssetID INT DEFAULT NULL,
_SourceID INT DEFAULT NULL,
_ExchangeAssetTicker VARCHAR(20) DEFAULT NULL,
_ExchangeAssetName VARCHAR(100) DEFAULT NULL,
_DARAssetID VARCHAR(50) DEFAULT NULL,
_EventType VARCHAR(100) DEFAULT NULL,
_EventDate DATETIME DEFAULT NULL,
_AnnouncementDate DATETIME  DEFAULT NULL,
_EventDescription VARCHAR(500) DEFAULT NULL,
_SourceURL VARCHAR(500) DEFAULT NULL,
_EventStatus VARCHAR(500) DEFAULT NULL,
_Notes VARCHAR(500) DEFAULT NULL,
_Deleted VARCHAR(500) DEFAULT NULL,
_Exchange VARCHAR(50) DEFAULT NULL,
_BlockHeight INT DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _DAREventID;
        v_del_count1 INT = 0;
        BEGIN
            SELECT Count(*) FROM EventInformation WHERE DAREventID=_DAREventID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO EventInformation( DateofReview,EventTypeID,AssetID,SourceID,ExchangeAssetTicker,ExchangeAssetName,
                    DARAssetID,EventType,EventDate,AnnouncementDate,EventDescription,SourceURL,EventStatus,Notes,Deleted,Exchange,BlockHeight,
                    CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _DateofReview,_EventTypeID,_AssetID,_SourceID,_ExchangeAssetTicker,_ExchangeAssetName,_DARAssetID,
                    _EventType,_EventDate,_AnnouncementDate,_EventDescription,_SourceURL,_EventStatus,_Notes, _Deleted, _Exchange,_BlockHeight,
                    _CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT DAREventID FROM EventInformation WHERE LastEditTime=v_date  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE EventInformation SET DateofReview=_DateofReview,EventTypeID=_EventTypeID,AssetID=_AssetID,SourceID=_SourceID,
                        ExchangeAssetTicker=_ExchangeAssetTicker,ExchangeAssetName=_ExchangeAssetName,DARAssetID=_DARAssetID,EventType=_EventType,EventDate=_EventDate,
                        AnnouncementDate=_AnnouncementDate,EventDescription=_EventDescription,SourceURL=_SourceURL,EventStatus=_EventStatus,Notes=_Notes,Deleted=_Deleted, 
                        Exchange=_Exchange,BlockHeight=_BlockHeight, LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE DAREventID=_DAREventID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM Asset WHERE ID=_AssetID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM EventInformation WHERE DAREventID=_DAREventID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Asset field (AssetID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLEventInformation_Audit(
_OPERATION VARCHAR(20),
_operation1 VARCHAR(15),
_DAREventID VARCHAR(20),
_ChangeID BIGINT(16) DEFAULT 1,
_DateofReview DATETIME DEFAULT NULL,
_EventTypeID INT  DEFAULT NULL,
_AssetID INT DEFAULT NULL,
_SourceID INT DEFAULT NULL,
_ExchangeAssetTicker VARCHAR(20) DEFAULT NULL,
_ExchangeAssetName VARCHAR(100) DEFAULT NULL,
_DARAssetID VARCHAR(50) DEFAULT NULL,
_EventType VARCHAR(100) DEFAULT NULL,
_EventDate DATETIME DEFAULT NULL,
_AnnouncementDate DATETIME  DEFAULT NULL,
_EventDescription VARCHAR(500) DEFAULT NULL,
_SourceURL VARCHAR(500) DEFAULT NULL,
_EventStatus VARCHAR(500) DEFAULT NULL,
_Notes VARCHAR(500) DEFAULT NULL,
_Deleted VARCHAR(500) DEFAULT NULL,
_Exchange VARCHAR(50) DEFAULT NULL,
_BlockHeight INT DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ChangeID;
        
        BEGIN
            SELECT Count(*) FROM EventInformation_Audit WHERE ChangeID=_ChangeID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO EventInformation_Audit( DAREventID,DateofReview,EventTypeID,AssetID,SourceID,ExchangeAssetTicker,ExchangeAssetName,
                    DARAssetID,EventType,EventDate,AnnouncementDate,EventDescription,SourceURL,EventStatus,Notes,Deleted,Exchange,BlockHeight,
                    CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime,operation)
                    values( _DAREventID,_DateofReview,_EventTypeID,_AssetID,_SourceID,_ExchangeAssetTicker,_ExchangeAssetName,_DARAssetID,
                    _EventType,_EventDate,_AnnouncementDate,_EventDescription,_SourceURL,_EventStatus,_Notes, _Deleted, _Exchange,_BlockHeight,
                    _CreateUser,_LastEditUser,_IsActive,v_date, v_date, _operation1);
					COMMIT;
                    SELECT ChangeID FROM EventInformation_Audit WHERE LastEditTime=v_date  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE EventInformation_Audit SET DAREventID=_DAREventID,DateofReview=_DateofReview,EventTypeID=_EventTypeID,AssetID=_AssetID,SourceID=_SourceID,
                        ExchangeAssetTicker=_ExchangeAssetTicker,ExchangeAssetName=_ExchangeAssetName,DARAssetID=_DARAssetID,EventType=_EventType,EventDate=_EventDate,
                        AnnouncementDate=_AnnouncementDate,EventDescription=_EventDescription,SourceURL=_SourceURL,EventStatus=_EventStatus,Notes=_Notes,Deleted=_Deleted, 
                        Exchange=_Exchange,BlockHeight=_BlockHeight, LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date, operation=_operation1 WHERE ChangeID=_ChangeID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                DELETE FROM EventInformation_Audit WHERE ChangeID=_ChangeID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
				
			END IF;
            Return v_id;
END //
DELIMITER ;



use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLExchange(
_OPERATION VARCHAR(20),
_DARExchangeID VARCHAR(20),
_ShortName VARCHAR(100),
_ID BIGINT(16) DEFAULT 1,
_ExchangeType VARCHAR(255) DEFAULT NULL,
_LegacyId TINYINT DEFAULT NULL,
_LegalName VARCHAR(255) DEFAULT NULL,
_LegalNameSource VARCHAR(255) DEFAULT NULL,
_ExchangeTypeSource VARCHAR(500) DEFAULT NULL,
_ExchangeStatus VARCHAR(255) DEFAULT NULL,
_ExternalClassification VARCHAR(255) DEFAULT NULL,
_InternalClassification VARCHAR(255) DEFAULT NULL,
_ClassificationFolder VARCHAR(500) DEFAULT NULL,
_ClassificationDate DATE  DEFAULT NULL,
_ClassificationVersion INT DEFAULT NULL,
_DomicileCountry VARCHAR(255) DEFAULT NULL,
_IncorporationCountry VARCHAR(255) DEFAULT NULL,
_ExchangeSLA VARCHAR(255) DEFAULT NULL,
_FoundingYear INT DEFAULT NULL,
_Ownership VARCHAR(255) DEFAULT NULL,
_LEI VARCHAR(255) DEFAULT NULL,
_Chairman VARCHAR(255) DEFAULT NULL,
_CEO VARCHAR(255) DEFAULT NULL,
_President VARCHAR(255) DEFAULT NULL,
_CTO VARCHAR(255) DEFAULT NULL,
_CISO VARCHAR(255) DEFAULT NULL,
_CCO VARCHAR(255) DEFAULT NULL,
_PrimaryPhone VARCHAR(255) DEFAULT NULL,
_PrimaryEmail VARCHAR(255) DEFAULT NULL,
_SupportURL VARCHAR(500) DEFAULT NULL,
_SupportPhone VARCHAR(255) DEFAULT NULL,
_SupportEmail VARCHAR(255) DEFAULT NULL,
_HQAddress1 VARCHAR(255) DEFAULT NULL,
_HQAddress2 VARCHAR(255) DEFAULT NULL,
_HQCity VARCHAR(255) DEFAULT NULL,
_HQState VARCHAR(255) DEFAULT NULL,
_HQCountry VARCHAR(255) DEFAULT NULL,
_HQPostalCode VARCHAR(255) DEFAULT NULL,
_Licenses VARCHAR(500) DEFAULT NULL,
_Wikipedia VARCHAR(255) DEFAULT NULL,
_MICCode VARCHAR(255) DEFAULT NULL,
_KnownRegulatoryIssues TINYINT DEFAULT NULL,
_TradeMonitoringSystem TINYINT DEFAULT NULL,
_BlockchainSurveillanceSystem TINYINT DEFAULT NULL,
_ThirdPartyAudit TINYINT DEFAULT NULL,
_KnownSecurityIncidences TINYINT DEFAULT NULL,
_InsuranceProviders VARCHAR(500) DEFAULT NULL,
_InsuranceonCryptoAssets TINYINT DEFAULT NULL,
_Wherethebankisdomiciled VARCHAR(255) DEFAULT NULL,
_SelfInsurance TINYINT DEFAULT NULL,
_MandatoryGovtIDPriortoTrading TINYINT DEFAULT NULL,
_TradingLimitExKYC VARCHAR(255) DEFAULT NULL,
_TradingLimitExKYCsource VARCHAR(255) DEFAULT NULL,
_DepositLimitExKYC VARCHAR(255) DEFAULT NULL,
_DepositLimitExKYCsource VARCHAR(255) DEFAULT NULL,
_WithdrawalLimitExKYC VARCHAR(255) DEFAULT NULL,
_WithdrawalLimitExKYCsource VARCHAR(255) DEFAULT NULL,
_KYCReqGovernmentID TINYINT DEFAULT NULL,
_KYCReqDigitalSelfPortrait TINYINT DEFAULT NULL,
_CorporateActionsPolicy VARCHAR(500) DEFAULT NULL,
_PoliciesOnListing VARCHAR(500) DEFAULT NULL,
_FeeSchedule VARCHAR(500) DEFAULT NULL,
_TradingHours VARCHAR(500) DEFAULT NULL,
_Leverage TINYINT DEFAULT NULL,
_Staking TINYINT DEFAULT NULL,
_IEOPlatform TINYINT DEFAULT NULL,
_NativeToken TINYINT DEFAULT NULL,
_ColdStorageCustody TINYINT DEFAULT NULL,
_CustodyInsurance TINYINT DEFAULT NULL,
_PercentOfAssetsinColdStorage INT DEFAULT NULL,
_StablecoinPairs TINYINT DEFAULT NULL,
_FiatTrading TINYINT DEFAULT NULL,
_Futures TINYINT DEFAULT NULL,
_Options TINYINT DEFAULT NULL,
_Swaps TINYINT DEFAULT NULL,
_APIType VARCHAR(255) DEFAULT NULL,
_APIDocumentation VARCHAR(500) DEFAULT NULL,
_PrimaryURL VARCHAR(500) DEFAULT NULL,
_Twitter VARCHAR(500) DEFAULT NULL,
_LinkedIn VARCHAR(500) DEFAULT NULL,
_Reddit VARCHAR(500) DEFAULT NULL,
_Facebook VARCHAR(500) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        
        BEGIN
            SELECT Count(*) FROM Exchange WHERE DARExchangeID=_DARExchangeID or ShortName=_ShortName into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Exchange( DARExchangeID,ShortName ,ExchangeType,LegacyId,LegalName,LegalNameSource,ExchangeTypeSource,ExchangeStatus,
                    ExternalClassification ,InternalClassification,ClassificationFolder,ClassificationDate,ClassificationVersion,DomicileCountry,
                    IncorporationCountry,ExchangeSLA,FoundingYear,Ownership,LEI,Chairman,CEO,President,CTO,CISO,CCO,PrimaryPhone,PrimaryEmail,
                    SupportURL,SupportPhone,SupportEmail,HQAddress1,HQAddress2,HQCity,HQState,HQCountry,HQPostalCode,Licenses,Wikipedia,MICCode,
                    KnownRegulatoryIssues,TradeMonitoringSystem,BlockchainSurveillanceSystem,ThirdPartyAudit,KnownSecurityIncidences,InsuranceProviders,
                    InsuranceonCryptoAssets,Wherethebankisdomiciled,SelfInsurance,MandatoryGovtIDPriortoTrading,TradingLimitExKYC,TradingLimitExKYCsource,
                    DepositLimitExKYC,DepositLimitExKYCsource,WithdrawalLimitExKYC,WithdrawalLimitExKYCsource,KYCReqGovernmentID,KYCReqDigitalSelfPortrait,
                    CorporateActionsPolicy,PoliciesOnListing,FeeSchedule,TradingHours,Leverage,Staking,IEOPlatform,NativeToken,ColdStorageCustody,
                    CustodyInsurance,PercentOfAssetsinColdStorage,StablecoinPairs,FiatTrading,Futures,Options,Swaps,APIType,APIDocumentation,PrimaryURL,
                    Twitter,LinkedIn,Reddit,Facebook,CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _DARExchangeID,_ShortName ,_ExchangeType,_LegacyId,_LegalName,_LegalNameSource,_ExchangeTypeSource,_ExchangeStatus,
                    _ExternalClassification ,_InternalClassification,_ClassificationFolder,_ClassificationDate,_ClassificationVersion,_DomicileCountry,
                    _IncorporationCountry,_ExchangeSLA,_FoundingYear,_Ownership,_LEI,_Chairman,_CEO,_President,_CTO,_CISO,_CCO,_PrimaryPhone,_PrimaryEmail,
                    _SupportURL,_SupportPhone,_SupportEmail,_HQAddress1,_HQAddress2,_HQCity,_HQState,_HQCountry,_HQPostalCode,_Licenses,_Wikipedia,_MICCode,
                    _KnownRegulatoryIssues,_TradeMonitoringSystem,_BlockchainSurveillanceSystem,_ThirdPartyAudit,_KnownSecurityIncidences,_InsuranceProviders,
                    _InsuranceonCryptoAssets,_Wherethebankisdomiciled,_SelfInsurance,_MandatoryGovtIDPriortoTrading,_TradingLimitExKYC,_TradingLimitExKYCsource,
                    _DepositLimitExKYC,_DepositLimitExKYCsource,_WithdrawalLimitExKYC,_WithdrawalLimitExKYCsource,_KYCReqGovernmentID,_KYCReqDigitalSelfPortrait,
                    _CorporateActionsPolicy,_PoliciesOnListing,_FeeSchedule,_TradingHours,_Leverage,_Staking,_IEOPlatform,_NativeToken,_ColdStorageCustody,
                    _CustodyInsurance,_PercentOfAssetsinColdStorage,_StablecoinPairs,_FiatTrading,_Futures,_Options,_Swaps,_APIType,_APIDocumentation,_PrimaryURL,
                    _Twitter,_LinkedIn,_Reddit,_Facebook,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT Id FROM Exchange WHERE DARExchangeID=_DARExchangeID and ShortName=_ShortName  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Exchange SET DARExchangeID=_DARExchangeID,ShortName=_ShortName ,ExchangeType=_ExchangeType,LegacyId=_LegacyId,LegalName=_LegalName,LegalNameSource=_LegalNameSource,
                        ExchangeTypeSource=_ExchangeTypeSource,ExchangeStatus=_ExchangeStatus,ExternalClassification=_ExternalClassification ,InternalClassification=_InternalClassification,
                        ClassificationFolder=_ClassificationFolder,ClassificationDate=_ClassificationDate,ClassificationVersion=_ClassificationVersion,DomicileCountry=_DomicileCountry,
                        IncorporationCountry=_IncorporationCountry,ExchangeSLA=_ExchangeSLA,FoundingYear=_FoundingYear,Ownership=_Ownership,LEI=_LEI,Chairman=_Chairman,CEO=_CEO,President=_President,
                        CTO=_CTO,CISO=_CISO,CCO=_CCO,PrimaryPhone=_PrimaryPhone,PrimaryEmail=_PrimaryEmail,SupportURL=_SupportURL,SupportPhone=_SupportPhone,SupportEmail=_SupportEmail,HQAddress1=_HQAddress1,
                        HQAddress2=_HQAddress2,HQCity=_HQCity,HQState=_HQState,HQCountry=_HQCountry,HQPostalCode=_HQPostalCode,Licenses=_Licenses,Wikipedia=_Wikipedia,MICCode=_MICCode,
                        KnownRegulatoryIssues=_KnownRegulatoryIssues,TradeMonitoringSystem=_TradeMonitoringSystem,BlockchainSurveillanceSystem=_BlockchainSurveillanceSystem,ThirdPartyAudit=_ThirdPartyAudit,
                        KnownSecurityIncidences=_KnownSecurityIncidences,InsuranceProviders=_InsuranceProviders,InsuranceonCryptoAssets=_InsuranceonCryptoAssets,Wherethebankisdomiciled=_Wherethebankisdomiciled,SelfInsurance=_SelfInsurance,
                        MandatoryGovtIDPriortoTrading=_MandatoryGovtIDPriortoTrading,TradingLimitExKYC=_TradingLimitExKYC,TradingLimitExKYCsource=_TradingLimitExKYCsource,DepositLimitExKYC=_DepositLimitExKYC,
                        DepositLimitExKYCsource=_DepositLimitExKYCsource,WithdrawalLimitExKYC=_WithdrawalLimitExKYC,WithdrawalLimitExKYCsource=_WithdrawalLimitExKYCsource,KYCReqGovernmentID=_KYCReqGovernmentID,
                        KYCReqDigitalSelfPortrait=_KYCReqDigitalSelfPortrait,CorporateActionsPolicy=_CorporateActionsPolicy,PoliciesOnListing=_PoliciesOnListing,FeeSchedule=_FeeSchedule,TradingHours=_TradingHours,
                        Leverage=_Leverage,Staking=_Staking,IEOPlatform=_IEOPlatform,NativeToken=_NativeToken,ColdStorageCustody=_ColdStorageCustody,CustodyInsurance=_CustodyInsurance,PercentOfAssetsinColdStorage=_PercentOfAssetsinColdStorage,
                        StablecoinPairs=_StablecoinPairs,FiatTrading=_FiatTrading,Futures=_Futures,Options=_Options,Swaps=_Swaps,APIType=_APIType,APIDocumentation=_APIDocumentation,PrimaryURL=_PrimaryURL,
                        Twitter=_Twitter,LinkedIn=_LinkedIn,Reddit=_Reddit,Facebook=_Facebook, LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                DELETE FROM Exchange WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
				
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLExchangeAvailability(
_OPERATION VARCHAR(20),
_ExchangeID BIGINT(16),
_AvailabilityTypeID BIGINT(16),
_ID BIGINT(16) DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT = 0;
        BEGIN
            SELECT Count(*) FROM ExchangeAvailability WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO ExchangeAvailability( ExchangeID,AvailabilityTypeID,CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _ExchangeID,_AvailabilityTypeID,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM ExchangeAvailability WHERE LastEditTime=v_date  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE ExchangeAvailability SET ExchangeID=_ExchangeID, AvailabilityTypeID=_AvailabilityTypeID,
                        LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM Exchange WHERE ID=_ExchangeID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM ExchangeAvailability WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Exchange field (ExchangeID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLExchangePair(
_OPERATION VARCHAR(20),
_PairID BIGINT(16),
_ExchangeID BIGINT(16),
_ExchangePairName VARCHAR(20),
_ID BIGINT(16) DEFAULT 1,
_ExchangePairNumberId INT DEFAULT NULL,
_ExchangePairStringId VARCHAR(200) DEFAULT NULL,
_ExchangePairShortName VARCHAR(200) DEFAULT NULL,
_ExchangePairLongName VARCHAR(255) DEFAULT NULL,
_ExchangeAssetStringId VARCHAR(200) DEFAULT NULL,
_ExchangeAssetNumberId INT DEFAULT NULL,
_ExchangeAssetShortName VARCHAR(200) DEFAULT NULL,
_ExchangeAssetLongName VARCHAR(255) DEFAULT NULL,
_ExchangeCurrencyStringId VARCHAR(200) DEFAULT NULL,
_ExchangeCurrencyNumberId INT DEFAULT NULL,
_ExchangeCurrencyShortName VARCHAR(200) DEFAULT NULL,
_ExchangeCurrencyLongName VARCHAR(255) DEFAULT NULL,
_IsAvailable TINYINT DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
        BEGIN
            SELECT Count(*) FROM ExchangePair WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO ExchangePair( PairID,ExchangeID,ExchangePairName,ExchangePairNumberId,ExchangePairStringId,ExchangePairShortName,ExchangeAssetLongName,
                    ExchangeCurrencyStringId,ExchangeCurrencyNumberId,ExchangeCurrencyShortName,ExchangeCurrencyLongName,CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _PairID,_ExchangeID,_ExchangePairName,_ExchangePairNumberId,_ExchangePairStringId,_ExchangePairShortName,_ExchangeAssetLongName,
                    _ExchangeCurrencyStringId,_ExchangeCurrencyNumberId,_ExchangeCurrencyShortName,_ExchangeCurrencyLongName,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM ExchangePair WHERE LastEditTime=v_date  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE ExchangePair SET PairID=_PairID,ExchangeID=_ExchangeID,ExchangePairName=_ExchangePairName,ExchangePairNumberId=_ExchangePairNumberId,ExchangePairStringId=_ExchangePairStringId,
                        ExchangePairShortName=_ExchangePairShortName,ExchangeAssetLongName=_ExchangeAssetLongName,ExchangeCurrencyStringId=_ExchangeCurrencyStringId,ExchangeCurrencyNumberId=_ExchangeCurrencyNumberId,
                        ExchangeCurrencyShortName=_ExchangeCurrencyShortName,ExchangeCurrencyLongName=_ExchangeCurrencyLongName,LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM Exchange WHERE ID=_ExchangeID into v_del_count1;
                SELECT Count(*) FROM Pair WHERE ID=_PairID into v_del_count2;

                
                IF(v_del_count1 =0 and v_del_count2=0) Then
					DELETE FROM ExchangePair WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Exchange field (ExchangeID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Pair field (PairID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLExchangeRowCount(
_OPERATION VARCHAR(20),
_ExchangeName VARCHAR(20),
_ExchangeRowCount INT,
_ID BIGINT(16) DEFAULT 0
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        
        BEGIN
            SELECT Count(*) FROM ExchangeRowCount WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO ExchangeRowCount( ExchangeName,ExchangeRowCount,CreateDate)
                    values( _ExchangeName,_ExchangeRowCount, v_date);
					COMMIT;
                    SELECT ID FROM ExchangeRowCount WHERE CreateDate=v_date  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE ExchangeRowCount SET ExchangeName=_ExchangeName,ExchangeRowCount=_ExchangeRowCount WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
				DELETE FROM ExchangeRowCount WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLExchangeURL(
_OPERATION VARCHAR(20),
_ExchangeID BIGINT(16) ,
_URLTypeID BIGINT(16) ,
_URLPath VARCHAR(250) ,
_ID BIGINT(16) DEFAULT 1,
_IsAvailable TINYINT DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM ExchangeURL WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO ExchangeURL( ExchangeID,URLTypeID,URLPath, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _ExchangeID,_URLTypeID,_URLPath,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM ExchangeURL WHERE LastEditTime=v_date  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE ExchangeURL SET ExchangeID=_ExchangeID,URLTypeID=_URLTypeID,URLPath=_URLPath,
                        LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM Exchange WHERE ID=_ExchangeID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM ExchangeURL WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Exchange field (ExchangeID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLExchangeVettingStatus(
_OPERATION VARCHAR(20),
_ProcessId INT ,
_ExchangeId INT,
_VettingStatusId INT,
_ID BIGINT(16) DEFAULT 1,
_IsAvailable TINYINT DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
        v_del_count3 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM ExchangeVettingStatus WHERE ProcessId=_ProcessId and ExchangeId=_ExchangeId and VettingStatusId=_VettingStatusId into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO ExchangeVettingStatus( ExchangeId, ProcessId,VettingStatusId, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _ExchangeId,_ProcessId,_VettingStatusId,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM ExchangeVettingStatus WHERE ProcessId=_ProcessId and ExchangeId = _ExchangeId and VettingStatusId=_VettingStatusId  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE ExchangeVettingStatus SET LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM Exchange WHERE ID=_ExchangeId into v_del_count1;
                SELECT Count(*) FROM Process WHERE ID=_ProcessId into v_del_count2;
                SELECT Count(*) FROM VettingStatus WHERE ID=_VettingStatusId into v_del_count3;
                
                IF(v_del_count1 =0 and v_del_count2 =0 and v_del_count3 =0) Then
					DELETE FROM ExchangeVettingStatus WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Exchange field (ExchangeID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Process field (ProcessId,Id)";
				ELSEIF v_del_count3 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table VettingStatus field (VettingStatusId,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


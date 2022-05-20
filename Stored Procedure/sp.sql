use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAsset(
_OPERATION VARCHAR(20),
_DARAssetID VARCHAR(20), 
_DARTicker VARCHAR(20), 
_Name VARCHAR(100),
_CreateUser VARCHAR(100),
_LastEditUser VARCHAR(100),
_ID BIGINT(16) DEFAULT 0, 
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
_ID BIGINT(16) DEFAULT 0, 
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
_ID BIGINT(16) DEFAULT 0, 
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
_ExchangeType VARCHAR(255) DEFAULT NULL,
_LegacyId INT DEFAULT NULL,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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
_ID BIGINT(16) DEFAULT 0,
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



use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLListing(
_OPERATION VARCHAR(20),
_AssetID INT,
_ExchangeID INT,
_ExchangeAssetTicker VARCHAR(20),
_ExchangeAssetName VARCHAR(100),
_ID BIGINT(16) DEFAULT 0,
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
            SELECT Count(*) FROM Listing WHERE AssetID=_AssetID and ExchangeID=_ExchangeID and ExchangeAssetTicker=_ExchangeAssetTicker into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Listing( AssetID, ExchangeID,ExchangeAssetTicker,ExchangeAssetName, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _AssetID,_ExchangeID,_ExchangeAssetTicker,_ExchangeAssetName,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM Listing WHERE AssetID=_AssetID and ExchangeID=_ExchangeID and ExchangeAssetTicker=_ExchangeAssetTicker  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Listing SET LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM Asset WHERE ID=_AssetID into v_del_count1;
                SELECT Count(*) FROM Exchange WHERE ID=_ExchangeID into v_del_count2;
                
                IF(v_del_count1 =0 and v_del_count2 =0) Then
					DELETE FROM Listing WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Asset field (AssetID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Exchange field (ExchangeID,Id)";
				
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLLog4NetLog(
_OPERATION VARCHAR(20),
_Date DATETIME,
_Thread VARCHAR(255),
_Level VARCHAR(50),
_Logger VARCHAR(255),
_Message VARCHAR(4000),
_ID BIGINT(16) DEFAULT 0,
_Exception VARCHAR(2000) DEFAULT NULL)RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM Log4NetLog WHERE ID=_ID into v_count;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Log4NetLog( Date,Thread, Level,Logger,Message, Exception)
                    values( _Date,_Thread, _Level,_Logger,_Message, _Exception);
					COMMIT;
                    SELECT ID FROM Log4NetLog WHERE Date=_Date and Thread=_Thread and Level=_Level and Logger=_Logger and Message=_Message into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Log4NetLog SET Date=_Date, Thread=_Thread, Level=_Level, Logger=_Logger, Message=_Message , Exception=_Exception WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                DELETE FROM Log4NetLog WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLOutstandingSupply(
_OPERATION VARCHAR(20),
_OutstandingSupply DECIMAL(18, 0),
_AssetID BIGINT(16),
_ProcessID BIGINT(16),
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1,
_Reviewed TINYINT DEFAULT NULL)RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_id BIGINT(16) =  _ID;
        v_date DATETIME = CURRENT_TIMESTAMP();
       
        BEGIN
            SELECT Count(*) FROM OutstandingSupply WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO OutstandingSupply( OutstandingSupply, AssetID, ProcessID, CollectedTimeStamp, IsActive, Reviewed)
                    values( _OutstandingSupply,_AssetID, _ProcessID,v_date,_IsActive, _Reviewed);
					COMMIT;
                    SELECT ID FROM OutstandingSupply WHERE OutstandingSupply=_OutstandingSupply and AssetID=_AssetID and ProcessID=_ProcessID and CollectedTimeStamp=v_date and IsActive=_IsActive into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE OutstandingSupply SET OutstandingSupply=_OutstandingSupply, AssetID=_AssetID, ProcessID=_ProcessID, CollectedTimeStamp=v_date, IsActive=_IsActive , Reviewed=_Reviewed WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                DELETE FROM OutstandingSupply WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLPair(
_OPERATION VARCHAR(20),
_AssetID INT,
_QuoteAssetID INT,
_DARName VARCHAR(20),
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_id BIGINT(16) =  _ID;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM Pair WHERE DARName=_DARName into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Pair( AssetID, QuoteAssetID, DARName, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _AssetID,_QuoteAssetID, _DARName,_CreateUser,_LastEditUser,_IsActive, v_date, v_date);
					COMMIT;
                    SELECT ID FROM Pair WHERE DARName=_DARName into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Pair SET AssetID=_AssetID, QuoteAssetID=_QuoteAssetID, LastEditUser=_LastEditUser, LastEditTime=v_date, IsActive=_IsActive WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM Asset WHERE ID=_AssetID into v_del_count1;
                SELECT Count(*) FROM Asset WHERE ID=_QuoteAssetID into v_del_count2;
				
                IF(v_del_count1 = 0 and v_del_count2 =0) Then
					DELETE FROM Pair WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Asset field (AssetID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Asset field (QuoteAssetID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLProcess(
_OPERATION VARCHAR(20),
_Name VARCHAR(255),
_Description VARCHAR(500),
_ID BIGINT(16) DEFAULT 0,
_Lookback INT DEFAULT NULL,
_Frequency INT DEFAULT NULL,
_LookbackUnit VARCHAR(20) DEFAULT NULL,
_FrequencyUnit VARCHAR(20) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_id BIGINT(16) =  _ID;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM Process WHERE Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Process( Name, Description, Lookback, Frequency, LookbackUnit, FrequencyUnit, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _Name, _Description, _Lookback, _Frequency, _LookbackUnit, _FrequencyUnit, _CreateUser, _LastEditUser, _IsActive, v_date, v_date);
					COMMIT;
                    SELECT ID FROM Process WHERE Name=_Name into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Process SET Description=_Description, Lookback=_Lookback, Frequency=_Frequency, LookbackUnit=_LookbackUnit, FrequencyUnit=_FrequencyUnit , LastEditUser=_LastEditUser, LastEditTime=v_date, IsActive=_IsActive WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				DELETE FROM Process WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLRoleAppModule(
_OPERATION VARCHAR(20),
_AppModuleId INT,
_RoleId VARCHAR(128),
_ID BIGINT(16) DEFAULT 0,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_id BIGINT(16) =  _ID;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM RoleAppModule WHERE AppModuleId=_AppModuleId and RoleId=_RoleId into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO RoleAppModule( AppModuleId, RoleId, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _AppModuleId,_RoleId, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT ID FROM RoleAppModule WHERE AppModuleId=_AppModuleId and RoleId=_RoleId into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE RoleAppModule SET LastEditUser=_LastEditUser, LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			
            SELECT Count(*) FROM AppModule WHERE ID=_AppModuleId into v_del_count1;
			SELECT Count(*) FROM RoleAppModule WHERE ID=_RoleId into v_del_count2;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				IF(v_del_count1 = 0 and v_del_count2 =0) Then
					DELETE FROM RoleAppModule WHERE ID=_ID;
					COMMIT;
                    ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table AppModule field (AppModuleId,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table RoleAppModule field (RoleId,Id)";
				END IF;
				
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSDataType(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250) ,
_ID BIGINT(16) DEFAULT 0,
_Description VARCHAR(250) DEFAULT NULL,
_ParentTypeID INT DEFAULT NULL,
_SqlDataType VARCHAR(100) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM SDataType WHERE DisplayName=_DisplayName or Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SDataType( Name,DisplayName,Description,ParentTypeID,SqlDataType, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _Name,_DisplayName,_Description,_ParentTypeID,_SqlDataType,_CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SDataType WHERE DisplayName=_DisplayName and Name=_Name into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SDataType SET Description=_Description,ParentTypeID=_ParentTypeID,SqlDataType=_SqlDataType,
                        LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM SDataType WHERE ID=_ ParentTypeID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM SDataType WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SDataType field (ParentTypeID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSEntity(
_OPERATION VARCHAR(20),
_CategoryID INT,
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_ID BIGINT(16) DEFAULT 0,
_Description VARCHAR(250) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM SEntity WHERE DisplayName=_DisplayName or Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SEntity( CategoryID,Name,DisplayName,Description, CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values( _CategoryID,_Name,_DisplayName,_Description, _CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SEntity WHERE DisplayName=_DisplayName and Name=_Name into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SEntity SET CategoryID=_CategoryID,Name=_Name,DisplayName=_DisplayName,Description=_Description, IsActive=_IsActive,
                        LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM SEntityCategory WHERE ID=_CategoryID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM SEntity WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntityCategory field (CategoryID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSEntityAttribute(
_OPERATION VARCHAR(20),
_EntityID INT,
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_DataTypeID INT,
_ID BIGINT(16) DEFAULT 0,
_EnumerationID INT DEFAULT NULL,
_Description VARCHAR(250) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
        v_del_count3 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM SEntityAttribute WHERE (EntityID=_EntityID and DisplayName=_DisplayName )or (EntityID=_EntityID and Name=_Name) into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SEntityAttribute( EntityID,Name,DisplayName,DataTypeID,EnumerationID,Description, CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values( _EntityID,_Name,_DisplayName,_DataTypeID,_EnumerationID, _Description,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SEntityAttribute WHERE (EntityID=_EntityID and DisplayName=_DisplayName )or (EntityID=_EntityID and Name=_Name) into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SEntityAttribute SET EntityID=_EntityID,Name=_Name,DisplayName=_DisplayName,DataTypeID=_DataTypeID,EnumerationID=_EnumerationID,
                        Description=_Description, IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM SDataType WHERE ID=_DataTypeID into v_del_count1;
                SELECT Count(*) FROM SEntity WHERE ID=_EntityID into v_del_count2;
                SELECT Count(*) FROM SEnumeration WHERE ID=_EnumerationID into v_del_count3;
                
                IF(v_del_count1 =0 and  v_del_count2 =0 and v_del_count3 =0 ) Then
					DELETE FROM SEntityAttribute WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SDataType field (DataTypeID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntity field (EntityID,Id)";
				ELSEIF v_del_count3 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEnumeration field (EnumerationID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSEntityCategory(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_ID BIGINT(16) DEFAULT 0,
_Description VARCHAR(250) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM SEntityCategory WHERE Name=_Name and DisplayName=_DisplayName  into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SEntityCategory( Name,DisplayName,Description, CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values( _Name,_DisplayName, _Description,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SEntityCategory WHERE Name=_Name and DisplayName=_DisplayName into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SEntityCategory SET Name=_Name,DisplayName=_DisplayName, Description=_Description, IsActive=_IsActive,
                        LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                DELETE FROM SEntityCategory WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSEnumeration(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_ID BIGINT(16) DEFAULT 0,
_LookupName VARCHAR(100) DEFAULT NULL,
_Description VARCHAR(250) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_IsSystem TINYINT DEFAULT 0,
_IsPublic TINYINT DEFAULT 0,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM SEnumeration WHERE Name=_Name and DisplayName=_DisplayName  into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SEnumeration( Name, DisplayName, Description, IsSystem, IsPublic, LookupName, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _Name,_DisplayName, _Description,_IsSystem,_IsPublic,_LookupName,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SEnumeration WHERE Name=_Name and DisplayName=_DisplayName into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SEnumeration SET Name=_Name,DisplayName=_DisplayName, Description=_Description,IsSystem=_IsSystem, IsPublic=_IsPublic, LookupName=_LookupName,
                        IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                DELETE FROM SEnumeration WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSEnumerationValue(
_OPERATION VARCHAR(20),
_EnumerationID INT,
_ValueID INT,
_SortOrder INT,
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM SEnumerationValue WHERE (Name=_Name and EnumerationID=_EnumerationID) or 
            (DisplayName=_DisplayName and EnumerationID=_EnumerationID) or 
            (SortOrder=_SortOrder and EnumerationID=_EnumerationID) or
            (ValueID=_ValueID and EnumerationID=_EnumerationID) into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SEnumerationValue( Name, DisplayName, EnumerationID, ValueID, SortOrder, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _Name,_DisplayName, _EnumerationID,_ValueID,_SortOrder,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SEnumerationValue WHERE (Name=_Name and EnumerationID=_EnumerationID) or 
            (DisplayName=_DisplayName and EnumerationID=_EnumerationID) or 
            (SortOrder=_SortOrder and EnumerationID=_EnumerationID) or
            (ValueID=_ValueID and EnumerationID=_EnumerationID)into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SEnumerationValue SET Name=_Name,DisplayName=_DisplayName, EnumerationID=_EnumerationID,ValueID=_ValueID, SortOrder=_SortOrder,
                        IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM SEnumeration WHERE ID=_EnumerationID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM SEnumerationValue WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEnumeration field (EnumerationID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLServingList(
_OPERATION VARCHAR(20),
_ProcessID INT,
_Start DATETIME,
_ID BIGINT(16) DEFAULT 0,
_End DATETIME DEFAULT NULL,
_PairID INT DEFAULT NULL,
_SourceID INT DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM ServingList WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO ServingList( ProcessID, Start, End, PairID, SourceID, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _ProcessID, _Start, _End, _PairID, _SourceID,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM ServingList WHERE ProcessID=_ProcessID and Start=_Start into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE ServingList SET ProcessID=_ProcessID,Start=_Start, End=_End,PairID=_PairID, SourceID=_SourceID,
                        IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM Pair WHERE ID=_PairID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM ServingList WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Pair field (PairID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLServingListSnapshot(
_OPERATION VARCHAR(20),
_SnapshotName VARCHAR(500),
_SnapshotVersion INT,
_ProcessName VARCHAR(255),
_PairName VARCHAR(20),
_ID BIGINT(16) DEFAULT 0,
_ProcessId INT DEFAULT NULL,
_PairId INT DEFAULT NULL,
_AssetName VARCHAR(100) DEFAULT NULL,
_AssetId INT DEFAULT NULL,
_Exchange VARCHAR(100) DEFAULT NULL,
_ExchangeId INT DEFAULT NULL,
_ExchangePairName VARCHAR(20) DEFAULT NULL,
_AssetTicker VARCHAR(20) DEFAULT NULL,
_ExchangeVettingStatus VARCHAR(200) DEFAULT NULL,
_ExchangeVettingStatusCode INT DEFAULT NULL,
_AssetTierDescription VARCHAR(200) DEFAULT NULL,
_AssetTierCode INT DEFAULT NULL,
_Start DATETIME DEFAULT NULL,
_End DATETIME DEFAULT NULL,
_AssetLegacyId VARCHAR(20) DEFAULT NULL,
_AssetLegacyDARAssetId VARCHAR(20) DEFAULT NULL,
_ExchangeLegacyId VARCHAR(20) DEFAULT NULL,
_Lookback INT DEFAULT NULL,
_LookbackUnit VARCHAR(20) DEFAULT NULL,
_Frequency INT DEFAULT NULL,
_FrequencyUnit VARCHAR(20) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM ServingListSnapshot WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO ServingListSnapshot( SnapshotName,SnapshotVersion,ProcessName, PairName,ProcessId,PairId,AssetName,
                    AssetId, Exchange,ExchangeId, ExchangePairName, AssetTicker,ExchangeVettingStatus, ExchangeVettingStatusCode,
                    AssetTierDescription, AssetTierCode, Start, End, AssetLegacyId, AssetLegacyDARAssetId, ExchangeLegacyId, Lookback,
                    LookbackUnit,Frequency, FrequencyUnit,CreateUser, IsActive, CreateTime)
                    values( _SnapshotName,_SnapshotVersion,_ProcessName,_PairName,_ProcessId,_PairId, _AssetName,_AssetId,_Exchange,
                    _ExchangeId,_ExchangePairName,_AssetTicker,_ExchangeVettingStatus, _ExchangeVettingStatusCode,_AssetTierDescription,
                    _AssetTierCode,_Start, _End, _AssetLegacyId, _AssetLegacyDARAssetId, _ExchangeLegacyId, _Lookback, _LookbackUnit,
                    _Frequency,_FrequencyUnit, _CreateUser,_IsActive,v_date);
					COMMIT;
                    SELECT ID FROM ServingListSnapshot WHERE SnapshotName=_SnapshotName and SnapshotVersion=_SnapshotVersion 
                    and ProcessName=_ProcessName and PairName=_PairName into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE ServingListSnapshot SET SnapshotName=_SnapshotName , SnapshotVersion=_SnapshotVersion,
                        ProcessName=_ProcessName , PairName=_PairName , ProcessId=_ProcessId , PairId=_PairId ,AssetName=_AssetName,
                        AssetId=_AssetId, Exchange=_Exchange, ExchangeId=_ExchangeId, ExchangePairName=_ExchangePairName, AssetTicker=_AssetTicker,
                        ExchangeVettingStatus=_ExchangeVettingStatus,AssetTierDescription=_AssetTierDescription, AssetTierCode=_AssetTierCode,
                        Start=_Start,End=_End, AssetLegacyId=_AssetLegacyId, AssetLegacyDARAssetId=_AssetLegacyDARAssetId, ExchangeLegacyId=_ExchangeLegacyId,
                        Lookback=_Lookback, LookbackUnit=_LookbackUnit, Frequency=_Frequency, FrequencyUnit=_FrequencyUnit, CreateUser=_CreateUser WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                
				DELETE FROM ServingListSnapshot WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSIdentifierType(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_ID BIGINT(16) DEFAULT 0,
_IsKey TINYINT DEFAULT 0,
_IsUnique TINYINT DEFAULT 0,
_IsNatural TINYINT DEFAULT 0,
_IsGrouped TINYINT DEFAULT 0,
_Description VARCHAR(250) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM SIdentifierType WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SIdentifierType( Name, DisplayName, IsKey, IsUnique, IsNatural,IsGrouped, Description, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _Name, _DisplayName, _IsKey, _IsUnique, _IsNatural,_IsGrouped,_Description, _CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SIdentifierType WHERE Name=_Name and DisplayName=_DisplayName and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SIdentifierType SET DisplayName=_DisplayName,Name=_Name, IsKey=_IsKey,IsUnique=_IsUnique, IsNatural=_IsNatural,IsGrouped=_IsGrouped, Description=_Description,
                        LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
               
				DELETE FROM SIdentifierType WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSource(
_OPERATION VARCHAR(20),
_DARSourceID VARCHAR(20),
_ShortName VARCHAR(255),
_SourceType VARCHAR(255),
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM Source WHERE DARSourceID=_DARSourceID or  ShortName=_ShortName into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Source( DARSourceID, ShortName, SourceType, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _DARSourceID, _ShortName, _SourceType, _IsActive, _CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM Source WHERE DARSourceID=_DARSourceID and  ShortName=_ShortName and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Source SET DARSourceID=_DARSourceID,ShortName=_ShortName, SourceType=_SourceType,IsActive=_IsActive,
                        LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
               
				DELETE FROM Source WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSSchemaVersion(
_OPERATION VARCHAR(20),
_Major INT ,
_Minor INT ,
_EffectiveStart DATE ,
_ID BIGINT(16) DEFAULT 0,
_Name VARCHAR(100)  DEFAULT NULL,
_DisplayName VARCHAR(250) DEFAULT NULL,
_EffectiveEnd DATE DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM SSchemaVersion WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SSchemaVersion( Name, DisplayName, Major, Minor,EffectiveStart,EffectiveEnd, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _Name, _DisplayName, _Major, _Minor,_EffectiveStart,_EffectiveEnd, _IsActive, _CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SSchemaVersion WHERE Major=_Major and  Minor=_Minor and EffectiveStart=_EffectiveStart  and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SSchemaVersion SET Name=_Name,DisplayName=_DisplayName, Major=_Major,Minor=_Minor,EffectiveStart=_EffectiveStart,EffectiveEnd=_EffectiveEnd,
                        IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
               
				DELETE FROM SSchemaVersion WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSSharedColumn(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_DataTypeID INT,
_SortOrder INT,
_VersionID INT,
_ID BIGINT(16) DEFAULT 0,
_IsRequired TINYINT DEFAULT 0,
_IsSystem TINYINT DEFAULT 0,
_IsDisplay TINYINT DEFAULT 0,
_IsPrecedingSort TINYINT DEFAULT 0,
_DefaultExpression VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM SSharedColumn WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SSharedColumn( Name, DisplayName, DataTypeID, SortOrder,IsRequired,IsSystem,IsDisplay,IsPrecedingSort,DefaultExpression,VersionID, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _Name, _DisplayName, _DataTypeID, _SortOrder,_IsRequired,_IsSystem,_IsDisplay,_IsPrecedingSort,_DefaultExpression,_VersionID, _IsActive, _CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SSharedColumn WHERE Name=_Name and  DisplayName=_DisplayName and DataTypeID=_DataTypeID and SortOrder=_SortOrder and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SSharedColumn SET Name=_Name,DisplayName=_DisplayName, DataTypeID=_DataTypeID,SortOrder=_SortOrder,IsRequired=_IsRequired,IsSystem=_IsSystem,IsDisplay=_IsDisplay, IsPrecedingSort=_IsPrecedingSort,
                        DefaultExpression=_DefaultExpression, VersionID=_VersionID ,IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM SSchemaVersion WHERE ID=_VersionID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM SSharedColumn WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SSchemaVersion field (VersionID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSTable(
_OPERATION VARCHAR(20),
_TypeID INT ,
_EntityID INT,
_VersionID INT,
_ID BIGINT(16) DEFAULT 0,
_IsLookup TINYINT DEFAULT 0,
_Name VARCHAR(100) DEFAULT NULL,
_DisplayName VARCHAR(250) DEFAULT NULL,
_GenOrder INT DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM STable WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO STable( TypeID, EntityID, Name, DisplayName, GenOrder,IsLookup,VersionID, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _TypeID, _EntityID, _Name, _DisplayName,_GenOrder,_IsLookup,_VersionID,_IsActive, _CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM STable WHERE TypeID=_TypeID and  EntityID=_EntityID and VersionID=_VersionID and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE STable SET Name=_Name,DisplayName=_DisplayName,TypeID=_TypeID,EntityID=_EntityID,GenOrder=_GenOrder,IsLookup=_IsLookup,VersionID=_VersionID, IsActive=_IsActive,
                        LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM SSchemaVersion WHERE ID=_VersionID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM STable WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SSchemaVersion field (VersionID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSTableJoin(
_OPERATION VARCHAR(20),
_FromColumnID INT,
_ToColumnID INT,
_JoinTypeID INT,
_JoinDirectionID INT,
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM STableJoin WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO STableJoin( FromColumnID,ToColumnID,JoinTypeID,JoinDirectionID,CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values( _FromColumnID,_ToColumnID,_JoinTypeID,_JoinDirectionID,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM STableJoin WHERE FromColumnID=_FromColumnID and ToColumnID=_ToColumnID and JoinTypeID=_JoinTypeID and JoinDirectionID=_JoinDirectionID and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE STableJoin SET FromColumnID=_FromColumnID,ToColumnID=_ToColumnID,JoinTypeID=_JoinTypeID,JoinDirectionID=_JoinDirectionID,
						IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM STableJoinDirection WHERE ID=_JoinDirectionID into v_del_count1;
                SELECT Count(*) FROM STableJoinType WHERE ID=_JoinTypeID into v_del_count2;
                 
                IF(v_del_count1 =0 and  v_del_count2 =0 ) Then
					DELETE FROM STableJoin WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table STableJoinDirection field (JoinDirectionID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntity field (JoinTypeID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSTableJoinDirection(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_ID BIGINT(16) DEFAULT 0,
_SqlKeyword VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM STableJoinDirection WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO STableJoinDirection( Name,DisplayName,SqlKeyword,CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values( _Name,_DisplayName,_SqlKeyword,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM STableJoinDirection WHERE Name=_Name and DisplayName=_DisplayName and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE STableJoinDirection SET Name=_Name,DisplayName=_DisplayName,SqlKeyword=_SqlKeyword,
						IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
            
				DELETE FROM STableJoinDirection WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
                
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSTableType(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_ID BIGINT(16) DEFAULT 0,
_Description VARCHAR(250) DEFAULT NULL,
_NamePrefix VARCHAR(10) DEFAULT NULL,
_OverrideDataTypeID INT DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM STableType WHERE DisplayName=_DisplayName and Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO STableType( Name,DisplayName,Description,NamePrefix, OverrideDataTypeID,CreateUser, LastEditUser,CreateTime, LastEditTime)
                    values( _Name,_DisplayName,_Description,_NamePrefix,_OverrideDataTypeID,_CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM STableType WHERE Name=_Name and DisplayName=_DisplayName and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE STableType SET Name=_Name,DisplayName=_DisplayName,Description=_Description,NamePrefix=_NamePrefix,OverrideDataTypeID=_OverrideDataTypeID,
						LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM SDataType WHERE ID=_OverrideDataTypeID into v_del_count1;
                
                IF(v_del_count1 =0) Then
					DELETE FROM STableType WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
                ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SDataType field (_OverrideDataTypeID,Id)";
				END IF;    
				
                
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStage_CollectedListing(
_OPERATION VARCHAR(20),
_CollectionSourceID INT,
_ExchangeAssetTicker VARCHAR(100),
_ID BIGINT(16) DEFAULT 0,
_ExchangeAssetName VARCHAR(250) DEFAULT NULL,
_ValidationTime DATETIME DEFAULT NULL,
_TickerMatch TINYINT DEFAULT NULL,
_NameMatch TINYINT DEFAULT NULL,
_ListingTickerMatch TINYINT DEFAULT NULL,
_ListingNameMatch TINYINT DEFAULT NULL,
_AssetID INT DEFAULT NULL,
_ListingID INT DEFAULT NULL,
_MatchesPrevious TINYINT DEFAULT NULL,
_ExcludeDuplicate TINYINT  DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM Stage_CollectedListing WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Stage_CollectedListing( CollectionSourceID, ExchangeAssetTicker, ExchangeAssetName, ValidationTime, TickerMatch,NameMatch,ListingTickerMatch, ListingNameMatch, AssetID, 
                    ListingID,MatchesPrevious,ExcludeDuplicate, CreateTime)
                    values( _CollectionSourceID, _ExchangeAssetTicker, _ExchangeAssetName, _ValidationTime,_TickerMatch,_NameMatch,_ListingTickerMatch,_ListingNameMatch, _AssetID,
                    _ListingID,_MatchesPrevious,_ExcludeDuplicate,v_date);
					COMMIT;
                    SELECT ID FROM Stage_CollectedListing WHERE CollectionSourceID=_CollectionSourceID and  ExchangeAssetTicker=_ExchangeAssetTicker and CreateTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Stage_CollectedListing SET CollectionSourceID=_CollectionSourceID, ExchangeAssetTicker=_ExchangeAssetTicker ,ExchangeAssetName=_ExchangeAssetName ,ValidationTime=_ValidationTime,
                        TickerMatch=_TickerMatch,NameMatch=_NameMatch,ListingTickerMatch=_ListingTickerMatch, ListingNameMatch=_ListingNameMatch, AssetID=_AssetID, ListingID=_ListingID, MatchesPrevious=_MatchesPrevious,
                        ExcludeDuplicate=_ExcludeDuplicate WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
                        
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM Stage_CollectionSource WHERE ID=_CollectionSourceID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM Stage_CollectedListing WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Stage_CollectionSource field (CollectionSourceID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStage_CollectionBatch(
_OPERATION VARCHAR(20),
_CollectionBatchTypeID INT,
_EffectiveDate DATE,
_StartTime DATETIME ,
_ID BIGINT(16) DEFAULT 0,
_EndTime DATETIME DEFAULT NULL,
_FailureMessage VARCHAR(250) DEFAULT NULL,
_PreviousBatchID INT DEFAULT NULL,
_CollectionValidationID INT DEFAULT NULL,
_MatchesPrevious TINYINT DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM Stage_CollectionBatch WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Stage_CollectionBatch( CollectionBatchTypeID, EffectiveDate, StartTime, EndTime, FailureMessage,PreviousBatchID,CollectionValidationID, MatchesPrevious, CreateTime)
                    values( _CollectionBatchTypeID, _EffectiveDate, _StartTime, _EndTime,_FailureMessage,_PreviousBatchID,_CollectionValidationID,_MatchesPrevious, v_date);
					COMMIT;
                    SELECT ID FROM Stage_CollectionBatch WHERE CollectionBatchTypeID=_CollectionBatchTypeID and  EffectiveDate=_EffectiveDate and StartTime=_StartTime and CreateTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Stage_CollectionBatch SET CollectionBatchTypeID=_CollectionBatchTypeID, EffectiveDate=_EffectiveDate ,StartTime=_StartTime ,EndTime=_EndTime,
                        FailureMessage=_FailureMessage,PreviousBatchID=_PreviousBatchID,CollectionValidationID=_CollectionValidationID, MatchesPrevious=_MatchesPrevious WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
                        
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM Stage_CollectionBatchType WHERE ID= _CollectionBatchTypeID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM Stage_CollectionBatch WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Stage_CollectionBatchType field (CollectionBatchTypeID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStage_CollectionBatchType(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_CollectedEntityID INT ,
_CollectionKeyAttributeID INT ,
_TargetEntityID INT ,
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
        v_del_count2 int =0;
        v_del_count3 int =0;
       
        BEGIN
            SELECT Count(*) FROM Stage_CollectionBatchType WHERE Name=_Name or ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Stage_CollectionBatchType( Name,CollectedEntityID,CollectionKeyAttributeID,TargetEntityID,  IsActive,CreateTime)
                    values( _Name,_CollectedEntityID,_CollectionKeyAttributeID,_TargetEntityID,_IsActive,v_date);
					COMMIT;
                    SELECT ID FROM Stage_CollectionBatchType WHERE Name=_Name and CreateTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Stage_CollectionBatchType SET CollectedEntityID=_CollectedEntityID,CollectionKeyAttributeID=_CollectionKeyAttributeID, TargetEntityID=_TargetEntityID,
						IsActive=_IsActive WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM SEntity WHERE ID=_CollectedEntityID into v_del_count1;
                SELECT Count(*) FROM SEntity WHERE ID=_TargetEntityID into v_del_count2;
                SELECT Count(*) FROM SEntityAttribute WHERE ID=_CollectionKeyAttributeID into v_del_count3;
                
                IF(v_del_count1 =0 and v_del_count2=0 and v_del_count3=0) Then
					DELETE FROM Stage_CollectionBatchType WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntity field (CollectedEntityID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntity field (TargetEntityID,Id)";
				ELSEIF v_del_count3 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntityAttribute field (CollectionKeyAttributeID,Id)";
				END IF;
                
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStage_CollectionSource(
_OPERATION VARCHAR(20),
_CollectionBatchID INT,
_EntityKey VARCHAR(100),
_CollectionMethod INT,
_StagingMethod INT,
_CollectedTime DATETIME,
_ID BIGINT(16) DEFAULT 0,
_PathLog VARCHAR(500) DEFAULT NULL,
_ValidationTime DATETIME DEFAULT NULL,
_MatchesPrevious TINYINT DEFAULT NULL,
_UseInValidation TINYINT DEFAULT NULL,
_EntityDbID INT DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM Stage_CollectionSource WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Stage_CollectionSource( CollectionBatchID, EntityKey, CollectionMethod,StagingMethod,CollectedTime, PathLog, ValidationTime,MatchesPrevious,UseInValidation, EntityDbID, CreateTime)
                    values( _CollectionBatchID, _EntityKey, _CollectionMethod,_StagingMethod,_CollectedTime, _PathLog,_ValidationTime,_MatchesPrevious,_UseInValidation,_EntityDbID, v_date);
					COMMIT;
                    SELECT ID FROM Stage_CollectionSource WHERE CollectionBatchID=_CollectionBatchID and  EntityKey=_EntityKey and CollectionMethod=_CollectionMethod and StagingMethod=_StagingMethod and CollectedTime=_CollectedTime and CreateTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Stage_CollectionSource SET CollectionBatchID=_CollectionBatchID, EntityKey=_EntityKey ,CollectionMethod=_CollectionMethod  ,StagingMethod=_StagingMethod ,CollectedTime=_CollectedTime
                        ,PathLog=_PathLog,ValidationTime=_ValidationTime,MatchesPrevious=_MatchesPrevious, UseInValidation=_UseInValidation, EntityDbID=_EntityDbID WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
                        
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM Stage_CollectionSource WHERE ID= _CollectionBatchID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM Stage_CollectionSource WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Stage_CollectionSource field (CollectionBatchID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStage_CollectionValidation(
_OPERATION VARCHAR(20),
_StartTime DATETIME,
_ID BIGINT(16) DEFAULT 0,
_CollectionBatchID INT DEFAULT NULL,
_EndTime DATETIME DEFAULT NULL,
_Success TINYINT DEFAULT NULL,
_ValidationResponse VARCHAR(500) DEFAULT NULL

) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM Stage_CollectionValidation WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Stage_CollectionValidation( StartTime, CollectionBatchID,EndTime,Success,ValidationResponse, CreateTime)
                    values( _StartTime, _CollectionBatchID, _EndTime,_Success,_ValidationResponse, v_date);
					COMMIT;
                    SELECT ID FROM Stage_CollectionValidation WHERE StartTime=_StartTime and  CreateTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Stage_CollectionValidation SET StartTime=_StartTime, CollectionBatchID=_CollectionBatchID ,EndTime=_EndTime  ,Success=_Success ,ValidationResponse=_ValidationResponse
                        WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
                        
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM Stage_CollectionBatch WHERE ID= _CollectionBatchID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM Stage_CollectionValidation WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Stage_CollectionBatch field (CollectionBatchID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStaging_CryptoNodeEvents(
_OPERATION VARCHAR(20),
_DateofReview DATETIME,
_ExchangeAssetTicker VARCHAR(100),
_ID BIGINT(16) DEFAULT 0,
_ExchangeAssetName VARCHAR(250) DEFAULT NULL,
_DARAssetID VARCHAR(50) DEFAULT NULL,
_EventType VARCHAR(100) DEFAULT NULL,
_EventDate DATETIME DEFAULT NULL,
_AnnouncementDate DATETIME DEFAULT NULL,
_EventDescription VARCHAR(500) DEFAULT NULL,
_SourceURL VARCHAR(500) DEFAULT NULL,
_EventStatus VARCHAR(500) DEFAULT NULL,
_Notes VARCHAR(500) DEFAULT NULL,
_Deleted VARCHAR(500) DEFAULT NULL,
_Exchange VARCHAR(50) DEFAULT NULL,
_ValidationTime DATETIME DEFAULT NULL,
_AssetID INT DEFAULT NULL,
_SourceID INT DEFAULT NULL,
_EventTypeID INT DEFAULT NULL,
_BlockHeight INT DEFAULT NULL,
_Error VARCHAR(500) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
        v_del_count2 int =0;
        v_del_count3 int =0;
       
        BEGIN
            SELECT Count(*) FROM Staging_CryptoNodeEvents WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Staging_CryptoNodeEvents( DateofReview,ExchangeAssetTicker,ExchangeAssetName,EventType,EventDate,AnnouncementDate,EventDescription,SourceURL,EventStatus,Notes,Deleted,Exchange,ValidationTime,AssetID,SourceID,EventTypeID,BlockHeight,Error,CreateTime)
                    values( _DateofReview,_ExchangeAssetTicker,_ExchangeAssetName,_EventType,_EventDate,_AnnouncementDate,_EventDescription,_SourceURL,_EventStatus,_Notes,_Deleted,_Exchange,_ValidationTime,_AssetID,_SourceID,_EventTypeID,_BlockHeight,_Error,v_date);
					COMMIT;
                    SELECT ID FROM Staging_CryptoNodeEvents WHERE DateofReview=_DateofReview and ExchangeAssetTicker=_ExchangeAssetTicker  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Staging_CryptoNodeEvents SET DateofReview=_DateofReview, ExchangeAssetTicker=_ExchangeAssetTicker, ExchangeAssetName=_ExchangeAssetName,EventType=_EventType,EventDate=_EventDate,AnnouncementDate=_AnnouncementDate,
						EventDescription=_EventDescription, SourceURL=_SourceURL, EventStatus=_EventStatus, Notes=_Notes, Deleted=_Deleted, Exchange=_Exchange, ValidationTime=_ValidationTime, AssetID=_AssetID, SourceID=_SourceID, EventTypeID=_EventTypeID, 
                        BlockHeight=_BlockHeight,Error=_Error WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM Asset WHERE ID=_AssetID into v_del_count1;
                SELECT Count(*) FROM Source WHERE ID=_SourceID into v_del_count2;
                SELECT Count(*) FROM Event WHERE ID=_EventTypeID into v_del_count3;
                
                IF(v_del_count1 =0 and v_del_count2=0 and v_del_count3=0) Then
					DELETE FROM Staging_CryptoNodeEvents WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Asset field (AssetID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Source field (SourceID,Id)";
				ELSEIF v_del_count3 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Event field (EventTypeID,Id)";
				END IF;
                
			END IF;
            Return v_id;
END //
DELIMITER ;


use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStaging_OutstandingSupply(
_OPERATION VARCHAR(20),
_SourceId INT,
_AssetID INT,
_ProcessID INT,
_OutstandingSupply DECIMAL(18, 0),
_ID BIGINT(16) DEFAULT 0,
_Error VARCHAR(500) DEFAULT NULL,
_PassedValidation TINYINT DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_Reviewed TINYINT DEFAULT NULL,
_OutstandingSupplyReviewed DECIMAL(18, 0) DEFAULT NULL,
_BaseDataAvailable TINYINT DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM Staging_OutstandingSupply WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Staging_OutstandingSupply( SourceId, AssetID,ProcessID,OutstandingSupply,Error,CollectedTimeStamp, PassedValidation,IsActive,Reviewed,OutstandingSupplyReviewed,BaseDataAvailable)
                    values( _SourceId, _AssetID, _ProcessID,_OutstandingSupply,_Error,v_date, _PassedValidation,_IsActive, _Reviewed,_OutstandingSupplyReviewed,_BaseDataAvailable);
					COMMIT;
                    SELECT ID FROM Staging_OutstandingSupply WHERE SourceId=_SourceId and  AssetID=_AssetID and ProcessID=_ProcessID and OutstandingSupply=_OutstandingSupply and CollectedTimeStamp=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Staging_OutstandingSupply SET SourceId=_SourceId, AssetID=_AssetID ,ProcessID=_ProcessID  ,OutstandingSupply=_OutstandingSupply ,Error=_Error,PassedValidation=_PassedValidation,IsActive=_IsActive,
                        Reviewed=_Reviewed, OutstandingSupplyReviewed=_OutstandingSupplyReviewed, BaseDataAvailable=_BaseDataAvailable WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
                        
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM Staging_OutstandingSupply WHERE ID= _AssetID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM Staging_OutstandingSupply WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Staging_OutstandingSupply field (AssetID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLTheme(
_OPERATION VARCHAR(20),
_Name VARCHAR(250),
_ThemeType VARCHAR(100),
_ID BIGINT(16) DEFAULT 0,
_Description VARCHAR(500) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM Theme WHERE Name=_Name or ThemeType=_ThemeType into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Theme(Name,Description,ThemeType,CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values(_Name,_Description,_ThemeType,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM Theme WHERE Name=_Name and ThemeType=_ThemeType and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
					UPDATE Theme SET Name=_Name, Description=_Description ,ThemeType=_ThemeType, IsActive=_IsActive, LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
					ECHO SELECT  v_id as "ID", 'Data  Updated';
                    
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				DELETE FROM Theme WHERE ID=_ID;
				COMMIT;
                ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
            
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLURLType(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_ID BIGINT(16) DEFAULT 0,
_APIName VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM URLType WHERE Name=_Name and DisplayName=_DisplayName  and ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO URLType(Name,DisplayName,APIName,CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values(_Name,_DisplayName,_APIName,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM URLType WHERE Name=_Name and DisplayName=_DisplayName and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
					UPDATE URLType SET Name=_Name, DisplayName=_DisplayName ,APIName=_APIName, IsActive=_IsActive, LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
					ECHO SELECT  v_id as "ID", 'Data  Updated';
                    
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				DELETE FROM URLType WHERE ID=_ID;
				COMMIT;
                ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
            
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLToken(
_OPERATION VARCHAR(20),
_DARTokenID VARCHAR(20),
_TokenName VARCHAR(255),
_ID BIGINT(16) DEFAULT 0,
_TokenDescription VARCHAR(1500) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM Token WHERE DARTokenID=_DARTokenID and TokenName=_TokenName  and ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Token(DARTokenID,TokenName,TokenDescription,CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values(_DARTokenID,_TokenName,_TokenDescription,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM Token WHERE DARTokenID=_DARTokenID and TokenName=_TokenName and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
					UPDATE Token SET DARTokenID=_DARTokenID, TokenName=_TokenName ,TokenDescription=_TokenDescription, IsActive=_IsActive, LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
					ECHO SELECT  v_id as "ID", 'Data  Updated';
                    
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				DELETE FROM Token WHERE ID=_ID;
				COMMIT;
                ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
            
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLVettingStatus(
_OPERATION VARCHAR(20),
_StatusCode INT,
_StatusDescription VARCHAR(200),
_StatusType VARCHAR(200),
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM VettingStatus WHERE StatusDescription=_StatusDescription and ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO VettingStatus(StatusCode,StatusDescription,StatusType,CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values(_StatusCode,_StatusDescription,_StatusType,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM VettingStatus WHERE StatusDescription=_StatusDescription and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
					UPDATE VettingStatus SET StatusCode=_StatusCode, StatusDescription=_StatusDescription ,StatusType=_StatusType, IsActive=_IsActive, LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
					ECHO SELECT  v_id as "ID", 'Data  Updated';
                    
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				DELETE FROM VettingStatus WHERE ID=_ID;
				COMMIT;
                ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
            
END //
DELIMITER ;

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
	v_date DATETIME;
	v_id BIGINT(16)= _ID;
        
BEGIN

	SELECT NOW() INTO v_date;
	SELECT Count(*) FROM Asset WHERE DARAssetID=_DARAssetID or DARTicker=_DARTicker or Name=_Name INTO v_count;
	If (UPPER(_OPERATION) = "UPSERT") Then
		IF(v_count = 0) Then 
			INSERT INTO Asset(DARAssetID , DARTicker, Name , AssetType , IsActive ,CreateUser , LastEditUser , CreateTime , LastEditTime  , Description , Sponsor,IsBenchmarkAsset, SEDOL, ISIN , CUSIP , DTI  , DevelopmentStage , MessariTaxonomySector , MessariTaxonomyCategory , DARSuperSector , DARSuperSectorCode  ,DARSector ,DARSectorCode , DARSubSector , DARSubSectorCode , DarTaxonomyVersion , IssuanceFramework , IsRestricted , EstimatedCirculatingSupply , MaxSupply , LegacyId , LegacyDARAssetId , InstitutionalCustodyAvailable , DATSSuperSector , DATSSuperSectorCode , DATSSector ,DATSSectorCode ,DATSSubSector , DATSSubSectorCode , DATSTaxonomyVersion ,HasERC20Version , HasNYDFSCustoday , CMC_ID , CG_ID, CirculatingSupply ) 
			Values (_DARAssetID , _DARTicker, _Name , _AssetType , _IsActive ,_CreateUser , _LastEditUser , v_date , v_date  , _Description , _Sponsor, _IsBenchmarkAsset, _SEDOL, _ISIN , _CUSIP , _DTI  , _DevelopmentStage , _MessariTaxonomySector , _MessariTaxonomyCategory , _DARSuperSector , _DARSuperSectorCode  ,_DARSector , _DARSectorCode , _DARSubSector , _DARSubSectorCode , _DarTaxonomyVersion , _IssuanceFramework , _IsRestricted , _EstimatedCirculatingSupply , _MaxSupply , _LegacyId , _LegacyDARAssetId , _InstitutionalCustodyAvailable , _DATSSuperSector , _DATSSuperSectorCode , _DATSSector ,_DATSSectorCode ,_DATSSubSector , _DATSSubSectorCode , _DATSTaxonomyVersion ,_HasERC20Version , _HasNYDFSCustoday , _CMC_ID , _CG_ID, _CirculatingSupply);
			COMMIT;
			SELECT Id FROM Asset WHERE DARAssetID=_DARAssetID and DARTicker=_DARTicker and Name=_Name into v_id;
			ECHO SELECT v_id as "ID",_DARAssetID as "DARAssetID",_DARTicker as "DARTicker",_Name as "Name", "Insert" AS msg; 
			
		ELSE
			DECLARE
				qry QUERY(v VARCHAR(128) NOT NULL) = SELECT ID
						FROM Asset
						WHERE DARAssetID=_DARAssetID 
                        AND DARTicker=_DARTicker 
                        AND Name=_Name;
				uid VARCHAR(128);
			BEGIN
				uid = SCALAR(qry);
				UPDATE Asset SET AssetType=_AssetType , IsActive=_IsActive , LastEditUser=_LastEditUser , LastEditTime=v_date  , Description=_Description , Sponsor=_Sponsor, IsBenchmarkAsset=_IsBenchmarkAsset, SEDOL=_SEDOL, ISIN=_ISIN , CUSIP=_CUSIP , DTI=_DTI  , DevelopmentStage=_DevelopmentStage , MessariTaxonomySector=_MessariTaxonomySector , MessariTaxonomyCategory=_MessariTaxonomyCategory , DARSuperSector=_DARSuperSector , DARSuperSectorCode=_DARSuperSectorCode  ,DARSector=_DARSector ,DARSectorCode=_DARSectorCode , DARSubSector=_DARSubSector , DARSubSectorCode=_DARSubSectorCode , DarTaxonomyVersion=_DarTaxonomyVersion , IssuanceFramework=_IssuanceFramework , IsRestricted=_IsRestricted , EstimatedCirculatingSupply=_EstimatedCirculatingSupply , MaxSupply=_MaxSupply , LegacyId=_LegacyId , LegacyDARAssetId=_LegacyDARAssetId , InstitutionalCustodyAvailable=_InstitutionalCustodyAvailable , DATSSuperSector=_DATSSuperSector , DATSSuperSectorCode=_DATSSuperSectorCode , DATSSector=_DATSSector ,DATSSectorCode=_DATSSectorCode ,DATSSubSector=_DATSSubSector , DATSSubSectorCode=_DATSSubSectorCode , DATSTaxonomyVersion=_DATSTaxonomyVersion ,HasERC20Version=_HasERC20Version , HasNYDFSCustoday=_HasNYDFSCustoday , CMC_ID=_CMC_ID , CG_ID=_CG_ID, CirculatingSupply=_CirculatingSupply  
				WHERE Id = uid;
				ECHO SELECT _ID as "ID",_DARAssetID as "DARAssetID",_DARTicker as "DARTicker",_Name as "Name", "Update" AS msg;
			END;
		END IF;
	END IF;
Return v_id;
END //
DELIMITER ;

use refmaster_internal;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAsset(
_Operation VARCHAR(20), 
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
_IsActive TINYINT DEFAULT 1,
_GovernanceToken VARCHAR(20) default null, 
_LayerOne VARCHAR(20) default null) RETURNS text AS
DECLARE 
	idcount_query QUERY(a INT) = SELECT COUNT(*)
		FROM refmaster_internal_DEV.Asset
		WHERE DARAssetID=_DARAssetID OR DARTicker=_DARTicker OR Name=_Name;
	id_count INT = 0; 
	v_date DATETIME;
	output TEXT = CONCAT(current_timestamp(), ", method: ", (_Operation), ", message: "); 
	v_id BIGINT(16); 
        
BEGIN
	SELECT NOW() INTO v_date;
    id_count = SCALAR(idcount_query);
	IF id_count = 0 THEN
		START TRANSACTION;
		INSERT INTO refmaster_internal_DEV.Asset(DARAssetID , DARTicker, Name , AssetType , IsActive ,CreateUser , LastEditUser , CreateTime , LastEditTime  , Description , Sponsor, IsBenchmarkAsset, GovernanceToken, LayerOne, SEDOL, ISIN , CUSIP , DTI  , DevelopmentStage , MessariTaxonomySector , MessariTaxonomyCategory , DARSuperSector , DARSuperSectorCode  ,DARSector ,DARSectorCode , DARSubSector , DARSubSectorCode , DarTaxonomyVersion , IssuanceFramework , IsRestricted , EstimatedCirculatingSupply , MaxSupply , LegacyId , LegacyDARAssetId , InstitutionalCustodyAvailable , DATSSuperSector , DATSSuperSectorCode , DATSSector ,DATSSectorCode ,DATSSubSector , DATSSubSectorCode , DATSTaxonomyVersion ,HasERC20Version , HasNYDFSCustoday , CMC_ID , CG_ID, CirculatingSupply ) 
		Values (_DARAssetID , _DARTicker, _Name , _AssetType , _IsActive ,_CreateUser , _LastEditUser , v_date , v_date  , _Description , _Sponsor, _IsBenchmarkAsset, _GovernanceToken, _LayerOne, _SEDOL, _ISIN , _CUSIP , _DTI  , _DevelopmentStage , _MessariTaxonomySector , _MessariTaxonomyCategory , _DARSuperSector , _DARSuperSectorCode  ,_DARSector , _DARSectorCode , _DARSubSector , _DARSubSectorCode , _DarTaxonomyVersion , _IssuanceFramework , _IsRestricted , _EstimatedCirculatingSupply , _MaxSupply , _LegacyId , _LegacyDARAssetId , _InstitutionalCustodyAvailable , _DATSSuperSector , _DATSSuperSectorCode , _DATSSector ,_DATSSectorCode ,_DATSSubSector , _DATSSubSectorCode , _DATSTaxonomyVersion ,_HasERC20Version , _HasNYDFSCustoday , _CMC_ID , _CG_ID, _CirculatingSupply);
        
        SELECT ID FROM refmaster_internal_DEV.Asset WHERE DARAssetID=_DARAssetID OR DARTicker=_DARTicker OR Name=_Name into v_id;
        
        INSERT INTO refmaster_internal_DEV.Asset_Audit(ID, DARAssetID, DARTicker, Name, AssetType, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime, Description, Sponsor, IsBenchmarkAsset, SEDOL, ISIN, CUSIP, DTI, DevelopmentStage, MessariTaxonomySector, MessariTaxonomyCategory, DARSuperSector, DARSuperSectorCode, DARSector, DARSectorCode, DARSubSector, DARSubSectorCode, DarTaxonomyVersion, IssuanceFramework, IsRestricted, EstimatedCirculatingSupply, MaxSupply, operation, LegacyId, LegacyDARAssetId, InstitutionalCustodyAvailable, DATSSuperSector, DATSSuperSectorCode, DATSSector, DATSSectorCode, DATSSubSector, DATSSubSectorCode, DATSTaxonomyVersion, HasERC20Version, HasNYDFSCustoday, CMC_ID, CG_ID, CirculatingSupply)
		VALUES (v_id, _DARAssetID , _DARTicker, _Name , _AssetType , _IsActive ,_CreateUser , _LastEditUser , v_date , v_date  , _Description , _Sponsor, _IsBenchmarkAsset, _SEDOL, _ISIN , _CUSIP , _DTI  , _DevelopmentStage , _MessariTaxonomySector , _MessariTaxonomyCategory , _DARSuperSector , _DARSuperSectorCode  ,_DARSector , _DARSectorCode , _DARSubSector , _DARSubSectorCode , _DarTaxonomyVersion , _IssuanceFramework , _IsRestricted , _EstimatedCirculatingSupply , _MaxSupply , "INSERT" , _LegacyId , _LegacyDARAssetId , _InstitutionalCustodyAvailable , _DATSSuperSector , _DATSSuperSectorCode , _DATSSector ,_DATSSectorCode ,_DATSSubSector , _DATSSubSectorCode , _DATSTaxonomyVersion ,_HasERC20Version , _HasNYDFSCustoday , _CMC_ID , _CG_ID, _CirculatingSupply);

		COMMIT;
		SELECT Id FROM refmaster_internal_DEV.Asset WHERE DARAssetID=_DARAssetID AND DARTicker=_DARTicker AND Name=_Name INTO v_id;
		output = CONCAT(output, "SUCCESS"); 
		ECHO SELECT v_id as ID, output AS RowOutput; 		
	ELSE
		output = CONCAT(output, "FAIL"); 
        ECHO SELECT v_id as ID, output AS RowOutput; 	
	END IF;
	RETURN v_id;
    EXCEPTION 
		WHEN OTHERS THEN
			ROLLBACK; 
			RAISE user_exception("abort");
END //
DELIMITER ;

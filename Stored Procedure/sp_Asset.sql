use refmaster_internal_DEV
DELIMITER $$
CREATE OR REPLACE PROCEDURE refmaster_internal_DEV.spDMLAsset(_Operation varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL, _DARAssetID varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL, _DARTicker varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL, _Name varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL, _CreateUser varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL, _LastEditUser varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL, _ID bigint(16) NULL DEFAULT 0, _AssetType varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _Description varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _Sponsor varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _IsBenchmarkAsset tinyint(4) NULL DEFAULT NULL, _SEDOL varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _ISIN varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _CUSIP varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DTI varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DevelopmentStage varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _MessariTaxonomySector varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _MessariTaxonomyCategory varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DARSuperSector varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DARSuperSectorCode varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DARSector varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DARSectorCode varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DARSubSector varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DARSubSectorCode varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DarTaxonomyVersion decimal(11,10) NULL DEFAULT NULL, _IssuanceFramework varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _IsRestricted tinyint(4) NULL DEFAULT NULL, _EstimatedCirculatingSupply decimal(16,15) NULL DEFAULT NULL, _MaxSupply decimal(18,0) NULL DEFAULT NULL, _LegacyId int(11) NULL DEFAULT NULL, _LegacyDARAssetId varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _InstitutionalCustodyAvailable tinyint(4) NULL DEFAULT NULL, _DATSSuperSector varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DATSSuperSectorCode varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DATSSector varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DATSSectorCode varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DATSSubSector varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DATSSubSectorCode varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _DATSTaxonomyVersion decimal(11,10) NULL DEFAULT NULL, _HasERC20Version tinyint(4) NULL DEFAULT NULL, _HasNYDFSCustoday tinyint(4) NULL DEFAULT NULL, _CMC_ID varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _CG_ID varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, _CirculatingSupply decimal(18,0) NULL DEFAULT NULL, _IsActive tinyint(4) NULL DEFAULT 1) RETURNS text CHARACTER SET utf8 COLLATE utf8_general_ci NULL AS
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
		INSERT INTO refmaster_internal_DEV.Asset(DARAssetID , DARTicker, Name , AssetType , IsActive ,CreateUser , LastEditUser , CreateTime , LastEditTime  , Description , Sponsor,IsBenchmarkAsset, SEDOL, ISIN , CUSIP , DTI  , DevelopmentStage , MessariTaxonomySector , MessariTaxonomyCategory , DARSuperSector , DARSuperSectorCode  ,DARSector ,DARSectorCode , DARSubSector , DARSubSectorCode , DarTaxonomyVersion , IssuanceFramework , IsRestricted , EstimatedCirculatingSupply , MaxSupply , LegacyId , LegacyDARAssetId , InstitutionalCustodyAvailable , DATSSuperSector , DATSSuperSectorCode , DATSSector ,DATSSectorCode ,DATSSubSector , DATSSubSectorCode , DATSTaxonomyVersion ,HasERC20Version , HasNYDFSCustoday , CMC_ID , CG_ID, CirculatingSupply ) 
		Values (_DARAssetID , _DARTicker, _Name , _AssetType , _IsActive ,_CreateUser , _LastEditUser , v_date , v_date  , _Description , _Sponsor, _IsBenchmarkAsset, _SEDOL, _ISIN , _CUSIP , _DTI  , _DevelopmentStage , _MessariTaxonomySector , _MessariTaxonomyCategory , _DARSuperSector , _DARSuperSectorCode  ,_DARSector , _DARSectorCode , _DARSubSector , _DARSubSectorCode , _DarTaxonomyVersion , _IssuanceFramework , _IsRestricted , _EstimatedCirculatingSupply , _MaxSupply , _LegacyId , _LegacyDARAssetId , _InstitutionalCustodyAvailable , _DATSSuperSector , _DATSSuperSectorCode , _DATSSector ,_DATSSectorCode ,_DATSSubSector , _DATSSubSectorCode , _DATSTaxonomyVersion ,_HasERC20Version , _HasNYDFSCustoday , _CMC_ID , _CG_ID, _CirculatingSupply);
        
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
END;$$
DELIMITER ;

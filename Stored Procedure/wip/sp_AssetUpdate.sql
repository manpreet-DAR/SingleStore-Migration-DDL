use refmaster_internal_DEV; 

DELIMITER //

CREATE OR REPLACE PROCEDURE spDMLAssetUpdate(
_ID BIGINT(16),
_CreateTime DATETIME,
_DARAssetID VARCHAR(20), 
_DARTicker VARCHAR(20), 
_Name VARCHAR(100),
_CreateUser VARCHAR(100),
_LastEditUser VARCHAR(100),
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
_GovernanceToken TINYINT default null, 
_LayerOne TINYINT default null
)
AS 
DECLARE
	v_date DATETIME;
BEGIN
	SELECT NOW() INTO v_date;
	START TRANSACTION;
    DELETE FROM Asset WHERE DARAssetID=_DARAssetID; 
	INSERT INTO Asset(ID, DARAssetID , DARTicker, Name , AssetType , IsActive ,CreateUser , LastEditUser , CreateTime , LastEditTime  , Description , Sponsor,IsBenchmarkAsset, GovernanceToken, LayerOne, SEDOL, ISIN , CUSIP , DTI  , DevelopmentStage , MessariTaxonomySector , MessariTaxonomyCategory , DARSuperSector , DARSuperSectorCode  ,DARSector ,DARSectorCode , DARSubSector , DARSubSectorCode , DarTaxonomyVersion , IssuanceFramework , IsRestricted , EstimatedCirculatingSupply , MaxSupply , LegacyId , LegacyDARAssetId , InstitutionalCustodyAvailable , DATSSuperSector , DATSSuperSectorCode , DATSSector ,DATSSectorCode ,DATSSubSector , DATSSubSectorCode , DATSTaxonomyVersion ,HasERC20Version , HasNYDFSCustoday , CMC_ID , CG_ID, CirculatingSupply ) 
		Values (_ID, _DARAssetID , _DARTicker, _Name , _AssetType , _IsActive ,_CreateUser , _LastEditUser , _CreateTime , v_date  , _Description , _Sponsor, _IsBenchmarkAsset, _GovernanceToken, _LayerOne, _SEDOL, _ISIN , _CUSIP , _DTI  , _DevelopmentStage , _MessariTaxonomySector , _MessariTaxonomyCategory , _DARSuperSector , _DARSuperSectorCode  ,_DARSector , _DARSectorCode , _DARSubSector , _DARSubSectorCode , _DarTaxonomyVersion , _IssuanceFramework , _IsRestricted , _EstimatedCirculatingSupply , _MaxSupply , _LegacyId , _LegacyDARAssetId , _InstitutionalCustodyAvailable , _DATSSuperSector , _DATSSuperSectorCode , _DATSSector ,_DATSSectorCode ,_DATSSubSector , _DATSSubSectorCode , _DATSTaxonomyVersion ,_HasERC20Version , _HasNYDFSCustoday , _CMC_ID , _CG_ID, _CirculatingSupply);
    COMMIT;
	CALL spDMLAssetAudit("UPDATE", _DARAssetID ,_LastEditUser);
END // 
DELIMITER ; 
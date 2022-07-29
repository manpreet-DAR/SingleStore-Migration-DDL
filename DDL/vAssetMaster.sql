ALTER VIEW vAssetMaster
AS
SELECT
a.ID
-- , CONVERT (UniqueID, CHAR(50)) AS UniqueID
, DARAssetID
, DARTicker
, a.Name
, AssetType
, a.Description
, Sponsor
, IsBenchmarkAsset
, GovernanceToken
, LayerOne
, SEDOL
, ISIN
, CUSIP
, DTI
, DevelopmentStage
, DARSuperSector
, DARSuperSectorCode
, DARSector
, DARSectorCode
, DARSubSector
, DARSubSectorCode
, DarTaxonomyVersion
, DATSSuperSector
, DATSSuperSectorCode
, DATSSector
, DATSSectorCode
, DATSSubSector
, DATSSubSectorCode
, DATSTaxonomyVersion
, IssuanceFramework
, IsRestricted
, EstimatedCirculatingSupply
, MaxSupply
, MessariTaxonomySector
, MessariTaxonomyCategory
, a.IsActive
, a.CreateUser
, a.LastEditUser
, a.CreateTime
, a.LastEditTime
, InstitutionalCustodyAvailable
, th.DarTheme as DarTheme
, thDATs.DatsTheme 
, au.primaryURL AS PrimaryURL
, au.twitter AS Twitter
, au.reddit AS Reddit
, au.blog AS Blog
, au.whitePaper AS WhitePaper
, au.codeRepositoryURL AS CodeRepositoryURL
, a.HasERC20Version
, a.HasNYDFSCustoday
, a.LegacyDARAssetId
, a.CirculatingSupply
, a.LegacyId
FROM Asset a
LEFT JOIN (
	SELECT
	d.AssetID, 
	MAX(CASE 
	 WHEN Name = 'Primary URL' THEN URLPath END) AS primaryURL,
	MAX(CASE 
 	WHEN Name = 'Twitter' THEN URLPath END) AS twitter,
 	MAX(CASE
 	WHEN Name = 'Reddit' THEN URLPath END) AS reddit,
 	MAX (CASE
 	WHEN Name = 'Blog' THEN URLPath END) AS blog,
 	MAX (CASE
 	WHEN Name = 'White Paper' THEN URLPath END) AS whitePaper,
 	MAX (CASE
	 WHEN Name = 'Code Repository URL' THEN URLPath END) AS codeRepositoryURL
	FROM (
		SELECT au.AssetID,ut.Name,au.URLPath
		FROM AssetURL au
		JOIN URLType ut ON au.URLTypeID = ut.ID
	) d
	GROUP BY AssetID
	                ) au on a.ID = au.AssetID
LEFT JOIN (SELECT AssetID, GROUP_CONCAT(Theme ORDER BY Theme ASC) as DarTheme
                                            FROM vAssetTheme t1
                                            WHERE t1.ThemeType = 'DAR'
                                            GROUP BY AssetID) th ON th.AssetID = a.ID
LEFT JOIN (SELECT  AssetID, GROUP_CONCAT(Theme ORDER BY Theme ASC) as DatsTheme
                                            FROM vAssetTheme t1
                                            WHERE t1.ThemeType = 'DATS'
                                            GROUP BY AssetID) thDATs ON thDATs.AssetID = a.ID; 
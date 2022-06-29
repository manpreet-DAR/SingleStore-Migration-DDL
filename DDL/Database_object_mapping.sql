Asset Table

SQL SERVER SCRIPT
CREATE TABLE dbo.Asset(
	ID int AUTO_INCREMENT NOT NULL, # IDENTITY(1,1) #handled
	UniqueID VARCHAR(36) NOT NULL, # uniqueidentifier not needed
	DARAssetID nvarchar(20) NOT NULL,
	DARTicker nvarchar(20) NOT NULL,
	Name nvarchar(100) NOT NULL,
	AssetType nvarchar(200) NULL,
	IsActive bit NOT NULL,
	CreateUser nvarchar(100) NULL,
	LastEditUser nvarchar(100) NULL,
	CreateTime datetime NOT NULL,
	LastEditTime datetime NOT NULL,
	Description nvarchar(1500) NULL,
	Sponsor nvarchar(255) NULL,
	IsBenchmarkAsset bit NULL,
	SEDOL nvarchar(200) NULL,
	ISIN nvarchar(200) NULL,
	CUSIP nvarchar(200) NULL,
	DTI nvarchar(200) NULL,
	DevelopmentStage nvarchar(200) NULL,
	MessariTaxonomySector nvarchar(500) NULL,
	MessariTaxonomyCategory nvarchar(500) NULL,
	DARSuperSector nvarchar(200) NULL,
	DARSuperSectorCode nvarchar(200) NULL,
	DARSector nvarchar(200) NULL,
	DARSectorCode nvarchar(200) NULL,
	DARSubSector nvarchar(200) NULL,
	DARSubSectorCode nvarchar(200) NULL,
	DarTaxonomyVersion decimal(11, 10) NULL,
	IssuanceFramework nvarchar(200) NULL,
	IsRestricted bit NULL,
	EstimatedCirculatingSupply decimal(16, 15) NULL,
	MaxSupply decimal(18, 0) NULL,
	LegacyId int NULL,
	LegacyDARAssetId nvarchar(20) NULL,
	InstitutionalCustodyAvailable bit NULL,
	DATSSuperSector nvarchar(200) NULL,
	DATSSuperSectorCode nvarchar(200) NULL,
	DATSSector nvarchar(200) NULL,
	DATSSectorCode nvarchar(200) NULL,
	DATSSubSector nvarchar(200) NULL,
	DATSSubSectorCode nvarchar(200) NULL,
	DATSTaxonomyVersion decimal(11, 10) NULL,
	HasERC20Version bit NULL,
	HasNYDFSCustoday bit NULL,
	CMC_ID nvarchar(255) NULL,
	CG_ID nvarchar(255) NULL,
 CONSTRAINT PK_Asset_ID PRIMARY KEY CLUSTERED # rows are inserted by id order
(
	ID ASC
),#WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON PRIMARY,
 CONSTRAINT UQ_Asset_DARAssetID UNIQUE NONCLUSTERED # map of id on what page
(
	DARAssetID ASC
), #WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON PRIMARY,
 CONSTRAINT UQ_Asset_DARTicker UNIQUE NONCLUSTERED 
(
	DARTicker ASC
), #WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON PRIMARY,
 CONSTRAINT UQ_Asset_Name UNIQUE NONCLUSTERED 
(
	Name ASC
), #WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON PRIMARY,
 CONSTRAINT UQ_Asset_UniqueID UNIQUE NONCLUSTERED 
(
	UniqueID ASC
) #WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON PRIMARY
); #ON PRIMARY




SINGLE STORE SCRIPT

CREATE TABLE `refmaster_internal_DEV`.`Asset` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DARAssetID` VARCHAR(20) NOT NULL,
  `DARTicker` VARCHAR(20) NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `AssetType` VARCHAR(200) NULL,
  `IsActive` TINYINT NOT NULL,
  `CreateUser` VARCHAR(100) NULL,
  `LastEditUser` VARCHAR(100) NULL,
  `CreateTime` DATETIME NOT NULL,
  `LastEditTime` DATETIME NOT NULL,
  `Description` VARCHAR(1500) NULL,
  `Sponsor` VARCHAR(255) NULL,
  `IsBenchmarkAsset` TINYINT NULL,
  `SEDOL` VARCHAR(200) NULL,
  `ISIN` VARCHAR(200) NULL,
  `CUSIP` VARCHAR(200) NULL,
  `DTI` VARCHAR(200) NULL,
  `DevelopmentStage` VARCHAR(200) NULL,
  `MessariTaxonomySector` VARCHAR(500) NULL,
  `MessariTaxonomyCategory` VARCHAR(500) NULL,
  `DARSuperSector` VARCHAR(200) NULL,
  `DARSuperSectorCode` VARCHAR(200) NULL,
  `DARSector` VARCHAR(200) NULL,
  `DARSectorCode` VARCHAR(200) NULL,
  `DARSubSector` VARCHAR(200) NULL,
  `DARSubSectorCode` VARCHAR(200) NULL,
  `DarTaxonomyVersion` DECIMAL(11,10) NULL,
  `IssuanceFramework` VARCHAR(200) NULL,
  `IsRestricted` TINYINT NULL,
  `EstimatedCirculatingSupply` DECIMAL(16,15) NULL,
  `MaxSupply` DECIMAL(18,0) NULL,
  `LegacyId` INT NULL,
  `LegacyDARAssetId` VARCHAR(20) NULL,
  `InstitutionalCustodyAvailable` TINYINT NULL,
  `DATSSuperSector` VARCHAR(200) NULL,
  `DATSSuperSectorCode` VARCHAR(200) NULL,
  `DATSSector` VARCHAR(200) NULL,
  `DATSSectorCode` VARCHAR(200) NULL,
  `DATSSubSector` VARCHAR(200) NULL,
  `DATSSubSectorCode` VARCHAR(200) NULL,
  `DATSTaxonomyVersion` DECIMAL(11,10) NULL,
  `HasERC20Version` TINYINT NULL,
  `HasNYDFSCustoday` TINYINT NULL,
  `CMC_ID` VARCHAR(255) NULL,
  `CG_ID` VARCHAR(255) NULL,
  `CirculatingSupply` DECIMAL(18, 0) NULL,
  PRIMARY KEY (`ID`,`DARAssetID` ASC, `DARTicker` ASC, `Name` ASC),
  SHARD KEY (`DARAssetID` ASC, `DARTicker` ASC, `Name` ASC));

Asset_Audit Table

SQL SERVER SCRIPT
CREATE TABLE [dbo].[Asset_Audit](
	[ChangeID] [int] IDENTITY(1,1) NOT NULL,
	[ID] [nvarchar](20) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[DARAssetID] [nvarchar](20) NOT NULL,
	[DARTicker] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[AssetType] [nvarchar](200) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
	[Description] [nvarchar](1500) NULL,
	[Sponsor] [nvarchar](255) NULL,
	[IsBenchmarkAsset] [bit] NULL,
	[SEDOL] [nvarchar](200) NULL,
	[ISIN] [nvarchar](200) NULL,
	[CUSIP] [nvarchar](200) NULL,
	[DTI] [nvarchar](200) NULL,
	[DevelopmentStage] [nvarchar](200) NULL,
	[MessariTaxonomySector] [nvarchar](500) NULL,
	[MessariTaxonomyCategory] [nvarchar](500) NULL,
	[DARSuperSector] [nvarchar](200) NULL,
	[DARSuperSectorCode] [nvarchar](200) NULL,
	[DARSector] [nvarchar](200) NULL,
	[DARSectorCode] [nvarchar](200) NULL,
	[DARSubSector] [nvarchar](200) NULL,
	[DARSubSectorCode] [nvarchar](200) NULL,
	[DarTaxonomyVersion] [decimal](11, 10) NULL,
	[IssuanceFramework] [nvarchar](200) NULL,
	[IsRestricted] [bit] NULL,
	[EstimatedCirculatingSupply] [decimal](16, 15) NULL,
	[MaxSupply] [decimal](18, 0) NULL,
	[operation] [varchar](15) NOT NULL,
	[LegacyId] [int] NULL,
	[LegacyDARAssetId] [nvarchar](20) NULL,
	[InstitutionalCustodyAvailable] [bit] NULL,
	[DATSSuperSector] [nvarchar](200) NULL,
	[DATSSuperSectorCode] [nvarchar](200) NULL,
	[DATSSector] [nvarchar](200) NULL,
	[DATSSectorCode] [nvarchar](200) NULL,
	[DATSSubSector] [nvarchar](200) NULL,
	[DATSSubSectorCode] [nvarchar](200) NULL,
	[DATSTaxonomyVersion] [decimal](11, 10) NULL,
	[HasERC20Version] [bit] NULL,
	[HasNYDFSCustoday] [bit] NULL,
	[CMC_ID] [nvarchar](255) NULL,
	[CG_ID] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ChangeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SINGLE STORE SCRIPT

CREATE TABLE `refmaster_internal_DEV`.`Asset_Audit` (
  `ChangeID` INT NOT NULL AUTO_INCREMENT,
  `ID` VARCHAR(20) NOT NULL,
  `DARAssetID` VARCHAR(20) NOT NULL,
  `DARTicker` VARCHAR(20) NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `AssetType` VARCHAR(200) NULL,
  `IsActive` TINYINT NOT NULL,
  `CreateUser` VARCHAR(100) NULL,
  `LastEditUser` VARCHAR(100) NULL,
  `CreateTime` DATETIME NOT NULL,
  `LastEditTime` DATETIME NOT NULL,
  `Description` VARCHAR(1500) NULL,
  `Sponsor` VARCHAR(255) NULL,
  `IsBenchmarkAsset` TINYINT NULL,
  `SEDOL` VARCHAR(200) NULL,
  `ISIN` VARCHAR(200) NULL,
  `CUSIP` VARCHAR(200) NULL,
  `DTI` VARCHAR(200) NULL,
  `DevelopmentStage` VARCHAR(200) NULL,
  `MessariTaxonomySector` VARCHAR(500) NULL,
  `MessariTaxonomyCategory` VARCHAR(500) NULL,
  `DARSuperSector` VARCHAR(200) NULL,
  `DARSuperSectorCode` VARCHAR(200) NULL,
  `DARSector` VARCHAR(200) NULL,
  `DARSectorCode` VARCHAR(200) NULL,
  `DARSubSector` VARCHAR(200) NULL,
  `DARSubSectorCode` VARCHAR(200) NULL,
  `DarTaxonomyVersion` DECIMAL(11,10) NULL,
  `IssuanceFramework` VARCHAR(200) NULL,
  `IsRestricted` TINYINT NULL,
  `EstimatedCirculatingSupply` DECIMAL(16,15) NULL,
  `MaxSupply` DECIMAL(18,0) NULL,
  `LegacyId` INT NULL,
  `LegacyDARAssetId` VARCHAR(20) NULL,
  `InstitutionalCustodyAvailable` TINYINT NULL,
  `DATSSuperSector` VARCHAR(200) NULL,
  `DATSSuperSectorCode` VARCHAR(200) NULL,
  `DATSSector` VARCHAR(200) NULL,
  `DATSSectorCode` VARCHAR(200) NULL,
  `DATSSubSector` VARCHAR(200) NULL,
  `DATSSubSectorCode` VARCHAR(200) NULL,
  `DATSTaxonomyVersion` DECIMAL(11,10) NULL,
  `HasERC20Version` TINYINT NULL,
  `HasNYDFSCustoday` TINYINT NULL,
  `CMC_ID` VARCHAR(255) NULL,
  `CG_ID` VARCHAR(255) NULL,
  `CirculatingSupply` DECIMAL(18, 0) NULL,
  PRIMARY KEY (`ChangeID` ASC),
  SHARD KEY (`ChangeID` ASC));

AssetURL

SQL SERVER SCRIPT
CREATE TABLE [dbo].[AssetURL](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[AssetID] [int] NOT NULL,
	[URLTypeID] [int] NOT NULL,
	[URLPath] [nvarchar](1500) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_AssetURL_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_AssetURL_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.AssetURL(
	ID INT NOT NULL AUTO_INCREMENT,
	AssetID BIGINT(16) NOT NULL,
	URLTypeID INT NOT NULL,
	URLPath VARCHAR(1500) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (`ID` ASC));

URLType
SQL SERVER SCRIPT

CREATE TABLE [dbo].[URLType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[APIName] [nvarchar](100) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_URLType_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_URLType_DisplayName] UNIQUE NONCLUSTERED 
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_URLType_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_URLType_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT


 CREATE TABLE refmaster_internal_DEV.URLType(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(100) NOT NULL,
	DisplayName VARCHAR(250) NOT NULL,
	APIName VARCHAR(100) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, DisplayName ASC, Name ASC),
    SHARD KEY (DisplayName ASC, Name ASC));

AssetTheme

SQL SERVER SCRIPT
CREATE TABLE [dbo].[AssetTheme](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AssetID] [int] NOT NULL,
	[ThemeID] [int] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_AssetTheme_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.AssetTheme(
	ID INT NOT NULL AUTO_INCREMENT,
	AssetID BIGINT(16) NOT NULL,
	ThemeID BIGINT(16) NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	PRIMARY KEY (ID ASC)); 


Theme
SQL SERVER SCRIPT

CREATE TABLE [dbo].[Theme](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
	[Description] [nvarchar](500) NULL,
	[ThemeType] [nvarchar](100) NULL,
 CONSTRAINT [PK_Theme_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC,
	[ThemeType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.Theme(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(250) NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	Description VARCHAR(500) NULL,
	ThemeType VARCHAR(100) NULL,
    PRIMARY KEY (ID ASC, Name ASC, ThemeType ASC),
    SHARD KEY (Name ASC, ThemeType ASC)); 

OutstandingSupply
SQL SERVER SCRIPT
CREATE TABLE [dbo].[OutstandingSupply](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AssetID] [int] NOT NULL,
	[ProcessID] [int] NOT NULL,
	[OutstandingSupply] [decimal](18, 0) NOT NULL,
	[CollectedTimeStamp] [datetime] NULL,
	[IsActive] [bit] NULL,
	[Reviewed] [bit] NULL,
 CONSTRAINT [PK_OutstandingSupply_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.OutstandingSupply(
	ID INT NOT NULL AUTO_INCREMENT,
	AssetID INT NOT NULL,
	ProcessID INT NOT NULL,
	OutstandingSupply DECIMAL(18, 0) NOT NULL,
	CollectedTimeStamp DATETIME NULL,
	IsActive TINYINT NULL,
	Reviewed TINYINT NULL,
    PRIMARY KEY (ID ASC));
EventInformation
SQL SERVER SCRIPT

CREATE TABLE [dbo].[EventInformation](
	[DAREventID] [int] IDENTITY(10000,1) NOT NULL,
	[DateofReview] [datetime] NULL,
	[EventTypeID] [int] NULL,
	[AssetID] [int] NULL,
	[SourceID] [int] NULL,
	[ExchangeAssetTicker] [nvarchar](20) NULL,
	[ExchangeAssetName] [nvarchar](100) NULL,
	[DARAssetID] [nvarchar](50) NULL,
	[EventType] [nvarchar](100) NULL,
	[EventDate] [datetime] NULL,
	[AnnouncementDate] [datetime] NULL,
	[EventDescription] [nvarchar](500) NULL,
	[SourceURL] [nvarchar](500) NULL,
	[EventStatus] [nvarchar](500) NULL,
	[Notes] [nvarchar](500) NULL,
	[Deleted] [nvarchar](500) NULL,
	[Exchange] [nvarchar](50) NULL,
	[BlockHeight] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[LastEditTime] [datetime] NULL,
 CONSTRAINT [PK_EventInformation_ID] PRIMARY KEY CLUSTERED 
(
	[DAREventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.EventInformation(
	DAREventID INT NOT NULL AUTO_INCREMENT,
	DateofReview DATETIME NULL,
	EventTypeID INT NULL,
	AssetID BIGINT(16) NULL,
	SourceID INT NULL,
	ExchangeAssetTicker VARCHAR(20) NULL,
	ExchangeAssetName VARCHAR(100) NULL,
	DARAssetID VARCHAR(50) NULL,
	EventType VARCHAR(100) NULL,
	EventDate DATETIME NULL,
	AnnouncementDate DATETIME NULL,
	EventDescription VARCHAR(500) NULL,
	SourceURL VARCHAR(500) NULL,
	EventStatus VARCHAR(500) NULL,
	Notes VARCHAR(500) NULL,
	Deleted VARCHAR(500) NULL,
	Exchange VARCHAR(50) NULL,
	BlockHeight INT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditUser VARCHAR(100) NULL,
	LastEditTime DATETIME NULL,
    PRIMARY KEY (DAREventID ASC));
Derivatives
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Derivatives](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UnderlierDARAssetID] [nvarchar](20) NOT NULL,
	[ContractType] [nvarchar](50) NOT NULL,
	[OptionType] [nvarchar](50) NULL,
	[ContractTicker] [nvarchar](500) NOT NULL,
	[DARContractID] [nvarchar](500) NOT NULL,
	[ContractExchange] [nvarchar](255) NOT NULL,
	[ContractExchangeDARID] [nvarchar](500) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[TradingHours] [nvarchar](10) NOT NULL,
	[MinimumTickSize] [decimal](18, 0) NOT NULL,
	[SettlementTime] [nvarchar](700) NOT NULL,
	[SettlementType] [nvarchar](100) NOT NULL,
	[SettlementCurrency] [nvarchar](50) NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[ContractSize] [int] NOT NULL,
	[InitialMargin] [nvarchar](1000) NOT NULL,
	[MaintenanceMargin] [nvarchar](1000) NOT NULL,
	[MarkPrice] [nvarchar](1000) NOT NULL,
	[DeliveryPrice] [nvarchar](1000) NOT NULL,
	[DeliveryMethod] [nvarchar](1000) NULL,
	[FeesURL] [nvarchar](200) NOT NULL,
	[PositionLimit] [nvarchar](1000) NULL,
	[PositionLimitURL] [nvarchar](200) NULL,
	[BlockTradeMinimum] [nvarchar](200) NULL,
	[LinktoTAndC] [nvarchar](100) NULL,
	[FundingRates] [nvarchar](100) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Derivative_ContractExchangeContractTicker] UNIQUE NONCLUSTERED 
(
	[ContractExchange] ASC,
	[ContractTicker] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.Derivatives(
	ID INT NOT NULL AUTO_INCREMENT,
	UnderlierDARAssetID VARCHAR(20) NOT NULL,
	ContractType VARCHAR(50) NOT NULL,
	OptionType VARCHAR(50) NULL,
	ContractTicker VARCHAR(500) NOT NULL,
	DARContractID VARCHAR(500) NOT NULL,
	ContractExchange VARCHAR(255) NOT NULL,
	ContractExchangeDARID VARCHAR(500) NOT NULL,
	Status VARCHAR(50) NOT NULL,
	TradingHours VARCHAR(10) NOT NULL,
	MinimumTickSize DECIMAL(18, 0) NOT NULL,
	SettlementTime VARCHAR(700) NOT NULL,
	SettlementType VARCHAR(100) NOT NULL,
	SettlementCurrency VARCHAR(50) NOT NULL,
	ExpirationDate DATETIME NOT NULL,
	ContractSize INT NOT NULL,
	InitialMargin VARCHAR(1000) NOT NULL,
	MaintenanceMargin VARCHAR(1000) NOT NULL,
	MarkPrice VARCHAR(1000) NOT NULL,
	DeliveryPrice VARCHAR(1000) NOT NULL,
	DeliveryMethod VARCHAR(1000) NULL,
	FeesURL VARCHAR(200) NOT NULL,
	PositionLimit VARCHAR(1000) NULL,
	PositionLimitURL VARCHAR(200) NULL,
	BlockTradeMinimum VARCHAR(200) NULL,
	LinktoTAndC VARCHAR(100) NULL,
	FundingRates VARCHAR(100) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC,ContractExchange ASC, ContractTicker ASC),
    SHARD KEY (ContractExchange ASC, ContractTicker ASC));





AddPrice
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AddPrice](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AssetName] [nvarchar](500) NOT NULL,
	[AssetTicker] [nvarchar](500) NOT NULL,
	[Exchange] [nvarchar](500) NOT NULL,
	[ContractAddress] [nvarchar](1000) NOT NULL,
	[Contact] [nvarchar](1000) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [UQ_AddPrice_NameTickerExchange] UNIQUE NONCLUSTERED 
(
	[AssetName] ASC,
	[AssetTicker] ASC,
	[Exchange] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
    
CREATE TABLE refmaster_internal_DEV.AddPrice(
	ID INT NOT NULL AUTO_INCREMENT,
	AssetName VARCHAR(500) NOT NULL,
	AssetTicker VARCHAR(500) NOT NULL,
	Exchange VARCHAR(500) NOT NULL,
	ContractAddress VARCHAR(1000) NOT NULL,
	Contact VARCHAR(1000) NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	PRIMARY KEY (ID ASC, AssetName ASC, AssetTicker ASC, Exchange ASC),
    SHARD KEY ( AssetName ASC, AssetTicker ASC, Exchange ASC));




AssetVettingStatus
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AssetVettingStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProcessId] [int] NOT NULL,
	[AssetId] [int] NOT NULL,
	[VettingStatusId] [int] NOT NULL,
	[IndexStatus] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_AssetVettingStatus_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.AssetVettingStatus(
	ID INT NOT NULL AUTO_INCREMENT,
	ProcessId BIGINT(16) NOT NULL,
	AssetId BIGINT(16) NOT NULL,
	VettingStatusId BIGINT(16) NOT NULL,
	IndexStatus INT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC));



Process
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Process](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[Lookback] [int] NULL,
	[Frequency] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
	[LookbackUnit] [nvarchar](20) NULL,
	[FrequencyUnit] [nvarchar](20) NULL,
 CONSTRAINT [PK_Process_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Process_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.Process(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(255) NOT NULL,
	Description VARCHAR(500) NOT NULL,
	Lookback INT NULL,
	Frequency INT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	LookbackUnit VARCHAR(20) NULL,
	FrequencyUnit VARCHAR(20) NULL,
    PRIMARY KEY (ID ASC, Name ASC),
     SHARD KEY ( Name  ASC));


VettingStatus
SQL SERVER SCRIPT
CREATE TABLE [dbo].[VettingStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StatusCode] [int] NOT NULL,
	[StatusDescription] [nvarchar](200) NOT NULL,
	[StatusType] [nvarchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_VettingStatus_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_VettingStatus_StatusDescription] UNIQUE NONCLUSTERED 
(
	[StatusDescription] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.VettingStatus(
	ID INT NOT NULL AUTO_INCREMENT,
	StatusCode INT NOT NULL,
	StatusDescription VARCHAR(200) NOT NULL,
	StatusType VARCHAR(200) NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, StatusDescription ASC),
    SHARD KEY ( StatusDescription ASC));



AssetCustodian
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AssetCustodian](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AssetID] [int] NOT NULL,
	[CustodianID] [int] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_AssetCustodian_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[AssetID] ASC,
	[CustodianID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.AssetCustodian(
	ID INT NOT NULL AUTO_INCREMENT,
	AssetID BIGINT(16) NOT NULL,
	CustodianID BIGINT(16) NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, AssetID ASC, CustodianID ASC),
    SHARD KEY ( AssetID ASC, CustodianID ASC));



Custodian
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Custodian](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_Custodian_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Custodian_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.Custodian(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(250) NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	Description VARCHAR(500) NULL,
    PRIMARY KEY (ID ASC, Name ASC),
    SHARD KEY ( Name ASC));




AssetToken
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AssetToken](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AssetID] [int] NOT NULL,
	[TokenId] [int] NOT NULL,
	[BlockChainId] [int] NOT NULL,
	[TokenContractAddress] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_AssetToken_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_AssetToken_AID_TID_BID] UNIQUE NONCLUSTERED 
(
	[AssetID] ASC,
	[TokenId] ASC,
	[BlockChainId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.AssetToken(
	ID INT NOT NULL AUTO_INCREMENT,
	AssetID BIGINT(16) NOT NULL,
	TokenId BIGINT(16) NOT NULL,
	BlockChainId BIGINT(16) NOT NULL,
	TokenContractAddress VARCHAR(500) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, AssetID ASC, TokenId ASC, BlockChainId ASC),
    SHARD KEY ( AssetID ASC, TokenId ASC, BlockChainId ASC));



BlockChain
SQL SERVER SCRIPT
CREATE TABLE [dbo].[BlockChain](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[ConsensusMechanism] [nvarchar](255) NULL,
	[HashAlgorithm] [nvarchar](255) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_BlockChain_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_BlockChain_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.BlockChain(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(255) NULL,
	Description VARCHAR(255) NULL,
	ConsensusMechanism VARCHAR(255) NULL,
	HashAlgorithm VARCHAR(255) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, Name ASC),
    SHARD KEY ( ID ASC, Name ASC));




Clients
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Clients](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[CallerID] [nvarchar](250) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
	[HasFullAccess] [bit] NULL,
 CONSTRAINT [PK_Clients_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_CallerID] UNIQUE NONCLUSTERED 
(
	[CallerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT
    
CREATE TABLE refmaster_internal_DEV.Clients(
	ID INT NOT NULL AUTO_INCREMENT,
	ClientName VARCHAR(250) NOT NULL,
	Description VARCHAR(250) NOT NULL,
	CallerID VARCHAR(250) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	HasFullAccess TINYINT NULL,
    	ReferenceData TINYINT NULL,
    	Price TINYINT NULL,
	APIKey VARCHAR(250) NULL,
    PRIMARY KEY (ID ASC, CallerID ASC),
    SHARD KEY ( CallerID ASC));

ClientAssets
SQL SERVER SCRIPT
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientAssets](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AssetID] [int] NOT NULL,
	[ClientID] [int] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
	[ReferenceData] [bit] NULL,
	[Price] [bit] NULL,
 CONSTRAINT [PK_ClientAssets_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[AssetID] ASC,
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClientAssets]  WITH CHECK ADD  CONSTRAINT [FK_Asset_ClientAssets_AssetID] FOREIGN KEY([AssetID])
REFERENCES [dbo].[Asset] ([ID])
GO
ALTER TABLE [dbo].[ClientAssets] CHECK CONSTRAINT [FK_Asset_ClientAssets_AssetID]
GO
ALTER TABLE [dbo].[ClientAssets]  WITH CHECK ADD  CONSTRAINT [FK_Clients_ClientAssets_ClientID] FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ID])
GO
ALTER TABLE [dbo].[ClientAssets] CHECK CONSTRAINT [FK_Clients_ClientAssets_ClientID]
GO


SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.ClientAssets(
	ID INT NOT NULL AUTO_INCREMENT,
	AssetID BIGINT(16) NOT NULL,
	ClientID BIGINT(16) NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	ReferenceData TINYINT NULL,
	Price TINYINT NULL,
	APIKey VARCHAR(250) NULL,
    PRIMARY KEY (ID ASC, AssetID ASC, ClientID ASC),
    SHARD KEY ( AssetID ASC, ClientID ASC));





Staging_CryptoNodeEvents
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Staging_CryptoNodeEvents](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DateofReview] [datetime] NOT NULL,
	[ExchangeAssetTicker] [nvarchar](100) NOT NULL,
	[ExchangeAssetName] [nvarchar](250) NULL,
	[DARAssetID] [nvarchar](50) NULL,
	[EventType] [nvarchar](100) NULL,
	[EventDate] [datetime] NULL,
	[AnnouncementDate] [datetime] NULL,
	[EventDescription] [nvarchar](500) NULL,
	[SourceURL] [nvarchar](500) NULL,
	[EventStatus] [nvarchar](500) NULL,
	[Notes] [nvarchar](500) NULL,
	[Deleted] [nvarchar](500) NULL,
	[Exchange] [nvarchar](50) NULL,
	[ValidationTime] [datetime] NULL,
	[AssetID] [int] NULL,
	[SourceID] [int] NULL,
	[EventTypeID] [int] NULL,
	[CreateTime] [datetime] NOT NULL,
	[BlockHeight] [int] NULL,
	[Error] [nvarchar](500) NULL,
 CONSTRAINT [PK_Staging_CryptoNodeEvents_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.Staging_CryptoNodeEvents(
	ID INT NOT NULL AUTO_INCREMENT,
	DateofReview DATETIME NOT NULL,
	ExchangeAssetTicker VARCHAR(100) NOT NULL,
	ExchangeAssetName VARCHAR(250) NULL,
	DARAssetID VARCHAR(50) NULL,
	EventType VARCHAR(100) NULL,
	EventDate DATETIME NULL,
	AnnouncementDate DATETIME NULL,
	EventDescription VARCHAR(500) NULL,
	SourceURL VARCHAR(500) NULL,
	EventStatus VARCHAR(500) NULL,
	Notes VARCHAR(500) NULL,
	Deleted VARCHAR(500) NULL,
	Exchange VARCHAR(50) NULL,
	ValidationTime DATETIME NULL,
	AssetID  BIGINT(16) NULL,
	SourceID BIGINT(16) NULL,
	EventTypeID BIGINT(16) NULL,
	CreateTime DATETIME NOT NULL,
	BlockHeight INT NULL,
	Error VARCHAR(500) NULL,
    PRIMARY KEY (ID ASC));

__MigrationHistory
SQL SERVER SCRIPT
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.__MigrationHistory(
	MigrationId VARCHAR(150),
	ContextKey VARCHAR(300),
    Model LONGBLOB,
    ProductVersion VARCHAR(32),
    PRIMARY KEY (MigrationId ASC, ContextKey ASC),
    SHARD KEY ( MigrationId ASC, ContextKey ASC));


AspNetUsers
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.AspNetUsers(
	Id VARCHAR(128) NOT NULL,
	Email VARCHAR(256) NULL,
	EmailConfirmed TINYINT NOT NULL,
	PasswordHash TEXT NULL,
	SecurityStamp TEXT NULL,
	PhoneNumber TEXT NULL,
	PhoneNumberConfirmed TINYINT NOT NULL,
	TwoFactorEnabled TINYINT NOT NULL,
	LockoutEndDateUtc DATETIME NULL,
	LockoutEnabled TINYINT NOT NULL,
	AccessFailedCount INT NOT NULL,
	UserName VARCHAR(256) NOT NULL,
    PRIMARY KEY (Id ASC));


AspNetUserClaims
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.AspNetUserClaims(
	ID INT NOT NULL AUTO_INCREMENT,
	UserId VARCHAR(128) NOT NULL,
	ClaimType LONGTEXT NOT NULL,
    ClaimValue LONGTEXT NULL,
    ProductVersion VARCHAR(32)  NULL,
    PRIMARY KEY (ID ASC),
    SHARD KEY ( ID ASC));

AspNetUserLogins
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO

SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.AspNetUserLogins(
	LoginProvider VARCHAR(128) NOT NULL,
	ProviderKey VARCHAR(128) NOT NULL,
	UserId VARCHAR(128) NOT NULL,
	PRIMARY KEY (LoginProvider ASC,ProviderKey ASC,UserId ASC),
	SHARD KEY ( LoginProvider ASC,ProviderKey ASC,UserId ASC));


AspNetRoles
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.AspNetRoles(
	Id VARCHAR(128) NOT NULL,
	Name VARCHAR(256) NOT NULL,
    PRIMARY KEY (ID ASC));


RoleAppModule
SQL SERVER SCRIPT
CREATE TABLE [dbo].[RoleAppModule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AppModuleId] [int] NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_RoleAppModule_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_RoleAppModule_AppModuleId_RoleId] UNIQUE NONCLUSTERED 
(
	[AppModuleId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.RoleAppModule(
	ID INT NOT NULL AUTO_INCREMENT,
	AppModuleId BIGINT(16) NOT NULL,
	RoleId VARCHAR(128) NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	PRIMARY KEY (ID ASC, AppModuleId ASC, RoleId ASC ),
    SHARD KEY ( AppModuleId ASC, RoleId ASC ));





AspNetUserRoles
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.AspNetUserRoles(
	UserId VARCHAR(128) NOT NULL,
	RoleId VARCHAR(128) NOT NULL,
    PRIMARY KEY (UserId ASC, RoleId ASC));

AppModule
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AppModule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ModuleName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[Link] [nvarchar](250) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_AppModule_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Link_AppModule] UNIQUE NONCLUSTERED 
(
	[Link] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_ModuleName_AppModule] UNIQUE NONCLUSTERED 
(
	[ModuleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_AppModule_Name] UNIQUE NONCLUSTERED 
(
	[ModuleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.AppModule(
	ID INT NOT NULL AUTO_INCREMENT,
	ModuleName VARCHAR(250) NOT NULL,
	Description VARCHAR(250) NOT NULL,
	Link VARCHAR(250) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, Link ASC, ModuleName ASC));


Event
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Event](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[EventName] [nvarchar](50) NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Event_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Event_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.Event(
	ID INT NOT NULL AUTO_INCREMENT,
	EventName VARCHAR(50) NOT NULL,
	CreateUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC));


Exchange
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Exchange](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[DARExchangeID] [nvarchar](20) NOT NULL,
	[ShortName] [nvarchar](100) NOT NULL,
	[ExchangeType] [nvarchar](255) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
	[LegacyId] [int] NULL,
	[LegalName] [nvarchar](255) NULL,
	[LegalNameSource] [nvarchar](255) NULL,
	[ExchangeTypeSource] [nvarchar](500) NULL,
	[ExchangeStatus] [nvarchar](255) NULL,
	[ExternalClassification] [nvarchar](255) NULL,
	[InternalClassification] [nvarchar](255) NULL,
	[ClassificationFolder] [nvarchar](500) NULL,
	[ClassificationDate] [date] NULL,
	[ClassificationVersion] [int] NULL,
	[DomicileCountry] [nvarchar](255) NULL,
	[IncorporationCountry] [nvarchar](255) NULL,
	[ExchangeSLA] [nvarchar](255) NULL,
	[FoundingYear] [int] NULL,
	[Ownership] [nvarchar](255) NULL,
	[LEI] [nvarchar](255) NULL,
	[Chairman] [nvarchar](255) NULL,
	[CEO] [nvarchar](255) NULL,
	[President] [nvarchar](255) NULL,
	[CTO] [nvarchar](255) NULL,
	[CISO] [nvarchar](255) NULL,
	[CCO] [nvarchar](255) NULL,
	[PrimaryPhone] [nvarchar](255) NULL,
	[PrimaryEmail] [nvarchar](255) NULL,
	[SupportURL] [nvarchar](500) NULL,
	[SupportPhone] [nvarchar](255) NULL,
	[SupportEmail] [nvarchar](255) NULL,
	[HQAddress1] [nvarchar](255) NULL,
	[HQAddress2] [nvarchar](255) NULL,
	[HQCity] [nvarchar](255) NULL,
	[HQState] [nvarchar](255) NULL,
	[HQCountry] [nvarchar](255) NULL,
	[HQPostalCode] [nvarchar](255) NULL,
	[Licenses] [nvarchar](500) NULL,
	[Wikipedia] [nvarchar](255) NULL,
	[MICCode] [nvarchar](255) NULL,
	[KnownRegulatoryIssues] [bit] NULL,
	[TradeMonitoringSystem] [bit] NULL,
	[BlockchainSurveillanceSystem] [bit] NULL,
	[ThirdPartyAudit] [bit] NULL,
	[KnownSecurityIncidences] [bit] NULL,
	[InsuranceProviders] [nvarchar](500) NULL,
	[InsuranceonCryptoAssets] [bit] NULL,
	[Wherethebankisdomiciled] [nvarchar](255) NULL,
	[SelfInsurance] [bit] NULL,
	[MandatoryGovtIDPriortoTrading] [bit] NULL,
	[TradingLimitExKYC] [nvarchar](255) NULL,
	[TradingLimitExKYCsource] [nvarchar](255) NULL,
	[DepositLimitExKYC] [nvarchar](255) NULL,
	[DepositLimitExKYCsource] [nvarchar](255) NULL,
	[WithdrawalLimitExKYC] [nvarchar](255) NULL,
	[WithdrawalLimitExKYCsource] [nvarchar](255) NULL,
	[KYCReqGovernmentID] [bit] NULL,
	[KYCReqDigitalSelfPortrait] [bit] NULL,
	[CorporateActionsPolicy] [nvarchar](500) NULL,
	[PoliciesOnListing] [nvarchar](500) NULL,
	[FeeSchedule] [nvarchar](500) NULL,
	[TradingHours] [nvarchar](500) NULL,
	[Leverage] [bit] NULL,
	[Staking] [bit] NULL,
	[IEOPlatform] [bit] NULL,
	[NativeToken] [bit] NULL,
	[ColdStorageCustody] [bit] NULL,
	[CustodyInsurance] [bit] NULL,
	[PercentOfAssetsinColdStorage] [int] NULL,
	[StablecoinPairs] [bit] NULL,
	[FiatTrading] [bit] NULL,
	[Futures] [bit] NULL,
	[Options] [bit] NULL,
	[Swaps] [bit] NULL,
	[APIType] [nvarchar](255) NULL,
	[APIDocumentation] [nvarchar](500) NULL,
	[PrimaryURL] [nvarchar](500) NULL,
	[Twitter] [nvarchar](500) NULL,
	[LinkedIn] [nvarchar](500) NULL,
	[Reddit] [nvarchar](500) NULL,
	[Facebook] [nvarchar](500) NULL,
 CONSTRAINT [PK_Exchange_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Exchange_DARExchangeID] UNIQUE NONCLUSTERED 
(
	[DARExchangeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Exchange_ShortName] UNIQUE NONCLUSTERED 
(
	[ShortName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Exchange_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.Exchange(
	ID INT NOT NULL AUTO_INCREMENT,
	DARExchangeID VARCHAR(20) NOT NULL,
	ShortName VARCHAR(100) NOT NULL,
	ExchangeType VARCHAR(255) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	LegacyId INT NULL,
	LegalName VARCHAR(255) NULL,
	LegalNameSource VARCHAR(255) NULL,
	ExchangeTypeSource VARCHAR(500) NULL,
	ExchangeStatus VARCHAR(255) NULL,
	ExternalClassification VARCHAR(255) NULL,
	InternalClassification VARCHAR(255) NULL,
	ClassificationFolder VARCHAR(500) NULL,
	ClassificationDate DATE NULL,
	ClassificationVersion INT NULL,
	DomicileCountry VARCHAR(255) NULL,
	IncorporationCountry VARCHAR(255) NULL,
	ExchangeSLA VARCHAR(255) NULL,
	FoundingYear INT NULL,
	Ownership VARCHAR(255) NULL,
	LEI VARCHAR(255) NULL,
	Chairman VARCHAR(255) NULL,
	CEO VARCHAR(255) NULL,
	President VARCHAR(255) NULL,
	CTO VARCHAR(255) NULL,
	CISO VARCHAR(255) NULL,
	CCO VARCHAR(255) NULL,
	PrimaryPhone VARCHAR(255) NULL,
	PrimaryEmail VARCHAR(255) NULL,
	SupportURL VARCHAR(500) NULL,
	SupportPhone VARCHAR(255) NULL,
	SupportEmail VARCHAR(255) NULL,
	HQAddress1 VARCHAR(255) NULL,
	HQAddress2 VARCHAR(255) NULL,
	HQCity VARCHAR(255) NULL,
	HQState VARCHAR(255) NULL,
	HQCountry VARCHAR(255) NULL,
	HQPostalCode VARCHAR(255) NULL,
	Licenses VARCHAR(500) NULL,
	Wikipedia VARCHAR(255) NULL,
	MICCode VARCHAR(255) NULL,
	KnownRegulatoryIssues TINYINT NULL,
	TradeMonitoringSystem TINYINT NULL,
	BlockchainSurveillanceSystem TINYINT NULL,
	ThirdPartyAudit TINYINT NULL,
	KnownSecurityIncidences TINYINT NULL,
	InsuranceProviders VARCHAR(500) NULL,
	InsuranceonCryptoAssets TINYINT NULL,
	Wherethebankisdomiciled VARCHAR(255) NULL,
	SelfInsurance TINYINT NULL,
	MandatoryGovtIDPriortoTrading TINYINT NULL,
	TradingLimitExKYC VARCHAR(255) NULL,
	TradingLimitExKYCsource VARCHAR(255) NULL,
	DepositLimitExKYC VARCHAR(255) NULL,
	DepositLimitExKYCsource VARCHAR(255) NULL,
	WithdrawalLimitExKYC VARCHAR(255) NULL,
	WithdrawalLimitExKYCsource VARCHAR(255) NULL,
	KYCReqGovernmentID TINYINT NULL,
	KYCReqDigitalSelfPortrait TINYINT NULL,
	CorporateActionsPolicy VARCHAR(500) NULL,
	PoliciesOnListing VARCHAR(500) NULL,
	FeeSchedule VARCHAR(500) NULL,
	TradingHours VARCHAR(500) NULL,
	Leverage TINYINT NULL,
	Staking TINYINT NULL,
	IEOPlatform TINYINT NULL,
	NativeToken TINYINT NULL,
	ColdStorageCustody TINYINT NULL,
	CustodyInsurance TINYINT NULL,
	PercentOfAssetsinColdStorage INT NULL,
	StablecoinPairs TINYINT NULL,
	FiatTrading TINYINT NULL,
	Futures TINYINT NULL,
	Options TINYINT NULL,
	Swaps TINYINT NULL,
	APIType VARCHAR(255) NULL,
	APIDocumentation VARCHAR(500) NULL,
	PrimaryURL VARCHAR(500) NULL,
	Twitter VARCHAR(500) NULL,
	LinkedIn VARCHAR(500) NULL,
	Reddit VARCHAR(500) NULL,
	Facebook VARCHAR(500) NULL,
    PRIMARY KEY (ID ASC, DARExchangeID ASC, ShortName ASC ),
    SHARD KEY (DARExchangeID ASC, ShortName ASC  ));

ExchangeVettingStatus
SQL SERVER SCRIPT
CREATE TABLE [dbo].[ExchangeVettingStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProcessId] [int] NOT NULL,
	[ExchangeId] [int] NOT NULL,
	[VettingStatusId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_ExchangeVettingStatus_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_ExchangeVettingStatus_PID_EID_VSID] UNIQUE NONCLUSTERED 
(
	[ProcessId] ASC,
	[ExchangeId] ASC,
	[VettingStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.ExchangeVettingStatus(
	ID INT NOT NULL AUTO_INCREMENT,
	ProcessId BIGINT(16) NOT NULL,
	ExchangeId BIGINT(16) NOT NULL,
	VettingStatusId BIGINT(16) NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, ProcessId ASC, ExchangeId ASC, VettingStatusId ASC ),
    SHARD KEY (ProcessId ASC, ExchangeId ASC , VettingStatusId ASC ));
ExchangePair
SQL SERVER SCRIPT
CREATE TABLE [dbo].[ExchangePair](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[PairID] [int] NOT NULL,
	[ExchangeID] [int] NOT NULL,
	[ExchangePairName] [varchar](20) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_ExchangePair_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ExchangeID] ASC,
	[ExchangePairName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_ExchangePair_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.ExchangePair(
	ID INT NOT NULL AUTO_INCREMENT,
	PairID BIGINT(16) NOT NULL,
	ExchangeID BIGINT(16) NOT NULL,
	ExchangePairName VARCHAR(20) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	ExchangePairNumberId INT NULL,
	ExchangePairStringId VARCHAR(200) NULL,
	ExchangePairShortName VARCHAR(200) NULL,
	ExchangePairLongName VARCHAR(255) NULL,
	ExchangeAssetStringId VARCHAR(200) NULL,
	ExchangeAssetNumberId INT NULL,
	ExchangeAssetShortName VARCHAR(200) NULL,
	ExchangeAssetLongName VARCHAR(255) NULL,
	ExchangeCurrencyStringId VARCHAR(200) NULL,
	ExchangeCurrencyNumberId INT NULL,
	ExchangeCurrencyShortName VARCHAR(200) NULL,
	ExchangeCurrencyLongName VARCHAR(255) NULL,
	IsAvailable TINYINT NULL,
    PRIMARY KEY (ID ASC, ExchangeID ASC, ExchangePairName ASC ),
    SHARD KEY (ExchangeID ASC, ExchangePairName ASC ))
    


Log4NetLog
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Log4NetLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Thread] [varchar](255) NOT NULL,
	[Level] [varchar](50) NOT NULL,
	[Logger] [varchar](255) NOT NULL,
	[Message] [varchar](4000) NOT NULL,
	[Exception] [varchar](2000) NULL,
 CONSTRAINT [PK_Log4NetLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.Log4NetLog(
	Id INT NOT NULL AUTO_INCREMENT,
	Date DATETIME NOT NULL,
	Thread VARCHAR(255) NOT NULL,
	Level VARCHAR(50) NOT NULL,
	Logger VARCHAR(255) NOT NULL,
	Message VARCHAR(4000) NOT NULL,
	Exception VARCHAR(2000) NULL,
    PRIMARY KEY (Id ASC));

Staging_OutstandingSupply
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Staging_OutstandingSupply](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SourceId] [int] NOT NULL,
	[AssetID] [int] NOT NULL,
	[ProcessID] [int] NOT NULL,
	[OutstandingSupply] [decimal](18, 0) NOT NULL,
	[Error] [nvarchar](500) NULL,
	[CollectedTimeStamp] [datetime] NULL,
	[PassedValidation] [bit] NULL,
	[IsActive] [bit] NULL,
	[Reviewed] [bit] NULL,
	[OutstandingSupplyReviewed] [decimal](18, 0) NULL,
	[BaseDataAvailable] [bit] NULL,
 CONSTRAINT [PK_Staging_OutstandingSupply_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.Staging_OutstandingSupply(
	ID INT NOT NULL AUTO_INCREMENT,
	SourceId BIGINT(16) NOT NULL,
	AssetID BIGINT(16) NOT NULL,
	ProcessID BIGINT(16) NOT NULL,
	OutstandingSupply DECIMAL(18, 0) NOT NULL,
	Error VARCHAR(500) NULL,
	CollectedTimeStamp DATETIME NULL,
	PassedValidation TINYINT NULL,
	IsActive TINYINT NULL,
	Reviewed TINYINT NULL,
	OutstandingSupplyReviewed DECIMAL(18, 0) NULL,
	BaseDataAvailable TINYINT NULL,
    PRIMARY KEY (ID ASC));

Source
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Source](
	[ID] [int] IDENTITY(1,1000000) NOT NULL,
	[DARSourceID] [nvarchar](20) NOT NULL,
	[ShortName] [nvarchar](255) NOT NULL,
	[SourceType] [nvarchar](255) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Source_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Source_DARSourceID] UNIQUE NONCLUSTERED 
(
	[DARSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Source_ShortName] UNIQUE NONCLUSTERED 
(
	[ShortName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.Source(
	ID INT NOT NULL AUTO_INCREMENT,
	DARSourceID VARCHAR(20) NOT NULL,
	ShortName VARCHAR(255) NOT NULL,
	SourceType VARCHAR(255) NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, DARSourceID ASC, ShortName ASC ),
    SHARD KEY (DARSourceID ASC, ShortName ASC ));



Pair
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Pair](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[AssetID] [int] NOT NULL,
	[QuoteAssetID] [int] NOT NULL,
	[DARName] [varchar](20) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Pair_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[DARName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Pair_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.Pair(
	ID INT NOT NULL AUTO_INCREMENT,
	AssetID BIGINT(16) NOT NULL,
	QuoteAssetID BIGINT(16) NOT NULL,
	DARName VARCHAR(20) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, DARName ASC),
    SHARD KEY (DARName ASC));


ServingList
SQL SERVER SCRIPT
CREATE TABLE [dbo].[ServingList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PairID] [int] NULL,
	[SourceID] [int] NULL,
	[ProcessID] [int] NOT NULL,
	[Start] [datetime] NOT NULL,
	[End] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_ServingList_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.ServingList(
	ID INT NOT NULL AUTO_INCREMENT,
	PairID BIGINT(16) NULL,
	SourceID BIGINT(16) NULL,
	ProcessID BIGINT(16) NOT NULL,
	Start DATETIME NOT NULL,
	End DATETIME NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC));

ServingListSnapshot
SQL SERVER SCRIPT
CREATE TABLE [dbo].[ServingListSnapshot](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SnapshotName] [nvarchar](500) NOT NULL,
	[SnapshotVersion] [int] NOT NULL,
	[ProcessName] [nvarchar](255) NOT NULL,
	[ProcessId] [int] NULL,
	[PairName] [nvarchar](20) NOT NULL,
	[PairId] [int] NULL,
	[AssetName] [nvarchar](100) NULL,
	[AssetId] [int] NULL,
	[Exchange] [nvarchar](100) NULL,
	[ExchangeId] [int] NULL,
	[ExchangePairName] [nvarchar](20) NULL,
	[AssetTicker] [nvarchar](20) NULL,
	[ExchangeVettingStatus] [nvarchar](200) NULL,
	[ExchangeVettingStatusCode] [int] NULL,
	[AssetTierDescription] [nvarchar](200) NULL,
	[AssetTierCode] [int] NULL,
	[Start] [datetime] NULL,
	[End] [datetime] NULL,
	[AssetLegacyId] [nvarchar](20) NULL,
	[AssetLegacyDARAssetId] [nvarchar](20) NULL,
	[ExchangeLegacyId] [nvarchar](20) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[Lookback] [int] NULL,
	[LookbackUnit] [nvarchar](20) NULL,
	[Frequency] [int] NULL,
	[FrequencyUnit] [nvarchar](20) NULL,
 CONSTRAINT [PK_ServingListSnapshot_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.ServingListSnapshot(
	ID INT NOT NULL AUTO_INCREMENT,
	SnapshotName VARCHAR(500) NOT NULL,
	SnapshotVersion INT NOT NULL,
	ProcessName VARCHAR(255) NOT NULL,
	ProcessId BIGINT(16) NULL,
	PairName VARCHAR(20) NOT NULL,
	PairId BIGINT(16) NULL,
	AssetName VARCHAR(100) NULL,
	AssetId BIGINT(16) NULL,
	Exchange VARCHAR(100) NULL,
	ExchangeId BIGINT(16) NULL,
	ExchangePairName VARCHAR(20) NULL,
	AssetTicker VARCHAR(20) NULL,
	ExchangeVettingStatus VARCHAR(200) NULL,
	ExchangeVettingStatusCode INT NULL,
	AssetTierDescription VARCHAR(200) NULL,
	AssetTierCode INT NULL,
	Start DATETIME NULL,
	End DATETIME NULL,
	AssetLegacyId VARCHAR(20) NULL,
	AssetLegacyDARAssetId VARCHAR(20) NULL,
	ExchangeLegacyId VARCHAR(20) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	Lookback INT NULL,
	LookbackUnit VARCHAR(20) NULL,
	Frequency INT NULL,
	FrequencyUnit VARCHAR(20) NULL,
    PRIMARY KEY (ID ASC));
Token
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Token](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DARTokenID] [nvarchar](20) NOT NULL,
	[TokenName] [nvarchar](255) NOT NULL,
	[TokenDescription] [nvarchar](1500) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Token_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Token_DARTokenID] UNIQUE NONCLUSTERED 
(
	[DARTokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Token_TokenName] UNIQUE NONCLUSTERED 
(
	[TokenName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
  CREATE TABLE refmaster_internal_DEV.Token(
	ID INT NOT NULL AUTO_INCREMENT,
	DARTokenID VARCHAR(20) NOT NULL,
	TokenName VARCHAR(255) NOT NULL,
	TokenDescription VARCHAR(1500) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	PRIMARY KEY (ID ASC, DARTokenID ASC, TokenName ASC));

*********************************************************************************************************

Listing
SQL SERVER SCRIPT
​​CREATE TABLE [dbo].[Listing](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[AssetID] [int] NOT NULL,
	[ExchangeID] [int] NOT NULL,
	[ExchangeAssetTicker] [nvarchar](20) NOT NULL,
	[ExchangeAssetName] [nvarchar](100) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Listing_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Listing_AssetIDExchangeIDExchangeAssetTickerExchangeAssetName] UNIQUE NONCLUSTERED 
(
	[AssetID] ASC,
	[ExchangeID] ASC,
	[ExchangeAssetTicker] ASC,
	[ExchangeAssetName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Listing_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT


CREATE TABLE refmaster_internal_DEV.Listing(
	ID INT NOT NULL AUTO_INCREMENT,
	AssetID BIGINT(16) NOT NULL,
	ExchangeID BIGINT(16) NOT NULL,
	ExchangeAssetTicker VARCHAR(20) NOT NULL,
	ExchangeAssetName VARCHAR(100) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, AssetID ASC,ExchangeID ASC, ExchangeAssetTicker ASC, ExchangeAssetName ASC ),
    SHARD KEY (AssetID ASC,ExchangeID ASC, ExchangeAssetTicker ASC, ExchangeAssetName ASC ));


EntityURLType
SQL SERVER SCRIPT
CREATE TABLE [dbo].[EntityURLType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[URLTypeID] [int] NOT NULL,
	[EntityID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_EntityURLType_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_EntityURLType_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.EntityURLType(
	ID INT NOT NULL AUTO_INCREMENT,
	URLTypeID BIGINT(16) NOT NULL,
	EntityID BIGINT(16) NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC));

EntityAvailabilityType
SQL SERVER SCRIPT
CREATE TABLE [dbo].[EntityAvailabilityType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[AvailabilityTypeID] [int] NOT NULL,
	[EntityID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_EntityAvailabilityType_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_EntityAvailabilityType_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.EntityAvailabilityType(
	ID INT NOT NULL AUTO_INCREMENT,
	AvailabilityTypeID BIGINT(16) NOT NULL,
	EntityID BIGINT(16) NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
     PRIMARY KEY (ID ASC));
 
AvailabilityType
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AvailabilityType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[APIName] [nvarchar](100) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_AvailabilityType_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_AvailabilityType_DisplayName] UNIQUE NONCLUSTERED 
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_AvailabilityType_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_AvailabilityType_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.AvailabilityType(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(100) NOT NULL,
	DisplayName VARCHAR(250) NOT NULL,
	APIName VARCHAR(100) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, DisplayName ASC, Name ASC),
	SHARD KEY (DisplayName ASC, Name ASC));


ExchangeURL
SQL SERVER SCRIPT
CREATE TABLE [dbo].[ExchangeURL](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[ExchangeID] [int] NOT NULL,
	[URLTypeID] [int] NOT NULL,
	[URLPath] [nvarchar](250) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_ExchangeURL_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_ExchangeURL_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT

 CREATE TABLE refmaster_internal_DEV.ExchangeURL(
	ID INT NOT NULL AUTO_INCREMENT,
	ExchangeID BIGINT(16) NOT NULL,
	URLTypeID BIGINT(16) NOT NULL,
	URLPath VARCHAR(250) NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC));

ExchangeAvailability
SQL SERVER SCRIPT
CREATE TABLE [dbo].[ExchangeAvailability](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[ExchangeID] [int] NOT NULL,
	[AvailabilityTypeID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_ExchangeAvailability_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_ExchangeAvailability_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.ExchangeAvailability(
	ID INT NOT NULL AUTO_INCREMENT,
	ExchangeID BIGINT(16) NOT NULL,
	AvailabilityTypeID BIGINT(16) NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC));

AssetAvailability
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AssetAvailability](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[AssetID] [int] NOT NULL,
	[AvailabilityTypeID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_AssetAvailability_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_AssetAvailability_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.AssetAvailability(
	ID INT NOT NULL AUTO_INCREMENT ,
	AssetID BIGINT(16) NOT NULL,
	AvailabilityTypeID BIGINT(16) NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	PRIMARY KEY (ID ASC));

Stage_CollectionValidation
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Stage_CollectionValidation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CollectionBatchID] [int] NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[Success] [bit] NULL,
	[ValidationResponse] [nvarchar](500) NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Stage_CollectionValidation_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.Stage_CollectionValidation(
	ID INT NOT NULL AUTO_INCREMENT,
	CollectionBatchID BIGINT(16) NULL,
	StartTime DATETIME NOT NULL,
	EndTime DATETIME NULL,
	Success TINYINT NULL,
	ValidationResponse VARCHAR(500) NULL,
	CreateTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC));

Stage_CollectedListing
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Stage_CollectedListing](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CollectionSourceID] [int] NOT NULL,
	[ExchangeAssetTicker] [nvarchar](100) NOT NULL,
	[ExchangeAssetName] [nvarchar](250) NULL,
	[ValidationTime] [datetime] NULL,
	[TickerMatch] [bit] NULL,
	[NameMatch] [bit] NULL,
	[ListingTickerMatch] [bit] NULL,
	[ListingNameMatch] [bit] NULL,
	[AssetID] [int] NULL,
	[ListingID] [int] NULL,
	[MatchesPrevious] [bit] NULL,
	[ExcludeDuplicate] [bit] NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Stage_CollectedListing_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.Stage_CollectedListing(
	ID INT NOT NULL AUTO_INCREMENT,
	CollectionSourceID BIGINT(16) NOT NULL,
	ExchangeAssetTicker VARCHAR(100) NOT NULL,
	ExchangeAssetName VARCHAR(250) NULL,
	ValidationTime DATETIME NULL,
	TickerMatch TINYINT NULL,
	NameMatch TINYINT NULL,
	ListingTickerMatch TINYINT NULL,
	ListingNameMatch TINYINT NULL,
	AssetID BIGINT(16) NULL,
	ListingID BIGINT(16) NULL,
	MatchesPrevious TINYINT NULL,
	ExcludeDuplicate TINYINT NULL,
	CreateTime DATETIME NOT NULL,
    	PRIMARY KEY (ID ASC));

Stage_CollectionSource
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Stage_CollectionSource](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CollectionBatchID] [int] NOT NULL,
	[EntityKey] [nvarchar](100) NOT NULL,
	[CollectionMethod] [int] NOT NULL,
	[StagingMethod] [int] NOT NULL,
	[PathLog] [nvarchar](500) NULL,
	[CollectedTime] [datetime] NOT NULL,
	[ValidationTime] [datetime] NULL,
	[MatchesPrevious] [bit] NULL,
	[UseInValidation] [bit] NULL,
	[EntityDbID] [int] NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Stage_CollectionSource_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.Stage_CollectionSource(
	ID INT NOT NULL AUTO_INCREMENT,
	CollectionBatchID BIGINT(16) NOT NULL,
	EntityKey VARCHAR(100) NOT NULL,
	CollectionMethod INT NOT NULL,
	StagingMethod INT NOT NULL,
	PathLog VARCHAR(500) NULL,
	CollectedTime DATETIME NOT NULL,
	ValidationTime DATETIME NULL,
	MatchesPrevious TINYINT NULL,
	UseInValidation TINYINT NULL,
	EntityDbID INT NULL,
	CreateTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC));

Stage_CollectionBatch
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Stage_CollectionBatch](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CollectionBatchTypeID] [int] NOT NULL,
	[EffectiveDate] [date] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[FailureMessage] [nvarchar](250) NULL,
	[PreviousBatchID] [int] NULL,
	[CollectionValidationID] [int] NULL,
	[MatchesPrevious] [bit] NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Stage_CollectionBatch_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.Stage_CollectionBatch(
	ID INT NOT NULL AUTO_INCREMENT,
	CollectionBatchTypeID BIGINT(16) NOT NULL,
	EffectiveDate DATE NOT NULL,
	StartTime DATETIME NOT NULL,
	EndTime DATETIME NULL,
	FailureMessage VARCHAR(250) NULL,
	PreviousBatchID INT NULL,
	CollectionValidationID BIGINT(16) NULL,
	MatchesPrevious TINYINT NULL,
	CreateTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC));

Stage_CollectionBatchType
SQL SERVER SCRIPT
CREATE TABLE [dbo].[Stage_CollectionBatchType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CollectedEntityID] [int] NOT NULL,
	[CollectionKeyAttributeID] [int] NOT NULL,
	[TargetEntityID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Stage_CollectionBatchType_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Stage_CollectionBatchType_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.Stage_CollectionBatchType(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(100) NOT NULL,
	CollectedEntityID BIGINT(16) NOT NULL,
	CollectionKeyAttributeID BIGINT(16) NOT NULL,
	TargetEntityID BIGINT(16) NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, Name ASC),
    SHARD KEY (Name ASC));

EventInformation_Audit
SQL SERVER SCRIPT
CREATE TABLE [dbo].[EventInformation_Audit](
	[ChangeID] [int] IDENTITY(10000,1) NOT NULL,
	[DAREventID] [nvarchar](20) NOT NULL,
	[DateofReview] [datetime] NULL,
	[EventTypeID] [int] NULL,
	[AssetID] [int] NULL,
	[SourceID] [int] NULL,
	[ExchangeAssetTicker] [nvarchar](20) NULL,
	[ExchangeAssetName] [nvarchar](100) NULL,
	[DARAssetID] [nvarchar](50) NULL,
	[EventType] [nvarchar](100) NULL,
	[EventDate] [datetime] NULL,
	[AnnouncementDate] [datetime] NULL,
	[EventDescription] [nvarchar](500) NULL,
	[SourceURL] [nvarchar](500) NULL,
	[EventStatus] [nvarchar](500) NULL,
	[Notes] [nvarchar](500) NULL,
	[Deleted] [nvarchar](500) NULL,
	[Exchange] [nvarchar](50) NULL,
	[BlockHeight] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[LastEditTime] [datetime] NULL,
	[operation] [varchar](15) NOT NULL
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.EventInformation_Audit(
	ChangeID INT NOT NULL AUTO_INCREMENT,
	DAREventID VARCHAR(20) NOT NULL,
	DateofReview DATETIME NULL,
	EventTypeID BIGINT(16) NULL,
	AssetID BIGINT(16) NULL,
	SourceID BIGINT(16) NULL,
	ExchangeAssetTicker VARCHAR(20) NULL,
	ExchangeAssetName VARCHAR(100) NULL,
	DARAssetID VARCHAR(50) NULL,
	EventType VARCHAR(100) NULL,
	EventDate DATETIME NULL,
	AnnouncementDate DATETIME NULL,
	EventDescription VARCHAR(500) NULL,
	SourceURL VARCHAR(500) NULL,
	EventStatus VARCHAR(500) NULL,
	Notes VARCHAR(500) NULL,
	Deleted VARCHAR(500) NULL,
	Exchange VARCHAR(50) NULL,
	BlockHeight INT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditUser VARCHAR(100) NULL,
	LastEditTime DATETIME NULL,
	operation VARCHAR(15) NOT NULL,
    PRIMARY KEY (ChangeID ASC));

ExchangeRowCount
SQL SERVER SCRIPT
CREATE TABLE [dbo].[ExchangeRowCount](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ExchangeName] [varchar](20) NOT NULL,
	[ExchangeRowCount] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ExchangeRowCount_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.ExchangeRowCount(
	ID INT NOT NULL AUTO_INCREMENT,
	ExchangeName VARCHAR(20) NOT NULL,
	ExchangeRowCount INT NOT NULL,
	CreateDate DATETIME NOT NULL,
     PRIMARY KEY (ID ASC));

SDataType
SQL SERVER SCRIPT
CREATE TABLE [dbo].[SDataType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[ParentTypeID] [int] NULL,
	[SqlDataType] [nvarchar](100) NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SDataType_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SDataType_DisplayName] UNIQUE NONCLUSTERED 
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SDataType_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SDataType_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.SDataType(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(100) NOT NULL,
	DisplayName VARCHAR(250) NOT NULL,
	Description VARCHAR(250) NULL,
	ParentTypeID INT NULL,
	SqlDataType VARCHAR(100) NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, DisplayName ASC, Name ASC),
    SHARD KEY (DisplayName ASC, Name ASC));

SEntity
SQL SERVER SCRIPT
CREATE TABLE [dbo].[SEntity](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SEntity_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEntity_DisplayName] UNIQUE NONCLUSTERED 
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEntity_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEntity_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.SEntity(
	ID INT NOT NULL AUTO_INCREMENT,
	CategoryID BIGINT(16) NOT NULL,
	Name VARCHAR(100) NOT NULL,
	DisplayName VARCHAR(250) NOT NULL,
	Description VARCHAR(250) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, DisplayName ASC, Name ASC),
    SHARD KEY (DisplayName ASC, Name ASC));


SEntityAttribute
SQL SERVER SCRIPT
CREATE TABLE [dbo].[SEntityAttribute](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[EntityID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[DataTypeID] [int] NOT NULL,
	[EnumerationID] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SEntityAttribute_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEntityAttribute_EntityIDDisplayName] UNIQUE NONCLUSTERED 
(
	[EntityID] ASC,
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEntityAttribute_EntityIDName] UNIQUE NONCLUSTERED 
(
	[EntityID] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEntityAttribute_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.SEntityAttribute(
	ID INT NOT NULL AUTO_INCREMENT,
	EntityID BIGINT(16) NOT NULL,
	Name VARCHAR(100) NOT NULL,
	DisplayName VARCHAR(250) NOT NULL,
	DataTypeID BIGINT(16) NOT NULL,
	EnumerationID BIGINT(16) NULL,
	Description VARCHAR(250) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, EntityID ASC, DisplayName ASC, Name ASC),
    SHARD KEY (EntityID ASC, DisplayName ASC, Name ASC));

SEntityCategory
SQL SERVER SCRIPT
CREATE TABLE [dbo].[SEntityCategory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SEntityCategory_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEntityCategory_DisplayName] UNIQUE NONCLUSTERED 
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEntityCategory_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEntityCategory_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.SEntityCategory(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(100) NOT NULL,
	DisplayName VARCHAR(250) NOT NULL,
	Description VARCHAR(250) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, DisplayName ASC, Name ASC),
    SHARD KEY (DisplayName ASC, Name ASC));

SEnumeration
SQL SERVER SCRIPT
CREATE TABLE [dbo].[SEnumeration](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IsSystem] [bit] NOT NULL,
	[IsPublic] [bit] NOT NULL,
	[LookupName] [nvarchar](100) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SEnumeration_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEnumeration_DisplayName] UNIQUE NONCLUSTERED 
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEnumeration_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEnumeration_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.SEnumeration(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(100) NOT NULL,
	DisplayName VARCHAR(250) NOT NULL,
	Description VARCHAR(250) NULL,
	IsSystem TINYINT NOT NULL,
	IsPublic TINYINT NOT NULL,
	LookupName VARCHAR(100) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	PRIMARY KEY (ID ASC, DisplayName ASC, Name ASC),
    SHARD KEY (DisplayName ASC, Name ASC));


SEnumerationValue
SQL SERVER SCRIPT
CREATE TABLE [dbo].[SEnumerationValue](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[EnumerationID] [int] NOT NULL,
	[ValueID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SEnumerationValue_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEnumerationValue_EnumerationIDDisplayName] UNIQUE NONCLUSTERED 
(
	[EnumerationID] ASC,
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEnumerationValue_EnumerationIDName] UNIQUE NONCLUSTERED 
(
	[EnumerationID] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEnumerationValue_EnumerationIDSortOrder] UNIQUE NONCLUSTERED 
(
	[EnumerationID] ASC,
	[SortOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEnumerationValue_EnumerationIDValueID] UNIQUE NONCLUSTERED 
(
	[EnumerationID] ASC,
	[ValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SEnumerationValue_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.SEnumerationValue(
	ID INT NOT NULL AUTO_INCREMENT,
	EnumerationID INT NOT NULL,
	ValueID INT NOT NULL,
	Name VARCHAR(100) NOT NULL,
	DisplayName VARCHAR(250) NOT NULL,
	SortOrder INT NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, EnumerationID ASC,DisplayName ASC, Name ASC, SortOrder ASC, ValueID ASC),
    SHARD KEY (EnumerationID ASC,DisplayName ASC, Name ASC, SortOrder ASC, ValueID ASC));
 

SIdentifierType
SQL SERVER SCRIPT
CREATE TABLE [dbo].[SIdentifierType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IsKey] [bit] NOT NULL,
	[IsUnique] [bit] NOT NULL,
	[IsNatural] [bit] NOT NULL,
	[IsGrouped] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SIdentifierType_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SIdentifierType_DisplayName] UNIQUE NONCLUSTERED 
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SIdentifierType_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SIdentifierType_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT

 CREATE TABLE refmaster_internal_DEV.SIdentifierType(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(100) NOT NULL,
	DisplayName VARCHAR(250) NOT NULL,
	Description VARCHAR(250) NULL,
	IsKey TINYINT NOT NULL,
	IsUnique TINYINT NOT NULL,
	IsNatural TINYINT NOT NULL,
	IsGrouped TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    	PRIMARY KEY (ID ASC, DisplayName ASC, Name ASC),
    	SHARD KEY (DisplayName ASC, Name ASC));

SSharedColumn
SQL SERVER SCRIPT
CREATE TABLE [dbo].[SSharedColumn](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[DataTypeID] [int] NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[DefaultExpression] [nvarchar](100) NULL,
	[IsSystem] [bit] NOT NULL,
	[IsDisplay] [bit] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsPrecedingSort] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[VersionID] [int] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SSharedColumn_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SSharedColumn_DisplayName] UNIQUE NONCLUSTERED 
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SSharedColumn_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SSharedColumn_SortOrder] UNIQUE NONCLUSTERED 
(
	[SortOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SSharedColumn_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
   
CREATE TABLE refmaster_internal_DEV.SSharedColumn(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(100) NOT NULL,
	DisplayName VARCHAR(250) NOT NULL,
	DataTypeID BIGINT(16) NOT NULL,
	IsRequired TINYINT NOT NULL,
	DefaultExpression VARCHAR(100) NULL,
	IsSystem TINYINT NOT NULL,
	IsDisplay TINYINT NOT NULL,
	SortOrder INT NOT NULL,
	IsPrecedingSort TINYINT NOT NULL,
	IsActive TINYINT NOT NULL,
	VersionID BIGINT(16) NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, DisplayName ASC, Name ASC, SortOrder ASC),
    SHARD KEY (DisplayName ASC, Name ASC, SortOrder ASC));
 

STable
SQL SERVER SCRIPT
CREATE TABLE [dbo].[STable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[TypeID] [int] NOT NULL,
	[EntityID] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[DisplayName] [nvarchar](250) NULL,
	[GenOrder] [int] NULL,
	[IsLookup] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[VersionID] [int] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_STable_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_STable_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.STable(
	ID INT NOT NULL AUTO_INCREMENT,
	TypeID BIGINT(16) NOT NULL,
	EntityID BIGINT(16) NOT NULL,
	Name VARCHAR(100) NULL,
	DisplayName VARCHAR(250) NULL,
	GenOrder INT NULL,
	IsLookup TINYINT NOT NULL,
	IsActive TINYINT NOT NULL,
	VersionID BIGINT(16) NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC ));

STableJoin
SQL SERVER SCRIPT
CREATE TABLE [dbo].[STableJoin](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[FromColumnID] [int] NOT NULL,
	[ToColumnID] [int] NOT NULL,
	[JoinTypeID] [int] NOT NULL,
	[JoinDirectionID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_STableJoin_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_STableJoin_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.STableJoin(
	ID INT NOT NULL AUTO_INCREMENT,
	FromColumnID BIGINT(16) NOT NULL,
	ToColumnID INT NOT NULL,
	JoinTypeID BIGINT(16) NOT NULL,
	JoinDirectionID BIGINT(16) NOT NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	PRIMARY KEY (ID ASC ));


STableJoinDirection
SQL SERVER SCRIPT
CREATE TABLE [dbo].[STableJoinDirection](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[SqlKeyword] [nvarchar](100) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_STableJoinDirection_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_STableJoinDirection_DisplayName] UNIQUE NONCLUSTERED 
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_STableJoinDirection_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_STableJoinDirection_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.STableJoinDirection(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(100) NOT NULL,
	DisplayName VARCHAR(250) NOT NULL,
	SqlKeyword VARCHAR(100) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, DisplayName ASC, Name ASC ),
    SHARD KEY (DisplayName ASC, Name ASC));
    

STableJoinType
SQL SERVER SCRIPT
CREATE TABLE [dbo].[STableJoinType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_STableJoinType_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_STableJoinType_DisplayName] UNIQUE NONCLUSTERED 
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_STableJoinType_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_STableJoinType_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.STableJoinType(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(100) NOT NULL,
	DisplayName VARCHAR(250) NOT NULL,
	Description VARCHAR(250) NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC, DisplayName ASC, Name ASC ),
    SHARD KEY (DisplayName ASC, Name ASC));

STableType
SQL SERVER SCRIPT
CREATE TABLE [dbo].[STableType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[NamePrefix] [nvarchar](10) NULL,
	[OverrideDataTypeID] [int] NULL,
	[CreateUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
	[LastEditUser] [nvarchar](100) NULL,
 CONSTRAINT [PK_STableType_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_STableType_DisplayName] UNIQUE NONCLUSTERED 
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_STableType_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_STableType_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.STableType(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(100) NOT NULL,
	DisplayName VARCHAR(250) NOT NULL,
	Description VARCHAR(250) NULL,
	NamePrefix VARCHAR(10) NULL,
	OverrideDataTypeID INT NULL,
	CreateUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
	LastEditUser VARCHAR(100) NULL,
	PRIMARY KEY (ID ASC, DisplayName ASC, Name ASC ),
    SHARD KEY (DisplayName ASC, Name ASC));



SSchemaVersion
SQL SERVER SCRIPT
​​CREATE TABLE [dbo].[SSchemaVersion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[DisplayName] [nvarchar](250) NULL,
	[Major] [int] NOT NULL,
	[Minor] [int] NOT NULL,
	[EffectiveStart] [date] NOT NULL,
	[EffectiveEnd] [date] NULL,
	[IsActive] [bit] NOT NULL,
	[CreateUser] [nvarchar](100) NULL,
	[LastEditUser] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastEditTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SSchemaVersion_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_SSchemaVersion_UniqueID] UNIQUE NONCLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.SSchemaVersion(
	ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(100) NULL,
	DisplayName VARCHAR(250) NULL,
	Major INT NOT NULL,
	Minor INT NOT NULL,
	EffectiveStart DATE NOT NULL,
	EffectiveEnd DATE NULL,
	IsActive TINYINT NOT NULL,
	CreateUser VARCHAR(100) NULL,
	LastEditUser VARCHAR(100) NULL,
	CreateTime DATETIME NOT NULL,
	LastEditTime DATETIME NOT NULL,
    PRIMARY KEY (ID ASC));
    


BlackListedRefId
SQL SERVER SCRIPT
CREATE TABLE [dbo].[BlackListedRefId](
	[DARRefId] [nvarchar](20) NOT NULL,
UNIQUE NONCLUSTERED 
(
	[DARRefId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.BlackListedRefId(
	DARRefId VARCHAR(20) NOT NULL,
    PRIMARY KEY (DARRefId ASC));

vAssetCustodian
SQL SERVER SCRIPT
CREATE VIEW [dbo].[vAssetCustodian]
--WITH ENCRYPTION
AS
select a.ID as AssetID,c.Name as Custodian
from AssetCustodian t
inner join Asset a on t.assetid = a.Id
inner join Custodian c on t.CustodianID = c.Id;
SINGLE STORE SCRIPT
CREATE VIEW vAssetCustodian
AS
select a.ID as AssetID,c.Name as Custodian
from AssetCustodian t
inner join Asset a on t.assetid = a.Id
inner join Custodian c on t.CustodianID = c.Id;


vAssetTheme
SQL SERVER SCRIPT
CREATE VIEW [dbo].[vAssetTheme]
--WITH ENCRYPTION
AS
	select ta.AssetId
		,th.Name as Theme
		,th.ThemeType
	from Theme th
	inner join dbo.AssetTheme ta on th.id = ta.ThemeID;
SINGLE STORE SCRIPT
use refmaster_internal_DEV;
CREATE VIEW vAssetTheme
AS
	select ta.AssetId
	,th.Name as Theme
	,th.ThemeType
	from Theme th
	inner join AssetTheme ta on th.id = ta.ThemeID;


vAssetToken
SQL SERVER SCRIPT
CREATE VIEW [dbo].[vAssetToken]
--WITH ENCRYPTION
AS
select
	atb.ID
	,a.DARAssetID
	, a.DARTicker
	, a.Name as AssetName
	,t.DARTokenID
	,t.TokenName
	,b.Name as BlockChain
	, atb.TokenContractAddress
	,b.ConsensusMechanism
	,b.HashAlgorithm
from dbo.AssetToken atb
inner join dbo.Asset a on atb.AssetID = a.ID
inner join dbo.Token t on atb.TokenId = t.ID
inner join dbo.BlockChain b on atb.BlockChainId = b.ID;

SINGLE STORE SCRIPT
CREATE VIEW vAssetToken
AS
select
	atb.ID
	,a.DARAssetID
	, a.DARTicker
	, a.Name as AssetName
	,t.DARTokenID
	,t.TokenName
	,b.Name as BlockChain
	, atb.TokenContractAddress
	,b.ConsensusMechanism
	,b.HashAlgorithm
from AssetToken atb
inner join Asset a on atb.AssetID = a.ID
inner join Token t on atb.TokenId = t.ID
inner join BlockChain b on atb.BlockChainId = b.ID;


vExchange
SQL SERVER SCRIPT
CREATE VIEW [dbo].[vExchange]
--WITH ENCRYPTION
AS

	SELECT
		  v.ID AS ExchangeID
		, v.UniqueID
		
		, v.DARExchangeID
		, v.ShortName
		, v.ExchangeType	AS ExchangeTypeEnumerationValueID
		, ev.ValueID		AS ExchangeTypeValueID
		, ev.[Name]			AS ExchangeTypeName
		, ev.DisplayName	AS ExchangeTypeDisplayName

		, v.IsActive
		
		, v.CreateTime
		, v.CreateUser
		, v.LastEditTime
		, v.LastEditUser
	FROM
		dbo.Exchange AS v
		LEFT JOIN dbo.SEnumerationValue AS ev ON v.ExchangeType = ev.ID;

SINGLE STORE SCRIPT
use refmaster_internal_DEV;
CREATE VIEW vExchange
AS

	SELECT
		  v.ID AS ExchangeID
		, v.DARExchangeID
		, v.ShortName
		, v.ExchangeType	AS ExchangeTypeEnumerationValueID
		, ev.ValueID		AS ExchangeTypeValueID
		, ev.Name   		AS ExchangeTypeName
		, ev.DisplayName	AS ExchangeTypeDisplayName
		, v.IsActive
		, v.CreateTime
		, v.CreateUser
		, v.LastEditTime
		, v.LastEditUser
	FROM
		Exchange AS v
		LEFT JOIN SEnumerationValue AS ev ON v.ExchangeType = ev.ID;

vExchangePair
SQL SERVER SCRIPT
CREATE VIEW [dbo].[vExchangePair]
--WITH ENCRYPTION
AS
	SELECT
		  v.ID AS ExchangePairID
		, v.UniqueID
		, e.ID			AS ExchangeID
		, e.DARExchangeID
		, e.ShortName	AS ExchangeShortName
		, a.ID			AS AssetID
		, a.DARAssetID
		, a.DARTicker	AS AssetDARTicker
		, qa.ID			AS QuoteAssetID
		, qa.DARAssetID AS QuoteDARAssetID
		, qa.DARTicker	AS QuoteAssetDARTicker
		, p.ID			AS PairID
		, p.DARName		AS PairDARName
		, v.ExchangePairName
		, v.IsActive
		, v.CreateTime
		, v.CreateUser
		, v.LastEditTime
		, v.LastEditUser
	FROM
		dbo.ExchangePair AS v
		INNER JOIN dbo.Pair AS p ON p.ID = v.PairID
		INNER JOIN dbo.Asset AS a ON a.ID = p.AssetID
		INNER JOIN dbo.Asset AS qa ON qa.ID = p.QuoteAssetID
		INNER JOIN dbo.Exchange AS e ON e.ID = v.ExchangeID;

SINGLE STORE SCRIPT
CREATE VIEW vExchangePair
AS

	SELECT
		  v.ID AS ExchangePairID
		, e.ID			AS ExchangeID
		, e.DARExchangeID
		, e.ShortName	AS ExchangeShortName
		, a.ID			AS AssetID
		, a.DARAssetID
		, a.DARTicker	AS AssetDARTicker
		, qa.ID			AS QuoteAssetID
		, qa.DARAssetID AS QuoteDARAssetID
		, qa.DARTicker	AS QuoteAssetDARTicker
		, p.ID			AS PairID
		, p.DARName		AS PairDARName
		, v.ExchangePairName
		, v.IsActive
		, v.CreateTime
		, v.CreateUser
		, v.LastEditTime
		, v.LastEditUser
	FROM
		ExchangePair AS v
		INNER JOIN Pair AS p ON p.ID = v.PairID
		INNER JOIN Asset AS a ON a.ID = p.AssetID
		INNER JOIN Asset AS qa ON qa.ID = p.QuoteAssetID
		INNER JOIN Exchange AS e ON e.ID = v.ExchangeID;

vListing
SQL SERVER SCRIPT
CREATE VIEW [dbo].[vListing]
--WITH ENCRYPTION
AS

	SELECT
		  v.ID AS ListingID
		, v.UniqueID
	
		, a.ID AS AssetID
		, a.DARAssetID
		, a.DARTicker AS AssetDARTicker
		, a.[Name] AS AssetName
		, e.ID AS ExchangeID
		, e.DARExchangeID
		, e.ShortName AS ExchangeShortName
		, v.ExchangeAssetTicker
		, v.ExchangeAssetName

		, v.IsActive
		
		, v.CreateTime
		, v.CreateUser
		, v.LastEditTime
		, v.LastEditUser
	FROM
		dbo.Listing AS v
		INNER JOIN dbo.Exchange AS e ON e.ID = v.ExchangeID
		INNER JOIN dbo.Asset AS a ON a.ID = v.AssetID;

SINGLE STORE SCRIPT
CREATE VIEW vListing
AS
	SELECT
		  v.ID AS ListingID
		, a.ID AS AssetID
		, a.DARAssetID
		, a.DARTicker AS AssetDARTicker
		, a.Name AS AssetName
		, e.ID AS ExchangeID
		, e.DARExchangeID
		, e.ShortName AS ExchangeShortName
		, v.ExchangeAssetTicker
		, v.ExchangeAssetName
		, v.IsActive
		, v.CreateTime
		, v.CreateUser
		, v.LastEditTime
		, v.LastEditUser
	FROM
		Listing AS v
		INNER JOIN Exchange AS e ON e.ID = v.ExchangeID
		INNER JOIN Asset AS a ON a.ID = v.AssetID;


vClientAssets
SQL SERVER SCRIPT
CREATE VIEW [dbo].[vClientAssets]
--WITH ENCRYPTION
AS
select ca.ID
		,c.ClientName
		,c.[Description]
		,c.CallerID
		,a.DARAssetID
		,a.Name as AssetName
		,a.DARTicker
		,coalesce(ca.ReferenceData,0) as ReferenceData
		,coalesce(ca.Price,0) as Price
		,a.ID as AssetID
		,c.ID as ClientID
from dbo.Clients c
inner join dbo.ClientAssets ca on c.ID = ca.ClientID
inner join dbo.Asset a on a.ID = ca.AssetID;


SINGLE STORE SCRIPT
use refmaster_internal_DEV;
CREATE VIEW vClientAssets
AS
select ca.ID
		,c.ClientName
		,c.Description
		,c.CallerID
		,a.DARAssetID
		,a.Name as AssetName
		,a.DARTicker
		,coalesce(ca.ReferenceData,0) as ReferenceData
		,coalesce(ca.Price,0) as Price
		,a.ID as AssetID
		,c.ID as ClientID
from Clients c
inner join ClientAssets ca on c.ID = ca.ClientID
inner join Asset a on a.ID = ca.AssetID;


OutstandingSupply_Audit
SQL SERVER SCRIPT
CREATE TABLE [dbo].[OutstandingSupply_Audit](
	[ChangeID] [int] IDENTITY(10000,1) NOT NULL,
	[ID] [nvarchar](20) NOT NULL,
	[AssetID] [int] NOT NULL,
	[ProcessID] [int] NOT NULL,
	[OutstandingSupply] [decimal](18, 0) NULL,
	[CollectedTimeStamp] [datetime] NULL,
	[IsActive] [bit] NULL,
	[Reviewed] [bit] NULL,
	[operation] [varchar](15) NOT NULL
) ON [PRIMARY]


SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.OutstandingSupply_Audit(
	ChangeID INT NOT NULL AUTO_INCREMENT,
	operation VARCHAR(15) NOT NULL,
	ID BIGINT(16) NOT NULL,
	AssetID INT NOT NULL,
	ProcessID INT NOT NULL,
	OutstandingSupply DECIMAL(18, 0) NOT NULL,
	CollectedTimeStamp DATETIME NULL,
	IsActive TINYINT NULL,
	Reviewed TINYINT NULL,
    PRIMARY KEY (ChangeID ASC));


AspNetUsers -> Users
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.Users(
	Id VARCHAR(128) NOT NULL,
	Email VARCHAR(256) NULL,
	EmailConfirmed TINYINT NOT NULL,
	PasswordHash TEXT NULL,
	SecurityStamp TEXT NULL,
	PhoneNumber TEXT NULL,
	PhoneNumberConfirmed TINYINT NOT NULL,
	TwoFactorEnabled TINYINT NOT NULL,
	LockoutEndDateUtc DATETIME NULL,
	LockoutEnabled TINYINT NOT NULL,
	AccessFailedCount INT NOT NULL,
	UserName VARCHAR(256) NOT NULL,
    PRIMARY KEY (Id ASC));


AspNetUserClaims -> UserClaims
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.UserClaims(
	ID INT NOT NULL AUTO_INCREMENT,
	UserId VARCHAR(128) NOT NULL,
	ClaimType LONGTEXT NOT NULL,
    ClaimValue LONGTEXT NULL,
    ProductVersion VARCHAR(32)  NULL,
    PRIMARY KEY (ID ASC),
    SHARD KEY ( ID ASC));
AspNetUserLogins -> UserLogins
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO

SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.UserLogins(
	LoginProvider VARCHAR(128) NOT NULL,
	ProviderKey VARCHAR(128) NOT NULL,
	UserId VARCHAR(128) NOT NULL,
	PRIMARY KEY (LoginProvider ASC,ProviderKey ASC,UserId ASC),
	SHARD KEY ( LoginProvider ASC,ProviderKey ASC,UserId ASC));


AspNetRoles ->  NetRoles
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT

CREATE TABLE refmaster_internal_DEV.Roles(
	Id VARCHAR(128) NOT NULL,
	Name VARCHAR(256) NOT NULL,
    PRIMARY KEY (ID ASC));

AspNetUserRoles -> UserRoles
SQL SERVER SCRIPT
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
SINGLE STORE SCRIPT
CREATE TABLE refmaster_internal_DEV.UserRoles(
	UserId VARCHAR(128) NOT NULL,
	RoleId VARCHAR(128) NOT NULL,
    PRIMARY KEY (UserId ASC, RoleId ASC));


CREATE TABLE refmaster_internal_DEV.DerivativesRisk(
ContractTicker VARCHAR(500) NOT NULL,
DARContractID VARCHAR(500) NOT NULL,
tick_size double NULL,
taker_commission double NULL,
strike double NULL,
settlement_period nvarchar(100) NULL,
settlement_currency nvarchar(100) NULL,
rfq TINYINT NULL,
quote_currency nvarchar(100) NULL,
price_index nvarchar(100) NULL,
option_type nvarchar(100) NULL,
min_trade_amount float NULL,
maker_commission double NULL,
kind nvarchar(100) NULL,
is_active TINYINT NULL,
instrument_name nvarchar(150) NULL,
instrument_id INT NULL,
expiration_timestamp nvarchar(50) NULL,
creation_timestamp nvarchar(50) NULL,
counter_currency nvarchar(50) NULL,
contract_size float NULL,
block_trade_commission  double NULL,
base_currency nvarchar(50) NULL,
max_liquidation_commission double NULL,
max_leverage INT NULL,
future_type nvarchar(50) NULL,
underlying_price double NULL,
underlying_index nvarchar(50) NULL,
timestamp nvarchar(50) NULL,
stats_volume float NULL,
stats_price_change float NULL,
stats_low double NULL,
stats_high double NULL,
state nvarchar(50) NULL,
settlement_price double NULL,
open_interest double NULL,
min_price double NULL,
max_price double NULL,
mark_price double NULL,
mark_iv float NULL,
last_price double NULL,
interest_rate INT,
index_price double NULL,
greeks_vega float NULL,
greeks_theta float NULL,
greeks_rho float NULL,
greeks_gamma float NULL,
greeks_delta float NULL,
estimated_delivery_price nvarchar(50) NULL,
bid_iv float NULL,
best_bid_price float NULL,
best_bid_amount float NULL,
best_ask_price float NULL,
best_ask_amount float NULL,
ask_iv float NULL,
PRIMARY KEY (instrument_id ASC));


CREATE TABLE refmaster_internal_DEV.DerivativesContractID(
ContractTicker VARCHAR(500) NOT NULL,
DARContractID VARCHAR(500) NOT NULL,
PRIMARY KEY (ContractTicker ASC, DARContractID ASC)
 )

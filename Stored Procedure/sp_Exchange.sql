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
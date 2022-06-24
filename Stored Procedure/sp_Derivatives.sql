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

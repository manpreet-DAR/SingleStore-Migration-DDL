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

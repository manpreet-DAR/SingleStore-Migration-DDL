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
				
                SELECT Count(*) FROM Pair WHERE ID=_PairID into v_del_count2;

                
                IF(v_del_count2=0) Then
					DELETE FROM ExchangePair WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Pair field (PairID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;
use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLPair(
_OPERATION VARCHAR(20),
_AssetID INT,
_QuoteAssetID INT,
_DARName VARCHAR(20),
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_id BIGINT(16) =  _ID;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_del_count1 INT =0;
        v_del_count2 INT =0;
       
        BEGIN
            SELECT Count(*) FROM Pair WHERE DARName=_DARName into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Pair( AssetID, QuoteAssetID, DARName, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _AssetID,_QuoteAssetID, _DARName,_CreateUser,_LastEditUser,_IsActive, v_date, v_date);
					COMMIT;
                    SELECT ID FROM Pair WHERE DARName=_DARName into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Pair SET AssetID=_AssetID, QuoteAssetID=_QuoteAssetID, LastEditUser=_LastEditUser, LastEditTime=v_date, IsActive=_IsActive WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM  ExchangePair WHERE PairID=_ID into v_del_count1;
				SELECT Count(*) FROM  ServingList WHERE PairID=_ID into v_del_count2;
            
			IF(v_del_count1=0 and v_del_count2=0) Then
				DELETE FROM Pair WHERE ID=_ID;
				COMMIT;
				ECHO SELECT _ID as "ID", 'Data Deleted';
			ELSEIF v_del_count1 !=0 Then
				ECHO SELECT "Foreign Key constraint violet here for Table ExchangePair field (PairID,Id)";
			ELSEIF v_del_count2 !=0 Then
				ECHO SELECT "Foreign Key constraint violet here for Table ServingList field (PairID,Id)";
				END IF;
            END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStage_CollectionValidation(
_OPERATION VARCHAR(20),
_StartTime DATETIME,
_ID BIGINT(16) DEFAULT 0,
_CollectionBatchID INT DEFAULT NULL,
_EndTime DATETIME DEFAULT NULL,
_Success TINYINT DEFAULT NULL,
_ValidationResponse VARCHAR(500) DEFAULT NULL

) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM Stage_CollectionValidation WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Stage_CollectionValidation( StartTime, CollectionBatchID,EndTime,Success,ValidationResponse, CreateTime)
                    values( _StartTime, _CollectionBatchID, _EndTime,_Success,_ValidationResponse, v_date);
					COMMIT;
                    SELECT ID FROM Stage_CollectionValidation WHERE StartTime=_StartTime and  CreateTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Stage_CollectionValidation SET StartTime=_StartTime, CollectionBatchID=_CollectionBatchID ,EndTime=_EndTime  ,Success=_Success ,ValidationResponse=_ValidationResponse
                        WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
                        
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM Stage_CollectionBatch WHERE ID= _CollectionBatchID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM Stage_CollectionValidation WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Stage_CollectionBatch field (CollectionBatchID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;
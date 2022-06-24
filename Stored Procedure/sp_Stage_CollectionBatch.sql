use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStage_CollectionBatch(
_OPERATION VARCHAR(20),
_CollectionBatchTypeID INT,
_EffectiveDate DATE,
_StartTime DATETIME ,
_ID BIGINT(16) DEFAULT 0,
_EndTime DATETIME DEFAULT NULL,
_FailureMessage VARCHAR(250) DEFAULT NULL,
_PreviousBatchID INT DEFAULT NULL,
_CollectionValidationID INT DEFAULT NULL,
_MatchesPrevious TINYINT DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
        v_del_count2 int =0;
        v_del_count3 int =0;
       
        BEGIN
            SELECT Count(*) FROM Stage_CollectionBatch WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Stage_CollectionBatch( CollectionBatchTypeID, EffectiveDate, StartTime, EndTime, FailureMessage,PreviousBatchID,CollectionValidationID, MatchesPrevious, CreateTime)
                    values( _CollectionBatchTypeID, _EffectiveDate, _StartTime, _EndTime,_FailureMessage,_PreviousBatchID,_CollectionValidationID,_MatchesPrevious, v_date);
					COMMIT;
                    SELECT ID FROM Stage_CollectionBatch WHERE CollectionBatchTypeID=_CollectionBatchTypeID and  EffectiveDate=_EffectiveDate and StartTime=_StartTime and CreateTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Stage_CollectionBatch SET CollectionBatchTypeID=_CollectionBatchTypeID, EffectiveDate=_EffectiveDate ,StartTime=_StartTime ,EndTime=_EndTime,
                        FailureMessage=_FailureMessage,PreviousBatchID=_PreviousBatchID,CollectionValidationID=_CollectionValidationID, MatchesPrevious=_MatchesPrevious WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
                        
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then

                SELECT Count(*) FROM Stage_CollectionBatch WHERE PreviousBatchID= _ID into v_del_count1;
                SELECT Count(*) FROM Stage_CollectionSource WHERE CollectionBatchID= _ID into v_del_count2;
                SELECT Count(*) FROM Stage_CollectionValidation WHERE CollectionBatchID= _ID into v_del_count3;
                
                IF(v_del_count1 =0 and v_del_count2 =0 and v_del_count3 =0 ) Then
					DELETE FROM Stage_CollectionBatch WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Stage_CollectionBatch field (PreviousBatchID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Stage_CollectionSource field (CollectionBatchID,Id)";
				ELSEIF v_del_count3 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Stage_CollectionValidation field (CollectionBatchID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;
use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStage_CollectionSource(
_OPERATION VARCHAR(20),
_CollectionBatchID INT,
_EntityKey VARCHAR(100),
_CollectionMethod INT,
_StagingMethod INT,
_CollectedTime DATETIME,
_ID BIGINT(16) DEFAULT 0,
_PathLog VARCHAR(500) DEFAULT NULL,
_ValidationTime DATETIME DEFAULT NULL,
_MatchesPrevious TINYINT DEFAULT NULL,
_UseInValidation TINYINT DEFAULT NULL,
_EntityDbID INT DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM Stage_CollectionSource WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Stage_CollectionSource( CollectionBatchID, EntityKey, CollectionMethod,StagingMethod,CollectedTime, PathLog, ValidationTime,MatchesPrevious,UseInValidation, EntityDbID, CreateTime)
                    values( _CollectionBatchID, _EntityKey, _CollectionMethod,_StagingMethod,_CollectedTime, _PathLog,_ValidationTime,_MatchesPrevious,_UseInValidation,_EntityDbID, v_date);
					COMMIT;
                    SELECT ID FROM Stage_CollectionSource WHERE CollectionBatchID=_CollectionBatchID and  EntityKey=_EntityKey and CollectionMethod=_CollectionMethod and StagingMethod=_StagingMethod and CollectedTime=_CollectedTime and CreateTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Stage_CollectionSource SET CollectionBatchID=_CollectionBatchID, EntityKey=_EntityKey ,CollectionMethod=_CollectionMethod  ,StagingMethod=_StagingMethod ,CollectedTime=_CollectedTime
                        ,PathLog=_PathLog,ValidationTime=_ValidationTime,MatchesPrevious=_MatchesPrevious, UseInValidation=_UseInValidation, EntityDbID=_EntityDbID WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
                        
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM Stage_CollectedListing WHERE CollectionSourceID=_ID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM Stage_CollectionSource WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Stage_CollectedListing field (CollectionSourceID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

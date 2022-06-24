use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStage_CollectionBatchType(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_CollectedEntityID INT ,
_CollectionKeyAttributeID INT ,
_TargetEntityID INT ,
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM Stage_CollectionBatchType WHERE Name=_Name or ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Stage_CollectionBatchType( Name,CollectedEntityID,CollectionKeyAttributeID,TargetEntityID,  IsActive,CreateTime)
                    values( _Name,_CollectedEntityID,_CollectionKeyAttributeID,_TargetEntityID,_IsActive,v_date);
					COMMIT;
                    SELECT ID FROM Stage_CollectionBatchType WHERE Name=_Name and CreateTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Stage_CollectionBatchType SET CollectedEntityID=_CollectedEntityID,CollectionKeyAttributeID=_CollectionKeyAttributeID, TargetEntityID=_TargetEntityID,
						IsActive=_IsActive WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM Stage_CollectionBatch WHERE CollectionBatchTypeID=_ID into v_del_count1;
                
                IF(v_del_count1 =0) Then
					DELETE FROM Stage_CollectionBatchType WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Stage_CollectionBatch field (CollectionBatchTypeID,Id)";
				END IF;
                
			END IF;
            Return v_id;
END //
DELIMITER ;
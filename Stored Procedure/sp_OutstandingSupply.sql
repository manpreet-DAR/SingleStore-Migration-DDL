use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLOutstandingSupply(
_OPERATION VARCHAR(20),
_OutstandingSupply DECIMAL(18, 0),
_AssetID BIGINT(16),
_ProcessID BIGINT(16),
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1,
_Reviewed TINYINT DEFAULT NULL)RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_id BIGINT(16) =  _ID;
        v_date DATETIME = CURRENT_TIMESTAMP();
       
        BEGIN
            SELECT Count(*) FROM OutstandingSupply WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO OutstandingSupply( OutstandingSupply, AssetID, ProcessID, CollectedTimeStamp, IsActive, Reviewed)
                    values( _OutstandingSupply,_AssetID, _ProcessID,v_date,_IsActive, _Reviewed);
					COMMIT;
                    SELECT ID FROM OutstandingSupply WHERE OutstandingSupply=_OutstandingSupply and AssetID=_AssetID and ProcessID=_ProcessID and CollectedTimeStamp=v_date and IsActive=_IsActive into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE OutstandingSupply SET OutstandingSupply=_OutstandingSupply, AssetID=_AssetID, ProcessID=_ProcessID, CollectedTimeStamp=v_date, IsActive=_IsActive , Reviewed=_Reviewed WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                DELETE FROM OutstandingSupply WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;

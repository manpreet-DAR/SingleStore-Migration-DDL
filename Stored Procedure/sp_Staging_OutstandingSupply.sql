use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStaging_OutstandingSupply(
_OPERATION VARCHAR(20),
_SourceId INT,
_AssetID INT,
_ProcessID INT,
_OutstandingSupply DECIMAL(18, 0),
_ID BIGINT(16) DEFAULT 0,
_Error VARCHAR(500) DEFAULT NULL,
_PassedValidation TINYINT DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_Reviewed TINYINT DEFAULT NULL,
_OutstandingSupplyReviewed DECIMAL(18, 0) DEFAULT NULL,
_BaseDataAvailable TINYINT DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM Staging_OutstandingSupply WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Staging_OutstandingSupply( SourceId, AssetID,ProcessID,OutstandingSupply,Error,CollectedTimeStamp, PassedValidation,IsActive,Reviewed,OutstandingSupplyReviewed,BaseDataAvailable)
                    values( _SourceId, _AssetID, _ProcessID,_OutstandingSupply,_Error,v_date, _PassedValidation,_IsActive, _Reviewed,_OutstandingSupplyReviewed,_BaseDataAvailable);
					COMMIT;
                    SELECT ID FROM Staging_OutstandingSupply WHERE SourceId=_SourceId and  AssetID=_AssetID and ProcessID=_ProcessID and OutstandingSupply=_OutstandingSupply and CollectedTimeStamp=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Staging_OutstandingSupply SET SourceId=_SourceId, AssetID=_AssetID ,ProcessID=_ProcessID  ,OutstandingSupply=_OutstandingSupply ,Error=_Error,PassedValidation=_PassedValidation,IsActive=_IsActive,
                        Reviewed=_Reviewed, OutstandingSupplyReviewed=_OutstandingSupplyReviewed, BaseDataAvailable=_BaseDataAvailable WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
                        
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				DELETE FROM Staging_OutstandingSupply WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;
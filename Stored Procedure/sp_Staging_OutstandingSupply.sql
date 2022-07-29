use refmaster_internal;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStaging_OutstandingSupply(
_OPERATION VARCHAR(20),
_SourceId BIGINT,
_darAssetID VARCHAR(20),
_ProcessID INT,
_OutstandingSupply DECIMAL(18, 0),
_Error VARCHAR(500) DEFAULT NULL,
_PassedValidation TINYINT DEFAULT NULL,
_Reviewed TINYINT DEFAULT NULL,
_OutstandingSupplyReviewed DECIMAL(18, 0) DEFAULT NULL,
_BaseDataAvailable TINYINT DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) = _darAssetID ;
       
        BEGIN
            SELECT Count(*) INTO v_count FROM Staging_OutstandingSupply 
            WHERE darAssetID =_darAssetID AND ProcessID=_ProcessID AND SourceId=_SourceId;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") then
				IF(v_count = 0) Then
					INSERT INTO Staging_OutstandingSupply( SourceId,darAssetID,ProcessID,OutstandingSupply,Error,CollectedTimeStamp, PassedValidation,Reviewed,OutstandingSupplyReviewed,BaseDataAvailable)
                    values( _SourceId, _darAssetID, _ProcessID,_OutstandingSupply,_Error,v_date, _PassedValidation,_Reviewed,_OutstandingSupplyReviewed,_BaseDataAvailable);
					COMMIT;
                    ECHO SELECT "Insert" AS RowOutput;
   
				ELSEIF(v_count = 1) Then
						UPDATE Staging_OutstandingSupply SET SourceId=_SourceId, ProcessID=_ProcessID, OutstandingSupply=_OutstandingSupply ,Error=_Error,PassedValidation=_PassedValidation,IsActive=_IsActive,
                        Reviewed=_Reviewed, OutstandingSupplyReviewed=_OutstandingSupplyReviewed, BaseDataAvailable=_BaseDataAvailable WHERE 
                        (darAssetID =_darAssetID AND ProcessID=_ProcessID AND SourceId=_SourceId);
						ECHO SELECT "Update" as RowOutput;
                        
				ELSEIF(v_count > 1) Then
					ECHO SELECT 'Duplicate Key Error' as RowOutput;
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				DELETE FROM Staging_OutstandingSupply 
                WHERE darAssetID =_darAssetID AND ProcessID=_ProcessID AND SourceId=_SourceId;
				COMMIT;
				ECHO SELECT "Delete" as RowOutput;
			END IF;
            Return v_id;
END //
DELIMITER ;
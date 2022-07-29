use refmaster_internal;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLOutstandingSupply(
_OPERATION VARCHAR(20),
_OutstandingSupply DECIMAL(18, 0),
_DARAssetID VARCHAR(20),
_ProcessID BIGINT(16),
_Reviewed TINYINT DEFAULT FALSE)RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_id BIGINT(16)=_DARAssetID; 
        v_date DATETIME = CURRENT_TIMESTAMP();
       
        BEGIN
            SELECT Count(*) FROM OutstandingSupply WHERE darAssetID=_DARAssetID AND ProcessID=_ProcessID INTO v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO OutstandingSupply( OutstandingSupply, darAssetID, ProcessID, CollectedTimeStamp, LoadTimeStamp, Reviewed)
                    VALUES(_OutstandingSupply,_AssetID, _ProcessID,v_date,v_date, _Reviewed);
					COMMIT;
                    SELECT ID FROM OutstandingSupply 
                    WHERE OutstandingSupply=_OutstandingSupply 
                    AND darAssetID=_DARAssetID AND ProcessID=_ProcessID AND CollectedTimeStamp=v_date into v_id;
                    ECHO SELECT 'Insert' AS RowOutput;
				ELSEIF(v_count = 1) Then
						UPDATE OutstandingSupply SET OutstandingSupply=_OutstandingSupply, darAssetID=_DARAssetID, ProcessID=_ProcessID, CollectedTimeStamp=v_date, IsActive=_IsActive , Reviewed=_Reviewed WHERE ID=_ID;
						ECHO SELECT 'Update' AS RowOutput;
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Cannot add or update row: ER_DUP_ENTRY_WITH_KEY_NAME' AS RowOutput;
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                DELETE FROM OutstandingSupply WHERE darAssetID = _DARAssetID AND _ProcessID=_ProcessID;
				COMMIT;
				ECHO SELECT 'Delete' AS RowOutput;
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetVettingStatus(
_OPERATION VARCHAR(20),
_AssetID BIGINT(16),
_ProcessId BIGINT(16),
_VettingStatusId BIGINT(16),
_IndexStatus INT DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        BEGIN
            SELECT Count(*) FROM AssetVettingStatus WHERE AssetID=_AssetID and ProcessId=_ProcessId and VettingStatusId=_VettingStatusId into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO AssetVettingStatus(AssetID, ProcessId, VettingStatusId, IndexStatus, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_AssetID, _ProcessId, _VettingStatusId, _IndexStatus, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT Id FROM AssetVettingStatus WHERE AssetID=_AssetID and ProcessId=_ProcessId and VettingStatusId=_VettingStatusId into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE AssetVettingStatus SET AssetID=_AssetID , ProcessId=_ProcessId, VettingStatusId=_VettingStatusId, IndexStatus=_IndexStatus, IsActive= _IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				DELETE FROM AssetVettingStatus WHERE Id=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;
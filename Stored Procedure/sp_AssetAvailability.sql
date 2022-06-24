use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetAvailability(
_OPERATION VARCHAR(20),
_AssetID BIGINT(16) ,
_AvailabilityTypeID BIGINT(16) ,
_CreateUser VARCHAR(100)DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) = _ID;
        BEGIN
            SELECT Count(*) FROM  AssetAvailability WHERE Id=_Id into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO  AssetAvailability(AssetID, AvailabilityTypeID, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_AssetID, _AvailabilityTypeID, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT ID FROM AssetAvailability WHERE AssetID=_AssetID and AvailabilityTypeID=_AvailabilityTypeID and CreateUser=_CreateUser and IsActive=_IsActive and CreateTime=v_date and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID", 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE  AssetAvailability SET AssetID=_AssetID , AvailabilityTypeID=_AvailabilityTypeID, IsActive=_IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_ID;
						ECHO SELECT v_id as "ID",  'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				DELETE FROM  AssetAvailability WHERE Id=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID",  'Data Deleted';
			END IF;
					
            Return v_id;
END //
DELIMITER ;

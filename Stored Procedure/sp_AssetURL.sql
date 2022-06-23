use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetURL(
_OPERATION VARCHAR(20),
_AssetID BIGINT(16),
_URLTypeID INT,
_URLPath VARCHAR(1500) DEFAULT NULL,
_CreateUser VARCHAR(100)DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_del_count1 INT =0;
        v_id BIGINT(16) =  _ID;
        BEGIN
			SELECT Count(*) FROM  AssetURL WHERE AssetID=_AssetID AND URLTypeID=_URLTypeID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO  AssetURL(AssetID, URLTypeID, URLPath, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_AssetID, _URLTypeID, _URLPath, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT ID FROM AssetURL WHERE AssetID=_AssetID into v_id;
                    ECHO SELECT v_id as 'ID', 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE  AssetURL SET AssetID=_AssetID , URLTypeID=_URLTypeID, URLPath=_URLPath, IsActive= _IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_ID;
						ECHO SELECT v_id as 'ID', 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				DELETE FROM  AssetURL WHERE Id=_ID;
				COMMIT;
				ECHO SELECT v_id as 'ID', 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;
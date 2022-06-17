use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLClientAssets(
_OPERATION VARCHAR(20),
_AssetID BIGINT(16),
_ClientID BIGINT(16),
_ID BIGINT(16) DEFAULT 0,
_ReferenceData TINYINT DEFAULT NULL,
_Price TINYINT DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        BEGIN
            SELECT Count(*) FROM ClientAssets WHERE AssetID=_AssetID AND ClientID=_ClientID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO ClientAssets(AssetID, ClientID, ReferenceData, Price, CreateUser,LastEditUser, CreateTime, LastEditTime)
                    values(_AssetID, _ClientID, _ReferenceData, _Price, _CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM ClientAssets WHERE AssetID=_AssetID and ClientID=_ClientID  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE ClientAssets SET  ReferenceData=_ReferenceData, Price=_Price,  LastEditUser=_LastEditUser, LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'FK constraint violation';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
            
				DELETE FROM ClientAssets WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
				
			END IF;
            Return v_id;
END //
DELIMITER ;
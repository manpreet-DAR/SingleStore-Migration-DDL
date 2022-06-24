use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetCustodian(
_OPERATION VARCHAR(20),
_AssetID BIGINT(16) ,
_CustodianID BIGINT(16),
_CreateUser VARCHAR(100)DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_Id BIGINT(16) DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) = _Id;
        BEGIN
            SELECT Count(*) FROM  AssetCustodian WHERE AssetID=_AssetID and CustodianID=_CustodianID  into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO  AssetCustodian(AssetID, CustodianID, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_AssetID, _CustodianID, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT ID FROM AssetCustodian WHERE AssetID=_AssetID and CustodianID=_CustodianID into v_id;
                    ECHO SELECT v_id as "ID", 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE  AssetCustodian SET AssetID=_AssetID , CustodianID=_CustodianID, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				DELETE FROM  AssetCustodian WHERE Id=_Id;
				COMMIT;
				ECHO SELECT v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;

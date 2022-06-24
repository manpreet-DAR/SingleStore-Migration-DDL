use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLBlockChain(
_OPERATION VARCHAR(20),
_ID BIGINT(16) DEFAULT 0,
_Name VARCHAR(255) DEFAULT NULL,
_Description VARCHAR(255) DEFAULT NULL,
_ConsensusMechanism VARCHAR(255) DEFAULT NULL,
_HashAlgorithm VARCHAR(255) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT =0;
        BEGIN
            SELECT Count(*) FROM BlockChain WHERE Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO BlockChain(Name, Description, ConsensusMechanism, HashAlgorithm, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_Name, _Description, _ConsensusMechanism, _HashAlgorithm, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT Id FROM BlockChain WHERE Name=_Name into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE BlockChain SET Name=_Name , Description=_Description, ConsensusMechanism=_ConsensusMechanism, HashAlgorithm=_HashAlgorithm, IsActive= _IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM  AssetToken WHERE BlockChainId=_ID into v_del_count1;
				IF(v_del_count1=0 ) Then
					DELETE FROM BlockChain WHERE Id=_ID;
					COMMIT;
					ECHO SELECT _ID as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table AssetToken field (BlockChainId,Id)";
				END IF;
            END IF;
            Return v_id;
END //
DELIMITER ;

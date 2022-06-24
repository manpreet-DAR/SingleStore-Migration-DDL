use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLCustodian(
_OPERATION VARCHAR(20),
_Name VARCHAR(250),
_ID BIGINT(16) DEFAULT 0,
_Description VARCHAR(500) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT =0;
        BEGIN
            SELECT Count(*) FROM Custodian WHERE Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Custodian(Name, Description, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values(_Name, _Description, _CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT Id FROM Custodian WHERE Name=_Name into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Custodian SET Description=_Description,LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE Id=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM  AssetCustodian WHERE CustodianID=_ID into v_del_count1;
				IF(v_del_count1=0) Then
					DELETE FROM Custodian WHERE Id=_ID;
					COMMIT;
					ECHO SELECT _ID as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table AssetCustodian field (CustodianID,Id)";
				END IF;
				
			END IF;
            Return v_id;
END //
DELIMITER ;



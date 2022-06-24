use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSTableType(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_ID BIGINT(16) DEFAULT 0,
_Description VARCHAR(250) DEFAULT NULL,
_NamePrefix VARCHAR(10) DEFAULT NULL,
_OverrideDataTypeID INT DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM STableType WHERE DisplayName=_DisplayName and Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO STableType( Name,DisplayName,Description,NamePrefix, OverrideDataTypeID,CreateUser, LastEditUser,CreateTime, LastEditTime)
                    values( _Name,_DisplayName,_Description,_NamePrefix,_OverrideDataTypeID,_CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM STableType WHERE Name=_Name and DisplayName=_DisplayName and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE STableType SET Name=_Name,DisplayName=_DisplayName,Description=_Description,NamePrefix=_NamePrefix,OverrideDataTypeID=_OverrideDataTypeID,
						LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM STable WHERE TypeID=_ID into v_del_count1;
                
                IF(v_del_count1 =0) Then
					DELETE FROM STableType WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
                ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table STable field (TypeID,Id)";
				END IF;    
			END IF;
            Return v_id;
END //
DELIMITER ;
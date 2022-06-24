use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSEntityCategory(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_ID BIGINT(16) DEFAULT 0,
_Description VARCHAR(250) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT =0;
       
        BEGIN
            SELECT Count(*) FROM SEntityCategory WHERE Name=_Name and DisplayName=_DisplayName  into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SEntityCategory( Name,DisplayName,Description, CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values( _Name,_DisplayName, _Description,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SEntityCategory WHERE Name=_Name and DisplayName=_DisplayName into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SEntityCategory SET Name=_Name,DisplayName=_DisplayName, Description=_Description, IsActive=_IsActive,
                        LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM  SEntity WHERE CategoryID=_ID into v_del_count1;
            
				IF(v_del_count1=0) Then
					DELETE FROM SEntityCategory WHERE ID=_ID;
					COMMIT;
					ECHO SELECT _ID as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntity field (CategoryID,Id)";
				END IF;
            END IF;
            Return v_id;
END //
DELIMITER ;

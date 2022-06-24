use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSIdentifierType(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_ID BIGINT(16) DEFAULT 0,
_IsKey TINYINT DEFAULT 0,
_IsUnique TINYINT DEFAULT 0,
_IsNatural TINYINT DEFAULT 0,
_IsGrouped TINYINT DEFAULT 0,
_Description VARCHAR(250) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM SIdentifierType WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SIdentifierType( Name, DisplayName, IsKey, IsUnique, IsNatural,IsGrouped, Description, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _Name, _DisplayName, _IsKey, _IsUnique, _IsNatural,_IsGrouped,_Description, _CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SIdentifierType WHERE Name=_Name and DisplayName=_DisplayName and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SIdentifierType SET DisplayName=_DisplayName,Name=_Name, IsKey=_IsKey,IsUnique=_IsUnique, IsNatural=_IsNatural,IsGrouped=_IsGrouped, Description=_Description,
                        LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
               
				DELETE FROM SIdentifierType WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;
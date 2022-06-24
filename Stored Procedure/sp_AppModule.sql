use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAppModule(
_OPERATION VARCHAR(20),
_ModuleName VARCHAR(250),
_Description VARCHAR(250),
_Link VARCHAR(250) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_ID BIGINT(16) DEFAULT 0, 
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_count2 INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16)= _ID;
		BEGIN
        
			SELECT NOW() into v_date;
            SELECT Count(*) FROM  AppModule WHERE Link=_Link or ModuleName=_ModuleName into v_count;
            SELECT Count(*) FROM  AppModule WHERE Link=_Link and ModuleName=_ModuleName into v_count2;
	
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then 
					INSERT INTO  AppModule(ModuleName, Description, Link, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_ModuleName, _Description, _Link, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT Id FROM AppModule WHERE Link=_Link and ModuleName=_ModuleName  into v_id;
                    ECHO SELECT v_id as "ID",_ModuleName as "ModuleName",_Link as "Link",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Inserted';
   
				ELSEIF(v_count = 1) Then
					
                    IF (v_count2 =1) Then
						UPDATE  AppModule SET Description=_Description, IsActive=_IsActive,LastEditUser=_LastEditUser, LastEditTime=v_date WHERE ID=_Id;  
						ECHO SELECT v_id as "ID",_ModuleName as "ModuleName",_Link as "Link",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Updated';
					ELSE 
                        ECHO SELECT v_id as "ID",_ModuleName as "ModuleName",_Link as "Link",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Partial combination exist for Link or ModuleName columns ';
						END IF;
				ELSEIF(v_count > 1) Then
					ECHO SELECT v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Duplicate Date found!!!';
                END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;
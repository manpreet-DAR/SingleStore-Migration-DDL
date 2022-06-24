use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLRoleAppModule(
_OPERATION VARCHAR(20),
_AppModuleId INT,
_RoleId VARCHAR(128),
_ID BIGINT(16) DEFAULT 0,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_id BIGINT(16) =  _ID;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM RoleAppModule WHERE AppModuleId=_AppModuleId and RoleId=_RoleId into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO RoleAppModule( AppModuleId, RoleId, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _AppModuleId,_RoleId, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT ID FROM RoleAppModule WHERE AppModuleId=_AppModuleId and RoleId=_RoleId into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE RoleAppModule SET LastEditUser=_LastEditUser, LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			
            SELECT Count(*) FROM AppModule WHERE ID=_AppModuleId into v_del_count1;
			SELECT Count(*) FROM RoleAppModule WHERE ID=_RoleId into v_del_count2;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				IF(v_del_count1 = 0 and v_del_count2 =0) Then
					DELETE FROM RoleAppModule WHERE ID=_ID;
					COMMIT;
                    ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table AppModule field (AppModuleId,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table RoleAppModule field (RoleId,Id)";
				END IF;
				
			END IF;
            Return v_id;
END //
DELIMITER ;

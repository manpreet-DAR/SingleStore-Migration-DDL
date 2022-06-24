use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSEntity(
_OPERATION VARCHAR(20),
_CategoryID INT,
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
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
        v_del_count3 INT = 0;
        v_del_count4 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM SEntity WHERE DisplayName=_DisplayName or Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SEntity( CategoryID,Name,DisplayName,Description, CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values( _CategoryID,_Name,_DisplayName,_Description, _CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SEntity WHERE DisplayName=_DisplayName and Name=_Name into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SEntity SET CategoryID=_CategoryID,Name=_Name,DisplayName=_DisplayName,Description=_Description, IsActive=_IsActive,
                        LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then

                SELECT Count(*) FROM EntityAvailabilityType WHERE EntityID=_ID into v_del_count1;
                SELECT Count(*) FROM EntityURLType WHERE EntityID=_ID into v_del_count12;
                SELECT Count(*) FROM SEntityAttribute WHERE EntityID=_ID into v_del_count13;
                SELECT Count(*) FROM STable WHERE EntityID=_ID into v_del_count4;
                
                IF(v_del_count1 =0 and v_del_count2 =0 and v_del_count3 =0 and v_del_count4 =0 ) Then
					DELETE FROM SEntity WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table EntityAvailabilityType field (EntityID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table EntityURLType field (EntityID,Id)";
				ELSEIF v_del_count3 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntityAttribute field (EntityID,Id)";
				ELSEIF v_del_count4 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table STable field (EntityID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;
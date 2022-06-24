use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAvailabilityType(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_APIName VARCHAR(100) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) = _ID;
        v_del_count1 INT= 0;
        BEGIN
            SELECT Count(*) FROM AvailabilityType WHERE DisplayName=_DisplayName and Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO AvailabilityType(Name, DisplayName, APIName, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_Name, _DisplayName, _APIName, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT Id FROM AvailabilityType WHERE DisplayName=_DisplayName and Name=_Name into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE AvailabilityType SET Name=_Name , DisplayName=_DisplayName, APIName=_APIName, IsActive= _IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM  EntityAvailabilityType WHERE AvailabilityTypeID=_ID into v_del_count1;
            
				IF(v_del_count1=0) Then
					DELETE FROM AvailabilityType WHERE Id=_ID;
					COMMIT;
					ECHO SELECT _ID as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table EntityAvailabilityType field (AvailabilityTypeID,Id)";
				END IF;
            END IF;
            Return v_id;
END //
DELIMITER ;

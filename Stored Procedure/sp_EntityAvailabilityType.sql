use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLEntityAvailabilityType(
_OPERATION VARCHAR(20),
_AvailabilityTypeID INT,
_EntityID INT,
_ID BIGINT(16) DEFAULT 0,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _Id;
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
        BEGIN
            SELECT Count(*) FROM EntityAvailabilityType WHERE Id=_Id into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO EntityAvailabilityType(AvailabilityTypeID, EntityID, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values(_AvailabilityTypeID, _EntityID, _CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT Id FROM EntityAvailabilityType WHERE AvailabilityTypeID=_AvailabilityTypeID and EntityID=_EntityID and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE EntityAvailabilityType SET AvailabilityTypeID=_AvailabilityTypeID , EntityID=_EntityID , LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM AvailabilityType WHERE ID=_AvailabilityTypeID into v_del_count1;
                SELECT Count(*) FROM SEntity WHERE Id=_EntityID into v_del_count2;
                
                IF(v_del_count1 =0 and v_del_count2=0 ) Then
					DELETE FROM EntityAvailabilityType WHERE Id=_Id;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table AvailabilityType field (AvailabilityTypeID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntity field (EntityID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

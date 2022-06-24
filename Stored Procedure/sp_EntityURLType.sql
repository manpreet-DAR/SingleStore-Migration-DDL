use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLEntityURLType(
_OPERATION VARCHAR(20),
_URLTypeID INT NOT NULL,
_EntityID INT NOT NULL,
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
            SELECT Count(*) FROM EntityURLType WHERE Id=_Id into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO EntityURLType(URLTypeID, EntityID, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values(_URLTypeID, _EntityID, _CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT Id FROM EntityURLType WHERE URLTypeID=_URLTypeID and EntityID=_EntityID and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE EntityURLType SET URLTypeID=_URLTypeID , EntityID=_EntityID , LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM URLType WHERE ID=_URLTypeID into v_del_count1;
                SELECT Count(*) FROM SEntity WHERE Id=_EntityID into v_del_count2;
                
                IF(v_del_count1 =0 and v_del_count2=0 ) Then
					DELETE FROM EntityURLType WHERE Id=_Id;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table URLType field (URLTypeID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntity field (EntityID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;
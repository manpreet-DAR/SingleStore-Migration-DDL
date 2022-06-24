use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSEntityAttribute(
_OPERATION VARCHAR(20),
_EntityID INT,
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_DataTypeID INT,
_ID BIGINT(16) DEFAULT 0,
_EnumerationID INT DEFAULT NULL,
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
       
        BEGIN
            SELECT Count(*) FROM SEntityAttribute WHERE (EntityID=_EntityID and DisplayName=_DisplayName )or (EntityID=_EntityID and Name=_Name) into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SEntityAttribute( EntityID,Name,DisplayName,DataTypeID,EnumerationID,Description, CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values( _EntityID,_Name,_DisplayName,_DataTypeID,_EnumerationID, _Description,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SEntityAttribute WHERE (EntityID=_EntityID and DisplayName=_DisplayName )or (EntityID=_EntityID and Name=_Name) into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SEntityAttribute SET EntityID=_EntityID,Name=_Name,DisplayName=_DisplayName,DataTypeID=_DataTypeID,EnumerationID=_EnumerationID,
                        Description=_Description, IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM SDataType WHERE ID=_DataTypeID into v_del_count1;
                SELECT Count(*) FROM SEntity WHERE ID=_EntityID into v_del_count2;
                SELECT Count(*) FROM SEnumeration WHERE ID=_EnumerationID into v_del_count3;
                
                IF(v_del_count1 =0 and  v_del_count2 =0 and v_del_count3 =0 ) Then
					DELETE FROM SEntityAttribute WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SDataType field (DataTypeID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntity field (EntityID,Id)";
				ELSEIF v_del_count3 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEnumeration field (EnumerationID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

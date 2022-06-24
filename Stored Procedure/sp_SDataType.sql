use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSDataType(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250) ,
_ID BIGINT(16) DEFAULT 0,
_Description VARCHAR(250) DEFAULT NULL,
_ParentTypeID INT DEFAULT NULL,
_SqlDataType VARCHAR(100) DEFAULT NULL,
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
            SELECT Count(*) FROM SDataType WHERE DisplayName=_DisplayName or Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SDataType( Name,DisplayName,Description,ParentTypeID,SqlDataType, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _Name,_DisplayName,_Description,_ParentTypeID,_SqlDataType,_CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SDataType WHERE DisplayName=_DisplayName and Name=_Name into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SDataType SET Description=_Description,ParentTypeID=_ParentTypeID,SqlDataType=_SqlDataType,
                        LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM SDataType WHERE ParentTypeID=_ID into v_del_count1;
                SELECT Count(*) FROM SEntityAttribute WHERE DataTypeID=_ID into v_del_count2;
                SELECT Count(*) FROM SSharedColumn WHERE DataTypeID=_ID into v_del_count3;
                SELECT Count(*) FROM STableType WHERE OverrideDataTypeID=_ID into v_del_count4;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM SDataType WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SDataType field (ParentTypeID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntityAttribute field (DataTypeID,Id)";
				ELSEIF v_del_count3 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SSharedColumn field (DataTypeID,Id)";
				ELSEIF v_del_count4 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table STableType field (OverrideDataTypeID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSSharedColumn(
_OPERATION VARCHAR(20),
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_DataTypeID INT,
_SortOrder INT,
_VersionID INT,
_ID BIGINT(16) DEFAULT 0,
_IsRequired TINYINT DEFAULT 0,
_IsSystem TINYINT DEFAULT 0,
_IsDisplay TINYINT DEFAULT 0,
_IsPrecedingSort TINYINT DEFAULT 0,
_DefaultExpression VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM SSharedColumn WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SSharedColumn( Name, DisplayName, DataTypeID, SortOrder,IsRequired,IsSystem,IsDisplay,IsPrecedingSort,DefaultExpression,VersionID, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _Name, _DisplayName, _DataTypeID, _SortOrder,_IsRequired,_IsSystem,_IsDisplay,_IsPrecedingSort,_DefaultExpression,_VersionID, _IsActive, _CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SSharedColumn WHERE Name=_Name and  DisplayName=_DisplayName and DataTypeID=_DataTypeID and SortOrder=_SortOrder and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SSharedColumn SET Name=_Name,DisplayName=_DisplayName, DataTypeID=_DataTypeID,SortOrder=_SortOrder,IsRequired=_IsRequired,IsSystem=_IsSystem,IsDisplay=_IsDisplay, IsPrecedingSort=_IsPrecedingSort,
                        DefaultExpression=_DefaultExpression, VersionID=_VersionID ,IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM SSchemaVersion WHERE ID=_VersionID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM SSharedColumn WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SSchemaVersion field (VersionID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

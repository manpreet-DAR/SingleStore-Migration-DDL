use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSEnumerationValue(
_OPERATION VARCHAR(20),
_EnumerationID INT,
_ValueID INT,
_SortOrder INT,
_Name VARCHAR(100),
_DisplayName VARCHAR(250),
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM SEnumerationValue WHERE (Name=_Name and EnumerationID=_EnumerationID) or 
            (DisplayName=_DisplayName and EnumerationID=_EnumerationID) or 
            (SortOrder=_SortOrder and EnumerationID=_EnumerationID) or
            (ValueID=_ValueID and EnumerationID=_EnumerationID) into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SEnumerationValue( Name, DisplayName, EnumerationID, ValueID, SortOrder, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _Name,_DisplayName, _EnumerationID,_ValueID,_SortOrder,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SEnumerationValue WHERE (Name=_Name and EnumerationID=_EnumerationID) or 
            (DisplayName=_DisplayName and EnumerationID=_EnumerationID) or 
            (SortOrder=_SortOrder and EnumerationID=_EnumerationID) or
            (ValueID=_ValueID and EnumerationID=_EnumerationID)into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SEnumerationValue SET Name=_Name,DisplayName=_DisplayName, EnumerationID=_EnumerationID,ValueID=_ValueID, SortOrder=_SortOrder,
                        IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM SEnumeration WHERE ID=_EnumerationID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM SEnumerationValue WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEnumeration field (EnumerationID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

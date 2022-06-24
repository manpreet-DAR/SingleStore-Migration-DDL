use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSTable(
_OPERATION VARCHAR(20),
_TypeID INT ,
_EntityID INT,
_VersionID INT,
_ID BIGINT(16) DEFAULT 0,
_IsLookup TINYINT DEFAULT 0,
_Name VARCHAR(100) DEFAULT NULL,
_DisplayName VARCHAR(250) DEFAULT NULL,
_GenOrder INT DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM STable WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO STable( TypeID, EntityID, Name, DisplayName, GenOrder,IsLookup,VersionID, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _TypeID, _EntityID, _Name, _DisplayName,_GenOrder,_IsLookup,_VersionID,_IsActive, _CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM STable WHERE TypeID=_TypeID and  EntityID=_EntityID and VersionID=_VersionID and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE STable SET Name=_Name,DisplayName=_DisplayName,TypeID=_TypeID,EntityID=_EntityID,GenOrder=_GenOrder,IsLookup=_IsLookup,VersionID=_VersionID, IsActive=_IsActive,
                        LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM SSchemaVersion WHERE ID=_VersionID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM STable WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SSchemaVersion field (VersionID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

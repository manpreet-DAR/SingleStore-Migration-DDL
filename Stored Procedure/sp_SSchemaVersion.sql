use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSSchemaVersion(
_OPERATION VARCHAR(20),
_Major INT ,
_Minor INT ,
_EffectiveStart DATE ,
_ID BIGINT(16) DEFAULT 0,
_Name VARCHAR(100)  DEFAULT NULL,
_DisplayName VARCHAR(250) DEFAULT NULL,
_EffectiveEnd DATE DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT =0;
        v_del_count2 INT =0;
       
        BEGIN
            SELECT Count(*) FROM SSchemaVersion WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO SSchemaVersion( Name, DisplayName, Major, Minor,EffectiveStart,EffectiveEnd, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _Name, _DisplayName, _Major, _Minor,_EffectiveStart,_EffectiveEnd, _IsActive, _CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM SSchemaVersion WHERE Major=_Major and  Minor=_Minor and EffectiveStart=_EffectiveStart  and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE SSchemaVersion SET Name=_Name,DisplayName=_DisplayName, Major=_Major,Minor=_Minor,EffectiveStart=_EffectiveStart,EffectiveEnd=_EffectiveEnd,
                        IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				SELECT Count(*) FROM  SSharedColumn WHERE VersionID=_ID into v_del_count1;
				SELECT Count(*) FROM  STable WHERE VersionID=_ID into v_del_count2;
            
				IF(v_del_count1=0 and v_del_count2=0) Then
					DELETE FROM SSchemaVersion WHERE ID=_ID;
					COMMIT;
					ECHO SELECT _ID as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SSharedColumn field (VersionID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table STable field (VersionID,Id)";
				END IF;
            END IF;
            Return v_id;
END //
DELIMITER ;

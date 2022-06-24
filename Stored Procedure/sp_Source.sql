use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSource(
_OPERATION VARCHAR(20),
_DARSourceID VARCHAR(20),
_ShortName VARCHAR(255),
_SourceType VARCHAR(255),
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT =0;
       
        BEGIN
            SELECT Count(*) FROM Source WHERE DARSourceID=_DARSourceID or  ShortName=_ShortName into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Source( DARSourceID, ShortName, SourceType, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values( _DARSourceID, _ShortName, _SourceType, _IsActive, _CreateUser,_LastEditUser,v_date, v_date);
					COMMIT;
                    SELECT ID FROM Source WHERE DARSourceID=_DARSourceID and  ShortName=_ShortName and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Source SET DARSourceID=_DARSourceID,ShortName=_ShortName, SourceType=_SourceType,IsActive=_IsActive,
                        LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM  Staging_CryptoNodeEvents WHERE SourceID=_ID into v_del_count1;
                IF(v_del_count1=0) Then
					DELETE FROM Source WHERE ID=_ID;
					COMMIT;
					ECHO SELECT _ID as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table ExchangeVettingStatus field (ExchangeId,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;


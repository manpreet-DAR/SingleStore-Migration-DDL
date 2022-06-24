use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLVettingStatus(
_OPERATION VARCHAR(20),
_StatusCode INT,
_StatusDescription VARCHAR(200),
_StatusType VARCHAR(200),
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
        v_del_count2 int =0;
       
        BEGIN
            SELECT Count(*) FROM VettingStatus WHERE StatusDescription=_StatusDescription and ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO VettingStatus(StatusCode,StatusDescription,StatusType,CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values(_StatusCode,_StatusDescription,_StatusType,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM VettingStatus WHERE StatusDescription=_StatusDescription and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
					UPDATE VettingStatus SET StatusCode=_StatusCode, StatusDescription=_StatusDescription ,StatusType=_StatusType, IsActive=_IsActive, LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
					ECHO SELECT  v_id as "ID", 'Data  Updated';
                    
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM  AssetVettingStatus WHERE ExchangeId=_ID into v_del_count1;
				SELECT Count(*) FROM  ExchangeVettingStatus WHERE ExchangeID=_ID into v_del_count2;
            
				IF(v_del_count1=0 and v_del_count2=0) Then
					DELETE FROM VettingStatus WHERE ID=_ID;
					COMMIT;
					ECHO SELECT _ID as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table AssetVettingStatus field (VettingStatusId,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table ExchangeVettingStatus field (VettingStatusId,Id)";
				END IF;
			END IF;
            Return v_id;
            
END //
DELIMITER ;

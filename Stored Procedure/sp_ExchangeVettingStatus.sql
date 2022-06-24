use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLExchangeVettingStatus(
_OPERATION VARCHAR(20),
_ProcessId INT ,
_ExchangeId INT,
_VettingStatusId INT,
_ID BIGINT(16) DEFAULT 0,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count2 INT = 0;
        v_del_count3 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM ExchangeVettingStatus WHERE ProcessId=_ProcessId and ExchangeId=_ExchangeId and VettingStatusId=_VettingStatusId into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO ExchangeVettingStatus( ExchangeId, ProcessId,VettingStatusId, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _ExchangeId,_ProcessId,_VettingStatusId,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM ExchangeVettingStatus WHERE ProcessId=_ProcessId and ExchangeId = _ExchangeId and VettingStatusId=_VettingStatusId  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE ExchangeVettingStatus SET LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM Process WHERE ID=_ProcessId into v_del_count2;
                SELECT Count(*) FROM VettingStatus WHERE ID=_VettingStatusId into v_del_count3;
                
                IF(v_del_count2 =0 and v_del_count3 =0) Then
					DELETE FROM ExchangeVettingStatus WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Process field (ProcessId,Id)";
				ELSEIF v_del_count3 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table VettingStatus field (VettingStatusId,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;
use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLProcess(
_OPERATION VARCHAR(20),
_Name VARCHAR(255),
_Description VARCHAR(500),
_ID BIGINT(16) DEFAULT 0,
_Lookback INT DEFAULT NULL,
_Frequency INT DEFAULT NULL,
_LookbackUnit VARCHAR(20) DEFAULT NULL,
_FrequencyUnit VARCHAR(20) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_id BIGINT(16) =  _ID;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM Process WHERE Name=_Name into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Process( Name, Description, Lookback, Frequency, LookbackUnit, FrequencyUnit, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _Name, _Description, _Lookback, _Frequency, _LookbackUnit, _FrequencyUnit, _CreateUser, _LastEditUser, _IsActive, v_date, v_date);
					COMMIT;
                    SELECT ID FROM Process WHERE Name=_Name into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Process SET Description=_Description, Lookback=_Lookback, Frequency=_Frequency, LookbackUnit=_LookbackUnit, FrequencyUnit=_FrequencyUnit , LastEditUser=_LastEditUser, LastEditTime=v_date, IsActive=_IsActive WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM  AssetVettingStatus WHERE ProcessId=_ID into v_del_count1;
				SELECT Count(*) FROM  ExchangeVettingStatus WHERE ProcessId=_ID into v_del_count2;
			IF(v_del_count1=0 and v_del_count2=0) Then
				DELETE FROM Process WHERE ID=_ID;
				COMMIT;
				ECHO SELECT _ID as "ID", 'Data Deleted';
			ELSEIF v_del_count1 !=0 Then
				ECHO SELECT "Foreign Key constraint violet here for Table AssetVettingStatus field (ProcessId,Id)";
			ELSEIF v_del_count2 !=0 Then
				ECHO SELECT "Foreign Key constraint violet here for Table ExchangeVettingStatus field (ProcessId,Id)";
				END IF;
            END IF;
            Return v_id;
END //
DELIMITER ;


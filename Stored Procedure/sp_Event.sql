use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLEvent(
_OPERATION VARCHAR(20),
_EventName VARCHAR(50),
_ID BIGINT(16) DEFAULT 0,
_CreateUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT =0;
        BEGIN
            SELECT Count(*) FROM Event WHERE Id=_Id into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Event(EventName, CreateUser, CreateTime)
                    values(_EventName, _CreateUser, v_date);
					COMMIT;
                    SELECT Id FROM Event WHERE EventName=_EventName and CreateTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Event SET EventName=_EventName, CreateUser=_CreateUser, CreateTime=v_date WHERE Id=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM  Staging_CryptoNodeEvents WHERE EventTypeID=_ID into v_del_count1;
				IF(v_del_count1=0) Then
					DELETE FROM Event WHERE Id=_ID;
					COMMIT;
					ECHO SELECT _ID as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Staging_CryptoNodeEvents field (EventTypeID,Id)";
				END IF;
            END IF;
            Return v_id;
END //
DELIMITER ;

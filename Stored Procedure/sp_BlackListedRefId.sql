use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLBlackListedRefId(
_OPERATION VARCHAR(20),
_DARRefId VARCHAR(20)) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        BEGIN
            SELECT Count(*) FROM BlackListedRefId WHERE DARRefId=_DARRefId into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO BlackListedRefId(DARRefId) values(_DARRefId);
					COMMIT;
                    ECHO SELECT _DARRefId as "DARRefId" , 'Data Inserted';
   
				ELSEIF(v_count > 0) Then
					ECHO SELECT  'DARRefId already present!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
            
				DELETE FROM BlackListedRefId WHERE DARRefId=_DARRefId;
				COMMIT;
				ECHO SELECT  _DARRefId as "DARRefId", 'Data Deleted';
				
			END IF;
            Return _DARRefId;
END //
DELIMITER ;
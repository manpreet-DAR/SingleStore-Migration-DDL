use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLExchangeRowCount(
_OPERATION VARCHAR(20),
_ExchangeName VARCHAR(20),
_ExchangeRowCount INT,
_ID BIGINT(16) DEFAULT 0
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        
        BEGIN
            SELECT Count(*) FROM ExchangeRowCount WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO ExchangeRowCount( ExchangeName,ExchangeRowCount,CreateDate)
                    values( _ExchangeName,_ExchangeRowCount, v_date);
					COMMIT;
                    SELECT ID FROM ExchangeRowCount WHERE CreateDate=v_date  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE ExchangeRowCount SET ExchangeName=_ExchangeName,ExchangeRowCount=_ExchangeRowCount WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
				DELETE FROM ExchangeRowCount WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;
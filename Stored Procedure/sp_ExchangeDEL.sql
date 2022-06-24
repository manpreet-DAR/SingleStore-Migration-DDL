use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLExchangeDEL(
_ID BIGINT(16)) RETURNS text AS
	DECLARE 
		v_del_count1 INT =0;
        v_del_count2 INT =0;
        v_del_count3 INT =0;
        v_del_count4 INT =0;
        v_del_count5 INT =0;
        
		BEGIN
			SELECT Count(*) FROM  ExchangeVettingStatus WHERE ExchangeId=_ID into v_del_count1;
            SELECT Count(*) FROM  ExchangePair WHERE ExchangeID=_ID into v_del_count2;
            SELECT Count(*) FROM  ExchangeAvailability WHERE ExchangeID=_ID into v_del_count3;
            SELECT Count(*) FROM  ExchangeURL WHERE ExchangeID=_ID into v_del_count4;
            SELECT Count(*) FROM  Listing WHERE ExchangeID=_ID into v_del_count5;
            
			IF(v_del_count1=0 and v_del_count2=0 and v_del_count3=0 and v_del_count4=0 and v_del_count5=0) Then
				DELETE FROM Exchange WHERE ID=_ID;
				COMMIT;
				ECHO SELECT _ID as "ID", 'Data Deleted';
			ELSEIF v_del_count1 !=0 Then
				ECHO SELECT "Foreign Key constraint violet here for Table ExchangeVettingStatus field (ExchangeId,Id)";
			ELSEIF v_del_count2 !=0 Then
				ECHO SELECT "Foreign Key constraint violet here for Table ExchangePair field (ExchangeId,Id)";
			ELSEIF v_del_count3 !=0 Then
				ECHO SELECT "Foreign Key constraint violet here for Table ExchangeAvailability field (ExchangeId,Id)";
			ELSEIF v_del_count4 !=0 Then
				ECHO SELECT "Foreign Key constraint violet here for Table ExchangeURL field (ExchangeId,Id)";
			ELSEIF v_del_count5 !=0 Then
				ECHO SELECT "Foreign Key constraint violet here for Table Listing field (ExchangeId,Id)";
			END IF;
		Return _ID;
END //
DELIMITER ;
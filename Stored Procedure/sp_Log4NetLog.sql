use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLLog4NetLog(
_OPERATION VARCHAR(20),
_Date DATETIME,
_Thread VARCHAR(255),
_Level VARCHAR(50),
_Logger VARCHAR(255),
_Message VARCHAR(4000),
_ID BIGINT(16) DEFAULT 0,
_Exception VARCHAR(2000) DEFAULT NULL)RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM Log4NetLog WHERE ID=_ID into v_count;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Log4NetLog( Date,Thread, Level,Logger,Message, Exception)
                    values( _Date,_Thread, _Level,_Logger,_Message, _Exception);
					COMMIT;
                    SELECT ID FROM Log4NetLog WHERE Date=_Date and Thread=_Thread and Level=_Level and Logger=_Logger and Message=_Message into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Log4NetLog SET Date=_Date, Thread=_Thread, Level=_Level, Logger=_Logger, Message=_Message , Exception=_Exception WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                DELETE FROM Log4NetLog WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;

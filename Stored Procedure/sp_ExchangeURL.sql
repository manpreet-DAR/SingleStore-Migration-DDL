use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLExchangeURL(
_OPERATION VARCHAR(20),
_ExchangeID BIGINT(16) ,
_URLTypeID BIGINT(16) ,
_URLPath VARCHAR(250) ,
_ID BIGINT(16) DEFAULT 0,
_IsAvailable TINYINT DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM ExchangeURL WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO ExchangeURL( ExchangeID,URLTypeID,URLPath, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _ExchangeID,_URLTypeID,_URLPath,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM ExchangeURL WHERE LastEditTime=v_date  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE ExchangeURL SET ExchangeID=_ExchangeID,URLTypeID=_URLTypeID,URLPath=_URLPath,
                        LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
				DELETE FROM ExchangeURL WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;

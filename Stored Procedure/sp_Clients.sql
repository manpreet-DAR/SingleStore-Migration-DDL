use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLClients(
_OPERATION VARCHAR(20),
_ClientName VARCHAR(250),
_Description VARCHAR(250) ,
_ID BIGINT(16) DEFAULT 0,
_CallerID VARCHAR(250) DEFAULT NULL,
_HasFullAccess TINYINT DEFAULT NULL,
_ReferenceData TINYINT DEFAULT NULL,
_Price TINYINT DEFAULT NULL,
_APIKey VARCHAR(250) DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
        BEGIN
            SELECT Count(*) FROM Clients WHERE CallerID=_CallerID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Clients(ClientName, Description, CallerID, HasFullAccess, ReferenceData, Price, APIKey, CreateUser,LastEditUser,IsActive, CreateTime, LastEditTime)
                    values(_ClientName, _Description, _CallerID, _HasFullAccess, _ReferenceData, _Price, _APIKey, _CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT Id FROM Clients WHERE CallerID=_CallerID into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Clients SET ClientName=_ClientName, Description=_Description, CallerID=_CallerID, HasFullAccess=_HasFullAccess, ReferenceData=_ReferenceData, Price=_Price, APIKey=_APIKey, IsActive=_IsActive, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM  ClientAssets WHERE ClientID=_ID into v_del_count1;
            
				IF(v_del_count1=0) Then
					DELETE FROM Clients WHERE Id=_ID;
					COMMIT;
					ECHO SELECT _ID as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table ClientAssets field (ClientID,Id)";
					END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;
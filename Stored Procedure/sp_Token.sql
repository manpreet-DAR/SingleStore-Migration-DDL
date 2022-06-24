use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLToken(
_OPERATION VARCHAR(20),
_DARTokenID VARCHAR(20),
_TokenName VARCHAR(255),
_ID BIGINT(16) DEFAULT 0,
_TokenDescription VARCHAR(1500) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM Token WHERE DARTokenID=_DARTokenID and TokenName=_TokenName  and ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Token(DARTokenID,TokenName,TokenDescription,CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values(_DARTokenID,_TokenName,_TokenDescription,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM Token WHERE DARTokenID=_DARTokenID and TokenName=_TokenName and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
					UPDATE Token SET DARTokenID=_DARTokenID, TokenName=_TokenName ,TokenDescription=_TokenDescription, IsActive=_IsActive, LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
					ECHO SELECT  v_id as "ID", 'Data  Updated';
                    
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM  AssetToken WHERE TokenId=_ID into v_del_count1;
				IF(v_del_count1=0) Then
					DELETE FROM Token WHERE ID=_ID;
					COMMIT;
					ECHO SELECT _ID as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table AssetToken field (TokenId,Id)";
				END IF;
            END IF;
            Return v_id;
END //
DELIMITER ;
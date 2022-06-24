use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLListing(
_OPERATION VARCHAR(20),
_AssetID INT,
_ExchangeID INT,
_ExchangeAssetTicker VARCHAR(20),
_ExchangeAssetName VARCHAR(100),
_ID BIGINT(16) DEFAULT 0,
_IsAvailable TINYINT DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM Listing WHERE AssetID=_AssetID and ExchangeID=_ExchangeID and ExchangeAssetTicker=_ExchangeAssetTicker into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Listing( AssetID, ExchangeID,ExchangeAssetTicker,ExchangeAssetName, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _AssetID,_ExchangeID,_ExchangeAssetTicker,_ExchangeAssetName,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM Listing WHERE AssetID=_AssetID and ExchangeID=_ExchangeID and ExchangeAssetTicker=_ExchangeAssetTicker  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Listing SET LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM  Stage_CollectedListing WHERE ListingID=_ID into v_del_count1;
				IF(v_del_count1=0) Then
					DELETE FROM Listing WHERE ID=_ID;
					COMMIT;
					ECHO SELECT _ID as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Stage_CollectedListing field (ListingID,Id)";
				END IF;
            END IF;
            Return v_id;
END //
DELIMITER ;


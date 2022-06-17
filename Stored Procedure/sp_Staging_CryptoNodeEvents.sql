use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStaging_CryptoNodeEvents(
_OPERATION VARCHAR(20),
_DateofReview DATETIME,
_ExchangeAssetTicker VARCHAR(100),
_ID BIGINT(16) DEFAULT 0,
_ExchangeAssetName VARCHAR(250) DEFAULT NULL,
_DARAssetID VARCHAR(50) DEFAULT NULL,
_EventType VARCHAR(100) DEFAULT NULL,
_EventDate DATETIME DEFAULT NULL,
_AnnouncementDate DATETIME DEFAULT NULL,
_EventDescription VARCHAR(500) DEFAULT NULL,
_SourceURL VARCHAR(500) DEFAULT NULL,
_EventStatus VARCHAR(500) DEFAULT NULL,
_Notes VARCHAR(500) DEFAULT NULL,
_Deleted VARCHAR(500) DEFAULT NULL,
_Exchange VARCHAR(50) DEFAULT NULL,
_ValidationTime DATETIME DEFAULT NULL,
_AssetID INT DEFAULT NULL,
_SourceID INT DEFAULT NULL,
_EventTypeID INT DEFAULT NULL,
_BlockHeight INT DEFAULT NULL,
_Error VARCHAR(500) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM Staging_CryptoNodeEvents WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Staging_CryptoNodeEvents( DateofReview,ExchangeAssetTicker,ExchangeAssetName,EventType,EventDate,AnnouncementDate,EventDescription,SourceURL,EventStatus,Notes,Deleted,Exchange,ValidationTime,AssetID,SourceID,EventTypeID,BlockHeight,Error,CreateTime)
                    values( _DateofReview,_ExchangeAssetTicker,_ExchangeAssetName,_EventType,_EventDate,_AnnouncementDate,_EventDescription,_SourceURL,_EventStatus,_Notes,_Deleted,_Exchange,_ValidationTime,_AssetID,_SourceID,_EventTypeID,_BlockHeight,_Error,v_date);
					COMMIT;
                    SELECT ID FROM Staging_CryptoNodeEvents WHERE DateofReview=_DateofReview and ExchangeAssetTicker=_ExchangeAssetTicker  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Staging_CryptoNodeEvents 
                        SET DARAssetID=_DARAssetID, DateofReview=_DateofReview, ExchangeAssetTicker=_ExchangeAssetTicker, ExchangeAssetName=_ExchangeAssetName,EventType=_EventType,EventDate=_EventDate,AnnouncementDate=_AnnouncementDate,
						EventDescription=_EventDescription, SourceURL=_SourceURL, EventStatus=_EventStatus, Notes=_Notes, Deleted=_Deleted, Exchange=_Exchange, ValidationTime=_ValidationTime, AssetID=_AssetID, SourceID=_SourceID, EventTypeID=_EventTypeID, 
                        BlockHeight=_BlockHeight,Error=_Error WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSE
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then

                DELETE FROM Staging_CryptoNodeEvents WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;

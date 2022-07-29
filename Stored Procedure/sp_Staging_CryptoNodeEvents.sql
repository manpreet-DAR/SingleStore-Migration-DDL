use refmaster_internal;
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
_Error VARCHAR(500) DEFAULT NULL) AS
DECLARE 
	v_count INT =0;
	v_date DATETIME = CURRENT_TIMESTAMP();
	v_id BIGINT(16) =  _ID;
	qry QUERY(id VARCHAR(50)) = SELECT DARAssetID FROM Asset WHERE DARTicker=_ExchangeAssetTicker AND Name=_ExchangeAssetName;
	assetid VARCHAR(50);
BEGIN
	assetid = SCALAR(qry); 
	SELECT NOW() into v_date;
	If (UPPER(_OPERATION) = "UPSERT") Then
		IF(_DARAssetID IS NULL OR assetid=_DARAssetID) THEN
			IF(_ID = 0) THEN
				INSERT INTO Staging_CryptoNodeEvents(DARAssetID, DateofReview,ExchangeAssetTicker,ExchangeAssetName,EventType,EventDate,AnnouncementDate,EventDescription,SourceURL,EventStatus,Notes,Deleted,Exchange,ValidationTime,AssetID,SourceID,EventTypeID,BlockHeight,Error,CreateTime)
				values(_DARAssetID,_DateofReview,_ExchangeAssetTicker,_ExchangeAssetName,_EventType,_EventDate,_AnnouncementDate,_EventDescription,_SourceURL,_EventStatus,_Notes,_Deleted,_Exchange,_ValidationTime,_AssetID,_SourceID,_EventTypeID,_BlockHeight,_Error,v_date);
				COMMIT;
				SELECT ID FROM Staging_CryptoNodeEvents WHERE DateofReview=_DateofReview and ExchangeAssetTicker=_ExchangeAssetTicker INTO v_id;
				ECHO SELECT v_id AS event_id, 'Insert' AS RowOutput;

			ELSE 
				UPDATE Staging_CryptoNodeEvents 
				SET DARAssetID=_DARAssetID, DateofReview=_DateofReview, ExchangeAssetTicker=_ExchangeAssetTicker, ExchangeAssetName=_ExchangeAssetName,EventType=_EventType,EventDate=_EventDate,AnnouncementDate=_AnnouncementDate,
				EventDescription=_EventDescription, SourceURL=_SourceURL, EventStatus=_EventStatus, Notes=_Notes, Deleted=_Deleted, Exchange=_Exchange, ValidationTime=_ValidationTime, AssetID=_AssetID, SourceID=_SourceID, EventTypeID=_EventTypeID, 
				BlockHeight=_BlockHeight,Error=_Error WHERE ID=_ID;
				ECHO SELECT v_id as event_id, 'Update' AS RowOutput;
			END IF;
		ELSE
			ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT Asset FOREIGN KEY ('ExchangeAssetTicker', 'ExchangeAssetName ') REFERENCES 'Asset' ('DARTicker', 'Name'))" AS RowOutput; 			
        END IF; 
	ELSEIF(UPPER(_OPERATION) = "DELETE") Then
		DELETE FROM Staging_CryptoNodeEvents WHERE ID=_ID;
		COMMIT;
		ECHO SELECT v_id AS event_id, 'Success' as RowOutput;
	END IF;
    
EXCEPTION
	WHEN ER_SCALAR_BUILTIN_NO_ROWS THEN
		ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT Asset FOREIGN KEY ('DARAssetID') REFERENCES 'Asset' ('DARAssetID'))" AS RowOutput; 
        RAISE; 
	WHEN OTHERS THEN
		RAISE user_exception("FAILED: Other exception"); 
END //
DELIMITER ;

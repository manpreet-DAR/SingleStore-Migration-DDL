use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLEventInformation(
_OPERATION VARCHAR(20),
_DAREventID BIGINT(11) DEFAULT 1,
_DateofReview DATETIME DEFAULT NULL,
_EventTypeID INT  DEFAULT NULL,
_AssetID INT DEFAULT NULL,
_SourceID INT DEFAULT NULL,
_ExchangeAssetTicker VARCHAR(20) DEFAULT NULL,
_ExchangeAssetName VARCHAR(100) DEFAULT NULL,
_DARAssetID VARCHAR(50) DEFAULT NULL,
_EventType VARCHAR(100) DEFAULT NULL,
_EventDate DATETIME DEFAULT NULL,
_AnnouncementDate DATETIME  DEFAULT NULL,
_EventDescription VARCHAR(500) DEFAULT NULL,
_SourceURL VARCHAR(500) DEFAULT NULL,
_EventStatus VARCHAR(500) DEFAULT NULL,
_Notes VARCHAR(500) DEFAULT NULL,
_Deleted VARCHAR(500) DEFAULT NULL,
_Exchange VARCHAR(50) DEFAULT NULL,
_BlockHeight INT DEFAULT NULL,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _DAREventID;
        BEGIN
            SELECT Count(*) FROM EventInformation WHERE DAREventID=_DAREventID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO EventInformation( DateofReview,EventTypeID,AssetID,SourceID,ExchangeAssetTicker,ExchangeAssetName,
                    DARAssetID,EventType,EventDate,AnnouncementDate,EventDescription,SourceURL,EventStatus,Notes,Deleted,Exchange,BlockHeight,
                    CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _DateofReview,_EventTypeID,_AssetID,_SourceID,_ExchangeAssetTicker,_ExchangeAssetName,_DARAssetID,
                    _EventType,_EventDate,_AnnouncementDate,_EventDescription,_SourceURL,_EventStatus,_Notes, _Deleted, _Exchange,_BlockHeight,
                    _CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT DAREventID FROM EventInformation WHERE LastEditTime=v_date  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE EventInformation SET DateofReview=_DateofReview,EventTypeID=_EventTypeID,AssetID=_AssetID,SourceID=_SourceID,
                        ExchangeAssetTicker=_ExchangeAssetTicker,ExchangeAssetName=_ExchangeAssetName,DARAssetID=_DARAssetID,EventType=_EventType,EventDate=_EventDate,
                        AnnouncementDate=_AnnouncementDate,EventDescription=_EventDescription,SourceURL=_SourceURL,EventStatus=_EventStatus,Notes=_Notes,Deleted=_Deleted, 
                        Exchange=_Exchange,BlockHeight=_BlockHeight, LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date WHERE DAREventID=_DAREventID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				DELETE FROM EventInformation WHERE DAREventID=_DAREventID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;
use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLEventInformation_Audit(
_OPERATION VARCHAR(20),
_operation1 VARCHAR(15),
_DAREventID VARCHAR(20),
_ChangeID BIGINT(16) DEFAULT 1,
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
        v_id BIGINT(16) =  _ChangeID;
        
        BEGIN
            SELECT Count(*) FROM EventInformation_Audit WHERE ChangeID=_ChangeID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO EventInformation_Audit( DAREventID,DateofReview,EventTypeID,AssetID,SourceID,ExchangeAssetTicker,ExchangeAssetName,
                    DARAssetID,EventType,EventDate,AnnouncementDate,EventDescription,SourceURL,EventStatus,Notes,Deleted,Exchange,BlockHeight,
                    CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime,operation)
                    values( _DAREventID,_DateofReview,_EventTypeID,_AssetID,_SourceID,_ExchangeAssetTicker,_ExchangeAssetName,_DARAssetID,
                    _EventType,_EventDate,_AnnouncementDate,_EventDescription,_SourceURL,_EventStatus,_Notes, _Deleted, _Exchange,_BlockHeight,
                    _CreateUser,_LastEditUser,_IsActive,v_date, v_date, _operation1);
					COMMIT;
                    SELECT ChangeID FROM EventInformation_Audit WHERE LastEditTime=v_date  into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE EventInformation_Audit SET DAREventID=_DAREventID,DateofReview=_DateofReview,EventTypeID=_EventTypeID,AssetID=_AssetID,SourceID=_SourceID,
                        ExchangeAssetTicker=_ExchangeAssetTicker,ExchangeAssetName=_ExchangeAssetName,DARAssetID=_DARAssetID,EventType=_EventType,EventDate=_EventDate,
                        AnnouncementDate=_AnnouncementDate,EventDescription=_EventDescription,SourceURL=_SourceURL,EventStatus=_EventStatus,Notes=_Notes,Deleted=_Deleted, 
                        Exchange=_Exchange,BlockHeight=_BlockHeight, LastEditUser=_LastEditUser, IsActive=_IsActive, LastEditTime=v_date, operation=_operation1 WHERE ChangeID=_ChangeID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                DELETE FROM EventInformation_Audit WHERE ChangeID=_ChangeID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
				
			END IF;
            Return v_id;
END //
DELIMITER ;

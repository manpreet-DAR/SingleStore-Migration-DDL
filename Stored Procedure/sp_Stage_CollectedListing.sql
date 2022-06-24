use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLStage_CollectedListing(
_OPERATION VARCHAR(20),
_CollectionSourceID INT,
_ExchangeAssetTicker VARCHAR(100),
_ID BIGINT(16) DEFAULT 0,
_ExchangeAssetName VARCHAR(250) DEFAULT NULL,
_ValidationTime DATETIME DEFAULT NULL,
_TickerMatch TINYINT DEFAULT NULL,
_NameMatch TINYINT DEFAULT NULL,
_ListingTickerMatch TINYINT DEFAULT NULL,
_ListingNameMatch TINYINT DEFAULT NULL,
_AssetID INT DEFAULT NULL,
_ListingID INT DEFAULT NULL,
_MatchesPrevious TINYINT DEFAULT NULL,
_ExcludeDuplicate TINYINT  DEFAULT NULL
) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
       
        BEGIN
            SELECT Count(*) FROM Stage_CollectedListing WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO Stage_CollectedListing( CollectionSourceID, ExchangeAssetTicker, ExchangeAssetName, ValidationTime, TickerMatch,NameMatch,ListingTickerMatch, ListingNameMatch, AssetID, 
                    ListingID,MatchesPrevious,ExcludeDuplicate, CreateTime)
                    values( _CollectionSourceID, _ExchangeAssetTicker, _ExchangeAssetName, _ValidationTime,_TickerMatch,_NameMatch,_ListingTickerMatch,_ListingNameMatch, _AssetID,
                    _ListingID,_MatchesPrevious,_ExcludeDuplicate,v_date);
					COMMIT;
                    SELECT ID FROM Stage_CollectedListing WHERE CollectionSourceID=_CollectionSourceID and  ExchangeAssetTicker=_ExchangeAssetTicker and CreateTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE Stage_CollectedListing SET CollectionSourceID=_CollectionSourceID, ExchangeAssetTicker=_ExchangeAssetTicker ,ExchangeAssetName=_ExchangeAssetName ,ValidationTime=_ValidationTime,
                        TickerMatch=_TickerMatch,NameMatch=_NameMatch,ListingTickerMatch=_ListingTickerMatch, ListingNameMatch=_ListingNameMatch, AssetID=_AssetID, ListingID=_ListingID, MatchesPrevious=_MatchesPrevious,
                        ExcludeDuplicate=_ExcludeDuplicate WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
                        
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                
				DELETE FROM Stage_CollectedListing WHERE ID=_ID;
				COMMIT;
				ECHO SELECT  v_id as "ID", 'Data Deleted';
			END IF;
            Return v_id;
END //
DELIMITER ;
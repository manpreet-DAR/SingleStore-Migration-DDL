use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetDEL(
_ID BIGINT(16) DEFAULT 0) RETURNS text AS
	DECLARE 
        v_del_count2 INT =0;
        v_del_count3 INT =0;
        v_del_count4 INT =0;
        v_del_count5 INT =0;
        v_del_count6 INT =0;
        v_del_count8 INT =0;
        v_del_count9 INT =0;
        v_del_count10 INT =0;
        v_del_count11 INT =0;
        v_del_count12 INT =0;
        v_del_count13 INT =0;
        v_del_count14 INT =0;
        
		BEGIN
            SELECT Count(*) FROM  ClientAssets WHERE AssetID=_ID into v_del_count2;
            SELECT Count(*) FROM  AssetToken WHERE AssetID=_ID into v_del_count3;
            SELECT Count(*) FROM  AssetVettingStatus WHERE AssetID=_ID into v_del_count4;
            SELECT Count(*) FROM  AssetAvailability WHERE AssetID=_ID into v_del_count5;
            SELECT Count(*) FROM  AssetCustodian WHERE AssetID=_ID into v_del_count6;
            SELECT Count(*) FROM  EventInformation WHERE AssetID=_ID into v_del_count8;
            SELECT Count(*) FROM  Listing WHERE AssetID=_ID into v_del_count9;
            SELECT Count(*) FROM  Pair WHERE AssetID=_ID into v_del_count10;
            SELECT Count(*) FROM  Pair WHERE QuoteAssetID=_ID into v_del_count11;
            SELECT Count(*) FROM  Stage_CollectedListing WHERE AssetID=_ID into v_del_count12;
            SELECT Count(*) FROM  Staging_CryptoNodeEvents WHERE AssetID=_ID into v_del_count13;
			SELECT Count(*) FROM  Staging_OutstandingSupply WHERE AssetID=_ID into v_del_count14;
            
			IF( v_del_count2=0 and v_del_count3=0 and v_del_count4=0 and v_del_count5=0 and v_del_count6=0 and v_del_count8=0 and v_del_count9=0 and v_del_count10=0 and v_del_count11=0 and v_del_count12=0 and v_del_count13=0 and v_del_count14=0) Then
				DELETE FROM AssetTheme WHERE AssetID=_ID;
                DELETE FROM AssetURL WHERE AssetID=_ID;
                DELETE FROM Asset WHERE ID=_ID;
				COMMIT;
				ECHO SELECT _ID as "ID", 'Success' as msg ;
			ELSEIF v_del_count2 !=0 Then
				ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT ClientAssets FOREIGN KEY ('AssetID') REFERENCES 'Asset' ('Id'))" AS msg;
			ELSEIF v_del_count3 !=0 Then
				ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT AssetToken FOREIGN KEY ('AssetID') REFERENCES 'Asset' ('Id'))" AS msg;
			ELSEIF v_del_count4 !=0 Then
				ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT AssetVettingStatus FOREIGN KEY ('AssetID') REFERENCES 'Asset' ('Id'))" AS msg;
			ELSEIF v_del_count5 !=0 Then
				ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT AssetAvailability FOREIGN KEY ('AssetID') REFERENCES 'Asset' ('Id'))" AS msg;
			ELSEIF v_del_count6 !=0 Then
				ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT AssetCustodian FOREIGN KEY ('AssetID') REFERENCES 'Asset' ('Id'))" AS msg;
			ELSEIF v_del_count8 !=0 Then
				ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT EventInformation FOREIGN KEY ('AssetID') REFERENCES 'Asset' ('Id'))" AS msg;
			ELSEIF v_del_count9 !=0 Then
				ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT Listing FOREIGN KEY ('AssetID') REFERENCES 'Asset' ('Id'))" AS msg;
			ELSEIF v_del_count10 !=0 Then
				ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT Pair FOREIGN KEY ('AssetID') REFERENCES 'Asset' ('Id'))"AS msg;
			ELSEIF v_del_count11 !=0 Then
				ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT Pair FOREIGN KEY ('QuoteAssetID') REFERENCES 'Asset' ('Id'))" AS msg;
			ELSEIF v_del_count12 !=0 Then
				ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT Stage_CollectedListing FOREIGN KEY ('AssetID') REFERENCES 'Asset' ('Id'))" AS msg;
			ELSEIF v_del_count13 !=0 Then
				ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT Staging_CryptoNodeEvents FOREIGN KEY ('AssetID') REFERENCES 'Asset' ('Id'))" AS msg;
			ELSEIF v_del_count14 !=0 Then
				ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT Staging_OutstandingSupply FOREIGN KEY ('AssetID') REFERENCES 'Asset' ('Id'))" AS msg;
			END IF;
		Return _ID;
END //
DELIMITER ;

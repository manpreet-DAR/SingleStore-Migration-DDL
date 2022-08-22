use refmaster_internal;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLClientDEL(
_ID BIGINT) AS
DECLARE 
	ip_count INT; 
    asset_count INT; 
    query_client_ids QUERY(id BIGINT NOT NULL) = SELECT ID FROM Clients WHERE ID=_ID;  
    cid BIGINT; 
BEGIN
    -- CASCADING DELETE removes FK records from downstream tables 'ClientIP' and 'ClientAssets'
    cid = SCALAR(query_client_ids);
    SELECT COUNT(*) FROM ClientAssets WHERE ClientID=_ID INTO asset_count;
    DELETE FROM ClientAssets WHERE ClientID=_ID;
    COMMIT; 
    SELECT COUNT(*) FROM ClientIPs WHERE ClientID=_ID INTO ip_count;
    DELETE FROM ClientIPs WHERE ClientID=_ID;
    COMMIT; 
    EXCEPTION
		WHEN ER_SCALAR_BUILTIN_NO_ROWS THEN 
			ECHO SELECT "KEY ('ID', 'Name') does not exist." AS Output; 
            RAISE; 
END //
DELIMITER ;


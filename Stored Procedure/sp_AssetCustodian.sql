use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetCustodian(
_AssetID BIGINT,
_CustodianID BIGINT,
_CreateUser VARCHAR(100)DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_ID LONG DEFAULT 0) AS
DECLARE 
	q QUERY(cust_id LONG not null) = SELECT ID FROM Custodian WHERE ID=_CustodianID;
    v LONG; 
	v_date DATETIME = CURRENT_TIMESTAMP();
BEGIN
	-- FK constraint for Custodian 
	v = SCALAR(q);
	SELECT NOW() into v_date;
	INSERT INTO AssetCustodian(ID, AssetID, CustodianID, CreateUser, LastEditUser, CreateTime, LastEditTime)
	VALUES(_ID, _AssetID, _CustodianID, _CreateUser, _LastEditUser, v_date, v_date)
	ON DUPLICATE KEY UPDATE LastEditUser = _LastEditUser, LastEditTime = v_date;
	ECHO SELECT ID FROM AssetCustodian WHERE CustodianID=_CustodianID AND AssetID=_AssetID; 
EXCEPTION
	WHEN ER_SCALAR_BUILTIN_NO_ROWS THEN
	ECHO SELECT "Cannot add or update a child row: a foreign key constraint fails( CONSTRAINT FOREIGN KEY ('CustodianID') REFERENCES 'Custodian' ('ID'))" 
	RAISE; 
END //
DELIMITER ;

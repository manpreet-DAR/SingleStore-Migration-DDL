USE refmaster_internal_DEV;
DELIMITER // 
CREATE OR REPLACE PROCEDURE spDMLUserRoles(
_operation VARCHAR(20) NULL,
_userId varchar(128) NULL, 
_roleId varchar(128) NULL) 
AS
DECLARE 
	users QUERY(id VARCHAR(128)) = SELECT UserId FROM UserRoles WHERE UserId=_userId AND RoleId=_roleId; 
    id VARCHAR(128); 
    output TEXT = CONCAT(current_timestamp(), ", method: ", (_operation), ", message: "); 
BEGIN
	id = SCALAR(users);     
    IF(UPPER(_operation) = "DELETE") THEN
		DELETE FROM UserRoles WHERE UserId=id AND RoleId=_roleId;
		COMMIT;
		output = CONCAT(output, "SUCCESS"); 
	ELSE
		output = CONCAT(output, "Cannot add or update a child row: Duplicate key error(CONSTRAINT ('UserId, 'RoleId') must be UNIQUE)"); 
	END IF; 
	ECHO SELECT output AS RowOutput;      
EXCEPTION
	WHEN ER_SCALAR_BUILTIN_NO_ROWS THEN
		IF(UPPER(_operation)="UPSERT") THEN
			INSERT INTO  UserRoles(UserId, RoleId)
			VALUES(_userId, _roleId);
			COMMIT; 
			output = CONCAT(output, "SUCCESS"); 
		ELSE
			output = CONCAT(output, "FAIL"); 
		END IF;
		ECHO SELECT output AS RowOutput;      
END //
DELIMITER ; 


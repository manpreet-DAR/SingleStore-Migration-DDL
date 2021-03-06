USE refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAppModuleDEL(_Id BIGINT(16) NULL) AS
BEGIN
	IF (_Id IS NOT NULL) THEN
		DELETE FROM RoleAppModule WHERE AppModuleId = _Id; 
        DELETE FROM AppModule WHERE Id = _Id;		
		COMMIT;
	ELSE
		ECHO SELECT "FAIL" AS Execution; 
	END IF; 
	ECHO SELECT "SUCCESS" AS Execution;
END // 
DELIMITER ;  

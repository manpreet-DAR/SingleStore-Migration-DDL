use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLUsersDEL(
_Id VARCHAR(128)) AS
	DECLARE
		claim_cnt INT;
--         login_cnt INT;
        user_roles INT;
		BEGIN
			SELECT Count(*) INTO claim_cnt FROM  UserClaims WHERE UserId=_Id; 
            -- User claims auditable using IDs from User_Audit
            -- SELECT Count(*) FROM  UserLogins WHERE UserId=_Id into v_del_count2;
            SELECT Count(*) INTO user_roles FROM  UserRoles WHERE UserId=_Id; 
			IF(claim_cnt=0 and user_roles=0) Then
				INSERT INTO Users_Audit
                SELECT * FROM Users WHERE ID=_Id; 
                COMMIT; 
				DELETE FROM Users WHERE ID=_Id;
				COMMIT;
				ECHO SELECT 'Success' AS msg;
			ELSEIF claim_cnt > 0 THEN
				RAISE user_exception("Duplicate value for key constraint (UserClaims, Id)");
			ELSEIF user_roles > 0 THEN
				RAISE user_exception("Duplicate value for key constraint (UserRoles,Id)");
			END IF;

END //
DELIMITER ;
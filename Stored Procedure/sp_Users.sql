use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLUsers(
_OPERATION VARCHAR(20),
_Id VARCHAR(128),
_EmailConfirmed TINYINT(1),
_PhoneNumberConfirmed TINYINT(1),
_TwoFactorEnabled TINYINT(1),
_LockoutEnabled TINYINT(1),
_AccessFailedCount INT,
_UserName VARCHAR(256),
_Email VARCHAR(256) DEFAULT NULL,
_PasswordHash LONGTEXT DEFAULT NULL,
_SecurityStamp LONGTEXT DEFAULT NULL,
_PhoneNumber LONGTEXT DEFAULT NULL,
_LockoutEndDateUtc DATETIME DEFAULT NULL
) RETURNS text AS
	DECLARE 
	v_count INT =0;
	v_count2 INT =0;
	BEGIN
		SELECT Count(*) FROM  Users WHERE Id=_Id or UserName=_UserName into v_count;
        SELECT Count(*) FROM  Users WHERE Id=_Id and UserName=_UserName into v_count2;
		IF (UPPER(_OPERATION) = "UPSERT") Then
			IF(v_count = 0) Then 
				INSERT INTO  Users(Id, Email, EmailConfirmed, PasswordHash, SecurityStamp, PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEndDateUtc, LockoutEnabled, AccessFailedCount, UserName)
				values(_Id, _Email, _EmailConfirmed, _PasswordHash, _SecurityStamp, _PhoneNumber, _PhoneNumberConfirmed, _TwoFactorEnabled, _LockoutEndDateUtc, _LockoutEnabled, _AccessFailedCount, _UserName);
				COMMIT;
				ECHO SELECT _Id as "Id", _UserName as "_UserName",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Inserted';

		ELSEIF(v_count = 1) Then
			IF (v_count2 =1) Then
				UPDATE  Users SET Email=_Email , EmailConfirmed=_EmailConfirmed, PasswordHash=_PasswordHash, SecurityStamp=_SecurityStamp, PhoneNumber=_PhoneNumber, PhoneNumberConfirmed=_PhoneNumberConfirmed, TwoFactorEnabled=_TwoFactorEnabled, LockoutEndDateUtc=_LockoutEndDateUtc, LockoutEnabled=_LockoutEnabled, AccessFailedCount=_AccessFailedCount, UserName=_UserName 
				WHERE Id=_Id;
				ECHO SELECT _Id as "Id", _UserName as "_UserName",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data  Updated';
			ELSE 
				ECHO SELECT _Id as "Id", _UserName as "_UserName",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Partial combination exist for UserName or Id columns ';
				END IF;
		ELSE
			ECHO SELECT v_count,v_count2, 'Duplicate Date found!!!';
		END IF;
		Return _Id;
	END //
DELIMITER ;
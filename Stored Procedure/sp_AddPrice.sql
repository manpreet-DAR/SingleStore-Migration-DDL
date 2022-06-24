use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAddPrice(
_OPERATION VARCHAR(20),
_AssetName VARCHAR(500),
_AssetTicker VARCHAR(500),
_Exchange VARCHAR(500),
_ContractAddress VARCHAR(1000),
_Contact VARCHAR(1000),
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_ID BIGINT(16) DEFAULT 0, 
_IsActive TINYINT DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_count2 INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
		v_id BIGINT(16)= _ID;

		BEGIN
			SELECT NOW() into v_date;
            SELECT Count(*) FROM  AddPrice WHERE AssetName=_AssetName or AssetTicker=_AssetTicker or Exchange=_Exchange into v_count;
            SELECT Count(*) FROM  AddPrice WHERE AssetName=_AssetName and AssetTicker=_AssetTicker and Exchange=_Exchange into v_count2;
			
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then 
					INSERT INTO  AddPrice(AssetName, AssetTicker, Exchange, ContractAddress, Contact, IsActive, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_AssetName, _AssetTicker, _Exchange, _ContractAddress, _Contact, _IsActive, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT Id FROM AddPrice WHERE AssetName=_AssetName and AssetTicker=_AssetTicker and Exchange=_Exchange into v_id;
                    ECHO SELECT v_id as "Id", _AssetName as "AssetName",_AssetTicker as "AssetTicker",_Exchange as "Exchange",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Inserted';
   
				ELSEIF(v_count = 1) Then
					
                    IF (v_count2 =1) Then
						UPDATE  AddPrice SET ContractAddress=_ContractAddress, Contact=_Contact, IsActive=_IsActive,LastEditUser=_LastEditUser, LastEditTime=v_date 
                        WHERE Id=_Id;  
						ECHO SELECT _Id as "Id", _AssetName as "AssetName",_AssetTicker as "AssetTicker",_Exchange as "Exchange", v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Data Updated';
					ELSE 
                        ECHO SELECT _Id as "Id", _AssetName as "AssetName",_AssetTicker as "AssetTicker",_Exchange as "Exchange",v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Partial combination exist for AssetName, AssetTicker or Exchange columns ';
						END IF;
				ELSEIF(v_count > 1) Then
					ECHO SELECT v_count as "Partial combination exists",v_count2 as "Exact combination exists",  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				IF (v_count2=1) Then
					DELETE FROM  AddPrice WHERE Id=_Id;
					COMMIT;
                    ECHO SELECT  _Id as "Id", _AssetName as "AssetName",_AssetTicker as "AssetTicker",_Exchange as "Exchange",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Data Deleted';
				ELSE
					ECHO SELECT  _Id as "Id", _AssetName as "AssetName",_AssetTicker as "AssetTicker",_Exchange as "Exchange",v_count as "Partial combination exists",v_count2 as "Exact combination exists", 'Partial combination exist for AssetName, AssetTicker or Exchange columns';
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;
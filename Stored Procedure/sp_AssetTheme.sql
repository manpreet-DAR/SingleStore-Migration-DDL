use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetTheme(
_OPERATION VARCHAR(20),
_AssetID BIGINT(16) ,
_ThemeID BIGINT(16) NOT NULL,
_CreateUser VARCHAR(100)DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL,
_Id BIGINT(16) DEFAULT 1) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_del_count1 INT =0;
        v_id BIGINT(16) =  _Id;
        BEGIN
            SELECT Count(*) FROM  AssetTheme WHERE AssetID=_AssetID and ThemeID=_ThemeID  into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO  AssetTheme(AssetID, ThemeID, CreateUser, LastEditUser, CreateTime, LastEditTime)
                    values(_AssetID, _ThemeID, _CreateUser, _LastEditUser, v_date, v_date);
					COMMIT;
                    SELECT ID FROM AssetTheme WHERE AssetID=_AssetID and ThemeID=_ThemeID into v_id;
                    ECHO SELECT v_id as "ID", 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE  AssetTheme SET AssetID=_AssetID , ThemeID=_ThemeID, LastEditUser=_LastEditUser, LastEditTime=v_date WHERE Id=_Id;
						ECHO SELECT v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM  Theme WHERE Id=_ThemeID into v_del_count1;
				IF(v_del_count1 =0) Then
					DELETE t FROM AssetTheme t
                    INNER JOIN Theme th on t.ThemeID = th.ID
                    WHERE t.AssetID = _AssetID
                    and th.Name = @theme
                    and th.ThemeType = @themeType
					DELETE FROM  AssetTheme WHERE Id=_Id;
					COMMIT;
					ECHO SELECT  v_id as "ID",'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Theme field (ThemeID,Id)";

				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

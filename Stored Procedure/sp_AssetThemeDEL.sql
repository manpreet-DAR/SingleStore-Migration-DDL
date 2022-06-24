use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLAssetThemeDEL(
_AssetID BIGINT(16) ,
_ThemeType VARCHAR(100),
_Theme VARCHAR(250)) AS
	BEGIN 
		DELETE t FROM AssetTheme t INNER JOIN Theme th on t.ThemeID = th.ID WHERE t.AssetID = _AssetID and th.Name = _Theme and th.ThemeType = _themeType;
        COMMIT;
		ECHO SELECT 'Data Deleted';
END //
DELIMITER ;
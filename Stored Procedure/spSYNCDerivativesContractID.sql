use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spSYNCDerivativesContractID()
AS
DECLARE
BEGIN
	
    INSERT IGNORE refmaster_internal_DEV.DerivativesContractID(DARContractID, ContractTicker) SELECT DISTINCT DARContractID, ContractTicker FROM refmaster_internal_DEV.Derivatives;
END //

DELIMITER ; 

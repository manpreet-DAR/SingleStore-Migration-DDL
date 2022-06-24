use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLServingList(
_OPERATION VARCHAR(20),
_ProcessID INT,
_Start DATETIME,
_ID BIGINT(16) DEFAULT 0,
_End DATETIME DEFAULT NULL,
_PairID INT DEFAULT NULL,
_SourceID INT DEFAULT NULL,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 int =0;
       
        BEGIN
            SELECT Count(*) FROM ServingList WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO ServingList( ProcessID, Start, End, PairID, SourceID, CreateUser, LastEditUser, IsActive, CreateTime, LastEditTime)
                    values( _ProcessID, _Start, _End, _PairID, _SourceID,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM ServingList WHERE ProcessID=_ProcessID and Start=_Start into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE ServingList SET ProcessID=_ProcessID,Start=_Start, End=_End,PairID=_PairID, SourceID=_SourceID,
                        IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
                SELECT Count(*) FROM Pair WHERE ID=_PairID into v_del_count1;
                
                IF(v_del_count1 =0 ) Then
					DELETE FROM ServingList WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table Pair field (PairID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

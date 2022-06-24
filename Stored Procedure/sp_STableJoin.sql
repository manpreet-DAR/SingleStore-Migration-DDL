use refmaster_internal_DEV;
DELIMITER //
CREATE OR REPLACE PROCEDURE spDMLSTableJoin(
_OPERATION VARCHAR(20),
_FromColumnID INT,
_ToColumnID INT,
_JoinTypeID INT,
_JoinDirectionID INT,
_ID BIGINT(16) DEFAULT 0,
_IsActive TINYINT DEFAULT 1,
_CreateUser VARCHAR(100) DEFAULT NULL,
_LastEditUser VARCHAR(100) DEFAULT NULL) RETURNS text AS
	DECLARE 
		v_count INT =0;
        v_date DATETIME = CURRENT_TIMESTAMP();
        v_id BIGINT(16) =  _ID;
        v_del_count1 INT = 0;
        v_del_count2 INT = 0;
       
        BEGIN
            SELECT Count(*) FROM STableJoin WHERE ID=_ID into v_count;
            SELECT NOW() into v_date;
            If (UPPER(_OPERATION) = "UPSERT") Then
				IF(v_count = 0) Then
					INSERT INTO STableJoin( FromColumnID,ToColumnID,JoinTypeID,JoinDirectionID,CreateUser, LastEditUser, IsActive,CreateTime, LastEditTime)
                    values( _FromColumnID,_ToColumnID,_JoinTypeID,_JoinDirectionID,_CreateUser,_LastEditUser,_IsActive,v_date, v_date);
					COMMIT;
                    SELECT ID FROM STableJoin WHERE FromColumnID=_FromColumnID and ToColumnID=_ToColumnID and JoinTypeID=_JoinTypeID and JoinDirectionID=_JoinDirectionID and LastEditTime=v_date into v_id;
                    ECHO SELECT v_id as "ID" , 'Data Inserted';
   
				ELSEIF(v_count = 1) Then
						UPDATE STableJoin SET FromColumnID=_FromColumnID,ToColumnID=_ToColumnID,JoinTypeID=_JoinTypeID,JoinDirectionID=_JoinDirectionID,
						IsActive=_IsActive,LastEditUser=_LastEditUser,LastEditTime=v_date WHERE ID=_ID;
						ECHO SELECT  v_id as "ID", 'Data  Updated';
				ELSEIF(v_count > 1) Then
					ECHO SELECT  'Duplicate Date found!!!';
                END IF;
			ELSEIF(UPPER(_OPERATION) = "DELETE") Then
				
                SELECT Count(*) FROM STableJoinDirection WHERE ID=_JoinDirectionID into v_del_count1;
                SELECT Count(*) FROM STableJoinType WHERE ID=_JoinTypeID into v_del_count2;
                 
                IF(v_del_count1 =0 and  v_del_count2 =0 ) Then
					DELETE FROM STableJoin WHERE ID=_ID;
					COMMIT;
					ECHO SELECT  v_id as "ID", 'Data Deleted';
				ELSEIF v_del_count1 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table STableJoinDirection field (JoinDirectionID,Id)";
				ELSEIF v_del_count2 !=0 Then
					ECHO SELECT "Foreign Key constraint violet here for Table SEntity field (JoinTypeID,Id)";
				END IF;
			END IF;
            Return v_id;
END //
DELIMITER ;

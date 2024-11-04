CREATE UNIQUE CLUSTERED INDEX [Issuance_VoterIDIndex]
    ON [dbo].[IssuanceRecord]([VoterID] ASC);

CREATE UNIQUE NONCLUSTERED INDEX [IssuanceRecordserialINDEX]
     ON [dbo].[IssuanceRecord]([ElectionSerialNo] ASC);

-- -- SELECT CONSTRAINT_NAME
-- -- FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
-- -- WHERE TABLE_NAME = 'IssuanceRecord'
-- -- AND CONSTRAINT_TYPE = 'PRIMARY KEY';


-- -- ALTER TABLE dbo.IssuanceRecord
-- -- DROP CONSTRAINT PK__Issuance__E918AC07368463C0;


-- ALTER TABLE dbo.IssuanceRecord
-- ADD CONSTRAINT PK_IssuanceRecord
-- PRIMARY KEY (VoterID, ElectionSerialNo);
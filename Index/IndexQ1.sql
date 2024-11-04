-- ALTER TABLE VoterRegistry
-- DROP CONSTRAINT PK__VoterReg__12D25BD82A44E571;

CREATE CLUSTERED INDEX VoterRegistry_DivN
                ON VoterRegistry(DivisionName);

-- ALTER TABLE VoterRegistry

-- ADD CONSTRAINT PK_VoterRegistry PRIMARY KEY NONCLUSTERED (VoterID);



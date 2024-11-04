CREATE PARTITION FUNCTION BallotPartitionFunction (INT)
AS RANGE LEFT FOR VALUES (1)-- Define ranges for hash values
-- Define partition scheme for Ballot and BallotPreferences
CREATE PARTITION SCHEME BallotPartitionScheme
AS PARTITION BallotPartitionFunction
ALL TO ([PRIMARY]); -- Map all partitions to primary filegroup
GO
-- Create Ballot table with hash partitioning
CREATE TABLE [dbo].[Ballot] (
[BallotID] INT NOT NULL, -- Unique identifier for the ballot
[ElectionEventID] INT NULL, -- Identifier for the associated election event
PRIMARY KEY CLUSTERED ([BallotID] ASC), -- Primary key constraint
HashValue AS (ABS(BINARY_CHECKSUM(ElectionEventID) % 4)) PERSISTED NOT NULL -- Computed
hash value
)
ON BallotPartitionScheme (HashValue); -- Partition scheme based on hash value
GO
CREATE TABLE [dbo].[BallotPreferences] (
[BallotID] INT NOT NULL, -- Identifier for the ballot
[CandidateID] INT NOT NULL, -- Identifier for the candidate
[Preference] INT NULL, -- Preference order
PRIMARY KEY CLUSTERED ([BallotID] ASC, [CandidateID] ASC), -- Composite primary key
HashValue AS (ABS(BINARY_CHECKSUM(Preference) % 4)) PERSISTED NOT NULL -- Computed hash
value
)
ON BallotPartitionScheme (HashValue); -- Partition scheme based on hash value
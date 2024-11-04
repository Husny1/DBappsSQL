-- Define partition function
CREATE PARTITION FUNCTION VoterPartitionFunction (INT)
AS RANGE LEFT FOR VALUES (1); -- Range boundary value

-- Define partition scheme
CREATE PARTITION SCHEME VoterPartitionScheme
AS PARTITION VoterPartitionFunction
ALL TO ([PRIMARY]); -- Map all partitions

-- Create partitioned table
CREATE TABLE VoterRegistry (
    VoterID INT IDENTITY(1,1), 
    FirstName VARCHAR(100),
    MiddleNames VARCHAR(100),
    LastName VARCHAR(100),
    Address VARCHAR(255), 
    DoB DATE, 
    Gender CHAR(1), 
    ResidentialAddress VARCHAR(255), 
    PostalAddress VARCHAR(255), 
    ContactPhone VARCHAR(20), 
    ContactMobile VARCHAR(20), 
    ContactEmail VARCHAR(100), 
    DivisionName VARCHAR(150), 
    HashValue AS (ABS(BINARY_CHECKSUM(VoterID) % 1)) PERSISTED NOT NULL -- Computed hash value
)
ON VoterPartitionScheme (VoterID); -- Partition scheme used
GO


SELECT 
    t.name AS TableName,
    p.partition_number,
    p.rows AS NumberOfRows
FROM 
    sys.partitions p
JOIN 
    sys.tables t ON p.object_id = t.object_id
WHERE 
    t.name = 'VoterRegistry'
ORDER BY 
    p.partition_number;
GO

-- INSERT INTO VoterRegistry (
--     FirstName, 
--     MiddleNames, 
--     LastName, 
--     Address, 
--     DoB, 
--     Gender, 
--     ResidentialAddress, 
--     PostalAddress, 
--     ContactPhone, 
--     ContactMobile, 
--     ContactEmail, 
--     DivisionName
-- ) 
-- VALUES 
--     ('Jane', 'B.', 'Smith', '456 Oak St', '1990-05-15', 'F', '456 Oak St', 'PO Box 456', '555-6789', '555-9876', 'jane.smith@example.com', 'Division2'),
--     ('Mike', NULL, 'Johnson', '789 Pine St', '1975-09-30', 'M', '789 Pine St', 'PO Box 789', '555-1357', '555-2468', 'mike.johnson@example.com', 'Division3');
-- GO
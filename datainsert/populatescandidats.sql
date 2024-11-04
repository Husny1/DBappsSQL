-- Insert 906 candidates into the existing Contests table with 151 ElectionEventIDs (6 candidates per division)

WITH NumberedCandidates AS (
    -- Generate 906 sequential CandidateID numbers
    SELECT 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS CandidateID
    FROM sys.objects o1
    CROSS JOIN sys.objects o2
),
ElectionEventAssignment AS (
    -- Assign ElectionEventID to each candidate by cycling through 1 to 151, with each ID repeated 6 times
    SELECT 
        CandidateID,
        ((ROW_NUMBER() OVER (ORDER BY CandidateID) - 1) / 6 + 1) AS ElectionEventID -- Assign each ElectionEventID to 6 candidates
    FROM NumberedCandidates
)
-- Insert into the existing Contests table
INSERT INTO [dbo].[Contests] (ElectionEventID, CandidateID)
SELECT 
    ElectionEventID,
    CandidateID
FROM ElectionEventAssignment
WHERE ElectionEventID <= 151; -- Ensure only 151 divisions are used


WITH NumberedCandidates AS (
    -- Generate 906 sequential CandidateID numbers starting from 907
    SELECT 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) + 906 AS CandidateID
    FROM sys.objects o1
    CROSS JOIN sys.objects o2
),
ElectionEventAssignment AS (
    -- Assign ElectionEventID to each candidate by cycling through 152 to 302, with each ID repeated 6 times
    SELECT 
        CandidateID,
        ((ROW_NUMBER() OVER (ORDER BY CandidateID) - 1) / 6 + 152) AS ElectionEventID -- Start from ElectionEventID 152 and assign 6 candidates per division
    FROM NumberedCandidates
)
-- Insert into the existing Contests table
INSERT INTO [dbo].[Contests] (ElectionEventID, CandidateID)
SELECT 
    ElectionEventID,
    CandidateID
FROM ElectionEventAssignment
WHERE ElectionEventID <= 302; 
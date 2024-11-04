CREATE OR ALTER FUNCTION Previously_Voted
(
    @VoterIdentification AS INT,
    @DivisionName AS VARCHAR(150),
    @EventSerialNumber AS INT
)
RETURNS INT -- return
AS
BEGIN 
    DECLARE @Previouslyvoted AS VARCHAR(10);
    -- Check if VoterID exists in the IssuanceRecord 
    IF NOT EXISTS (SELECT 1 FROM IssuanceRecord WHERE VoterID = @VoterIdentification)
    BEGIN
        RETURN -1;--might change to boolean variable 
    END;

    -- Check if DivisionName exists in the VoterRegistry
    IF NOT EXISTS (SELECT 1 FROM VoterRegistry WHERE DivisionName = @DivisionName)
    BEGIN
        RETURN -2;--might change to boolean variable 
    END;

    -- Check if DivisionName matches VoterID
    IF NOT EXISTS (SELECT 1 FROM VoterRegistry WHERE VoterID = @VoterIdentification AND DivisionName = @DivisionName)
    BEGIN
        RETURN -3;--might change to boolean variable 
    END;

    -- Check if ElectionSerialNo exists
    IF NOT EXISTS (SELECT 1 FROM IssuanceRecord WHERE ElectionSerialNo = @EventSerialNumber)
    BEGIN
        RETURN -4;--might change to boolean variable 
    END;

    -- Check if the Voter has previously voted in the election
    SET @Previouslyvoted = CASE
        WHEN EXISTS (
            SELECT 1
            FROM IssuanceRecord 
            WHERE VoterID = @VoterIdentification
            AND ElectionSerialNo = @EventSerialNumber
        ) 
        THEN 1 --true have voted
        ELSE 0--false have not
    END;

    RETURN @Previouslyvoted;
END;
GO
-- to run 

-- working example
-- SELECT dbo.Previously_Voted(1 ,'cowper', 20220521) AS Previously_Voted;

-- fail example
-- SELECT dbo.Previously_Voted(2 ,'Hinkler', 20220521) AS Previously_Voted;

-- SHOULD BE ABLE TO BE USED IN STORED FUNCTION 

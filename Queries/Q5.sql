CREATE OR ALTER PROCEDURE PrimaryVoteCount
 --declare variables
    @DivisionName VARCHAR(100),
    @ElectionEventID INT
AS
DECLARE
@CandidateID INT,
@roundCount INT
SET @roundCount = 1 

BEGIN -- input validation -- check if DivisionName exists in electionEvent
        IF NOT EXISTS (SELECT 1 FROM ElectionEvent  WHERE DivisionName = @DivisionName)
        BEGIN
            RAISERROR (' DivisonName does not exist, Try again', 10, 0);
            RETURN;
        END;
        -- check if electioneventID exists in electionevent
           IF NOT EXISTS (SELECT 1 FROM ElectionEvent WHERE ElectionEventID = @ElectionEventID)
        BEGIN
            RAISERROR ('electioneventID number does not exist, Try again', 10, 0);
            RETURN;
        END; 
        -- check if eventid and div name exist within each other 
         IF NOT EXISTS (SELECT 1 FROM ElectionEvent WHERE ElectionEventID = @ElectionEventID AND DivisionName = @DivisionName)
        BEGIN
            RAISERROR ('electioneventID number does not match divisionName , Try again', 10, 0);
            RETURN;
    END;
WITH GetCandidateID AS  -- CTE to get candidate ID from user inputs on division and serialNO
(  -- SAME A QUEUE 2 QUERY
    SELECT ElectionEvent.DivisionName, ElectionEvent.ElectionEventID, Candidate.CandidateID
    FROM ElectionEvent
    JOIN Contests ON ElectionEvent.ElectionEventID = Contests.ElectionEventID 
    JOIN Candidate ON Contests.CandidateID = Candidate.CandidateID
    WHERE ElectionEvent.ElectionEventID = @ElectionEventID
    AND ElectionEvent.DivisionName = @DivisionName
),
primaryVoteCount AS
(
    SELECT BallotPreferences.CandidateID, COUNT(*) AS VoteCount -- counting preferences
    FROM BallotPreferences
    JOIN GetCandidateID ON BallotPreferences.CandidateID = GetCandidateID.CandidateID -- joining GETCAN CTE with Ballot table to get matching CandID 
    WHERE BallotPreferences.Preference = '1' -- counting preferences only with 1 
    GROUP BY BallotPreferences.CandidateID  --Grouping  candidates in preferences

)

INSERT INTO PreferenceTallyPerRoundPerCandidate (ElectionEventID,RoundNo,CandidateID,PreferenceTally)
SELECT 
    @ElectionEventID,          -- Use the variable for electioneventID
    @roundcount,                    -- Use the variable for RoundNo
    primaryVoteCount.CandidateID,    -- CandidateID from the CTE
    primaryVoteCount.VoteCount       -- VoteCount from the CTE
FROM primaryVoteCount;


WITH EliminatedCandidate AS 
(
    SELECT CandidateID, PreferenceTally
    FROM PreferenceTallyPerRoundPerCandidate
    WHERE PreferenceTally = ( -- sub select required to get min of preferencetally in cte 
    SELECT MIN (PreferenceTally) -- select lowest preftally 
    FROM PreferenceTallyPerRoundPerCandidate
    
)
)

INSERT INTO PrefCountRecord (ElectionEventID,RoundNo,EliminatedCandidateID,PreferenceAggregate)
SELECT 
    @ElectionEventID,          -- Use the variable for electioneventID
    @roundcount,                    -- Use the variable for RoundNo
    CandidateID,    -- CandidateID from the CTE
    PreferenceTally --  PREF AGGREGATE from the CTE
FROM EliminatedCandidate;

END;

-- to refresh and delete tables
--  DELETE FROM PreferenceTallyPerRoundPerCandidate
--  DELETE FROM PrefCountRecord
-- to run 
-- EXEC PrimaryVoteCount @DivisionName = 'Bennelong', @ElectionEventID = 10 
-- inserting into the table  and removing invalid votes 

-- DELETE FROM BallotPreferences;
-- DELETE FROM PreferenceTallyPerRoundPerCandidate;

INSERT INTO BallotPreferences (BallotID, CandidateID, Preference)
SELECT 
    BallotID,
    CandidateID,
    CASE  -- Converting sequential roman numerals to INT
        WHEN Preference = 'I' THEN 1
        WHEN Preference = 'II' THEN 2
        WHEN Preference = 'III' THEN 3
        WHEN Preference = 'IV' THEN 4
        WHEN Preference = 'V' THEN 5
        WHEN Preference = 'VI' THEN 6
        ELSE CAST(Preference AS INT) -- Convert numeric values stored as strings
    END AS PreferenceConverted
FROM ballotData
WHERE -- No null values imported to the table
    BallotID IS NOT NULL  --  BallotID is not NULL 
    AND CandidateID IS NOT NULL  --  CandidateID is not NULL
    AND Preference IS NOT NULL  --  Preference is not NULL
    AND BallotID NOT IN (100, 200, 300,400,500,600, 700, 900, 1000); --removng these ballot ids as they are invalid 
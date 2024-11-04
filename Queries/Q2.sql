SELECT ElectionEvent.DivisionName AS Division_Name,  Candidate.CandidateName AS Candidate_Name, PoliticalParty.PartyName AS Political_Party, ElectionEvent.ElectionSerialNo AS ElectionSerialNumber
FROM ElectionEvent
JOIN Contests ON ElectionEvent.ElectionEventID = Contests.ElectionEventID -- Joining electioneventID to electioneventID in contests
JOIN Candidate ON Contests.CandidateID = Candidate.CandidateID -- joining candidate id contests to the candidate id in candidate 
JOIN PoliticalParty ON Candidate.PartyCode = PoliticalParty.PartyCode -- joining party code to candidate partycode
WHERE ElectionEvent.ElectionSerialNo = '20220521' -- election serial no must be x
ORDER BY ElectionEvent.DivisionName ASC,NEWID(); --  random order to the CandidateID coloumn using newID will randomise every RUN EXEC



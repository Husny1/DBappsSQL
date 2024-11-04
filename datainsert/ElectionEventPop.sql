INSERT INTO ElectionEvent (ElectionEventID, TotalVoters, VotesCast, VotesReject, VotesValid, ElectionSerialNo, DivisionName)
SELECT ElectionEventID,  TotalVoters, VotesCast, VotesRejected, VotesValid, EventSerialNo, DivisionName
FROM ElectionEventData;
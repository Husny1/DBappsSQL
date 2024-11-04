INSERT INTO IssuanceRecord (VoterID,EventSerialNo)
SELECT VoterID, ElectionSerialNo 
FROM IssuanceData
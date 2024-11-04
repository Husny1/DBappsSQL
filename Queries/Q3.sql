SELECT FirstName, Address FROM VoterRegistry
WHERE VoterID NOT IN ( -- if not it it will show add and first
SELECT VoterID from IssuanceRecord 
WHERE ElectionSerialNo IN ('20220521', '20190518')) -- did not vote in those events 

-- Only 200 records in issuancedata
-- so should be -200 registered as there are only 200 records inserted IssuanceRecord into from 1000 registeredVoters 

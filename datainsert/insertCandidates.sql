INSERT INTO Candidate (CandidateName, ContactAddress, ContactPhone, ContactEmail, PartyCode)
SELECT CandidateName, ContactAddress, ContactPhone, ContactEmail, PartyCode FROM candidatesData2;

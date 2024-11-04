INSERT INTO Candidate ( CandidateName, ContactAddress, ContactMobile, PartyCode)
SELECT First_Name + ' ' + Surname AS CandidateName, 
Electorate_Address_Line_1 AS ContactAddress,
Telephone AS ContactMobile,
Political_Party AS PartyCode
FROM [Current Members of Parliament(8)];
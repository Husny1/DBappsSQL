INSERT INTO VoterRegistry (FirstName,LastName, Address, DoB, Gender, ContactPhone, ContactEmail, ResidentialAddress, DivisionName)
SELECT FirstName,LastName, Address, DoB, Gender, ContactPhone, ContactEmail, ResidentialAddress, DivisionName
FROM MOCK_DATA
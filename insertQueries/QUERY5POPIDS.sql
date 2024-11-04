-- -- Enable identity insert to allow manual setting of CandidateID
-- SET IDENTITY_INSERT Candidate ON;

-- -- Insert 6 new records with specific CandidateID values
-- INSERT INTO Candidate (CandidateID, CandidateName, ContactAddress, ContactPhone, ContactEmail, PartyCode)
-- VALUES
-- (20645, 'Candidate 1', 'Address 1', 'Phone 1', 'email1@example.com', 'AWP'),
-- (10268, 'Candidate 2', 'Address 2', 'Phone 2', 'email2@example.com', 'AWP'),
-- (13321, 'Candidate 3', 'Address 3', 'Phone 3', 'email3@example.com', 'AWP'),
-- (17258, 'Candidate 4', 'Address 4', 'Phone 4', 'email4@example.com', 'AWP'),
-- (17846, 'Candidate 5', 'Address 5', 'Phone 5', 'email5@example.com', 'AWP'),
-- (20553, 'Candidate 6', 'Address 6', 'Phone 6', 'email6@example.com', 'AWP');

-- -- Disable identity insert to revert to auto-increment behavior
-- SET IDENTITY_INSERT Candidate OFF;


INSERT INTO [dbo].[Contests] (ElectionEventID, CandidateID)
VALUES
(10, 20645),
(10, 10268),
(10, 13321),
(10, 17258),
(10, 17846),
(10, 20553);

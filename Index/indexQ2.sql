
-- ALTER TABLE Ballot
-- DROP CONSTRAINT FK__Ballot__Election__4D94879B;

-- ALTER TABLE ElectionEvent
-- DROP CONSTRAINT PK__Election__BCAF7DFEA59077C5;

-- ALTER TABLE dbo.ElectionEvent
-- ADD CONSTRAINT PK_ElectionEventID
-- PRIMARY KEY NONCLUSTERED (ElectionEventID);

-- ALTER TABLE Ballot
-- ADD CONSTRAINT FK__Ballot__Election__4D94879B
-- FOREIGN KEY (ElectionEventID) REFERENCES dbo.ElectionEvent (ElectionEventID);

CREATE UNIQUE index electioeventIDINDEX
ON ElectionEvent (ElectionEventID);

CREATE CLUSTERED  INDEX EventDivisionNameINDEX
ON ElectionEvent (DivisionName);

CREATE NONCLUSTERED INDEX PolPartyINDEX
ON Candidate (PartyCode);

CREATE UNIQUE CLUSTERED INDEX CandidateIDIndex
ON Candidate (CandidateID)
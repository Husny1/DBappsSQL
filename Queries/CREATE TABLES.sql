CREATE TABLE ElectionMaster (
    ElectionSerialNo INT, 
    ElectionDate DATETIME,
    Type VARCHAR(50),
    TotalNumDivisions INT,
    TotalRegVoters INT,
    LastDateToVoterRegister DATE,
    LastDateCandidateNominate DATE,
    LastDateToDeclareResult DATE
    PRIMARY KEY (ElectionSerialNo)
);

CREATE TABLE ElectoralDivision (
    DivisionName VARCHAR(150),
    TotalRegVoters INT,
    CurrMember VARCHAR(100)
    PRIMARY KEY (DivisionName)
);

CREATE TABLE ElectoralDivisionHistory (
    DivisionName VARCHAR(150),
    ElectionSerialNo INT,
    HistoricRegVoters INT
    PRIMARY KEY (DivisionName, ElectionSerialNo)
);

CREATE TABLE ElectionEvent (
    ElectionEventID INT,
    TotalVoters INT,
    VotesCast INT,
    VotesReject INT,
    VotesValid INT,
    ElectionSerialNo INT,
    DivisionName VARCHAR(150),
    TwoCandidatePrefWinnerCandidateID INT,
    WinnerTally INT,
    TwoCandidatePrefLoserCandidateID INT,
    LoserTally INT
    PRIMARY KEY (ElectionEventID)
    FOREIGN KEY (ElectionSerialNo) REFERENCES ElectionMaster(ElectionSerialNo),
    FOREIGN KEY (DivisionName) REFERENCES ElectoralDivision(DivisionName)
);

CREATE TABLE Contests (
    ElectionEventID INT,
    CandidateID INT
    PRIMARY KEY (ElectionEventID, CandidateID)
);

CREATE TABLE PoliticalParty (
    PartyCode VARCHAR(20),
    PartyName VARCHAR(100),
    PostalAddress VARCHAR(255),
    PartySecretary VARCHAR(100),
    ContactPersonName VARCHAR(100),
    ContactPersonPhone VARCHAR(20),
    ContactPersonMobile VARCHAR(20),
    ContactPersonEmail VARCHAR(100)
    PRIMARY KEY (PartyCode)
);

CREATE TABLE Candidate (
    CandidateID INT IDENTITY(1,1),
    CandidateName VARCHAR(100),
    ContactAddress VARCHAR(255),
    ContactPhone VARCHAR(20),
    ContactMobile VARCHAR(20),
    ContactEmail VARCHAR(100),
    PartyCode VARCHAR(20),
    PRIMARY KEY (CandidateID),
    FOREIGN KEY (PartyCode) REFERENCES PoliticalParty (PartyCode)
    );

CREATE TABLE VoterRegistry (
    VoterID INT IDENTITY(1,1),
    FirstName VARCHAR(100),
    MiddleNames VARCHAR(100),
    LastName VARCHAR(100),
    Address VARCHAR(255),
    DoB DATE,
    Gender CHAR(1),
    ResidentialAddress VARCHAR(255),
    PostalAddress VARCHAR(255),
    ContactPhone VARCHAR(20),
    ContactMobile VARCHAR(20),
    ContactEmail VARCHAR(100),
    DivisionName VARCHAR(150)
    PRIMARY KEY (VoterID),
    FOREIGN KEY (DivisionName) REFERENCES ElectoralDivision(DivisionName)
);

CREATE TABLE Ballot (
    BallotID INT,
    ElectionEventID INT
    PRIMARY KEY (BallotID)
    FOREIGN KEY (ElectionEventID) REFERENCES ElectionEvent (ElectionEventID)
);

CREATE TABLE BallotPreferences (
    BallotID INT,
    CandidateID INT,
    Preference INT
    PRIMARY KEY (BallotID,CandidateID)
);

CREATE TABLE IssuanceRecord (
    VoterID INT,
    ElectionEventID INT,
    IssueDate DATE,
    Timestamp DATETIME,
    PollingStation VARCHAR(100)
    PRIMARY KEY (VoterID, ElectionEventID)
);

CREATE TABLE PrefCountRecord (
    ElectionEventID INT,
    RoundNo INT,
    EliminatedCandidateID INT,
    CountStatus VARCHAR(50),
    PreferenceAggregate INT
    PRIMARY KEY (ElectionEventID, RoundNo)
    FOREIGN KEY (EliminatedCandidateID) REFERENCES Candidate(CandidateID)
);

CREATE TABLE PreferenceTallyPerRoundPerCandidate (
    ElectionEventID INT,
    RoundNo INT,
    CandidateID INT,
    PreferenceTally INT
    PRIMARY KEY (ElectionEventID,RoundNo,CandidateID)
);

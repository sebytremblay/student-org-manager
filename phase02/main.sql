CREATE DATABASE IF NOT EXISTS StudentOrgManager;

USE StudentOrgManager;

CREATE TABLE IF NOT EXISTS Users
(
    userID         INT PRIMARY KEY,
    NUID           CHAR(9),
    graduationYear YEAR,
    startDate      DATE,
    currentYear    INT,
    firstName      VARCHAR(50),
    lastName       VARCHAR(50),
    goalsWants     TEXT,
    challenges     TEXT
);

-- Stores information about a user's email accounts
CREATE TABLE IF NOT EXISTS EmailInfos
(
    userID INT,
    email  VARCHAR(30),
    PRIMARY KEY (userID, email),
    FOREIGN KEY (userID)
        REFERENCES Users (userID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Stores information about a user's social media accounts
CREATE TABLE IF NOT EXISTS SocialsInfos
(
    userID   INT,
    platform VARCHAR(20),
    username VARCHAR(30),
    PRIMARY KEY (userID, platform, username),
    FOREIGN KEY (userID)
        REFERENCES Users (userID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Alumni
(
    userID     INT PRIMARY KEY,
    location   VARCHAR(100),
    currentJob VARCHAR(100),
    alumniID   INT,
    FOREIGN KEY (UserID) REFERENCES Users (userID)
);

CREATE TABLE IF NOT EXISTS StudentOrgs
(
    orgID         INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(30),
    establishedAt DATETIME,
    orgType       VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS Dues
(
    userID  INT,
    orgID   INT,
    amount  DECIMAL(10, 2),
    dueDate DATE,
    FOREIGN KEY (userID) REFERENCES Users (userID),
    FOREIGN KEY (orgID) REFERENCES StudentOrgs (orgID)
);

CREATE TABLE IF NOT EXISTS Events
(
    eventID     INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    startTime   TIMESTAMP    NOT NULL,
    endTime     TIMESTAMP    NOT NULL,
    location    TEXT,
    isMandatory boolean DEFAULT FALSE
);

-- Bridge table between Event and User storing information about which users are attending which events
CREATE TABLE IF NOT EXISTS EventUsers
(
    eventID INT,
    userID  INT,
    PRIMARY KEY (eventID, userID),
    FOREIGN KEY (eventID) REFERENCES Events (eventID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (userID) REFERENCES Users (userID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Stores information about roles/positions a user has held in a student organization
CREATE TABLE IF NOT EXISTS Roles
(
    userID       INT,
    orgID        INT,
    positionName VARCHAR(30),
    year         INT,
    semester     VARCHAR(10),
    PRIMARY KEY (userID, orgID, positionName, year, semester),
    FOREIGN KEY (userID)
        REFERENCES Users (userID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (orgID)
        REFERENCES StudentOrgs (orgID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Drills
(
    drillID          int NOT NULL AUTO_INCREMENT,
    name             varchar(100),
    drillDescription TEXT,
    PRIMARY KEY (drillID)
);

-- Stores information about each practice event
CREATE TABLE IF NOT EXISTS Practices
(
    eventID      int,
    practiceID   int NOT NULL,
    injuriesDesc TEXT,
    CONSTRAINT fk_practice
        PRIMARY KEY (eventID, practiceID),
    FOREIGN KEY (eventID)
        REFERENCES Events (eventID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Bridge table between practices and drills storing information about which drills were used in which practices
-- Used to create practice plan for each practice
CREATE TABLE IF NOT EXISTS DrillInstances
(
    eventID    int,
    practiceID int,
    drillID    int,
    PRIMARY KEY (eventID, practiceID, drillID),
    CONSTRAINT fk_practice
        FOREIGN KEY (practiceID, eventID)
            REFERENCES Practices (practiceID, eventID)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    FOREIGN KEY (drillID)
        REFERENCES Drills (drillID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Games
(
    gameID              INT NOT NULL AUTO_INCREMENT,
    eventID             INT,
    opponentTeamName    TEXT,
    nuScore             INT,
    opponentScore       INT,
    injuriesDescription TEXT,
    PRIMARY KEY (gameID, eventID),
    FOREIGN KEY (eventID) REFERENCES Events (eventID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Workshops
(
    workshopID INT,
    eventID          INT,
    speakerEmail     TEXT,
    speakerFirstName TEXT,
    speakerLastName  TEXT,
    topic            TEXT,
    collabOrgId      INT,
    PRIMARY KEY (workshopID, eventID),
    FOREIGN KEY (eventID) REFERENCES Events (eventID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (collabOrgId) REFERENCES StudentOrgs (orgID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Meetings
(
    eventID          INT,
    meetingID   INT AUTO_INCREMENT,
    agenda      TEXT NOT NULL,
    minutes     TEXT NOT NULL,
    PRIMARY KEY (eventID, meetingID),
    FOREIGN KEY (eventID) REFERENCES Events (eventID) ON UPDATE CASCADE ON DELETE CASCADE,
);

CREATE TABLE IF NOT EXISTS CommunityServices
(
    eventID          INT,
    serviceID          INT AUTO_INCREMENT,
    hours              INT  NOT NULL,
    serviceDescription TEXT NOT NULL,
    PRIMARY KEY (eventID, serviceID),
    FOREIGN KEY (eventID) REFERENCES Events (eventID) ON UPDATE CASCADE ON DELETE CASCADE,
);

CREATE TABLE IF NOT EXISTS Philanthropies
(
    eventID          INT,
    philanthropyID INT AUTO_INCREMENT,
    cause          VARCHAR(255)   NOT NULL,
    amountRaised   DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (eventID, philanthropyID),
    FOREIGN KEY (eventID) REFERENCES Events (eventID) ON UPDATE CASCADE ON DELETE CASCADE,
);

CREATE TABLE IF NOT EXISTS Rituals
(
    eventID          INT,
    ritualID          INT AUTO_INCREMENT,
    ritualName        VARCHAR(255) NOT NULL,
    ritualDescription TEXT         NOT NULL,
    PRIMARY KEY (eventID, ritualID),
    FOREIGN KEY (eventID) REFERENCES Events (eventID) ON UPDATE CASCADE ON DELETE CASCADE,
);
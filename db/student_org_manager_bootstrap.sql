-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
CREATE DATABASE StudentOrgManager;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
GRANT ALL PRIVILEGES ON StudentOrgManager.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

-- Move into the database we just created.
USE StudentOrgManager;

-- ================================================================
--
-- TABLE DEFINITIONS
-- 
-- ================================================================

-- Stores information about a user
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

-- Stores information about an alumni
CREATE TABLE IF NOT EXISTS Alumni
(
    userID     INT PRIMARY KEY,
    location   VARCHAR(100),
    currentJob VARCHAR(100),
    alumniID   INT,
    FOREIGN KEY (UserID)
        REFERENCES Users (userID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Stores information about a student organization
CREATE TABLE IF NOT EXISTS StudentOrgs
(
    orgID         INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(30),
    establishedAt DATETIME,
    orgType       VARCHAR(30)
);

-- Stores information about dues owed to a student organization
CREATE TABLE IF NOT EXISTS Dues
(
    userID  INT,
    orgID   INT,
    dueID   INT,
    amount  DECIMAL(10, 2),
    beenPaid BOOLEAN DEFAULT FALSE,
    dueDate DATE,
    PRIMARY KEY (userID, orgID, dueID),
    FOREIGN KEY (userID)
        REFERENCES Users (userID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (orgID)
        REFERENCES StudentOrgs (orgID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Stores the baseline information stored across all types of events
CREATE TABLE IF NOT EXISTS Events
(
    eventID     INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    orgID       INT          NOT NULL,
    name        VARCHAR(100) NOT NULL,
    startTime   TIMESTAMP    NOT NULL,
    endTime     TIMESTAMP    NOT NULL,
    location    TEXT,
    isMandatory boolean DEFAULT FALSE,
    FOREIGN KEY (orgID)
        REFERENCES StudentOrgs (orgID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Bridge table between Event and User storing information about which users are attending which events
CREATE TABLE IF NOT EXISTS EventUsers
(
    eventID INT,
    userID  INT,
    PRIMARY KEY (eventID, userID),
    FOREIGN KEY (eventID)
        REFERENCES Events (eventID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (userID)
        REFERENCES Users (userID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Stores information about roles/positions a user has held in a student organization
CREATE TABLE IF NOT EXISTS Roles
(
    userID       INT,
    orgID        INT,
    positionName VARCHAR(30),
    school_year  INT,
    semester     VARCHAR(10),
    PRIMARY KEY (userID, orgID, positionName, school_year, semester),
    FOREIGN KEY (userID)
        REFERENCES Users (userID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (orgID)
        REFERENCES StudentOrgs (orgID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Stores information about each drill
CREATE TABLE IF NOT EXISTS Drills
(
    drillID          int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name             varchar(100),
    drillDescription TEXT
);

-- Stores information about each practice event
CREATE TABLE IF NOT EXISTS Practices
(
    eventID      int,
    practiceID   int,
    injuriesDesc TEXT,
    PRIMARY KEY (eventID, practiceID),
    FOREIGN KEY (eventID)
        REFERENCES Events (eventID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Bridge table between practices and drills storing information about which drills were used in which practices. Used to create practice plan for each practice
CREATE TABLE IF NOT EXISTS DrillInstances
(
    eventID    int,
    practiceID int,
    drillID    int,
    PRIMARY KEY (eventID, practiceID, drillID),
    FOREIGN KEY (eventID, practiceID)
        REFERENCES Practices (eventID, practiceID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (drillID)
        REFERENCES Drills (drillID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Stores information about each game
CREATE TABLE IF NOT EXISTS Games
(
    gameID              INT,
    eventID             INT,
    opponentTeamName    TEXT,
    nuScore             INT,
    opponentScore       INT,
    injuriesDescription TEXT,
    PRIMARY KEY (gameID, eventID),
    FOREIGN KEY (eventID)
        REFERENCES Events (eventID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Stores information about workshops
CREATE TABLE IF NOT EXISTS Workshops
(
    workshopID       INT,
    eventID          INT,
    speakerEmail     TEXT,
    speakerFirstName TEXT,
    speakerLastName  TEXT,
    topic            TEXT,
    collabOrgId      INT,
    PRIMARY KEY (workshopID, eventID),
    FOREIGN KEY (eventID)
        REFERENCES Events (eventID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (collabOrgId)
        REFERENCES StudentOrgs (orgID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Stores information about meetings
CREATE TABLE IF NOT EXISTS Meetings
(
    eventID   INT,
    meetingID INT,
    agenda    TEXT NOT NULL,
    duration   TEXT NOT NULL,
    PRIMARY KEY (eventID, meetingID),
    FOREIGN KEY (eventID)
        REFERENCES Events (eventID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Stores information about community service events
CREATE TABLE IF NOT EXISTS CommunityServices
(
    eventID            INT,
    serviceID          INT,
    hours              INT  NOT NULL,
    serviceDescription TEXT NOT NULL,
    PRIMARY KEY (eventID, serviceID),
    FOREIGN KEY (eventID)
        REFERENCES Events (eventID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Stores information about philanthropic events
CREATE TABLE IF NOT EXISTS Philanthropies
(
    eventID        INT,
    philanthropyID INT,
    cause          VARCHAR(255)   NOT NULL,
    amountRaised   DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (eventID, philanthropyID),
    FOREIGN KEY (eventID)
        REFERENCES Events (eventID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Stores information about ritual events
CREATE TABLE IF NOT EXISTS Rituals
(
    eventID           INT          NOT NULL UNIQUE,
    ritualID          INT AUTO_INCREMENT PRIMARY KEY,
    ritualName        VARCHAR(255) NOT NULL,
    ritualDescription TEXT         NOT NULL,
    FOREIGN KEY (eventID)
        REFERENCES Events (eventID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ================================================================
--
-- SAMPLEM DATA INSERTION
--
-- ================================================================

-- Inserting sample users
INSERT INTO Users (userID, NUID, graduationYear, startDate, currentYear, firstName, lastName, goalsWants, challenges) VALUES
(1, '002171805', 2023, '2021-08-23', 3, 'Alice', 'Smith', 'To become a software engineer at a major tech company', 'Struggling with time management'),
(2, '001234578', 2024, '2021-08-23', 3, 'Bob', 'Jones', 'To gain leadership skills and network with professionals', 'Finding the right opportunities'),
(3, '001234589', 2023, '2021-08-23', 3, 'Carol', 'Wilson', 'To improve public speaking skills', 'Overcoming public speaking anxiety');

-- Inserting sample student organizations
INSERT INTO StudentOrgs (name, establishedAt, orgType)
VALUES ('Soccer', '2010-09-01 00:00:00', 'Club Sports'),
       ('Roller Hockey', '2012-05-15 00:00:00', 'Club Sports'),
       ('Delta Tau Delta', '2011-08-20 00:00:00', 'Greek Life'),
       ('Delta Zeta', '2013-03-05 00:00:00', 'Greek Life');

-- Inserting sample email info
INSERT INTO EmailInfos (userID, email) VALUES
(1, 'alice.smith@email.com'),
(2, 'bob.jones@email.com'),
(3, 'carol.wilson@email.com');

-- Inserting sample socials info
INSERT INTO SocialsInfos (userID, platform, username) VALUES
(1, 'Twitter', 'AliceS'),
(2, 'LinkedIn', 'BobJ'),
(3, 'Instagram', 'CarolW');

-- Inserting sample alumni
INSERT INTO Alumni (userID, location, currentJob, alumniID) VALUES
(1, 'New York, NY', 'Software Engineer', 101),
(2, 'Boston, MA', 'Data Analyst', 102);

-- Inserting sample dues
INSERT INTO Dues (userID, orgID, dueID, amount, dueDate) VALUES
(1, 1, 1, 50.00, '2023-09-01'),
(2, 2, 2, 75.00, '2023-09-01'),
(3, 3, 3, 20.00, '2023-09-01');

-- Inserting sample roles
INSERT INTO Roles (userID, orgID, positionName, school_year, semester) VALUES
(1, 1, 'President', 2023, 'Spring'),
(2, 2, 'Vice President', 2023, 'Fall'),
(3, 3, 'Secretary', 2021, 'Fall');

-- Inserting sample drills for practices
INSERT INTO Drills (drillID, name, drillDescription)
VALUES (1, 'Butterfly',
        'half of team lines up in each corner one by one skating around the offensive zone circle and receiving a pass then taking a shot'),
       (2, 'Breakout',
        'one player behind net, two wings swing low while last player swings way high behind the other teams net'),
       (3, 'PowerPlay/PenaltyKill',
        'four offensive players, three defensive players. work a diamond and rotate into a box for PP, work a triangle for PK'),
       (4, 'Scrimmage', 'four versus four');

-- Inserting practice events for Soccer and Roller Hockey
INSERT INTO Events (eventID, orgID, name, startTime, endTime, location, isMandatory)
VALUES 
(1, 1, 'Soccer Practice 1', '2024-04-05 15:00:00', '2024-04-05 17:00:00', 'Campus Field', FALSE),
(2, 2, 'Roller Hockey Practice 1', '2024-04-06 18:00:00', '2024-04-06 20:00:00', 'Campus Rink', TRUE);
INSERT INTO Practices (eventID, practiceID, injuriesDesc)
VALUES 
(1, 1, 'Minor ankle sprain during drill.'),
(2, 2, 'None reported.');

-- Inserting samples instances of drills during a specific practice
INSERT INTO DrillInstances (eventID, practiceID, drillID)
VALUES (1, 1, 1),
       (1, 1, 2),
       (1, 1, 3),
       (1, 1, 4),
       (2, 2, 1),
       (2, 2, 2),
       (2, 2, 3),
       (2, 2, 4);

-- Inserting game events for Soccer and Roller Hockey
INSERT INTO Events (eventID, orgID, name, startTime, endTime, location, isMandatory)
VALUES 
(3, 1, 'Soccer Game vs University A', '2024-05-10 15:00:00', '2024-05-10 17:00:00', 'University A Field', TRUE),
(4, 2, 'Roller Hockey Game vs College B', '2024-05-11 18:00:00', '2024-05-11 20:00:00', 'College B Rink', TRUE);
INSERT INTO Games (gameID, eventID, opponentTeamName, injuriesDescription)
VALUES 
(1, 3, 'University A', 'None reported.'),
(2, 4, 'College B', 'One player had a mild concussion.');

-- Inserting workshop events for Delta Tau Delta and Delta Zeta
INSERT INTO Events (eventID, orgID, name, startTime, endTime, location, isMandatory)
VALUES 
(5, 3, 'Leadership Workshop', '2024-06-15 09:00:00', '2024-06-15 12:00:00', 'Chapter House', FALSE),
(6, 4, 'Career Development Workshop', '2024-06-16 13:00:00', '2024-06-16 15:00:00', 'Community Center', FALSE);
INSERT INTO Workshops (workshopID, eventID, speakerEmail, speakerFirstName, speakerLastName, topic, collabOrgId)
VALUES 
(1, 5, 'speaker1@example.com', 'John', 'Doe', 'Effective Leadership Skills', NULL),
(2, 6, 'speaker2@example.com', 'Jane', 'Doe', 'Resume Building and Networking', NULL);

-- Inserting meeting events for Delta Tau Delta and Delta Zeta
INSERT INTO Events (eventID, orgID, name, startTime, endTime, location, isMandatory)
VALUES 
(7, 3, 'Chapter Meeting', '2024-07-20 18:00:00', '2024-07-20 19:30:00', 'Chapter House', TRUE),
(8, 4, 'General Assembly', '2024-07-21 18:00:00', '2024-07-21 19:30:00', 'Chapter House', TRUE);
INSERT INTO Meetings (eventID, meetingID, agenda, duration)
VALUES 
(7, 1, 'Discuss upcoming philanthropy event, budget review, and member achievements', '1h 30m'),
(8, 2, 'Election of new officers, upcoming events planning, and chapter goals discussion', '1h 30m');

-- Inserting community service events for Delta Tau Delta and Delta Zeta
INSERT INTO Events (eventID, orgID, name, startTime, endTime, location, isMandatory)
VALUES 
(9, 3, 'Beach Cleanup Initiative', '2022-08-25 08:00:00', '2022-08-25 12:00:00', 'Local Beach', FALSE),
(10, 4, 'Park Renovation Project', '2022-08-26 09:00:00', '2022-08-26 13:00:00', 'City Park', FALSE);
INSERT INTO CommunityServices (eventID, serviceID, hours, serviceDescription)
VALUES
(9, 1, 4, 'Beach cleanup to remove trash and promote environmental awareness'),
(10, 2, 4, 'Participate in park renovation efforts, including planting trees and painting.');

-- Inserting philanthropy events for Delta Tau Delta and Delta Zeta
INSERT INTO Events (eventID, orgID, name, startTime, endTime, location, isMandatory)
VALUES 
(11, 3, 'Annual Fundraiser Gala', '2021-09-30 19:00:00', '2021-09-30 23:00:00', 'Grand Hotel Ballroom', TRUE),
(12, 4, 'Charity Run for Education', '2022-10-01 07:00:00', '2022-10-01 11:00:00', 'Community Park', TRUE);
INSERT INTO Philanthropies (eventID, philanthropyID, cause, amountRaised)
VALUES 
(11, 1, 'Scholarship Fund for Underprivileged Students', 5000.00),
(12, 2, 'Supporting Local Schools with Supplies and Technology', 3000.00);

-- Inserting ritual events for Delta Tau Delta and Delta Zeta
INSERT INTO Events (eventID, orgID, name, startTime, endTime, location, isMandatory)
VALUES 
(13, 3, 'Initiation Ceremony', '2024-11-05 18:00:00', '2024-11-05 20:00:00', 'Chapter House', TRUE),
(14, 4, 'Founders Day Celebration', '2024-11-06 18:00:00', '2024-11-06 20:00:00', 'Chapter House', TRUE);
INSERT INTO Rituals (eventID, ritualName, ritualDescription)
VALUES 
(13, 'Initiation Ceremony', 'Formal initiation of new members into the fraternity, including oath-taking and welcome speech.'),
(14, 'Founders Day', 'Celebration of the founding of the sorority with speeches, awards, and alumni involvement.');

-- Inserting sample event users
INSERT INTO EventUsers (eventID, userID) VALUES
(1, 1),
(2, 2),
(3, 3);

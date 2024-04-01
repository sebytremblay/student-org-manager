-- ==================================
--
-- TABLE DEFINITIONS
--
-- ==================================

-- Stores information about a student organization
CREATE TABLE IF NOT EXISTS StudentOrg
(
    orgID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    establishedAt DATETIME,
    orgType VARCHAR(30)
);

-- Stores information about roles/positions a user has held in a student organization
CREATE TABLE IF NOT EXISTS Roles
(
    userID INT,
    orgID INT,
    positionName VARCHAR(30),
    year INT,
    semester VARCHAR(10),
    PRIMARY KEY(userID, orgID, positionName, year, semester),
    FOREIGN KEY(userID)
        REFERENCES Users(ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY(orgID)
        REFERENCES StudentOrg(orgID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Stores information about a user's email accounts
CREATE TABLE IF NOT EXISTS EmailInfo
(
    userID INT,
    email VARCHAR(30),
    PRIMARY KEY (userID, email),
    FOREIGN KEY(userID)
        REFERENCES Users(ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Stores information about a user's social media accounts
CREATE TABLE IF NOT EXISTS SocialsInfo
(
    userID INT,
    platform VARCHAR(20),
    username VARCHAR(30),
    PRIMARY KEY (userID, platform, username),
    FOREIGN KEY(userID)
        REFERENCES Users(ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ==================================
--
-- SAMPLE DATA
--
-- ==================================
INSERT INTO StudentOrg (name, establishedAt, orgType) VALUES
('Soccer', '2010-09-01 00:00:00', 'Club Sports'),
('Roller Hockey', '2012-05-15 00:00:00', 'Club Sports'),
('Delta Tau Delta', '2011-08-20 00:00:00', 'Greek Life'),
('Delta Zeta', '2013-03-05 00:00:00', 'Greek Life');

INSERT INTO Roles (userID, orgID, positionName, year, semester) VALUES
(1, 1, 'President', 2022, 'Fall'),
(2, 2, 'Vice President', 2023, 'Spring'),
(3, 3, 'Treasurer', 2022, 'Fall'),
(4, 4, 'Secretary', 2023, 'Spring');

INSERT INTO EmailInfo (userID, email) VALUES
(1, 'user1@example.com'),
(2, 'user2@example.com'),
(3, 'user3@example.com'),
(4, 'user4@example.com');

INSERT INTO SocialsInfo (userID, platform, username) VALUES
(1, 'Twitter', 'user1_tw'),
(2, 'Instagram', 'user2_ig'),
(3, 'Facebook', 'user3_fb'),
(4, 'LinkedIn', 'user4_ln');

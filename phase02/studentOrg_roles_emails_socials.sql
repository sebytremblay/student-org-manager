-- Stores information about a student organization
CREATE TABLE IF NOT EXISTS StudentOrg
(
    orgID INT PRIMARY KEY,
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
    PRIMARY KEY(userID, orgID),
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

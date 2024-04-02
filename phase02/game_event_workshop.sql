-- ==================================
--
-- TABLE DEFINITIONS
--
-- ==================================

CREATE TABLE IF NOT EXISTS Event
(
    eventID     INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    startTime   TIMESTAMP    NOT NULL,
    endTime     TIMESTAMP    NOT NULL,
    location    TEXT,
    isMandatory boolean DEFAULT FALSE
);

-- Bridge table between Event and User storing information about which users are attending which events
CREATE TABLE IF NOT EXISTS EventUser
(
    eventID INT,
    userID  INT,
    PRIMARY KEY (eventID, userID),
    FOREIGN KEY (eventID) REFERENCES Event (eventID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (userID) REFERENCES User (userID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Game
(
    gameID              INT NOT NULL AUTO_INCREMENT,
    eventID             INT,
    opponentTeamName    TEXT,
    nuScore             INT,
    opponentScore       INT,
    injuriesDescription TEXT,
    PRIMARY KEY (gameID, eventID),
    FOREIGN KEY (eventID) REFERENCES Event (eventID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Workshop
(
    eventID          INT,
    speakerEmail     TEXT,
    speakerFirstName TEXT,
    speakerLastName  TEXT,
    topic            TEXT,
    collabOrgId      INT,
    FOREIGN KEY (eventID) REFERENCES Event (eventID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (collabOrgId) REFERENCES StudentOrg (orgID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- ==================================
--
-- SAMPLE DATA
--
-- ==============================

INSERT INTO Event VALUES
    (
        'Workshop on the Importance of Sleep',
        '2021-03-01 12:00:00',
        '2021-03-01 13:00:00',
        'Zoom',
        FALSE
    ),
    (
        'Game vs. Rival School',
        '2021-03-02 19:00:00',
        '2021-03-02 21:00:00',
        'Matthews Arena',
        TRUE
    )
;

INSERT INTO EventUser VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (2, 3)
;

INSERT INTO Game VALUES
    (
        2,
        'Boston University',
        3,
        2,
        'none'
    )
;

INSERT INTO Workshop VALUES
    (
        1,
        'john@doe.com',
        'John',
        'Doe',
        'The Importance of Sleep',
        3
    )
;
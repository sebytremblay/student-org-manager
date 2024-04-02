-- ==================================
--
-- TABLE DEFINITIONS
--
-- ==================================

-- Stores information about drills to be used in practice events
CREATE TABLE Drill (
    drillID int NOT NULL AUTO_INCREMENT,
    name varchar(100),
    drillDescription varchar(250),
    PRIMARY KEY(drillID)
);

-- Stores information about each practice event
CREATE TABLE Practice (
    eventID int,
    practiceID int NOT NULL AUTO_INCREMENT,
    team varchar(20) NOT NULL,
    injuriesDesc varchar(250),
    PRIMARY KEY(eventID, practiceID),
    FOREIGN KEY (eventID)
        REFERENCES Event (eventID)
);

-- Bridge table between practices and drills storing information about which drills were used in which practices
-- Used to create practice plan for each practice
CREATE TABLE DrillInstance (
    practiceID int NOT NULL,
    drillID int NOT NULL,
    PRIMARY KEY(practiceID, drillID),
    FOREIGN KEY (practiceID)
        REFERENCES Practice (practiceID),
    FOREIGN KEY (drillID)
        REFERENCES Drill (drillID)
);

-- ==================================
--
-- SAMPLE DATA
--
-- ==================================

INSERT INTO Drill (drillID, name, description) VALUES  
(1, "Butterfly", "half of team lines up in each corner one by one" + "skating around the offensive zone circle and" + "recieveing a pass then taking a shot"),
(2, "Breakout", "one player behind net, two wings swing low while last player" + "swings way high behind the other teams net"),
(3, "PowerPlay/PenaltyKill", "four offensive players, three defensive players." + " work a diamond and rotate into a box for PP," + "work a triangle for PK"),
(4, "Scrimmage", "four versus four");

INSERT INTO practice (eventID, practiceID, team, injuriesDesc) VALUES
(?, 1, "All", "none"),
(?, 2, "D2", "none"),
(?, 3, "D4", "puck to chest, knocked wind out of player");

INSERT INTO DrillInstance (practiceID, drillID) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(2, 3),
(2, 4),
(3, 4);

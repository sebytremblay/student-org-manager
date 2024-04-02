USE StudentOrgManager;

INSERT INTO StudentOrgs (name, establishedAt, orgType)
VALUES ('Soccer', '2010-09-01 00:00:00', 'Club Sports'),
       ('Roller Hockey', '2012-05-15 00:00:00', 'Club Sports'),
       ('Delta Tau Delta', '2011-08-20 00:00:00', 'Greek Life'),
       ('Delta Zeta', '2013-03-05 00:00:00', 'Greek Life');

-- Inserting sample data into 'User'
INSERT INTO Users (UserID, NUID, GraduationYear, StartDate, CurrentYear, FirstName, LastName, GoalsWants, Challenges)
VALUES (1, 'N12345678', 2024, '2021-09-01', 3, 'John', 'Doe', 'Enhance business acumen', 'Time management'),
       (2, 'N87654321', 2025, '2022-09-01', 2, 'Jane', 'Smith', 'Develop leadership skills', 'Networking'),
       (3, 'N11223344', 2023, '2020-09-01', 4, 'Alice', 'Brown', 'Learn about start-ups', 'Finding the right mentors');

-- Inserting sample data into 'Dues'
INSERT INTO Dues (UserID, orgID, Amount, DueDate)
VALUES (1, 1, 50.00, '2024-10-01'),
       (2, 2, 75.00, '2025-11-01'),
       (3, 3, 20.00, '2023-12-01');

-- Inserting sample data into 'Alumni'
INSERT INTO Alumni (UserID, Location, CurrentJob, AlumniID)
VALUES (1, 'Boston', 'Analyst', 1001),
       (2, 'Cambridge', 'Consultant', 1002),
       (3, 'Somerville', 'Entrepreneur', 1003);

INSERT INTO Roles (userID, orgID, positionName, year, semester)
VALUES (1, 1, 'President', 2022, 'Fall'),
       (2, 2, 'Vice President', 2023, 'Spring'),
       (3, 3, 'Treasurer', 2022, 'Fall');

INSERT INTO EmailInfos (userID, email)
VALUES (1, 'user1@example.com'),
       (2, 'user2@example.com'),
       (3, 'user3@example.com');

INSERT INTO SocialsInfos (userID, platform, username)
VALUES (1, 'Twitter', 'user1_tw'),
       (2, 'Instagram', 'user2_ig'),
       (3, 'Facebook', 'user3_fb');


INSERT INTO Events (name, startTime, endTime, location, isMandatory)
VALUES ('Workshop on the Importance of Sleep',
        '2021-03-01 12:00:00',
        '2021-03-01 13:00:00',
        'Zoom',
        FALSE),
       ('Game vs. Rival School',
        '2021-03-02 19:00:00',
        '2021-03-02 21:00:00',
        'Matthews Arena',
        TRUE)
;

INSERT INTO EventUsers
VALUES (1, 1),
       (1, 2),
       (2, 1),
       (2, 3)
;

INSERT INTO Games (eventID, opponentTeamName, nuScore, opponentScore, injuriesDescription)
VALUES (2,
        'Boston University',
        3,
        2,
        'none')
;

INSERT INTO Workshops
VALUES (1,
        'john@doe.com',
        'John',
        'Doe',
        'The Importance of Sleep',
        3)
;

INSERT INTO Meetings (Agenda, Minutes, MeetingDate, StartTime, EndTime)
VALUES ('Planning for the upcoming charity event', 'Assigned roles and tasks', '2024-04-10', '18:00:00', '19:30:00'),
       ('Monthly budget review', 'Approved the budget for next month', '2024-04-17', '18:00:00', '19:00:00'),
       ('New member induction', 'Welcomed new members and outlined fraternity values', '2024-05-01', '18:00:00',
        '20:00:00'),
       ('Community service planning', 'Organized a community cleanup event', '2024-05-15', '18:00:00', '19:00:00');

-- Community Services
INSERT INTO CommunityServices (Hours, ServiceDescription, ServiceDate)
VALUES (4, 'Local park cleanup', '2024-03-20'),
       (3, 'Food drive organization', '2024-03-27'),
       (5, 'Volunteering at a local shelter', '2024-04-03'),
       (4, 'Beach cleanup initiative', '2024-04-17');

-- Philanthropies
INSERT INTO Philanthropies (Cause, AmountRaised, EventDate)
VALUES ('Education for Underprivileged Children', 5000.00, '2024-02-25'),
       ('Cancer Research Fundraiser', 7500.00, '2024-03-15'),
       ('Local Homeless Shelter Support', 3200.00, '2024-04-05'),
       ('Environmental Conservation', 4500.00, '2024-04-22');

-- Rituals
INSERT INTO Rituals (RitualName, RitualDescription, RitualDate)
VALUES ('Induction Ceremony', 'Formal ceremony to welcome new members.', '2024-05-01'),
       ('Yearly Commemoration', 'Anniversary of the fraternity’s founding.', '2024-05-08'),
       ('Senior Farewell Ritual', 'Ceremony to bid farewell to graduating members.', '2024-06-15'),
       ('Alumni Homecoming Ritual', 'Event for alumni members to reconnect with the fraternity.', '2024-07-20');

INSERT INTO Drills (drillID, name, drillDescription)
VALUES (1, 'Butterfly',
        'half of team lines up in each corner one by one skating around the offensive zone circle and receiving a pass then taking a shot'),
       (2, 'Breakout',
        'one player behind net, two wings swing low while last player swings way high behind the other teams net'),
       (3, 'PowerPlay/PenaltyKill',
        'four offensive players, three defensive players. work a diamond and rotate into a box for PP, work a triangle for PK'),
       (4, 'Scrimmage', 'four versus four');

INSERT INTO Events (name, startTime, endTime, location, isMandatory)
VALUES ('Practice 1',
        '2021-03-01 12:00:00',
        '2021-03-01 13:00:00',
        'Matthews',
        FALSE),
       ('Practice 2',
        '2021-03-02 19:00:00',
        '2021-03-02 21:00:00',
        'Matthews',
        TRUE);

INSERT INTO Practices (eventID, practiceID, injuriesDesc)
VALUES (3, 1, 'none'),
       (4, 2, 'puck to chest, knocked wind out of player');

INSERT INTO DrillInstances (practiceID, drillID)
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (1, 4),
       (2, 1),
       (2, 3),
       (2, 4),
       (3, 4);

USE StudentOrgManager;

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
(1, 1, 'President', 2023, 'Fall'),
(2, 2, 'Vice President', 2023, 'Fall'),
(3, 3, 'Secretary', 2023, 'Fall');

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
(2, 2, 'Roller Hockey Practice 1', '2024-04-06 18:00:00', '2024-04-06 20:00:00', 'Campus Rink', FALSE);
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
INSERT INTO Games (gameID, eventID, opponentTeamName, nuScore, opponentScore, injuriesDescription)
VALUES 
(1, 3, 'University A', 3, 2, 'None reported.'),
(2, 4, 'College B', 5, 3, 'One player had a mild concussion.');

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
(9, 3, 'Beach Cleanup Initiative', '2024-08-25 08:00:00', '2024-08-25 12:00:00', 'Local Beach', FALSE),
(10, 4, 'Park Renovation Project', '2024-08-26 09:00:00', '2024-08-26 13:00:00', 'City Park', FALSE);
INSERT INTO CommunityServices (eventID, serviceID, hours, serviceDescription)
VALUES 
(9, 1, 4, 'Beach cleanup to remove trash and promote environmental awareness'),
(10, 2, 4, 'Participate in park renovation efforts, including planting trees and painting.');

-- Inserting philanthropy events for Delta Tau Delta and Delta Zeta
INSERT INTO Events (eventID, orgID, name, startTime, endTime, location, isMandatory)
VALUES 
(11, 3, 'Annual Fundraiser Gala', '2024-09-30 19:00:00', '2024-09-30 23:00:00', 'Grand Hotel Ballroom', TRUE),
(12, 4, 'Charity Run for Education', '2024-10-01 07:00:00', '2024-10-01 11:00:00', 'Community Park', TRUE);
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
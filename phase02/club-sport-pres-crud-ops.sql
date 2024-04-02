—- an organized user directory, showing who's on the e-board, players, supporters, and alumni, for easy identification and communication.

SELECT UserID, FirstName, LastName, PositionName
FROM Users
JOIN Roles ON Users.userID = Roles.userID
WHERE Roles.orgID = <Group OrgID>
GROUP BY  PositionName;


—- a centralized schedule for practices, games, and results, updated in real-time for everyone's awareness and coordination.

SELECT Name, StartTime, Location
FROM Events
JOIN Games ON Events.eventID = Games.eventID
JOIN Practices ON Events.eventID = Practices.eventID
JOIN Meetings ON Events.eventID = Meetings.eventID
WHERE OrgID = <OrgID>
ORDER BY StartTime Desc;


—- A way to schedule games, practices, and meetings so that the team can be kept up to date with the schedule.

—- Practice
INSERT INTO Events (orgID, name, startTime, endTime, location, isMandatory)
VALUES (1, 'Practice Event 1', '2024-04-02 10:00:00', '2024-04-02 12:00:00', 'Practice Location 1', TRUE);

INSERT INTO Practices (eventID, practiceID, injuriesDesc)
VALUES (1, 1, 'No injuries reported during practice.');

INSERT INTO DrillInstances (eventID, practiceID, drillID)
VALUES (1, 1, 1); -- Assuming you have a specific drill with drillID 1 that was used in this practice event


—- Game
INSERT INTO Events (orgID, name, startTime, endTime, location, isMandatory)
VALUES (1, 'Game Event 1', '2024-04-02 14:00:00', '2024-04-02 16:00:00', 'Game Location 1', TRUE);

INSERT INTO Games (eventID, opponentTeamName, nuScore, opponentScore, injuriesDescription)
VALUES (2, 'Opponent Team 1', 20, 15, 'No injuries reported during the game.');


-- Meeting
INSERT INTO Events (orgID, name, startTime, endTime, location, isMandatory)
VALUES (1, 'Meeting Event 1', '2024-04-03 10:00:00', '2024-04-03 12:00:00', 'Meeting Location 1', FALSE);

INSERT INTO Meetings (eventID, agenda, minutes)
VALUES (3, 'Agenda for the meeting event', 'Minutes of the meeting event.');


-- A dedicated section on the website to view prospective students so we can reach out to them.

SELECT UserID, FirstName, LastName, Email
FROM Users
JOIN (
    SELECT Users.userID
    FROM Users
    LEFT JOIN Roles ON Users.userID = Roles.userID
    WHERE Roles.userID IS NULL
) AS UsersWithoutRole ON Users.userID = UsersWithoutRole.userID
WHERE Users.orgID = <Group OrgID>;


—- A way to view all of the people that owe dues to the club.

SELECT U.userID, U.firstName, U.lastName, D.amount, D.dueDate
FROM Users U
INNER JOIN Dues D ON U.userID = D.userID
WHERE D.dueDate <= CURDATE() AND D.orgID = X;

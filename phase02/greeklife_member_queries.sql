-- Query 2.1: Fetch detailed information about upcoming philanthropy events and community service opportunities
SELECT
    E.name AS EventName,
    E.startTime,
    E.endTime,
    P.cause AS PhilanthropyCause,
    P.amountRaised,
    C.serviceDescription,
    C.hours AS ServiceHours
FROM
    Events E
    LEFT JOIN Philanthropies P ON E.eventID = P.eventID
    LEFT JOIN CommunityServices C ON E.eventID = C.eventID
WHERE
    E.startTime > NOW()
ORDER BY
    E.startTime;

-- Query 2.2: Generate a calendar of fraternity events
SELECT
    eventID,
    name,
    startTime,
    endTime,
    location,
    isMandatory
FROM
    Events
WHERE
    startTime BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 MONTH)
ORDER BY
    startTime;

-- Query 2.3: Find alumni based on career
SELECT
    U.firstName,
    U.lastName,
    A.location,
    A.currentJob,
    U.NUID 
FROM
    Alumni A
    JOIN Users U ON A.userID = U.userID
WHERE
    A.currentJob LIKE '%[Career Interest]%' 
ORDER BY
    A.location, A.currentJob;

-- Query 4.1: Retrieve names and phone numbers of all chapter members
SELECT
    firstName,
    lastName,
    email 
FROM
    Users
ORDER BY
    lastName, firstName;

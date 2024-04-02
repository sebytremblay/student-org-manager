# Story 1, interested in business clubs
SELECT Name, Description
FROM StudentOrganization
WHERE Type = 'Business';

# Story 2 Wants to join small greek life

SELECT Name, COUNT(UserID) as MemberCount
FROM StudentOrganization
JOIN Roles ON StudentOrganization.GroupID = Roles.GroupID
WHERE Type = 'Greek Life'
GROUP BY Name
HAVING MemberCount < (40);

# Interested in sports club meeting not frequently
-- 3.1: Sports club meeting frequency

SELECT Name, MeetingFrequency
FROM StudentOrganization
WHERE Type = 'Sports';

# Interested in frat events
SELECT Name, EventName, StartDate, EndDate
FROM StudentOrganization
JOIN Event ON StudentOrganization.GroupID = Event.GroupID
WHERE Type = 'Social Fraternity';
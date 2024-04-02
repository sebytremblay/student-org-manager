CREATE TABLE Meetings (
    MeetingID INT AUTO_INCREMENT PRIMARY KEY,
    Agenda TEXT NOT NULL,
    Minutes TEXT NOT NULL,
    MeetingDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL
);

CREATE TABLE CommunityServices (
    ServiceID INT AUTO_INCREMENT PRIMARY KEY,
    Hours INT NOT NULL,
    ServiceDescription TEXT NOT NULL,
    ServiceDate DATE NOT NULL
);

CREATE TABLE Philanthropies (
    PhilanthropyID INT AUTO_INCREMENT PRIMARY KEY,
    Cause VARCHAR(255) NOT NULL,
    AmountRaised DECIMAL(10, 2) NOT NULL,
    EventDate DATE NOT NULL
);

CREATE TABLE Rituals (
    RitualID INT AUTO_INCREMENT PRIMARY KEY,
    RitualName VARCHAR(255) NOT NULL,
    RitualDescription TEXT NOT NULL,
    RitualDate DATE NOT NULL
);

INSERT INTO Meetings (Agenda, Minutes, MeetingDate, StartTime, EndTime) VALUES
('Planning for the upcoming charity event', 'Assigned roles and tasks', '2024-04-10', '18:00:00', '19:30:00'),
('Monthly budget review', 'Approved the budget for next month', '2024-04-17', '18:00:00', '19:00:00'),
('New member induction', 'Welcomed new members and outlined fraternity values', '2024-05-01', '18:00:00', '20:00:00'),
('Community service planning', 'Organized a community cleanup event', '2024-05-15', '18:00:00', '19:00:00');

-- Community Services
INSERT INTO CommunityServices (Hours, ServiceDescription, ServiceDate) VALUES
(4, 'Local park cleanup', '2024-03-20'),
(3, 'Food drive organization', '2024-03-27'),
(5, 'Volunteering at a local shelter', '2024-04-03'),
(4, 'Beach cleanup initiative', '2024-04-17');

-- Philanthropies
INSERT INTO Philanthropies (Cause, AmountRaised, EventDate) VALUES
('Education for Underprivileged Children', 5000.00, '2024-02-25'),
('Cancer Research Fundraiser', 7500.00, '2024-03-15'),
('Local Homeless Shelter Support', 3200.00, '2024-04-05'),
('Environmental Conservation', 4500.00, '2024-04-22');

-- Rituals
INSERT INTO Rituals (RitualName, RitualDescription, RitualDate) VALUES
('Induction Ceremony', 'Formal ceremony to welcome new members.', '2024-05-01'),
('Yearly Commemoration', 'Anniversary of the fraternity’s founding.', '2024-05-08'),
('Senior Farewell Ritual', 'Ceremony to bid farewell to graduating members.', '2024-06-15'),
('Alumni Homecoming Ritual', 'Event for alumni members to reconnect with the fraternity.', '2024-07-20');

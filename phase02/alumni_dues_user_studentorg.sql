
CREATE TABLE User (
  UserID INT PRIMARY KEY,
  NUID CHAR(9),
  GraduationYear YEAR,
  StartDate DATE,
  CurrentYear INT,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  GoalsWants TEXT,
  Challenges TEXT
);

CREATE TABLE StudentOrganization (
  GroupID INT PRIMARY KEY,
  Name VARCHAR(100),
  Established DATE,
  Type VARCHAR(50)
);


CREATE TABLE Dues (
  UserID INT,
  GroupID INT,
  Amount DECIMAL(10, 2),
  DueDate DATE,
  FOREIGN KEY (UserID) REFERENCES User(UserID),
  FOREIGN KEY (GroupID) REFERENCES StudentOrganization(GroupID)
);

CREATE TABLE Alumni (
  UserID INT PRIMARY KEY,
  Location VARCHAR(100),
  CurrentJob VARCHAR(100),
  AlumniID INT,
  FOREIGN KEY (UserID) REFERENCES User(UserID)
);
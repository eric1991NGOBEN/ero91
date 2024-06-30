CREATE DATABASE BusManagementSystem;
USE BusManagementSystem;

CREATE TABLE Parent (
    Parent_ID INT AUTO_INCREMENT PRIMARY KEY,
    Parent_Name VARCHAR(50),
    Parent_Surname VARCHAR(50),
    Parent_Cellno VARCHAR(15),
    Parent_Email VARCHAR(50),
    Parent_Passcode VARCHAR(20)
);

CREATE TABLE Parent_Student_App (
    Application_No INT AUTO_INCREMENT PRIMARY KEY,
    Learner_ID INT,
    Parent_ID INT,
    Application_Status VARCHAR(20),
    FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID),
    FOREIGN KEY (Parent_ID) REFERENCES Parent(Parent_ID)
);

CREATE TABLE Administrator (
    Admin_ID INT AUTO_INCREMENT PRIMARY KEY,
    Learner_ID INT,
    Parent_ID INT,
    Admin_Initials VARCHAR(5),
    Admin_Surname VARCHAR(50),
    Admin_Email VARCHAR(50),
    Admin_Passcode VARCHAR(20),
    FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID),
    FOREIGN KEY (Parent_ID) REFERENCES Parent(Parent_ID)
);

CREATE TABLE Learner (
    Learner_ID INT AUTO_INCREMENT PRIMARY KEY,
    Bus_ID INT,
    Admin_ID INT,
    Learner_Name VARCHAR(50),
    Learner_Surname VARCHAR(50),
    Learner_Grade INT,
    Learner_CellNo VARCHAR(15),
    FOREIGN KEY (Bus_ID) REFERENCES Bus(Bus_ID),
    FOREIGN KEY (Admin_ID) REFERENCES Administrator(Admin_ID)
);

CREATE TABLE WaitingList (
    Waiting_No INT AUTO_INCREMENT PRIMARY KEY,
    Learner_ID INT,
    Admin_ID INT,
    Learner_Contacts VARCHAR(15),
    WaitingList_Group VARCHAR(20),
    FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID),
    FOREIGN KEY (Admin_ID) REFERENCES Administrator(Admin_ID)
);

CREATE TABLE Bus (
    Bus_ID INT AUTO_INCREMENT PRIMARY KEY,
    Admin_ID INT,
    Route_ID INT,
    Bus_SpaceStatus VARCHAR(10),
    Bus_Time TIME,
    FOREIGN KEY (Admin_ID) REFERENCES Administrator(Admin_ID),
    FOREIGN KEY (Route_ID) REFERENCES Routes(Route_ID)
);

CREATE TABLE Routes (
    Route_ID INT AUTO_INCREMENT PRIMARY KEY,
    PickUp_No INT,
    DropOff_No INT,
    Route_Times TIME,
    Route_Destination VARCHAR(50),
    FOREIGN KEY (PickUp_No) REFERENCES Pick_Up(PickUp_No),
    FOREIGN KEY (DropOff_No) REFERENCES Drop_Off(DropOff_No)
);

CREATE TABLE Pick_Up (
    PickUp_No INT AUTO_INCREMENT PRIMARY KEY,
    PickUp_Name VARCHAR(50),
    PickUp_Point TIME
);

CREATE TABLE Drop_Off (
    DropOff_No INT AUTO_INCREMENT PRIMARY KEY,
    DropOff_Name VARCHAR(50),
    DropOff_Point TIME
);

-- Insert Data into Pick_Up Table
INSERT INTO Pick_Up (PickUp_Name, PickUp_Point)
VALUES 
('Corner of Panorama and Marabou Road', '06:22:00'),
('Corner of Kolgansstraat and Skimmerstraat', '06:30:00'),
('Corner of Reddersburg Street and Mafeking Drive', '06:25:00'),
('Corner of Theuns van Niekerkstraat and Roosmarynstraat', '06:35:00'),
('Corner of Jasper Drive and Tieroog Street', '06:20:00'),
('Corner of Louise Street and Von Willich Drive', '06:40:00');

-- Insert Data into Drop_Off Table
INSERT INTO Drop_Off (DropOff_Name, DropOff_Point)
VALUES 
('Corner of Panorama and Marabou Road', '14:30:00'),
('Corner of Kolgansstraat and Skimmerstraat', '14:39:00'),
('Corner of Reddersburg Street and Mafeking Drive', '14:25:00'),
('Corner of Theuns van Niekerkstraat and Roosmarynstraat', '14:30:00'),
('Corner of Jasper Drive and Tieroog Street', '14:30:00'),
('Corner of Louise Street and Von Willich Drive', '14:40:00');

-- Insert Data into Routes Table
INSERT INTO Routes (PickUp_No, DropOff_No, Route_Times, Route_Destination)
VALUES 
((SELECT PickUp_No FROM Pick_Up WHERE PickUp_Name = 'Corner of Panorama and Marabou Road' AND PickUp_Point = '06:22:00'), (SELECT DropOff_No FROM Drop_Off WHERE DropOff_Name = 'Corner of Panorama and Marabou Road' AND DropOff_Point = '14:30:00'), '06:22:00', 'Rooihuiskraal'),
((SELECT PickUp_No FROM Pick_Up WHERE PickUp_Name = 'Corner of Kolgansstraat and Skimmerstraat' AND PickUp_Point = '06:30:00'), (SELECT DropOff_No FROM Drop_Off WHERE DropOff_Name = 'Corner of Kolgansstraat and Skimmerstraat' AND DropOff_Point = '14:39:00'), '06:30:00', 'Rooihuiskraal'),
((SELECT PickUp_No FROM Pick_Up WHERE PickUp_Name = 'Corner of Reddersburg Street and Mafeking Drive' AND PickUp_Point = '06:25:00'), (SELECT DropOff_No FROM Drop_Off WHERE DropOff_Name = 'Corner of Reddersburg Street and Mafeking Drive' AND DropOff_Point = '14:25:00'), '06:25:00', 'Wierdapark'),
((SELECT PickUp_No FROM Pick_Up WHERE PickUp_Name = 'Corner of Theuns van Niekerkstraat and Roosmarynstraat' AND PickUp_Point = '06:35:00'), (SELECT DropOff_No FROM Drop_Off WHERE DropOff_Name = 'Corner of Theuns van Niekerkstraat and Roosmarynstraat' AND DropOff_Point = '14:30:00'), '06:35:00', 'Wierdapark'),
((SELECT PickUp_No FROM Pick_Up WHERE PickUp_Name = 'Corner of Jasper Drive and Tieroog Street' AND PickUp_Point = '06:20:00'), (SELECT DropOff_No FROM Drop_Off WHERE DropOff_Name = 'Corner of Jasper Drive and Tieroog Street' AND DropOff_Point = '14:30:00'), '06:20:00', 'Centurion'),
((SELECT PickUp_No FROM Pick_Up WHERE PickUp_Name = 'Corner of Louise Street and Von Willich Drive' AND PickUp_Point = '06:40:00'), (SELECT DropOff_No FROM Drop_Off WHERE DropOff_Name = 'Corner of Louise Street and Von Willich Drive' AND DropOff_Point = '14:40:00'), '06:40:00', 'Centurion');

-- Insert Data into Bus Table
INSERT INTO Bus (Admin_ID, Route_ID, Bus_SpaceStatus, Bus_Time)
VALUES 
(NULL, (SELECT Route_ID FROM Routes WHERE Route_Destination = 'Rooihuiskraal' AND Route_Times = '06:22:00'), 'Available', '06:22:00'),
(NULL, (SELECT Route_ID FROM Routes WHERE Route_Destination = 'Rooihuiskraal' AND Route_Times = '06:30:00'), 'Available', '06:30:00'),
(NULL, (SELECT Route_ID FROM Routes WHERE Route_Destination = 'Wierdapark' AND Route_Times = '06:25:00'), 'Available', '06:25:00'),
(NULL, (SELECT Route_ID FROM Routes WHERE Route_Destination = 'Wierdapark' AND Route_Times = '06:35:00'), 'Available', '06:35:00'),
(NULL, (SELECT Route_ID FROM Routes WHERE Route_Destination = 'Centurion' AND Route_Times = '06:20:00'), 'Available', '06:20:00'),
(NULL, (SELECT Route_ID FROM Routes WHERE Route_Destination = 'Centurion' AND Route_Times = '06:40:00'), 'Available', '06:40:00');

-- Insert Data into Parent Table
INSERT INTO Parent (Parent_Name, Parent_Surname, Parent_Cellno, Parent_Email, Parent_Passcode)
VALUES
('Alice', 'Brown', '0123456789', 'alice.brown@example.com', 'pass123'),
('Bob', 'Smith', '0123456790', 'bob.smith@example.com', 'pass123'),
('Carol', 'Johnson', '0123456791', 'carol.johnson@example.com', 'pass123'),
('David', 'Wilson', '0123456792', 'david.wilson@example.com', 'pass123'),
('Eve', 'Davis', '0123456793', 'eve.davis@example.com', 'pass123'),
('Frank', 'Miller', '0123456794', 'frank.miller@example.com', 'pass123'),
('Grace', 'Moore', '0123456795', 'grace.moore@example.com', 'pass123'),
('Hank', 'Taylor', '0123456796', 'hank.taylor@example.com', 'pass123'),
('Ivy', 'Anderson', '0123456797', 'ivy.anderson@example.com', 'pass123'),
('Jack', 'Thomas', '0123456798', 'jack.thomas@example.com', 'pass123');

-- Insert Data into Administrator Table
INSERT INTO Administrator (Learner_ID, Parent_ID, Admin_Initials, Admin_Surname, Admin_Email, Admin_Passcode)
VALUES 
(NULL, 1, 'A.B', 'Admin1', 'admin1@example.com', 'adminpass'),
(NULL, 2, 'B.S', 'Admin2', 'admin2@example.com', 'adminpass'),
(NULL, 3, 'C.J', 'Admin3', 'admin3@example.com', 'adminpass');

-- Insert Data into Learner Table
INSERT INTO Learner (Bus_ID, Admin_ID, Learner_Name, Learner_Surname, Learner_Grade, Learner_CellNo)
VALUES
((SELECT Bus_ID FROM Bus WHERE Bus_SpaceStatus = 'Available' AND Route_ID = (SELECT Route_ID FROM Routes WHERE Route_Destination = 'Rooihuiskraal' AND Route_Times = '06:22:00')), 1, 'Liam', 'Brown', 5, '0123456799'),
((SELECT Bus_ID FROM Bus WHERE Bus_SpaceStatus = 'Available' AND Route_ID = (SELECT Route_ID FROM Routes WHERE Route_Destination = 'Rooihuiskraal' AND Route_Times = '06:30:00')), 1, 'Noah', 'Smith', 6, '0123456700'),
((SELECT Bus_ID FROM Bus WHERE Bus_SpaceStatus = 'Available' AND Route_ID = (SELECT Route_ID FROM Routes WHERE Route_Destination = 'Wierdapark' AND Route_Times = '06:25:00')), 2, 'Olivia', 'Johnson', 7, '0123456701'),
((SELECT Bus_ID FROM Bus WHERE Bus_SpaceStatus = 'Available' AND Route_ID = (SELECT Route_ID FROM Routes WHERE Route_Destination = 'Wierdapark' AND Route_Times = '06:35:00')), 2, 'Emma', 'Wilson', 8, '0123456702'),
((SELECT Bus_ID FROM Bus WHERE Bus_SpaceStatus = 'Available' AND Route_ID = (SELECT Route_ID FROM Routes WHERE Route_Destination = 'Centurion' AND Route_Times = '06:20:00')), 3, 'Ava', 'Davis', 9, '0123456703'),
((SELECT Bus_ID FROM Bus WHERE Bus_SpaceStatus = 'Available' AND Route_ID = (SELECT Route_ID FROM Routes WHERE Route_Destination = 'Centurion' AND Route_Times = '06:40:00')), 3, 'Sophia', 'Miller', 10, '0123456704');

-- Insert Data into Parent_Student_App Table
INSERT INTO Parent_Student_App (Learner_ID, Parent_ID, Application_Status)
VALUES 
(1, 1, 'Approved'),
(2, 2, 'Approved'),
(3, 3, 'Approved'),
(4, 4, 'Approved'),
(5, 5, 'Approved'),
(6, 6, 'Approved');

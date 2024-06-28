PRAGMA foreign_keys = TRUE;
-- creat table
CREATE TABLE Staff (
    staff_id CHAR (9) PRIMARY KEY,
    name VARCHAR (30),
    email VARCHAR (50),
    street VARCHAR (50),
    city VARCHAR (20),
    postcode VARCHAR (10)
);

CREATE TABLE Phone (
    staff_id CHAR (9) PRIMARY KEY,
    phone_number CHAR (10),
    type VARCHAR (10),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Manager (
    staff_id CHAR (9) PRIMARY KEY,
    annual_salary NUMERIC (8, 2) NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Driver (
    staff_id CHAR (9) PRIMARY KEY,
    hourly_salary INT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Station (
    station_name VARCHAR (50) PRIMARY KEY,
    town VARCHAR (30) NOT NULL,
    manager_id CHAR (9),
    FOREIGN KEY (manager_id) REFERENCES Manager(staff_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Service (
    service_number VARCHAR(3) PRIMARY KEY,
    departure_station_name VARCHAR (50),
    destination_station_name VARCHAR (50),
    FOREIGN KEY (departure_station_name) REFERENCES Station(station_name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (destination_station_name) REFERENCES Station(station_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Drives (
    staff_id CHAR (9),
    service_number VARCHAR(3),
    hours_driven NUMERIC(5, 1) NOT NULL,
    PRIMARY KEY (staff_id, service_number),
    FOREIGN KEY (staff_id) REFERENCES Driver(staff_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (service_number) REFERENCES Service(service_number) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ServiceTime (
    service_number VARCHAR(3),
    start_time TIME,
    PRIMARY KEY (service_number, start_time),
    FOREIGN KEY (service_number) REFERENCES Service(service_number) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Stop (
    stop_name VARCHAR(50) PRIMARY KEY
);

CREATE TABLE TimeOnStop (
    service_number VARCHAR(3),
    start_time TIME,
    stop_name VARCHAR(50),
    arrival_time TIME NOT NULL,
    fare_from_origin DOUBLE NOT NULL,
    PRIMARY KEY (service_number, start_time, stop_name),
    FOREIGN KEY (service_number, start_time) REFERENCES ServiceTime(service_number, start_time) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (stop_name) REFERENCES Stop(stop_name) ON DELETE CASCADE ON UPDATE CASCADE
);

--insert datas into tables
INSERT INTO Staff (staff_id, name, email, street, city, postcode)
VALUES
    ('230015450', 'David', 'dav83@bus.co.uk', 'Strathkiness', 'Fife', 'KY16 9UW'),
    ('230015451', 'Tom', 'tom82@bus.co.uk', 'Buchanan Gardens', 'Fife', 'KY16 9WJ'),
    ('230015452', 'John', 'joh55@bus.co.uk', 'Princes Street', 'Edinburgh', 'EH5 8IU'),
    ('230015453', 'Mary', 'mar52@bus.co.uk', 'Haymarket', 'Edinburgh', 'EH3 7ST'),
    ('230015454', 'Michael', 'mic74@bus.co.uk', 'Deansgate', 'Manchester', 'M20 3YI'),
    ('230015455', 'Jennifer', 'jen56@bus.co.uk', 'Buchanan Street', 'Glasgow', 'G8 4OE'),
    ('230015456', 'Susan', 'sus80@bus.co.uk', 'Sauchiehall Street', 'Glasgow', 'G7 2OU'),
    ('230015457', 'James', 'jam05@bus.co.uk', 'Bridgeton', 'Glasgow', 'G6 5YU'),
    ('230015458', 'Linda', 'lin10@bus.co.uk', 'Redriff Rd', 'London', 'E1W 2SL'),
    ('230015459', 'Robert', 'rob20@bus.co.uk', 'Oxford Street', 'London', 'SE15 4OI');

INSERT INTO Phone (staff_id, phone_number, type)
VALUES
    ('230015450', '7820378887', 'family'),
    ('230015451', '7817251234', 'work'),
    ('230015452', '7978435435', NULL),
    ('230015453', '7830311223', NULL),
    ('230015454', '7801234567', 'work'),
    ('230015455', '7816329876', 'family'),
    ('230015456', '7820711234', 'family'),
    ('230015457', '7828187654', NULL),
    ('230015458', '7758416713', 'work'),
    ('230015459', '7854824523', 'work');

INSERT INTO Manager (staff_id, annual_salary)
VALUES
    ('230015450', 84500.33),
    ('230015451', 76550.54),
    ('230015452', 60000.20),
    ('230015453', 50042.32),
    ('230015454', 35050.55);

INSERT INTO Driver (staff_id, hourly_salary)
VALUES
    ('230015455', 80.2),
    ('230015456', 65.1),
    ('230015457', 70.3),
    ('230015458', 102.5),
    ('230015459', 60.5);

INSERT INTO Station (station_name, town, manager_id)
VALUES
    ('St Andrews Bus Station', 'St Andrews', '230015450'),
    ('Old Course', 'St Andrews', '230015451'),
    ('Seagate', 'Dundee', '230015452'),
    ('Edinburgh Bus Station', 'Edinburgh', '230015453'),
    ('City Square Bus Stop', 'Dundee', '230015454');

INSERT INTO Service (service_number, departure_station_name, destination_station_name)
VALUES
    ('99A', 'Edinburgh Bus Station', 'City Square Bus Stop'),
    ('92B', 'Seagate', 'Edinburgh Bus Station'),
    ('X59', 'Edinburgh Bus Station', 'St Andrews Bus Station'),
    ('93A', 'City Square Bus Stop', 'St Andrews Bus Station'),
    ('32R', 'Seagate', 'Old Course');

INSERT INTO Drives (staff_id, service_number, hours_driven)
VALUES
    ('230015455', '99A', 5),
    ('230015456', '92B', 2),
    ('230015457', 'X59', 3),
    ('230015458', '93A', 2),
    ('230015459', '32R', 4);

INSERT INTO ServiceTime (service_number, start_time)
VALUES
    ('99A', '06:00:00'),
    ('99A', '08:00:00'),
    ('99A', '18:00:00'),
    ('92B', '07:30:00'),
    ('92B', '20:15:00'),
    ('X59', '08:30:00'),
    ('X59', '12:30:00'),
    ('93A', '10:15:00'),
    ('93A', '12:15:00'),
    ('32R', '07:15:00'),
    ('32R', '13:00:00');

INSERT INTO Stop (stop_name)
VALUES
    ('South Street'),
    ('George Street'),
    ('Royal Mile'),
    ('Rose Street'),
    ('Grassmarket'),
    ('Candlemaker Row'),
    ('Queensferry Street'),
    ('Hanover Street'),
    ('Buchanan Gardens, St Andrews'),
    ('Leith Walk');

INSERT INTO TimeOnStop (service_number, start_time, stop_name, arrival_time, fare_from_origin)
VALUES
    ('99A', '06:00:00', 'South Street', '07:30:00', 1.50),
    ('99A', '06:00:00', 'George Street', '07:00:00', 1.10),
    ('99A', '06:00:00', 'Royal Mile', '07:05:00', 1.30),
    ('99A', '08:00:00', 'South Street', '08:30:00', 1.50),
    ('99A', '08:00:00', 'George Street', '09:00:00', 1.10),
    ('99A', '08:00:00', 'Royal Mile', '09:05:00', 1.30),
    ('99A', '18:00:00', 'South Street', '19:30:00', 1.50),
    ('99A', '18:00:00', 'George Street', '19:00:00', 1.10), 
    ('99A', '18:00:00', 'Royal Mile', '19:05:00', 1.30), 
    ('92B', '07:30:00', 'George Street', '07:50:00', 1.00),
    ('92B', '07:30:00', 'Rose Street', '09:30:00', 4.80),
    ('92B', '20:15:00', 'George Street', '20:35:00', 1.00),
    ('92B', '20:15:00', 'Rose Street', '22:15:00', 4.80),
    ('X59', '08:30:00', 'Grassmarket', '10:30:00', 4.80),
    ('X59', '08:30:00', 'Candlemaker Row', '11:30:00', 5.00),
    ('X59', '12:30:00', 'Grassmarket', '14:30:00', 4.80),
    ('X59', '12:30:00', 'Candlemaker Row', '15:30:00', 5.00),
    ('93A', '10:15:00', 'South Street', '11:00:00', 2.10),
    ('93A', '10:15:00', 'Buchanan Gardens, St Andrews', '11:15:00', 2.80),
    ('93A', '12:15:00', 'South Street', '13:00:00', 2.10),
    ('93A', '12:15:00', 'Buchanan Gardens, St Andrews', '13:15:00', 2.80),
    ('32R', '07:15:00', 'George Street', '07:30:00', 1.00),
    ('32R', '07:15:00', 'Leith Walk', '08:30:00', 2.00),
    ('32R', '13:00:00', 'George Street', '13:15:00', 1.00),
    ('32R', '13:00:00', 'Leith Walk', '14:15:00', 2.00);


--task2 query
-- 1. 
SELECT service_number, departure_station_name
FROM Service
WHERE departure_station_name  = 'Seagate';
--2.
SELECT staff_id, (annual_salary/12) AS monthly_salary
FROM Manager;

--3.
SELECT STF.name AS driver_name, DRR.hourly_salary, DRR.hourly_salary * Drives.hours_driven AS total_earnings
FROM Driver DRR
JOIN Staff STF ON DRR.staff_id = STF.staff_id
JOIN Drives ON DRR.staff_id = Drives.staff_id
JOIN Service ON Drives.service_number = Service.service_number
JOIN Station ON Service.departure_station_name = Station.station_name OR Service.destination_station_name = Station.station_name
WHERE (Station.town = 'Edinburgh' AND (Service.departure_station_name = 'Edinburgh Bus Station' OR Service.destination_station_name = 'Edinburgh Bus Station'))
ORDER BY total_earnings;

--4.
SELECT S.manager_id, COUNT(*) AS num_services
FROM Station S
JOIN Service ON S.station_name = Service.departure_station_name OR S.station_name = Service.destination_station_name
GROUP BY S.manager_id
ORDER BY num_services DESC
LIMIT 1;


--5.
SELECT TOS.arrival_time, S.departure_station_name, S.destination_station_name, S.service_number
FROM TimeOnStop TOS
JOIN Service S ON TOS.service_number = S.service_number
WHERE TOS.stop_name = 'Buchanan Gardens, St Andrews'
    AND TOS.arrival_time >= '10:00:00'
    AND TOS.arrival_time <= '14:00:00'
ORDER BY TOS.arrival_time;

--creat new query 
--6.
SELECT departure_station_name, COUNT(*) AS num_services
FROM Service
WHERE departure_station_name = 'Edinburgh Bus Station'
GROUP BY departure_station_name;


--7.
SELECT service_number, AVG(fare_from_origin) AS average_fare
FROM TimeOnStop
GROUP BY service_number
HAVING COUNT(service_number) >= 2;
--8.
SELECT S.station_name, COUNT(*) AS num_services
FROM Station S
LEFT JOIN Service ON S.station_name = Service.departure_station_name OR S.station_name = Service.destination_station_name
GROUP BY S.station_name
HAVING COUNT(S.station_name) >= 2
ORDER BY num_services DESC;

--9.
SELECT service_number, departure_station_name, destination_station_name
FROM Service
ORDER BY service_number
LIMIT 2;

--creat three new views

--View1
CREATE VIEW EmployeeBasicInfo AS
SELECT staff_id, name, email, street, city, postcode
FROM Staff;
--view2
CREATE VIEW StationInfo AS
SELECT S.station_name, S.town, ST.name AS manager_name
FROM Station S
LEFT JOIN Manager M ON S.manager_id = M.staff_id
LEFT JOIN Staff ST ON M.staff_id = ST.staff_id;
--View3
CREATE VIEW DriverEarnings AS
SELECT ST.name AS driver_name, D.hourly_salary, D.hourly_salary * Drives.hours_driven AS total_earnings
FROM Driver D
JOIN Staff ST ON D.staff_id = ST.staff_id
JOIN Drives ON D.staff_id = Drives.staff_id;



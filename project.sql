----Creating Payroll table and inserting values in it------
CREATE TABLE Payroll (
  employee_id INT,
  salary INT,
  net_salary INT,
  hourly_salary INT,
  bonus_salary INT,
  compensation INT,
  IBAN INT,
  account_no INT
);

INSERT INTO Payroll VALUES (1, 65000, 95000, 30, 5000, 1000, 123456789, 987654321);
INSERT INTO Payroll VALUES (2, 43000, 96000, 25, 2500, 500, 234567890, 876543210);
INSERT INTO Payroll VALUES (3, 75000, 90000, 35, 10000, 2000, 345678901, 765432109);
INSERT INTO Payroll VALUES (4, 70000, 80000, 20, 10000, 2000, 345678901, 765432109);
INSERT INTO Payroll VALUES (5, 12000, 70000, 25, 10000, 2000, 345678901, 765432109);

----Creating Employee_Master table and inserting values in it------
CREATE TABLE Employee_Master (
  employee_id INT,
  personal_id INT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  country VARCHAR(50),
  dob DATE,
  gender VARCHAR(10),
  address VARCHAR(200),
  mobile INT,
  email VARCHAR(100),
  department_id INT
);

INSERT INTO Employee_Master VALUES (1, 123, 'Vinit', 'Patel', 'India', '2001-01-01', 'Male', '135 Blane Street, Gujarat, India', 7895862145, 'vinitpatel@email.com', 1);
INSERT INTO Employee_Master VALUES (2, 456, 'Nupur', 'Bhavsar', 'India', '2002-04-30', 'Female', '4997 Jadewood Farms, Rajkot, India', 7854921658, 'nupurbhavsar@email.com', 2);
INSERT INTO Employee_Master VALUES (3, 789, 'Omar', 'Radwan', 'Canada', '2000-07-10', 'Male', '14 Greenman dr, Kingston, ON, Canada', 9984325617, 'omarradwan@email.com', 3);
INSERT INTO Employee_Master VALUES (4, 589, 'Asmabanu', 'Saiyed', 'USA', '2000-07-01', 'Female', '1578 Stuart Street, New York, USA', 4512687593, 'asmasaiyed@email.com', 4);
INSERT INTO Employee_Master VALUES (5, 714, 'Umang', 'Deval', 'Canada', '2001-10-08', 'Male', '123 Mary Jones station, ON, Canada', 1148659729, 'umangdeval@email.com', 5);

/*1. Based on these two tables please write a query to display the employee information with their salary?
The attributes you need to pull is first name, employee id, last name, email and salary*/
---Ans1
SELECT em.first_name, em.employee_id, em.last_name, em.email, p.salary
FROM Employee_Master em
INNER JOIN Payroll p ON em.employee_id = p.employee_id;

----2. Write a query to display the third maximum salary from payroll table?----
---Ans2
SELECT salary
FROM (
  SELECT salary, ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
  FROM Payroll
)
WHERE rn = 3;

----Creating Patient tablet------
CREATE TABLE Patient (
  patient_id INT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  dob DATE,
  nationality VARCHAR(50),
  gender VARCHAR(10),
  address VARCHAR(200),
  phone INT,
  email VARCHAR(100)
);

---3. Write a stored procedure to insert two rows into patient table? You can insert any values you like.Important is that you can insert two rows
---Ans3
CREATE OR REPLACE PROCEDURE InsertTwoPatients
AS
BEGIN
  INSERT INTO Patient VALUES (1, 'Kethy', 'Clark', '1996-05-04', 'Canada', 'Male', '142 George Street, Toronto, Canada', 9948758796, 'kethyclark@email.com');
  INSERT INTO Patient VALUES (2, 'Amy', 'Smith', '1898-12-25', 'USA', 'Female', '3220 Baker Street, London, USA', 4075893654, 'amysmith@email.com');
END;
/
EXEC InsertTwoPatients;

----Creating Nurse tablet------
CREATE TABLE Nurse (
  employee_id INT,
  name VARCHAR(100),
  position VARCHAR(50),
  registered VARCHAR(1),
  ssn INT
);

INSERT INTO Nurse VALUES (101, 'Carla Espinosa', 'Head Nurse', 't', 111111110);
INSERT INTO Nurse VALUES (102, 'Laverne roberts', 'Nurse', 't', 222222220);
INSERT INTO Nurse VALUES (103, 'Paul Flowers', 'Nurse', 'f', 333333330);


---4. Write a query to show the name of the nurses who are in Head Nurse position
---Ans4
SELECT name
FROM Nurse
WHERE position = 'Head Nurse';

---5.Imagine we have a user Smith, and we want to grant him to select a new table. Please provide a password for him when you are creating that user
---Ans5
CREATE USER Smith IDENTIFIED BY mypassword;

GRANT SELECT ON Employee_Master TO Smith;

---6. Create another user John and grant him insert into patient table and then revoke his access
---Ans6
CREATE USER John IDENTIFIED BY mypassword;

GRANT INSERT ON Patient TO John;

REVOKE INSERT ON Patient FROM John;

---7. Practice Cold Backup for all these tables you created and try to crash the DB ( any scenario you like ) and recover the lost info
---Ans7
--A cold backup involves taking a backup of the entire database
--while it is shut down. This type of backup can be used to
--recover the database in the event of a catastrophic failure, 
--such as a hardware failure or a data corruption issue.
shutdown immediate;
startup mount;
backup database;
shutdown immediate;

startup mount;
restore database;
recover database;
alter database open;


















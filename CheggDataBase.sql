USE db_rdong6

-- table for students using Chegg
DROP TABLE IF EXISTS student;
create table student (
	studentID VARCHAR(32) NOT NULL,
	studentName VARCHAR(16),
	phoneNo VARCHAR(16),
	studentAddress VARCHAR(64),
	studentEmail VARCHAR(32),
	plan VARCHAR(8),
	fee DOUBLE,
	Primary Key(studentID)
);

-- table for orders made by students
DROP TABLE IF EXISTS order;
create table order (
	orderID VARCHAR(32) NOT NULL,
	studentID VARCHAR(32) NOT NULL,
	cardNo VARCHAR(16)
	itemType VARCHAR(16)
	orderDate SMALL-DATE-TIME,
	totalPrice DOUBLE,
	status VARCHAR(16)
)

-- sample data for student table
INSERT INTO student (studentID, studentName, phoneNo, studentAddress, studentEmail, plan, fee) VALUES (111111, "Jack", 8581111111, "122 Jack Road", "Jack@jack.edu", "monthly", 100)



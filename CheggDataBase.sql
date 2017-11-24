USE db_dhuang

-- length of strings
-- names of a person32
-- ID: 16 (since CC has 16 and ISBN has 13, 16 should be enough)
-- Address 128
-- email 32

-- disable checking foreign keys so we could delete tables conviniently
SET FOREIGN_KEY_CHECKS = 0; 
-- remove all tables
DROP TABLE IF EXISTS student, orders, payment, bookSeller, book, findsSolution, textbookSolution, textbookSolutionGivenBy, questions, questionAnsweredBy, expertAnswerReviews, expertAnswerGivenBy, expertAnswer, tutor, suppliedBy; 
-- re-enable foreign key checks
SET FOREIGN_kEY_CHECKS = 1;

-- students using Chegg
create table student (
	studentID VARCHAR(16) NOT NULL,
	studentName VARCHAR(32),
	studentPhoneNo VARCHAR(16),
	studentAddress VARCHAR(128),
	studentEmail VARCHAR(32),
	plan VARCHAR(8),
	fee DOUBLE,
	PRIMARY KEY (studentID)
);

-- information about books for sell and rental
create table book (
	ISBN VARCHAR(13) NOT NULL,
	bookName VARCHAR(64),
	author VARCHAR(16),
	publisher VARCHAR(64),
	edition Integer,
	PRIMARY KEY (ISBN)
);

-- information about seller of the book
create table bookSeller (
	sellerID VARCHAR(16) NOT NULL, 
	sellerAddress VARCHAR(64),
	sellerName VARCHAR(16),
	PRIMARY KEY (sellerID)
);

create table tutor (
	tutorID VARCHAR(16) NOT NULL, 
	tutorName VARCHAR(32) NOT NULL,
	totalLike Integer NOT NULL,
	totalDisLike Integer NOT NULL,
	idle Boolean NOT NULL,
	degree VARCHAR(32),
	majors VARCHAR(32),
	PRIMARY KEY (tutorID)
);

-- orders made by students
create table orders (
	orderID VARCHAR(16) NOT NULL,
	studentID VARCHAR(16) NOT NULL,
	cardNo VARCHAR(16),
	itemType VARCHAR(16),
	orderDate DATETIME,
	orderTotal DOUBLE,
	orderStatus VARCHAR(16),
	PRIMARY KEY (orderID),
	FOREIGN KEY (studentID) REFERENCES student(studentID)
);

-- payment information of a order
create table payment (
	cardNo VARCHAR(16) NOT NULL,
	studentID VARCHAR(16) NOT NULL,
	expDate DATETIME NOT NULL,
	CSC VARCHAR(3) NOT NULL,
	PRIMARY KEY (cardNo),
	FOREIGN KEY (studentID) REFERENCES student(studentID) ON DELETE CASCADE
);

-- books purchased within an order
create table suppliedBy (
	sellerID VARCHAR(16) NOT NULL,
	orderID VARCHAR(16) NOT NULL,
	ISBN VARCHAR(13), 
	quantity INTEGER,
	price DOUBLE,
	description VARCHAR(10),
	dueDate DATETIME,
	arrivalDate DATETIME,
	FOREIGN KEY (orderID) REFERENCES orders(orderID),
	FOREIGN KEY (ISBN) REFERENCES book(ISBN),
	FOREIGN KEY (sellerID) REFERENCES bookSeller(sellerID) ON DELETE CASCADE
);

-- questions asked by students
create table questions (
	questionID VARCHAR(16) NOT NULL,
	studentID VARCHAR(16) NOT NULL,
	questionSubject VARCHAR(32),
	questionContent VARCHAR(1000) NOT NULL,
	PRIMARY KEY (questionID),
	FOREIGN KEY (studentID) REFERENCES student(studentID) ON DELETE CASCADE
);

-- solution of textbooks
create table textbookSolution ( 
	ISBN VARCHAR(13) NOT NULL,
	questionNo INTEGER NOT NULL, 
	solution VARCHAR(1000),
	PRIMARY KEY (ISBN, questionNo),
	FOREIGN KEY (ISBN) REFERENCES book(ISBN) ON DELETE CASCADE
);

-- questions student are looking for
create table findsSolution ( 
	studentID VARCHAR(16) NOT NULL,
	questionNo INTEGER NOT NULL,
	ISBN VARCHAR(13) NOT NULL,
	foundSolutionDate DATE NOT NULL,
	PRIMARY KEY (studentID, questionNo),
	FOREIGN KEY (studentID) REFERENCES student(studentID) ON DELETE CASCADE,
	FOREIGN KEY (ISBN, questionNo) REFERENCES textbookSolution(ISBN, questionNo) ON DELETE CASCADE
); 

-- relation between textbook solution and tutors
create table textbookSolutionGivenBy ( 
	ISBN VARCHAR(13) NOT NULL, 
	questionNo INTEGER NOT NULL, 
	tutorID VARCHAR(16) NOT NULL,
	PRIMARY KEY (ISBN, questionNo, tutorID),
	FOREIGN KEY (tutorID) REFERENCES tutor(tutorID) ON DELETE CASCADE,
	FOREIGN KEY (ISBN, questionNo) REFERENCES textbookSolution(ISBN, questionNo) ON DELETE CASCADE
);

-- information on tutors who answer a question
create table questionAnsweredBy (
	tutorID VARCHAR(16) NOT NULL,
	questionID VARCHAR(16) NOT NULL,
	PRIMARY KEY (tutorID),
	FOREIGN KEY (tutorID) REFERENCES tutor(tutorID) ON DELETE CASCADE,
	FOREIGN KEY (questionID) REFERENCES questions(questionID) ON DELETE CASCADE 
);

create table expertAnswer ( 
	answerID VARCHAR(16) NOT NULL, 
	questionID VARCHAR(16) NOT NULL,
	tutorID VARCHAR(16) NOT NULL,
	answerContent VARCHAR(500) NOT NULL,
	disLikes Integer NOT NULL, 
	likes Integer NOT NULL,
	PRIMARY KEY (answerID),
	FOREIGN KEY (tutorID) REFERENCES tutor(tutorID) ON DELETE CASCADE,
	FOREIGN KEY (questionID) REFERENCES questions(questionID) ON DELETE CASCADE
);

 
-- reviews of expert answers
create table expertAnswerReviews ( 
	answerID VARCHAR(16) NOT NULL,
	questionID VARCHAR(16) NOT NULL,
	studentID VARCHAR(16) NOT NULL,
	reviewContent VARCHAR(1000) NOT NULL,
	PRIMARY KEY (studentID, questionID, answerID),
	FOREIGN KEY (studentID) REFERENCES student(studentID) ON DELETE CASCADE,
	FOREIGN KEY (questionID) REFERENCES questions(questionID) ON DELETE CASCADE,
	FOREIGN KEY (answerID) REFERENCES expertAnswer(answerID) ON DELETE CASCADE
);

-- relation between expert answers and tutors
create table expertAnswerGivenBy (
	questionID VARCHAR(16) NOT NULL,
	tutorID VARCHAR(16) NOT NULL,
	PRIMARY KEY (questionID, tutorId),
	FOREIGN KEY (questionID) REFERENCES questions(questionID) ON DELETE CASCADE,
	FOREIGN KEY (tutorID) REFERENCES tutor(tutorID) ON DELETE CASCADE
);	

-- sample data for tutor table
INSERT INTO tutor 
(tutorID, tutorName, totalLike, totalDisLike, idle, degree, majors)
VALUES
(1111, "Alex", 50, 0, TRUE, "Master", "Math"),
(2222, "Beth", 40, 0, True, "Master", "English"),
(3333, "Catherine", 30, 0, TRUE, "Master", "Philosophy"),
(4444, "Daniel", 20, 0, TRUE, "Bachelor", "CS"),
(5555, "Edger", 10, 0, TRUE, "PHD", "ECE");

-- sample data for student
INSERT INTO student
(studentID, studentName, studentPhoneNO, studentAddress, studentEmail, plan, fee)
VALUES
(1001, "s1", "111-111-1111", "111 One Road", "1111@One.com", "monthly", 33),
(1002, "s2", "222-222-2222", "222 Two Road", "2222@two.com", "yearly", 300),
(1003, "s3", "333-333-3333", "333 Three Road", "3333@three.com", "yearly", 310),
(1004, "s4", "444-444-4444", "444 Four Road", "4444@four.com", "monthly", 50),
(1005, "s5", "555-555-5555", "555 Five Road", "5555@five.com", "monthly", 98),
(1006, "s6", "666-666-6666", "666 Six Road", "6666@six.com", "monthly", 28),
(1007, "s7", "777-777-7777", "777 Seven Road", "7777@seven.com", "yearly", 320),
(1008, "s8", "888-888-8888", "888 Eight Road", "8888@eight.com", "yearly", 312),
(1009, "s9", "999-999-9999", "999 Nine Road", "9999@nine.com", "monthly", 29),
(1010, "s10", "100-100-1010", "1010 Ten Road", "1010@ten.com", "monthly", 34);

-- sample data for seller
INSERT INTO bookSeller
(sellerID, sellerAddress, sellerName)
VALUES
(1, "seller1 rd", "handsomeSeller"),
(2, "seller2 rd", "coolSeller"),
(3, "seller3 rd", "amazingSeller"),
(4, "seller4 rd", "fantasticSeller"),
(5, "seller5 rd", "bigSeller");

-- sample data for book
INSERT INTO book
(ISBN, bookName, author, publisher, edition)
VALUES
("9780596009205", "Head First Java", "Kathy Sierra", "p1", 2),
("0439708184", "Harry Potter and the Sorcerer's Stone", "J.K. Rowling", "p2", 1),
("1542046637", "The Good Samaritan", "John Marrs", "p3", 1),
("9780151010264", "Animal Farm", "George Orwell", "Houghton Mifflin Harcourt", 2),
("9780062696120", "Brave New World", "Aldous Huxley", "Harper", 1);

-- sample data for orders
INSERT INTO orders
(orderID, studentID, cardNo, itemType, orderDate, orderTotal, orderStatus)
VALUES
(111, 1001, 1111222233334444, "textbook", '2017-11-22 23:10:22', 87, "pending"),
(222, 1003, 2222333344445555, "textbook", '2018-12-12 11:11:58', 98, "cancelled"),
(333, 1005, 3333444455556666, "textbook", '2019-05-09 13:55:45', 66, "pending"),
(444, 1007, 4444555566667777, "textbook", '2016-06-09 14:45:19', 12, "completed"),
(555, 1009, 5555666677778888, "textbook", '2015-07-18 08:09:08', 123, "completed");

-- sample data for supplied by
INSERT INTO suppliedBy
(sellerID, orderID, ISBN, quantity, price, description, dueDate, arrivalDate)
VALUES
(1, 222, "9780062696120", 10, 199, "rental", '2017-10-30 11:11:22', '2017-08-12 23:34:11'),
(1, 222, "1542046637", 20, 12, "rental", '2018-08-18 12:22:10', '2017-05-18 15:22:31'),
(2, 333, "9780062696120", 3, 99, "purchase", '2017-07-22 15:33:21', '2017-01-01 01:22:33'),
(3, 333, "9780151010264", 18, 123, "purchase", '2016-07-11 12:14:57', '2016-09-23 13:22:41'),
(4, 555, "1542046637", 777, 21, "rental", '2015-01-01 12:34:55', '2014-09-09 12:12:12');

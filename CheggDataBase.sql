USE db_rdong6

-- length of strings
-- names of a person32
-- ID: 16 (since CC has 16 and ISBN has 13, 16 should be enough)
-- Address 128
-- email 32

-- disable checking foreign keys so we could delete tables conviniently
SET FOREIGN_KEY_CHECKS = 0; 
DROP TABLE IF EXISTS student, orders, payment, bookOrdered, bookSoldBy, bookSeller, book, findsSolution, textbookSolution, textbookSolutionGivenBy, questions, questionAnsweredBy, expertAnswerReviews, expertAnswerGivenBy, expertAnswer, tutor; 
SET FOREIGN_kEY_CHECKS = 1;

-- students using Chegg
DROP TABLE IF EXISTS student;
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
DROP TABLE IF EXISTS book;
create table book (
	ISBN VARCHAR(13) NOT NULL,
	bookName VARCHAR(64),
	author VARCHAR(16),
	publisher VARCHAR(64),
	edition Integer,
	PRIMARY KEY (ISBN)
);

-- information about seller of the book
DROP TABLE IF EXISTS bookSeller;
create table bookSeller (
	sellerID VARCHAR(16) NOT NULL, 
	sellerAddress VARCHAR(64),
	sellerName VARCHAR(16),
	PRIMARY KEY (sellerID)
);

DROP TABLE IF EXISTS tutor;
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
DROP TABLE IF EXISTS orders;
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
DROP TABLE IF EXISTS payment;
create table payment (
	cardNo VARCHAR(16) NOT NULL,
	studentID VARCHAR(16) NOT NULL,
	expDate DATETIME NOT NULL,
	CSC VARCHAR(3) NOT NULL,
	PRIMARY KEY (cardNo),
	FOREIGN KEY (studentID) REFERENCES student(studentID) ON DELETE CASCADE
);

-- books ordered inside an order
DROP TABLE IF EXISTS bookOrdered;
create table bookOrdered ( 
	orderID VARCHAR(16) NOT NULL,
	ISBN VARCHAR(13), 
	quantiy INTEGER,
	price DOUBLE,
	description VARCHAR(10),
	dueDate DATETIME,
	arrivalDate DATETIME,
	FOREIGN KEY (orderID) REFERENCES orders(orderID),
	FOREIGN KEY (ISBN) REFERENCES book(ISBN)
);

-- relation that connects bookOrdered and bookSeller
DROP TABLE IF EXISTS bookSoldBy;
create table bookSoldBy (
	ISBN VARCHAR(13) NOT NULL,
	sellerID VARCHAR(16) NOT NULL,
	PRIMARY KEY (ISBN, sellerID),
	FOREIGN KEY (ISBN) REFERENCES book(ISBN) ON DELETE CASCADE,
	FOREIGN KEY (sellerID) REFERENCES bookSeller(sellerID) ON DELETE CASCADE
);


-- questions asked by students
DROP TABLE IF EXISTS questions;
create table questions (
	questionID VARCHAR(16) NOT NULL,
	studentID VARCHAR(16) NOT NULL,
	questionSubject VARCHAR(16),
	questionContent VARCHAR(1000) NOT NULL,
	PRIMARY KEY (questionID),
	FOREIGN KEY (studentID) REFERENCES student(studentID) ON DELETE CASCADE
);

-- solution of textbooks
DROP TABLE IF EXISTS textbookSolution;
create table textbookSolution ( 
	ISBN VARCHAR(13) NOT NULL,
	questionNo INTEGER NOT NULL, 
	solution VARCHAR(1000),
	PRIMARY KEY (ISBN, questionNo),
	FOREIGN KEY (ISBN) REFERENCES book(ISBN) ON DELETE CASCADE
);

-- questions student are looking for
DROP TABLE IF EXISTS findsSolution;
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
DROP TABLE IF EXISTS textBookSolutionGivenBy;
create table textBookSolutionGivenBy ( 
	ISBN VARCHAR(13) NOT NULL, 
	questionNo INTEGER NOT NULL, 
	tutorID VARCHAR(16) NOT NULL,
	PRIMARY KEY (ISBN, questionNo, tutorID),
	FOREIGN KEY (tutorID) REFERENCES tutor(tutorID) ON DELETE CASCADE,
	FOREIGN KEY (ISBN, questionNo) REFERENCES textbookSolution(ISBN, questionNo) ON DELETE CASCADE
);

-- information on tutors who answer a question
DROP TABLE IF EXISTS questionAnsweredBy;
create table questionAnsweredBy (
	tutorID VARCHAR(16) NOT NULL,
	questionID VARCHAR(16) NOT NULL,
	PRIMARY KEY (tutorID),
	FOREIGN KEY (tutorID) REFERENCES tutor(tutorID) ON DELETE CASCADE,
	FOREIGN KEY (questionID) REFERENCES questions(questionID) ON DELETE CASCADE 
);

DROP TABLE IF EXISTS expertAnswer;
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
DROP TABLE IF EXISTS expertAnswerReviews;
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
DROP TABLE IF EXISTS expertAnswerGivenBy;
create table expertAnswerGivenBy (
	questionID VARCHAR(16) NOT NULL,
	tutorID VARCHAR(16) NOT NULL,
	PRIMARY KEY (questionID, tutorId),
	FOREIGN KEY (questionID) REFERENCES questions(questionID) ON DELETE CASCADE,
	FOREIGN KEY (tutorID) REFERENCES tutor(tutorID) ON DELETE CASCADE
);	

-- restart foreign key checks
--SET FOREIGN_KEY_CHECKS = 1;

-- sample data for student table
INSERT INTO student (studentID, studentName, studentPhoneNo, studentAddress, studentEmail, plan, fee) VALUES (111111, "Jack", 8581111111, "122 Jack Road", "Jack@jack.edu", "monthly", 100);


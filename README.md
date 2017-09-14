# Project Description
Group 6: &nbsp; `Donny Dong` &nbsp; `Dat Hong` &nbsp; `Di Huang`

- [Description](#description)
- [Requirements](#requirements)
	- [The business purpose](#the-business-purpose)
	- [The problem to be solved](#the-problem-to-be-solved)
	- [Questions to be answered](#questions-to-be-answered)
- [Assumptions](#assumptions)
- [Project Scope](#project-scope)
	- [In scope](#in-scope)
	- [Out of scope](#out-of-scope)
- [Design Approach](#design-approach)

## Description
_Teaching Resource Database_: The database we are building is a simulation of Chegg database. Chegg is a company that provides online textbook rentals and tutoring services. People are able to find the cheapest and fastest renting or buying options using this platform. It also serves as a channel between students and tutors, for example, students can ask tutors for homework help through it. Event Tracking for this database: which students are requesting what services; which students have the membership; which tutors are working on tutoring; Inventory and sales/rentals volume of textbooks and due date of rented books.

## Requirements
### The business purpose
To build a platform for textbook rentals and sales, as well as online tutoring. Tutors are hired and paid hourly. The Revenue of Chegg mainly comes from renting/selling textbooks and membership fees for student to get homework help or tutoring.
### The problem to be solved
High cost of textbooks; students being not able to get extra help for their courses.
### Questions to be answered
- What are the most popular subjects?  
- Who are the most popular tutors?  
- What time intervals are tutors most needed?  
- What time intervals have excess of students/tutors?  
- What are the most popular textbooks?  
- How long should each appointment time last?  

## Assumptions
We are assuming that each customer only has one account and no events occuring at the same time. Tutoring is limited to only practical subjects (cannot help with field work, lab procedures and so on). All hired tutors are professional enough to anwser any on-topic question. Only students request services (rent/buy textbooks, ask for homework help and so on).

## Project Scope
### In scope
Tutor & student data, book data, textbook solutions data, question data and subject data. For example, if a student is renting/buying a book, the database will track which book he/she needs, price data and due date of rented books. If a student is requesting a textbook solutions, the database will track which textbook it is and if the student has the membership. 
### Out of scope
All economic and financial data, such as operational costs, revenue and so on; all random and unpredictable situations, such as running status of the server.

## Design Approach
- `Tutor`: __tutorName__, degree, majors, ratings, reviews and isWorking.
- `Student`: __username__, personalInfo, address and credit card info.
- `Textbook`: __bookID__, book_name, ISBN, author, edition, price and stockAmount.
- `Request`: __requestID__, date and requestType.
- `Order`: __orderID__, order history and costs.

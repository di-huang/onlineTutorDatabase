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
To build a platform for textbook rentals and sales, as well as online tutoring. Revenue orignates from textbook rental/sales and student membership fees.
### The problem to be solved
High cost of textbooks; students being not able to get extra help for their courses.
### Questions to be answered
- What are the most popular subjects?  
- Who are the most popular tutors?  
- What are the most popular textbooks?  
- What are the most needed majors?
- Which testbook generates the most income?
- Who are the least active tutors in answering questions?

## Assumptions
Each customer only has one account. All hired tutors are professional enough to anwser any on-topic question, and one tutor will specialize in only one major. Only students request services (rent/buy textbooks, ask for homework help and so on).

## Project Scope
### In scope
Tutor & student data, book data, textbook solutions data, question data and subject data. For example, if a student is renting/buying a book, the database will track which book he/she needs, price data and due date of rented books. If a student is requesting textbook solutions, the database will track which textbook it is and if the student has the membership. 
### Out of scope
All economic and financial data, such as operational costs, revenue and so on; all random and unpredictable situations, such as running status of the server.

## Design Approach
- `Tutor`: __tutorName__, degree, majors, ratings, and reviews.
- `Student`: __username__, personalInfo and address.
- `Textbook`: __bookID__, book_name, ISBN, author, edition, price.
- `order`: __orderID__, order history, costs and relevant information.
- `book` : __ISBN__, detailed information of book
- `orderAudit`: audit table for all changes to orders
- `payment`: __cardNo__, payment information for each order
- `question`: __questionID__, questions asked by students
- `textbookSolution`: __questionID__, answers to problems in textbooks
- `

## ER Model
![alt text](https://github.com/r2dong/DB-Group6/blob/master/documents/ERModel.png)


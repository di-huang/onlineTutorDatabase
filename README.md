
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
_Teaching Resource Database_: A relational database for online tutoring sites such as Chegg is built using MySQL. Such sites provide competitive rent and buy options, and they also connects students and tutors. For example, students can get help on homework from tutors. 

## Requirements
### The business purpose
To build a database that supports platforms for textbook rentals and sales, as well as online tutoring. Revenue orignates from textbook rental/sales and student membership fees.
### The problem to be solved
High cost of textbooks; students being not able to get extra help for their courses.
### Questions to be answered
- What are the most popular subjects?  
- Who are the most popular tutors?  
- What are the most popular textbooks?  
- What are the most needed majors for tutors?
- Which testbook generates the most income?
- Who are the least active tutors in answering questions? 
- Which students have membership? 
- Which tutors are the most active? 
- Which rented books are overdue?

## Assumptions
Each customer only has one account. All hired tutors are professional enough to anwser any on-topic question, and one tutor will specialize in only one major. Only students request services (rent/buy textbooks, ask for homework help and so on).

## Project Scope
### In scope
Tutor & student data, book data, textbook solutions data, question data and subject data. For example, for renting/buying a book, the database tracks price and due dates of books. Similarly, for textbook problem solutions, the database tracks which textbook the problem is from and verfiy that the student has membership. 
### Out of scope
All economic and financial data, such as operational costs, revenue and so on; all random and unpredictable situations, such as running status of the server.

## Schemas:
- `tutor`: __tutorName__, degree, majors, ratings, and reviews.
- `student`: __username__, personalInfo and address.
- `textbook`: __bookID__, book_name, ISBN, author, edition, price.
- `order`: __orderID__, order history, costs and relevant information.
- `book` : __ISBN__, detailed information of book
- `orderAudit`: audit table for all changes to orders
- `payment`: __cardNo__, payment information for each order
- `question`: __questionID__, questions asked by students
- `textbookSolution`: __questionID__, answers to problems in textbooks
- `orderAudit`: __orderID__, keeps a log of orders

## ER Model at Following Link
![alt text](Design/ERModel(by_drawio).png)


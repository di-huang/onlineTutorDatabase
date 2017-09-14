# DB-Group6
Group Members: &nbsp; `Donny Dong` &nbsp; `Dat Hong` &nbsp; `Di Huang`

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
Chegg is a company that provides textbook rentals. If people want to rent/buy the textbooks online, they will be able to find the cheapest and fastest renting/buying options using this platform. It also serves as a channel between students and tutors, which means students can ask tutors for homework questions through it.

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
- How long should each appointment time lost?  

## Assumptions
We are assuming that each customer only has one account and no events occuring at the same time. Tutoring limited to only practical subjects (cannot help with field work, lab procedures and so on). All hired tutors are professional enough to anwser any on-topic question.

## Project Scope
### In scope
The data to be captured: for all users, we will track the info about personal setting, contact, address, billing info, degree level, academic info, language preferences and so on; for student only, we will track the subjects who need help; for textbooks, we will track stocking info, demand, supply, price and shipping info.
### Out of scope
## Design Approach
For all users, login (email) will be used as key  
- `User`: userName, userType, personalInfo, address and billing, language, ...  
- `Textbook`: name, ISBN, author, edition, price, stockAmount  





import random
import fileparser
import os
from string import ascii_letters
from string import ascii_lowercase
from string import ascii_uppercase
from string import digits

#################### base resourses below ####################
script_dir = os.path.dirname(__file__)

'''question-subjects (stored in QsSubjs)'''
QsSubjs = ['Prealgebra', 'Geometry', 'Algebra', 'Trigonometry', 'Precalculus', 'Calculus', 	
			'Statistics&Probability', 'Advanced Math', 'Other Math',						# Math
			'Physics', 'Chemistry', 'Biology', 'Earth Science', 'Advanced Physics', 
			'Nursing',	'Anatomy&Physiology',												# Science
			'Computer Science', 'Electrical Engineering', 'Mechanical Engineering', 
			'Civil Engineering', 'Chemical Engineering', 									# Engineering
			'Finance', 'Economics', 'Accounting', 'Operations Management',					# Business
			'Psychology'																	# Social Sciences											
			]

'''majors (major -> subjects)'''
Majors = {}
Majors['Math'] = QsSubjs[:9]
for i in range(9, len(QsSubjs)):
	Majors[QsSubjs[i]] = [QsSubjs[i]]

'''names of students and tutors (stored in firstnames and lastnames)'''
firstn_file = os.path.join(script_dir, 'resource/firstnames')
lastn_file = os.path.join(script_dir, 'resource/lastnames')
fileparser.formatnames(firstn_file)
fileparser.formatnames(lastn_file)

with open(firstn_file, 'r') as file:
	# firstnames = file.readlines() # this got newline
	firstnames = file.read().splitlines()
with open(lastn_file, 'r') as file:
	# lastnames = file.readlines()	# this got newline
	lastnames = file.read().splitlines()

'''books' information (0: ISBN, 1: Title, 2: Author(s), 3: Imprint, Edition) | extra: 4: Year'''
bookres = os.path.join(script_dir, 'resource/book2007.xlsx')
ISBN = fileparser.attriColn_book(bookres, 0)
Title = fileparser.attriColn_book(bookres, 1)
Author = fileparser.attriColn_book(bookres, 2)
Imprint = fileparser.attriColn_book(bookres, 3)
Edition = []
for t in Title:
	ed = t[t.find("(")+1 : t.find(")")]
	if "edition" in ed.lower():
		Edition.append(ed)
	else:
		Edition.append(None)
Books = []

for i in range(len(ISBN)):
	b = (ISBN[i], Title[i], Author[i], Imprint[i], Edition[i])
	Books.append(b)

#################### api functions below ####################
'''get a random question-subject'''
def getRanSubj():
	return random.choice(QsSubjs)

'''get a random major'''
def getRanMajorItem():
	return random.choice(list(Majors.items()))

'''get a random name (firstname, lastname)'''
def getRanName():
	fn = random.choice(firstnames)
	ln = random.choice(lastnames)
	while(fn == ln):
		fn = random.choice(firstnames)
	return (fn, ln)

'''get a random book'''
def getRanBook():
	return random.choice(Books)

'''generate length=N number'''
def rannum(length, type_):
	if type_ == 'int':
		res = random.choice(digits[1:])
		res += ''.join(random.choice(digits) for i in range(1,length))
		return res
	return ''.join(random.choice(digits) for i in range(length))

'''generate length=N letters'''
def ranlett(length):
	res = random.choice(ascii_uppercase)
	res += ''.join(random.choice(ascii_lowercase) for i in range(1,length))
	return res

#################### api classes (schemas) below ####################
class Student:
	def make(self):
		self.ID = int(rannum(8, 'int'))
		self.name = getRanName()[0] + ' ' + getRanName()[1]
		self.phone = str(rannum(10, 'int'))
		directions = ['N ','','S ','','E ','','W ']
		self.address = ("%s %s%s St") % (rannum(3, 'str'), 
			random.choice(directions), ranlett(random.randint(3, 7)))
		emails = ['gmail', 'outlook', 'yahoo', 'aol', 'yandex', 'protonmail', 'zoho', 'gmx', 'tutanota', 'tuta', 'mail', 'inbox']
		self.email = ("%s%s@%s.com") % (ranlett(random.randint(5, 7)), 
			rannum(random.randint(1, 5), 'str'), 
			random.choice(emails))
		self.plan = random.choice(['monthly','monthly','yearly','monthly','monthly'])
		self.fee = 0
		if self.plan == 'monthly':
			self.fee += 14.95+random.randint(0, 50)
		else:
			self.fee += 150.0+random.randint(0, 100)
	def info(self):
		return (self.ID, self.name, self.phone, self.address, self.email, self.plan, self.fee)


# print("#################### test-cases below ####################")
# print(getRanSubj())
# print(getRanName())
# print(getRanBook())
# print(getRanMajorItem())
# print(rannum(10, 'int'))
# print(rannum(10, 'str'))
# print(ranlett(random.randint(3, 7)))
# s0 = Student()
# s0.make()
# print(s0.info())


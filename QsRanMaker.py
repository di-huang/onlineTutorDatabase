import pymysql
import random
from sqlfileMaker import *

QsSubjs = ['Algebra', 'Geometry', 'Trigonometry', 'Calculus', 'Advanced Math',	# Math
			'Physics', 'Chemistry', 'Biology', 'Earth Science', 'Nursing',		# Science
			'Computer Science', 'Electrical Engineering', 'Chemical Engineering', # Engineering
			'Finance', 'Accounting', 'Economics', 'Operations Management']		# Business

# change to your db info if you want to test
db = pymysql.connect(host='localhost', port=3306, user='root', passwd='root', db='db_dhuang' )
cursor = db.cursor()

# set autocommit off to be able to rollback your commit
# cursor.execute('set autocommit = 0')
db.autocommit(False)

# fetch all students from student table
cursor.execute('select studentID from student')
res_fetch_stu = cursor.fetchall()
if res_fetch_stu == None or len(res_fetch_stu) == 0:
	exit()

''' 
insert questions randomly
if exe = True, then execute insert-cmds and make sql files 
else then only make sql files
'''
def exe_makefile(exe):
	N = int(input('\nHow many questions you want to insert? '))		# the num of Qs to be inserted
	iniN = 100000				# initial question id number to start (default: 100000)
	sql = 'select questionID from questions order by questionid desc limit 1'
	cursor.execute(sql)
	res = cursor.fetchone()
	if res != None and len(res) != 0:
		iniN = int(res[0])+1

	fm = fileMaker('InsertQuestions.sql')
	fm.makehead('questions')

	# question format: qid, sid, qsubj, qcont
	for qid in range(iniN, iniN+N):
		sid = random.choice(res_fetch_stu)[0]
		qsubj = random.choice(QsSubjs)
		if exe:
			sql = ("insert into questions values "
				"('%d', '%d', '%s', '%s')") % (qid, int(sid), qsubj, 'question content')
			cursor.execute(sql)
		fm.makebody(('%d', '%d', '%s', '%s'), (qid, int(sid), qsubj, 'question content'))

	fm.makeend()
	if exe:
		db.commit()
		# rollback if you want
		#cursor.execute('rollback')
	print('Completed!')
# only make sql files
# exe_makefile(False)
# execute insert cmds and make sql files 
exe_makefile(True)


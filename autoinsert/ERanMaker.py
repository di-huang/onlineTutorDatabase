import pymysql
import random
from resource import *
from sqlfileMaker import *

'''Automatically generate a sql file which does N times insert-random-value operations'''
# change to your db info if you want to test
db = pymysql.connect(host='localhost', port=3306, user='root', passwd='root', db='db_dhuang' )
cursor = db.cursor()

# set autocommit off to be able to rollback your commit
# cursor.execute('set autocommit = 0')
db.autocommit(False)

''' 
insert entities randomly
if exe = True, then execute insert-cmds and make sql files 
else then only make sql files
'''
def insertquestions(exe):
	# fetch all students from student table
	cursor.execute('select studentID from student')
	res_fetch_stu = cursor.fetchall()
	if res_fetch_stu == None or len(res_fetch_stu) == 0:
		exit()
	N = int(input('\nHow many questions you want to insert? '))		# the num of Qs to be inserted
	iniN = 100000				# initial question id number to start (default: 100000)
	sql = 'select questionID from questions order by questionid desc limit 1'
	cursor.execute(sql)
	res = cursor.fetchone()
	if res != None and len(res) != 0:
		iniN = int(res[0])+1

	fm = fileMaker('InsertQuestions.sql')
	fm.makehead('question')
	# question format: qid, sid, qsubj, qcont
	for qid in range(iniN, iniN+N):
		sid = random.choice(res_fetch_stu)[0]
		qsubj = random.choice(QsSubjs)
		if exe:
			sql = ("insert into question values "
				"('%d', '%d', '%s', '%s')") % (qid, int(sid), qsubj, 'question content')
			cursor.execute(sql)
		fm.makebody(('%d', '%d', '%s', '%s'), (qid, int(sid), qsubj, 'question content'))
	fm.makeend()
	if exe:
		db.commit()
		# rollback if you want
		#cursor.execute('rollback')
	print('Completed!')

def insertstudents(exe):
	N = int(input('\nHow many students you want to insert? '))
	fm = fileMaker('InsertStudents.sql')
	fm.makehead('student')
	S = Student()
	for i in range(N):
		if exe:
			sql = ("insert into student values "
				"('%d','%s','%s','%s','%s','%s','%d')")%(S.ID, S.name, S.phone, S.address, S.email, S.plan, S.fee)
			cursor.execute(sql)
		S.make()
		fm.makebody(('%d','%s','%s','%s','%s','%s','%d'), 
			(S.ID, S.name, S.phone, S.address, S.email, S.plan, S.fee))
	fm.makeend()
	if exe:
		db.commit()
		# rollback if you want
		cursor.execute('rollback')
	print('Completed!')


# print("#################### test-cases below ####################")
# only make sql files
insertquestions(False)
# execute insert cmds and make sql files 
# insertquestions(True)
insertstudents(False)

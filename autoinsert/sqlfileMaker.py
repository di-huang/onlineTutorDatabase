import os

'''
Generate insert-into test cases for a particular table and 
store them in a specific sql file.
Run the created sql file by the following format:
mysql> source (.../filename.sql, including the explicit path)
Actually, you may be able to drag the created sql file into the terminal 
and get the full path. Take my MacOS for example:
mysql> source /Users/dihuang/Desktop/db_tst/db_dhuang/xxx.sql
'''
class fileMaker():

	def __init__(self, filename='InsertDefault.sql'):
		self.filename = filename
		self.file = open(filename, 'a+')

	def makehead(self, target=''):				
		self.file.write('insert into %s values \n' % target)
		
	def makebody(self, format=(), values=()):
		sql =  self.doformat(format) % values
		sql += ",\n"
		self.file.write(sql)

	def makeend(self):
		self.file.close()
		self.file = open(self.filename, 'rb+')
		self.file.seek(-2, os.SEEK_END)
		self.file.truncate()
		self.file.close()
		self.file = open(self.filename, 'a+')
		self.file.write(";\n")
		self.file.close()

	def doformat(self, format=()):
		res = "("
		for f in format:
			if f == '%s' or f == '%t':
				res += '"%s", '
			else:
				res += "%s, "
		res = res[:len(res)-2]		# remove the last comma and space
		res += ")"
		return res

'''TestCases below
The symbol '%' used here is just for clarification, there's only difference between 
'%s' and non-'%s' actually
%s: string
%d: decimal (int, float, double)
%b: boolean
%t: datetime
''' 
# fm = fileMaker('InsertTestcases.sql')
# fm.makehead('testcase')
# fm.makebody(('%s', '%s', '%b', '%s'), ('1001', '1001', 'True', 'content'))
# fm.makebody(('%s', '%s', '%s', '%s', '%d'),
# 	("0439708184", "Harry Potter and the Sorcerer's Stone", "J.K. Rowling", "p2", 1.01))
# fm.makebody(('%d', '%d', '%d', '%s', '%t', '%d', '%s'),
# 	(111, 1001, 1111222233334444, "textbook", '2017-11-22 23:10:22', 87, "pending"))
# fm.makeend()

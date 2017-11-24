import os

'''
Make input=N insert-into cases for particular table and 
store them in a specific sql file
'''
class fileMaker():

	def __init__(self, filename='insert.sql'):
		self.filename = filename
		self.file = open(filename, 'w+')

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
			if f == '%s':
				res += '"%s", '
			else:
				res += "%s, "
		res = res[:len(res)-2]		# remove the last comma and space
		res += ")"
		return res

# fm = fileMaker('InsertTestcases.sql')
# fm.makehead('testcase')
# fm.makebody(('%s', '%s', '%b', '%s'), ('1001', '1001', 'True', 'content'))
# fm.makebody(('%s', '%s', '%s', '%s'), ('1002', '1002', 'Math', 'content'))
# fm.makebody(('%d', '%s', '%s', '%s'), ('1003', '1003', 'Math', 'content'))
# fm.makeend()

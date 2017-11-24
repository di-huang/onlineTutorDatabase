import os

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
				f = "'%s',"
			res += f
		res = res[:len(res)-1]		# remove the last comma
		res += ")"
		return res

# fm = fileMaker('InsertQuestions.sql')
# fm.makehead('questions')
# fm.makebody(('%s', '%s', '%s', '%s'), ('1000', '44', 'Math', 'content'))
# fm.makebody(('%s', '%s', '%s', '%s'), ('1001', '44', 'Math', 'content'))
# fm.makebody(('%s', '%s', '%s', '%s'), ('1002', '44', 'Math', 'content'))
# fm.makeend()

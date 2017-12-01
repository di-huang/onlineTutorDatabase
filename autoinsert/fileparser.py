import xlrd
import os

'''a function to format all names (e.g. "Amy") in a specific file'''
def formatnames(filename):
	with open(filename, 'r') as file:
		read_data = file.readlines()
	with open(filename, 'w+') as file:
		for line in read_data:
			ns = line[0].upper() + line[1:].lower()
			file.write(ns)
	pass

'''a function to get attribute-column list of a specific xlsx file'''
def attriColn_book(filename, attriIndex):		# filename = 'book2007.xlsx'
	coln = []
	workbook = xlrd.open_workbook(filename)
	i = os.path.splitext(filename)[0].rfind('/')
	sheet = workbook.sheet_by_name(os.path.splitext(filename)[0][i+1:])
	isbn = False
	if attriIndex == 0:
		isbn = True
	for r in range(1, sheet.nrows):
		row = sheet.row_values(r)
		# coln.append(sheet.cell(r, attriIndex))	# it contains tag
		if isbn:
			coln.append(int(row[attriIndex]))
		else:
			coln.append(row[attriIndex])
	return coln

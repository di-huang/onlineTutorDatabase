import MySQLdb

s = """ %s """

def index(req):
   message = "<html><head><title>Group 6 Python Script</title></head>\n"
   # connect
   dbcnx = MySQLdb.connect(host="dbdev.cs.uiowa.edu",port=3306,user="rdong6",passwd="gEYiYXJuZV.d",db="db_rdong6")
   
   sqlquery="""SELECT studentID FROM student;"""
   
   # create a database cursor
   cursor = dbcnx.cursor()
   
   # execute SQL select 
   cursor.execute(sqlquery)
   
   message += "<h2> %s </h2>"
   message %= sqlquery
   message += "<table><tr><th>Name</th><th>Salary</th><th>dno</th></tr>\n"
   
   # get the number of rows in the resultset
   numrows = int(cursor.rowcount)
   
   # get and display one row at a time
   for x in range(0,numrows):
       row = cursor.fetchone()
       message += "<tr><td> %s </td>\n"
       message %= row[0]
       message += "    <td></td></tr>\n"
 
   message += "</table>\n"
   message += "</body></html>\n"
   cursor.close ()
   dbcnx.close ()
   return s % (message)

import MySQLdb
def application(environ, start_response):
    status = '200 OK'
    output = '<html><head><title>Sample Python Script</title></head>\n'

    # connect
 #   dbcnx = MySQLdb.connect(host="dbdev.cs.uiowa.edu",port=3306,user="dbdevtest",passwd="XiuyD=jP",db="WorksOn")
    dbcnx = MySQLdb.connect(host="dbdev.cs.uiowa.edu",port=3306,user="dthong",passwd="BGUqtsurr8Q0",db="db_dthong")    

    #sqlquery = 'select * from book;'  
    sqlquery = 'SELECT tutorID, tutorName, major, questionsAnswered FROM (SELECT tutorID, questionsAnswered FROM (SELECT tutorID, count(tutorID) AS questionsAnswered FROM ( (SELECT tutorID FROM questionAnsweredBy t1 ) UNION ALL (SELECT tutorID FROM expertAnswerGivenBy t2 ) UNION ALL (SELECT tutorID FROM textbookSolutionGivenBy t3 ) ) t4 GROUP BY tutorID ) t5 WHERE (questionsAnswered <= ALL (SELECT count(tutorID) AS questionsAnswered2 FROM ( (SELECT tutorID FROM questionAnsweredBy t6 ) UNION ALL (SELECT tutorID FROM expertAnswerGivenBy t7 ) UNION ALL (SELECT tutorID FROM textbookSolutionGivenBy t8 ) ) t9 GROUP BY tutorID ) ) ) nj1 NATURAL JOIN (SELECT tutorID, tutorName, major FROM tutor t11 ) nj2;'
    # create a database cursor
    cursor = dbcnx.cursor()
   
    # execute SQL select 
    cursor.execute(sqlquery)
    
    output += "<h2> %s </h2>"
    output %= sqlquery
    output += "<table><tr>"   

    # get the number of rows in the resultset
    numrows = int(cursor.rowcount)
    
    # get column list
    num_fields = len(cursor.description)
    field_names = [i[0] for i in cursor.description]

    # get and display one row at a time
    for i,e in enumerate(field_names):
       output += "<th>" + str(e) + "</th>"
    output+="</tr>\n"        
    output+="<tr>"
    for x in range(0,numrows):
       row = cursor.fetchone()
       for i,e in enumerate(field_names):
          output += "<td>%s</td>"
          output %= row[i]
       output +="</tr>\n"
   
    output += "</table>\n"
    output += "</body></html>\n"
    
    cursor.close ()
    dbcnx.close ()

    response_headers = [('Content-type', 'text/html'),
                        ('Content-Length', str(len(output)))]

    start_response(status, response_headers)

    return [output]


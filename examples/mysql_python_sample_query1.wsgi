import MySQLdb
def application(environ, start_response):
    status = '200 OK'
    output = '<html><head><title>Sample Python Script</title></head>\n'

    # connect
 #   dbcnx = MySQLdb.connect(host="dbdev.cs.uiowa.edu",port=3306,user="dbdevtest",passwd="XiuyD=jP",db="WorksOn")
    dbcnx = MySQLdb.connect(host="dbdev.cs.uiowa.edu",port=3306,user="dthong",passwd="BGUqtsurr8Q0",db="db_dthong")    

    #sqlquery = 'select * from book;'  
    sqlquery = 'SELECT major, count(*) AS questionsSolved FROM ( (SELECT major FROM (SELECT tutorID FROM questionAnsweredBy t1 ) nj1 NATURAL JOIN (SELECT tutorID, major FROM tutor t2 ) nj2 ) UNION ALL (SELECT major FROM (SELECT tutorID FROM expertAnswerGivenBy t3 ) nj3 NATURAL JOIN (SELECT tutorID, major FROM tutor t4 ) nj4 ) UNION ALL (SELECT major FROM (SELECT tutorID FROM textbookSolutionGivenBy t5 ) nj5 NATURAL JOIN (SELECT tutorID, major FROM tutor ) nj6 ) ) u GROUP BY major;'
    
    sqlqueryhtml = ' <html>   <body>   <UL style="list-style-type:none">   <LI> SELECT major, count(*) AS questionsSolved   <LI> FROM   <UL style="list-style-type:none">   <LI> (SELECT major   <LI> FROM   <UL style="list-style-type:none">   <LI> (   <UL style="list-style-type:none">   <LI> (SELECT tutorID   <LI> From questionAnsweredBy   <LI> )   <LI> UNION ALL   <LI> (SELECT tutorID   <LI> From textbookSolutionGivenBy   <LI> )   <LI> (SELELCT tutorID   <LI> FROM questionAnsweredBy   </UL>   <LI> ) nj1   <LI> NATURAL JOIN   <LI> (SELECT tutorID, major   <LI> FROM tutor   <LI> ) nj2   </UL>   <LI> ) t1   </UL>   <LI> GROUP BY major   <LI> ;   </UL>   </body>  </html> '

    # create a database cursor
    cursor = dbcnx.cursor()
   
    # execute SQL select 
    cursor.execute(sqlquery)
    
    output += "<h2> %s </h2>"
    output %= sqlqueryhtml
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


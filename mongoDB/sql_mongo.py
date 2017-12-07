import pymysql                  # NOTE: change this to "import MySQLdb" if you are using python 2.x
from filemaker import *

# NOTE: change to your db info if you want to test
db = pymysql.connect(host='localhost', port=3306, user='root', passwd='root', db='db_dhuang' )
cursor = db.cursor()

def translate(destfile):
    fm = filemaker(destfile)
    cursor.execute('show tables')
    tables = cursor.fetchall()
    fm.make('create table', tables)

    for t in tables:
        cursor.execute('show columns from %s' % t)
        raw_attributes = cursor.fetchall()
        attributes = [ raw_attributes[i][0] for i in range(len(raw_attributes)) ]
        cursor.execute('select * from %s' % t)
        inserted = cursor.fetchall()
        if len(inserted) == 0:
            continue
        fm.make('insert into', t, attributes, inserted[0])

    fm.makeend()

translate('mongo.sql')



















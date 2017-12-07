

class filemaker():
    def __init__(self, filename='mongo.sql'):
        self.file = open(filename, 'a+')

    def make(self, format, data0=[], data1=[], data2=[]):
        if 'create table' in format.lower():
            [self.file.write('db.createCollection("%s")\n' % d) for d in data0] 
        if 'insert into' in format.lower():
            body = ''
            for i in range(len(data1)):
                a, d = data1[i], data2[i]
                if type(d) == int or type(d) == float or type(d) == bool:
                    body += a + ': ' + str(d) + ', '
                else:
                    body += a + ': ' + '"%s"' % d + ', '
            body = body[:-2]
            if type(a) == str:
                self.file.write("db.%s.insert({%s})\n" % (data0[0], body))
        self.file.write('\n')

    def makeend(self):
        self.file.close()

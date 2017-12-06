import re

def removeSpace(fileName):
    
    # set up regex splitter
    regex = "[\t\r\n\s+]+"
    splitter = re.compile(regex)
    
    # split file
    myFile = open(fileName, "r")
    strToWrite = ""
    for line in myFile:
        words = splitter.split(line)
        for word in words:
            strToWrite += word + " "
    myFile.close()
    
    oldName = fileName[0:fileName.find(".")] 
    extension = fileName[fileName.find("."):]
    outFileName = oldName + "Flattened" + extension
    outFile = open(outFileName, "w")
    outFile.write(strToWrite)
    outFile.close()

removeSpace("activityByMajor.html")
removeSpace("bestSellingBooks.html")
removeSpace("leastActiveTutors.html")

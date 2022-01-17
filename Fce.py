import random


class adfgvx():
    table5 = ["A", "D", "F", "G", "X"]
    table6 = ["A", "D", "F", "G", "V", "X"]
    def __init__(self, string, key1, key2, encode = True):
        self.key1 = key1
        self.key2 = self.key2toList(key2)
        self.myStr = string
        self.key1Dict = self.makeDict(self.key1)
        self.output = ""
        if encode:
            self.enc()
        else:
            self.dec()

    def key2toList(self, key2):
        myList =[]
        for i in key2:
            tmp = 0
            for j in myList:
                if i in j:
                    tmp += 1
            myList.append(i + str(tmp))
        return myList

    def makeDict(self, str): #  char : number
        myRet = {}
        for i in range(len(str)):
            myRet[str[i]] = i
        return myRet

    def enc(self):
        text = self.myStr
        list = []
        subs = ""
        trans = {}

        if len(self.key1) == 25:
            myDict = self.table5
        else:
            myDict = self.table6
        for i in text:
            list.append(self.key1Dict[i])
        #subs
        for i in list:
            subs += myDict[i //len(myDict)] #row
            subs += myDict[i % len(myDict)] #column
        #trans
        for i in self.key2:
            trans[i] = ""
        for i in range(len(subs)):
            trans[self.key2[i % len(self.key2)]] += subs[i]
        newKey2 = self.key2
        newKey2.sort()
        for i in newKey2:
            self.output += trans[i]
    
    def dec(self):
        text = self.myStr
        text = [char for char in text]
        mylist = []
        subs = ""
        trans = {}
        transList = self.key2.copy()
        partColumns =[]
        partColumn = len(text) % len(self.key2)
        if partColumn:
            partColumns = transList[partColumn:]
        transList.sort()

        if len(self.key1) == 25:
            myDict = self.table5
        else:
            myDict = self.table6
        for i in self.key2:
            trans[i] = ""

        # reverse transposition
        row =len(text) // len(self.key2)
        counter = 0
        last = 0
        isSymetric = len(partColumns) == 0
        if isSymetric:
            for i in range(len(self.key2)):
                oldLast = last
                last = last + row
                for j in range(oldLast,last):
                    tmp = transList[counter % len(transList)]
                    trans[tmp] += text[j]
                counter += 1
        else:
            for i in range(0,len(text),row):
                if transList[counter % len(transList)] in partColumns:
                    oldLast = last
                    if oldLast != len(text):
                        last = last + row
                        wasShort = True
                        for j in range(oldLast,last):
                            tmp = transList[counter % len(transList)]
                            trans[tmp] += text[j]
                else:
                    oldLast = last
                    if oldLast != len(text):
                        last = last + row + 1
                        for j in range(oldLast, last):
                            tmp = transList[counter % len(transList)]
                            trans[tmp] += text[j]
                counter +=1

        # back to normal position
        tmpList = []
        zCount = -1
        tmpString = ""
        finalString = ""
        for i in self.key2:
            tmpList.append(trans[i])
        for i in range(len(text)):
            if i % len(tmpList) == 0:
                zCount +=1
            tmpString = tmpList[i % len(tmpList)]
            finalString += tmpString[zCount]
        
        # back to chars
        for i in range(0,len(finalString), 2):
            a = finalString[i]
            b = finalString[i + 1]
            a =  myDict.index(a)
            b = myDict.index(b)
            char = a * len(myDict) + b
            char = self.key1[char]
            self.output += char


            
#test = adfgvx("PRILIS ZLUTOUCKY KUN UPEL DABELSKE ODY", ['H', 'O', 'V', 'C', 'L', 'A', 'Y', 'M', 'W', 'N', 'G', 'U', 'Q', 'I', 'R', 'P', 'S', 'D', 'X', 'F', 'T', 'E', 'Z', 'B', 'K', " ", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"], "Pepa").output
#print(test)
#print(adfgvx(test, ['H', 'O', 'V', 'C', 'L', 'A', 'Y', 'M', 'W', 'N', 'G', 'U', 'Q', 'I', 'R', 'P', 'S', 'D', 'X', 'F', 'T', 'E', 'Z', 'B', 'K', " ", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"], "Pepa", False).output)
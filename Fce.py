from os import name


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


def genKeyPicture(nameKey1, key1, nameKey2, key2, nameSpace, space):
    size = 5
    if len(key1) == 36:
        size = 6
    bgCol = "#201e1b"
    bg2Col="#acb1aa"
    borderCol = "#3fa108"
    fontWhite = "#e4f8ff"
    fontBlack = "#1a1512"
    Spc = " " * 4
    svg = "<?xml version='1.0' standalone='yes'?>\n" \
        f"{Spc}<svg version='1.1'\n"\
        f"{Spc * 2}width='{size * 100 + 10}' height='1000'\n"\
        f"{Spc * 2}xmlns='http://www.w3.org/2000/svg'>\n\n"\
        f"{Spc}<style type='text/css'>\n"\
        f"{Spc * 2}@font-face "\
        "{\n"\
        f"{Spc * 3}font-family: 'Fira Code', monospace;\n"\
        f"{Spc * 3}rc: url('fonts/FiraCode-Medium.ttf');\n"\
        f"{Spc * 2}"\
        "}\n"\
        f"{Spc}</style>\n\n"\
        f"{Spc}<rect width='{size * 100 + 10}' height='{size * 100 + 480}' x='0' y='0' fill='{bg2Col}'/>\n\n"\
        f"{Spc}<text x='{(size * 100 + 10) /2 }' y='{40}' font-size='48'"\
        f" dominant-baseline='middle' text-anchor='middle' ext-anchor='middle' font-family="\
        f"'Fira Code' fill='{fontBlack}'>{nameKey1}</text>\n\n"\
        f"{Spc}<rect width='{size}00' height='{size}00' x='5' y='75' fill='{bgCol}'/>\n\n"
    for i in range(size):
        for j in range(size):
            svg += f"{Spc}<rect width='100' height='100' x='{i * 100+5}' y='{j * 100+75}'"\
                    f" fill='{bgCol}' stroke='{borderCol}' stroke-width='10'/>\n" \
                    f"{Spc}<text x='{i * 100 + 39}' y='{j * 100 + 142}' font-size='48'"\
                    "ext-anchor='middle' font-family="\
                    f"'Fira Code' fill='{fontWhite}'>{key1[i * size + j]}</text>\n"
    
    svg += f"\n{Spc}<text x='{(size * 100 + 10) /2 }' y='{140 + 100 * size}' font-size='48'"\
        f" dominant-baseline='middle' text-anchor='middle' ext-anchor='middle' font-family="\
        f"'Fira Code' fill='{fontBlack}'>{nameKey2}</text>\n\n"\
        f"{Spc}<rect width='{size * 100}' height='100' x='{5}' y='{175 + 100 * size}'"\
        f" fill='{bgCol}' stroke='{borderCol}' stroke-width='10'/>\n" \
        f"{Spc}<text x='{(size * 100 + 10) /2 }' y='{225 + 100 * size}' font-size='48'"\
        f" dominant-baseline='middle' text-anchor='middle' ext-anchor='middle' font-family="\
        f"'Fira Code' fill='{fontWhite}'>{key2}</text>\n\n"\
        f"{Spc}<text x='{(size * 100 + 10) /2 }' y='{340 + 100 * size}' font-size='48'"\
        f" dominant-baseline='middle' text-anchor='middle' ext-anchor='middle' font-family="\
        f"'Fira Code' fill='{fontBlack}'>{nameSpace}</text>\n\n"\
        f"{Spc}<rect width='{size * 100}' height='100' x='{5}' y='{375 + 100 * size}'"\
        f" fill='{bgCol}' stroke='{borderCol}' stroke-width='10'/>\n" \
        f"{Spc}<text x='{(size * 100 + 10) /2 }' y='{425 + 100 * size}' font-size='48'"\
        f" dominant-baseline='middle' text-anchor='middle' ext-anchor='middle' font-family="\
        f"'Fira Code' fill='{fontWhite}'>{space}</text>\n\n"\
        "</svg>"
    return svg

def ToSysPath(file):
    # windows
    if name == "nt":
        return file[8:]
    # unix
    else:
        return file[7:]



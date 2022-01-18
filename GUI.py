import os
import random
import sys

from PySide6.QtCore import *
from PySide6.QtCore import QObject, Signal, Slot
from PySide6.QtGui import *
from PySide6.QtQml import *
from PySide6.QtWidgets import *

import Fce
from Lang import appLang


class GetData(QObject):
    def __init__(self):
        QObject.__init__(self)

    randomized = Signal(list)
    solution = Signal(str)
    key1 = Signal(list)
    key2 = Signal(str)
    text = Signal(str)
    space = Signal(str)
    myInputText = Signal(str)

    @Slot(str)
    def sendRandom(self, abc):
        abc = list(abc)
        random.shuffle(abc)
        self.randomized.emit(abc)
    
    @Slot(str, list, str, str)
    def encodeText(self, text, key1, key2, space):
        self.text.emit(text)
        newtext = text.replace(" ", space)
        output = Fce.adfgvx(newtext, key1, key2, True).output
        self.solution.emit(output)
        self.key1.emit(key1)
        self.key2.emit(key2)
        self.space.emit(space)

    @Slot(str, list, str, str)
    def decodeText(self, text, key1, key2, space):
        self.solution.emit(text)
        text = text.replace(" ", "")
        output = Fce.adfgvx(text, key1, key2, False).output
        output = output.replace(space, " ")
        self.text.emit(output)
        self.key1.emit(key1)
        self.key2.emit(key2)
        self.space.emit(space)

    @Slot(str)
    def verifyText(self, file):
        myPath = Fce.ToSysPath(file)
        with open(myPath, "r") as f:
            content = f.read()
        self.myInputText.emit(content)

    nameRandom  = Signal(str)
    nameKey1  = Signal(str)
    nameKey2 = Signal(str)
    nameTypeHere = Signal(str)
    nameChoseFile = Signal(str)
    nameFile = Signal(str)
    nameFileUnchosed = Signal(str)
    nameSpcRpl = Signal(str)
    nameEncode = Signal(str)
    nameDecode = Signal(str)
    nameSpecChar = Signal(str)
    nameWhyEnDe = Signal(str)
    nameEmpty = Signal(str)
    nameEncodeTxt = Signal(str)
    nameOpenText = Signal(str)
    nameSaveTxt = Signal(str)
    nameSaveKeys = Signal(str)
    nameSlctTXT = Signal(str)

    @Slot(str)
    def getLang(self, lang):
        myLang = appLang[lang]
        self.nameRandom.emit(myLang['nameRandom'])
        self.nameKey1.emit(myLang['nameKey1'])
        self.nameKey2.emit(myLang['nameKey2'])
        self.nameTypeHere.emit(myLang['nameTypeHere'])
        self.nameChoseFile.emit(myLang['nameChoseFile'])
        self.nameFile.emit(myLang['nameFile'])
        self.nameFileUnchosed.emit(myLang['nameFileUnchosed'])
        self.nameSpcRpl.emit(myLang['nameSpcRpl'])
        self.nameEncode.emit(myLang['nameEncode'])
        self.nameDecode.emit(myLang['nameDecode'])
        self.nameSpecChar.emit(myLang['nameSpecChar'])
        self.nameWhyEnDe.emit(myLang['nameWhyEnDe'])
        self.nameEmpty.emit(myLang['nameEmpty'])
        self.nameEncodeTxt.emit(myLang['nameEncodeTxt'])
        self.nameOpenText.emit(myLang['nameOpenText'])
        self.nameSaveTxt.emit(myLang['nameSaveTxt'])
        self.nameSaveKeys.emit(myLang['nameSaveKeys'])
        self.nameSlctTXT.emit(myLang['nameSlctTXT'])

class runQML():
    def __init__(self):
        sys_argv = sys.argv
        sys_argv += ['--style', 'Fusion']
        self.app = QApplication(sys_argv)
        app_icon = QIcon()
        app_icon.addFile('icons/TaskBar.svg')
        self.app.setWindowIcon(app_icon)
        QFontDatabase.addApplicationFont('fonts/Poppins-Medium.ttf')
        QFontDatabase.addApplicationFont('fonts/Roboto-Medium.ttf')
        QFontDatabase.addApplicationFont('fonts/FiraCode-Medium.ttf')
        self.engine = QQmlApplicationEngine()

        self.getD = GetData()
        self.engine.rootContext().setContextProperty("myData", self.getD)
        self.engine.load('Main.qml')

    def exec(self):
        if not self.engine.rootObjects():
            return -1
        return self.app.exec()

if __name__ == '__main__':
    GUI = runQML()
    GUI.exec()

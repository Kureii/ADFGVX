import os
import random
import sys

from PySide6.QtCore import *
from PySide6.QtCore import QObject, Signal, Slot
from PySide6.QtGui import *
from PySide6.QtQml import *
from PySide6.QtWidgets import *

import Fce


class GetData(QObject):
    def __init__(self):
        QObject.__init__(self)

    randomized = Signal(list)

    @Slot(str)
    def sendRandom(self, abc):
        abc = list(abc)
        random.shuffle(abc)
        self.randomized.emit(abc)


class runQML():
    def __init__(self, dic= {}):
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

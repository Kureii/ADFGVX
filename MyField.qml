import QtQuick 2.9
import QtQuick.Controls

TextField {
    property color myCol: "transparent"

    id: myField
    selectByMouse: true
    color: myWhiteFont
    enabled: activeWindow
    horizontalAlignment: Text.AlignHCenter
    font.capitalization: Font.AllUppercase
    font.family: "FiraCode Medium"
    placeholderTextColor: Qt.darker(myWhiteFont, 2)
    placeholderText: "○"
    background: Rectangle {
        id: back
        color: "transparent"
        border.width: 3
        border.color: myCol
        radius: 4
    }
    onTextChanged: {
        let myTxt = myField.text
        let tmp = myField.cursorPosition
        myTxt = myTxt.toUpperCase()
        myField.text = myTxt
        myField.cursorPosition = tmp
        if (myTxt.length > 1) {
            myField.text = myTxt[0]
            myTxt = myField.text
        }
        if(fiveSixTab.currentIndex) {

        } else {
            let myAbc = ""
            if (chosAbc.currentIndex == 0) {
                myAbc = solidEngAlpha
            } else if (chosAbc.currentIndex == 1) {
                myAbc = solidCsVAlpha
            } else {
                myAbc = solidCsKAlpha
            }
            veri(key1five, myAbc)
        }
    }
}

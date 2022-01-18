import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQml.Models 2.2
import Qt5Compat.GraphicalEffects
import QtQuick.Dialogs 

Window {
    id: winSol
    visible: true
    width: 600
    height: 450

    color: "transparent"

    flags: Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    function readKey1() {
                
    }

    Flickable {
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds

        Rectangle {
            color: myBackground2
            radius: 8
            border.color: myUpperBar
            border.width: 4
            anchors.fill: parent
            anchors.rightMargin: 12
            anchors.leftMargin: 12
            anchors.bottomMargin: 12
            anchors.topMargin: 12

            GridLayout {
                anchors.fill: parent
                rowSpacing: 0
                columns: 1
                columnSpacing: 2

                Rectangle {
                    width: 200
                    height: 200
                    color: myUpperBar
                    radius: 8
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.maximumHeight: 30
                    Layout.minimumHeight: 30
                    Layout.fillWidth: true

                    Rectangle {
                        width: 200
                        height: 8
                        color: myUpperBar
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                    }

                    RowLayout {
                        anchors.fill: parent

                        MouseArea {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            property variant clickPos: "1,1"
                            onPressed: {
                                clickPos = Qt.point(mouseX, mouseY)
                            }

                            onPositionChanged: {
                                var delta = Qt.point(mouseX - clickPos.x,
                                                     mouseY - clickPos.y)
                                winSol.x += delta.x
                                winSol.y += delta.y
                            }
                        }

                        RowLayout {
                            width: 52
                            Layout.rightMargin: 6
                            layoutDirection: Qt.LeftToRight
                            Layout.columnSpan: 2
                            Layout.fillWidth: false
                            Layout.fillHeight: true
                            spacing: 6

                            Button {
                                id: myClose4
                                width: 20
                                height: 20
                                flat: true
                                Layout.minimumWidth: 20
                                Layout.minimumHeight: 20
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                background: Rectangle {
                                    color: myClose4.pressed ? Qt.darker(myCloseBtn, 1.5) :
                                                              (myClose4.hovered ? myCloseBtn : myUpperBar)
                                    radius: 4
                                    Rectangle {
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: 45
                                        color: myClose4.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }
                                    Rectangle {
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: -45
                                        color: myClose4.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }
                                }
                                onClicked: {
                                    winSol.close()
                                    shifter.value = 1
                                    shifterA.value = 1
                                    shifterB.value = 1
                                    spaceSpin.value = 5
                                    repSpaces.text = ""
                                    repSpaces2.text = ""
                                    keySensitive = false
                                    choseAbcTab.currentIndex = 0
                                    fileDialog.currentFile = ""
                                    inputText.text = ""
                                    fileState.text = textChoseFile
                                    inputText2.text = ""
                                    fileState2.text = textChoseFile
                                    textFileTab.currentIndex = 0
                                    customCircleBig.source = ""
                                    customCircle.source = ""
                                    customCircleBig.source = "icons/BasicBigCircle.png"
                                    customCircle.source = "icons/BasicSmallCircle.png"
                                    activeWindow = true


                                }
                            }
                        }
                    }

                    /*Text {
                        y: 7
                        text: titleSolution
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 30
                        font.family: "Roboto Medium"
                        font.weight: Font.Medium
                        color: myWhiteFont
                    }*/

                    Image {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Image.AlignLeft
                        source: "icons/TaskBar.svg"
                        anchors.leftMargin: 5
                        anchors.topMargin: 5
                        anchors.bottomMargin: 5
                        sourceSize.height: 20
                        sourceSize.width: 20
                    }
                }

                ColumnLayout {
                    width: 100
                    height: 100
                    Layout.topMargin: 4
                    spacing: 0
                    Layout.margins: 12
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Label {
                        text: nameKey1
                        bottomPadding: 0
                        topPadding: 4
                        padding: 8
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        font.family: "Poppins Medium"
                        color:  myUpperBar
                        Layout.minimumHeight: 18
                    }


                    Flickable {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.minimumHeight: 32
                        TextArea.flickable: TextArea {
                            selectByMouse: true
                            visible: true
                            readOnly: true
                            text: key1.join()
                            color: myWhiteFont
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            font.family: "Roboto Medium"
                            background: Rectangle {
                                color: myBackground
                                radius: 8
                            }
                        }

                        ScrollBar.vertical: ScrollBar {}
                    }

                    
                        

                    ColumnLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Label {
                            text: nameKey2
                            bottomPadding: 0
                            topPadding: 4
                            padding: 8
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.family: "Poppins Medium"
                            color:  myUpperBar
                            Layout.minimumHeight: 18
                        }


                        Flickable {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.minimumHeight: 32
                            TextArea.flickable: TextArea {
                                selectByMouse: true
                                visible: true
                                readOnly: true
                                text: fiveSixTab.currentIndex ? key2six.text : key2five.text
                                color: myWhiteFont
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                                font.family: "Roboto Medium"
                                background: Rectangle {
                                    color: myBackground
                                    radius: 8
                                }
                            }

                            ScrollBar.vertical: ScrollBar {}
                        }
                    }

                            
                            
                        
                    

                    Label {
                        text: nameSpcRpl
                        bottomPadding: 0
                        topPadding: 4
                        padding: 8
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        font.family: "Poppins Medium"
                        color:  myUpperBar
                        Layout.minimumHeight: 18
                    }


                    Flickable {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.minimumHeight: 32
                        TextArea.flickable: TextArea {
                            selectByMouse: true
                            visible: true
                            readOnly: true
                            text: specChar
                            color: myWhiteFont
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            font.family: "Roboto Medium"
                            background: Rectangle {
                                color: myBackground
                                radius: 8
                            }
                        }

                        ScrollBar.vertical: ScrollBar {}
                    }
                    
                    Label {
                        text: nameOpenText
                        bottomPadding: 0
                        topPadding: 4
                        padding: 8
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        font.family: "Poppins Medium"
                        color:  myUpperBar
                        Layout.minimumHeight: 18
                    }

                    Flickable {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.minimumHeight: 64
                        TextArea.flickable: TextArea {
                            selectByMouse: true
                            visible: true
                            readOnly: true
                            text: solText
                            color: myWhiteFont
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            font.family: "Roboto Medium"
                            background: Rectangle {
                                color: myBackground
                                radius: 8
                            }
                        }

                        ScrollBar.vertical: ScrollBar {}
                    }
                    

                    Label {
                        text: nameEncodeTxt
                        bottomPadding: 0
                        topPadding: 4
                        padding: 8
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        font.family: "Poppins Medium"
                        color:  myUpperBar
                        Layout.minimumHeight: 18
                    }

                    Flickable {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.minimumHeight: 64
                        TextArea.flickable: TextArea {
                            selectByMouse: true
                            visible: true
                            readOnly: true
                            text: solution
                            color: myWhiteFont
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            font.family: "Roboto Medium"
                            background: Rectangle {
                                color: myBackground
                                radius: 8
                            }
                        }

                        ScrollBar.vertical: ScrollBar {}
                    }

                    RowLayout {
                        Layout.minimumWidth: 150
                        Layout.minimumHeight: 32
                        Layout.fillWidth: true

                        Button {
                            id: svT
                            Layout.topMargin: 8
                            Layout.minimumWidth: 75
                            Layout.minimumHeight: 32
                            Layout.fillWidth: true
                            onClicked: {
                                saveDialog.visible = true
                            }
                            background: Rectangle {
                                anchors.fill: parent
                                color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
                                radius: 8
                                Label{
                                    text: nameSaveTxt
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Roboto Medium"
                                    color: svT.down ? myUpperBar : (svT.hovered ? Qt.darker(myWhiteFont, 1.25) :myWhiteFont)
                                }
                            }
                        }
                        Button {
                            id: svI
                            Layout.topMargin: 8
                            Layout.minimumWidth: 75
                            Layout.minimumHeight: 32
                            Layout.fillWidth: true
                            onClicked: {
                                saveImgDialog.visible = true
                            }
                            background: Rectangle {
                                anchors.fill: parent
                                color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
                                radius: 8
                                Label{
                                    text: nameSaveKeys
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Roboto Medium"
                                    color: svI.down ? myUpperBar : (svI.hovered ? Qt.darker(myWhiteFont, 1.25) :myWhiteFont)
                                }
                            }
                        }

                    }




                }
            }
        }

        Rectangle {
            id: winSolGlow
            color: "#cf018500"
            radius: 8
            anchors.fill: parent
            anchors.rightMargin: 12
            anchors.leftMargin: 12
            anchors.bottomMargin: 12
            anchors.topMargin: 12
            z: -1
        }
        FastBlur {
            anchors.fill: winSolGlow
            radius: 12
            transparentBorder: true
            source: winSolGlow
            z: -1
        }

        FileDialog {
            id: saveDialog
            visible: false
            nameFilters: [nameSlctTXT]
            fileMode: FileDialog.SaveFile
            onAccepted: {
                myData.getSaveFile(saveDialog.currentFile)
                winSol.close()
            }
            onRejected: saveDialog.currentFile = ""
        }
        FileDialog {
            id: saveImgDialog
            visible: false
            nameFilters: nameSaveImg
            fileMode: FileDialog.SaveFile
            onAccepted: {
                myData.getSaveImg(saveDialog.currentFile)
                winSol.close()
            }
            onRejected: saveDialog.currentFile = ""
        }
    }
}

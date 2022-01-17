import QtQuick 2.9
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQuick.Timeline 1.0 
import QtQuick.Dialogs

GridLayout {
    id: app
    anchors.fill: parent
    rowSpacing: 0
    columnSpacing: 0
    columns: 1
    clip: true
    
    property string sizeText: "Size"
   
    // size title
    Label {
        color: myWhiteFont
        text: sizeText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        Layout.columnSpan: parent.columns
        bottomPadding: 8
        topPadding: 8
        Layout.bottomMargin: 0
        Layout.topMargin: 0
        Layout.margins: 0
        Layout.fillWidth: true
        font.family: "Roboto Medium"
        background: Rectangle {color: myBackground}
    }

    //size tab
    TabBar {
        id: fiveSixTab
        height: 35
        enabled: activeWindow
        position: TabBar.Footer
        currentIndex: 0
        Layout.fillHeight: false
        Layout.columnSpan: parent.columns
        font.family: "Roboto Medium"
        Layout.rightMargin: 0
        Layout.leftMargin: 0
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.fillWidth: true

        // 5x5
        TabButton {
            id: fiveBtn
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            bottomPadding: 18
            padding: 8
            background: Rectangle {
                color: parent.hovered && activeWindow ? Qt.lighter( myBackground, 2) : myBackground
                anchors.fill: parent
                Label {
                    text: "5 × 5"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: fiveSixTab.currentIndex == 0 ? -2 : 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: parent.parent.hovered && activeWindow ? Qt.lighter(myWhiteFont, 2) : myWhiteFont
                }

                Rectangle {
                    height: 4
                    color: fiveSixTab.currentIndex == 0 ? myHighLighht : (parent.parent.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                }
            }
            onClicked: {
                stack.pop(five)
            }
        }

        // 6x6
        TabButton {
            id: sixBtn
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            bottomPadding: 18
            padding: 8
            background: Rectangle {
                color: parent.hovered && activeWindow ? Qt.lighter(myBackground,2) : myBackground
                anchors.fill: parent
                Label {
                    text: "6 × 6"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: fiveSixTab.currentIndex == 1 ? -2 : 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: parent.parent.hovered && activeWindow ? Qt.lighter(myWhiteFont, 2) : myWhiteFont
                }

                Rectangle {
                    height: 4
                    color: fiveSixTab.currentIndex == 1 ? myHighLighht : (parent.parent.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                }
            }
            onClicked: {
                stack.push(six)
            }
        }
    }

    StackView {
        id: stack
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.columnSpan: parent.columns
        initialItem:five
        
    }

    Five {
        id: five
        visible: true
    }

    Six {
        id: six
        visible: false
    }


}

/*##^##
Designer {
    D{i:0;autoSize:true;height:0;width:316}
}
##^##*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQuick.Timeline 1.0 
import QtQuick.Dialogs

GridLayout {
    Layout.fillHeight: true
    Layout.fillWidth: true
    rows: 2
    columns: 2

    Component.onCompleted: {
        makeSix()
        //makeAlpha()
    }


    RowLayout {
        height: 24
        Layout.columnSpan: 2
        Layout.fillWidth: true
        Layout.topMargin: 8
        Layout.leftMargin: 32
        Layout.rightMargin: 32


        // alphabet
        TextField {
            id: alphaSix
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: 0
            Layout.rightMargin: 0
            Layout.maximumHeight: 24
            Layout.minimumHeight: 24
            selectByMouse: true
            color: myWhiteFont
            text: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            enabled: activeWindow
            horizontalAlignment: Text.AlignHCenter
            font.capitalization: Font.AllUppercase
            font.family: "Roboto Medium"
            placeholderTextColor: Qt.darker(myWhiteFont, 2)
            placeholderText: nameTypeHere
            validator: RegularExpressionValidator { regularExpression:  /^[a-zA-Zá-žÁ-Ž0-9 .-_/!?()]+$/ }
            background: Rectangle {
                id: key2sixVer2
                color: myBackground
                border.width: 3
                border.color: "transparent"
                radius: 8
            }
            
            onTextChanged: {
             if(alphaSix.text != "") {
                let tmp = alphaSix.cursorPosition
                let myKey = alphaSix.text

                myKey = myKey.toUpperCase()
                myKey = String.prototype.concat(...new Set(myKey))
                if (myKey.length == 0) {
                    key2sixVer2.border.color = myCloseBtn
                } else if (myKey.length > 0 && myKey.length < 36){ 
                    key2sixVer2.border.color = "#F9D800"
                } else {
                    key2sixVer2.border.color = myHighLighht
                    myKey = myKey.substring(0,36)
                }
                alphaSix.text = myKey
                alphaSix.cursorPosition = tmp
                }   
            }
        }

        Label {
            font.family: "Roboto Medium"
            color: myUpperBar
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: 16
            Layout.topMargin: 0
            text: newText()
            function newText() {
                let i = alphaSix.text
                let len = i.length
                return len + "/36"
            }
        }
        
    }

    ColumnLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.maximumWidth:252

        // key 1 text
        Label {
            text: nameKey1
            font.family: "Roboto Medium"
            color: myUpperBar
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        // key 1
        Rectangle {
            id: key1size2
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumHeight: 235
            Layout.maximumWidth: 273
            Layout.minimumHeight: 235
            Layout.minimumWidth: 273
            Layout.leftMargin: 8
            Layout.topMargin: -4
            radius: 8
            color: myBackground
            
            Rectangle {
                height: 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                color: parent.color
            }

            GridLayout {
                id: key1six
                anchors.fill: parent
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.bottomMargin: 5
                anchors.topMargin: 5
                rows: 6
                columns: 6

            }
        }

        // key 1 random
        Button {
            Layout.fillHeight: true
            Layout.topMargin: -5
            Layout.leftMargin: 8
            Layout.bottomMargin: 8
            Layout.fillWidth: true
            Layout.minimumHeight: 24
            Layout.maximumWidth: key1size2.width
            enabled: alphaSix.text.length == 36
            ToolTip {
                text: nameTTRnd
                visible: parent.hovered && !parent.enabled
                background: Rectangle {
                    color: myBackground2
                    border.color: myHighLighht
                    radius: 4
                    
                    Label {
                        color: "#F9D800"
                        font.pointSize: 12
                        font.family: "Roboto Medium"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 2
                        anchors.leftMargin: 2
                        anchors.bottomMargin: 2
                        anchors.topMargin: 2
                    }
                    
                }
                
            }
            background: Rectangle {
                anchors.fill: parent
                color: parent.down ? myHighLighht : (parent.hovered && parent.endable ? Qt.lighter(myBackground, 2) : myBackground)
                radius: 8

                Rectangle {
                    height: 10
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    color: parent.color
                }

                Label{
                    text: nameRandom
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Roboto Medium"
                    color: parent.parent.down ? myUpperBar : (parent.parent.hovered  && parent.parent.endable ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
                }
            }
            onClicked: {
                myData.sendRandom(alphaSix.text)
                for (let i = 0; i < 36; i++) {
                    key1six.children[i].text = key1[i]
                    key1six.children[i].myCol = myHighLighht
                }
            }
        }

        
    }

    ColumnLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.rightMargin: -34
        Layout.bottomMargin: 2
        Layout.leftMargin: -6
        Layout.topMargin: -7
        Layout.maximumHeight:290
        Layout.minimumHeight:290
        Layout.maximumWidth: 270

        
        // key 2 text
        Label {
            text: nameKey2
            font.family: "Roboto Medium"
            color: myUpperBar
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: 16
            Layout.topMargin: 0
        }

        // key 2
        TextField {
            id: key2six
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: 0
            Layout.rightMargin: 0
            Layout.maximumHeight: 24
            Layout.minimumHeight: 24
            selectByMouse: true
            color: myWhiteFont
            enabled: activeWindow
            horizontalAlignment: Text.AlignHCenter
            font.capitalization: Font.AllUppercase
            font.family: "Roboto Medium"
            placeholderTextColor: Qt.darker(myWhiteFont, 2)
            placeholderText: nameTypeHere
            validator: RegularExpressionValidator { regularExpression:  /^[a-zA-Zá-žÁ-Ž]+$/ }
            background: Rectangle {
                id: key2sixVer
                color: myBackground
                border.width: 3
                border.color: "transparent"
                radius: 8
            }
            onTextChanged: {
                if(key2six.text != "") {
                    let tmp = key2six.cursorPosition
                    let myKey = key2six.text
                    myKey = myKey.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
                    myKey = myKey.replace(" ", "")
                    myKey = myKey.toUpperCase()
                    if (myKey.length <= 1) {
                        key2sixVer.border.color = myCloseBtn
                    } else {
                        key2sixVer.border.color = myHighLighht
                    }
                    key2six.text = myKey
                    key2six.cursorPosition = tmp
                }
                canIUseBtn()
            }
        }

        // encode or deecode
        TabBar {
            id: decEncBar2
            width: 240
            height: 35
            enabled: activeWindow
            position: TabBar.Footer
            font.family: "Roboto Medium"
            Layout.topMargin: -6
            Layout.rightMargin: 4
            Layout.leftMargin: 4
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true

            TabButton {
                id: encTabButtno2
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                bottomPadding: 18
                padding: 8
                background: Rectangle {
                    color: encTabButtno2.hovered
                            && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                    anchors.fill: parent
                    Label {
                        text: nameEncode
                        anchors.verticalCenter: parent.verticalCenter
                        font.weight: Font.Medium
                        font.family: "Poppins Medium"
                        anchors.verticalCenterOffset: decEncBar2.currentIndex == 0 ? 2 : 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: encTabButtno2.hovered
                                && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                    }

                    Rectangle {
                        height: 4
                        color: decEncBar2.currentIndex == 0 ? myHighLighht : (encTabButtno2.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
                                myBackground2)
                        radius: 4
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                    }
                }
                onClicked: {
                    //enableEncDec()
                    encOrDec = false
                }
            }

            TabButton {
                id: decTabButton2
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                bottomPadding: 18
                padding: 8
                background: Rectangle {
                    color: decTabButton2.hovered
                            && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                    anchors.fill: parent
                    Label {
                        text: nameDecode
                        anchors.verticalCenter: parent.verticalCenter
                        font.weight: Font.Medium
                        font.family: "Poppins Medium"
                        anchors.verticalCenterOffset: decEncBar2.currentIndex == 1 ? 2 : 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: decTabButton2.hovered
                                && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                    }

                    Rectangle {
                        height: 4
                        color: decEncBar2.currentIndex == 1 ? myHighLighht : (decTabButton2.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
                                myBackground2)
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                    }
                }
                onClicked: {
                    //enableEncDec()
                    encOrDec = true
                }
            }
        } 

        // file / text
        StackView {
            id: stackFT2
            width: 200
            height: 100
            Layout.minimumHeight: 100
            Layout.maximumHeight: 100
            Layout.fillWidth: true
            Layout.fillHeight: false
            clip:true
            initialItem:textFT2
        
        }
        Flickable {
            id: textFT2
            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: true
            TextArea.flickable: TextArea {
                id: inputText2
                visible: true
                selectByMouse: true
                color: myWhiteFont
                enabled: activeWindow
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WrapAnywhere
                textFormat: Text.AutoText
                placeholderTextColor: Qt.darker(myWhiteFont, 2)
                font.family: "Roboto Medium"
                font.hintingPreference: Font.PreferFullHinting
                font.capitalization: Font.AllUppercase
                placeholderText: nameTypeHere
                background: Rectangle {
                    color: myBackground
                    radius: 8
                }
                onTextChanged: {
                    let tmp = inputText2.cursorPosition
                    let nl = false
                    if (inputText2.text.includes("\n") || inputText2.text.includes("\t")) {
                        inputText2.text = inputText2.text.replace("\n", "")
                        inputText2.text = inputText2.text.replace("\t", "")
                        nl = true
                    }
                    let myinputText2 = inputText2.text
                    myinputText2 = myinputText2.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
                    myinputText2 = myinputText2.toUpperCase()
                    inputText2.text = myinputText2
                    if (nl) {
                        inputText2.cursorPosition = tmp - 1
                    } else {
                        inputText2.cursorPosition = tmp
                    }
                    canIUseBtn()
                }
            }
            ScrollBar.vertical: ScrollBar {}

        }

        ColumnLayout {
            id: fileFT2
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: false

            Button {
                id: btnChoseFile2
                enabled: activeWindow
                Layout.topMargin: 16
                Layout.fillHeight: true
                Layout.fillWidth: true
                background: Rectangle {
                    anchors.fill: parent
                    color: btnChoseFile2.down ? myHighLighht : (btnChoseFile2.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                    radius: 8

                    Label {
                        text: nameChoseFile
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Roboto Medium"
                        color: myWhiteFont
                    }
                }
                onClicked: {
                    fileDialog2.visible = true
                    canIUseBtn()
                }
            }


            Label {
                id: fileState2
                Layout.fillWidth: true
                text: nameFileUnchosed
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                topPadding: 8
                bottomPadding: 16
                font.family: "Poppins Medium"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: myUpperBar
            }
            
        }

        

        // text / file button tab
        TabBar {
            id: textFileTab2
            width: 240
            height: 35
            enabled: activeWindow
            position: TabBar.Footer
            font.family: "Roboto Medium"
            Layout.topMargin: -9
            Layout.rightMargin: 4
            Layout.leftMargin: 4
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true

            TabButton {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                bottomPadding: 18
                padding: 8
                background: Rectangle {
                    color: parent.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                    anchors.fill: parent
                    Label {
                        text: "Text"
                        anchors.verticalCenter: parent.verticalCenter
                        font.weight: Font.Medium
                        font.family: "Poppins Medium"
                        anchors.verticalCenterOffset: textFileTab2.currentIndex == 0 ? 2 : 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: parent.parent.hovered && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                    }

                    Rectangle {
                        height: 4
                        color: textFileTab2.currentIndex == 0 ? myHighLighht : 
                                (parent.parent.hovered && activeWindow ? 
                                Qt.darker(myBackground2, 1.25) : myBackground2)
                        radius: 4
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                    }
                }
                onClicked: {
                    stackFT2.pop(textFT2)
                }
            }

            TabButton {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                bottomPadding: 18
                padding: 8
                background: Rectangle {
                    color: parent.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                    anchors.fill: parent
                    Label {
                        text: nameFile
                        anchors.verticalCenter: parent.verticalCenter
                        font.weight: Font.Medium
                        font.family: "Poppins Medium"
                        anchors.verticalCenterOffset: textFileTab2.currentIndex == 1 ? 2 : 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: parent.parent.hovered && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                    }

                    Rectangle {
                        height: 4
                        color: textFileTab2.currentIndex == 1 ? myHighLighht : (parent.parent.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) :
                                                                                                                       myBackground2)
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                    }
                }
                onClicked: {
                    stackFT2.push(fileFT2)
                }
            }
        }

        
        // select char for spacing
        RowLayout {
            width: 200
            height: 400
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true

            Row {
                width: 200
                height: 400

                Label {
                    font.family: "Poppins Medium"
                    color: myUpperBar
                    text: nameSpecChar
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignBottom
                    topPadding: 3
                }

                ComboBox {
                    id: chosSpecCh2
                    Layout.minimumHeight: 24
                    Layout.maximumHeight: 24
                    Layout.minimumWidth: 85
                    Layout.maximumWidth: 85
                    Layout.fillWidth: true
                    currentIndex: 0
                    font.family: "Poppins Medium"
                    model: Array.from(alphaSix.text)
                    
                    delegate: ItemDelegate {
                        width: chosSpecCh2.width - 10
                        height: 22
                        contentItem: Text {
                            text: modelData
                            color: myWhiteFont
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.topMargin: -628
                            anchors.bottomMargin: -15
                            anchors.leftMargin: -600
                            anchors.rightMargin: -71
                            anchors.horizontalCenter: mainWindow.horizontalCenter
                            font.family: "Roboto Medium"
                        }
                        highlighted: chosSpecCh2.highlightedIndex === index
                        Component.onCompleted: {
                            background.color =  myBackground
                            background.radius = 6
                        }
                        Binding {
                            target: background
                            property: "color"
                            value: highlighted ? myHighLighht : myBackground
                        }
                    }

                    indicator: Image {
                        anchors.verticalCenter: chosSpecCh2.verticalCenter
                        anchors.right: chosSpecCh2.right
                        source: "icons/UpDown.svg"
                        anchors.rightMargin: 6
                        sourceSize.height: 10
                        sourceSize.width: 10
                        fillMode: Image.Pad

                    }

                    contentItem: Text {
                        text: chosSpecCh2.displayText
                        font: chosSpecCh2.font
                        color: chosSpecCh2.pressed ? myBackground : myUpperBar
                        verticalAlignment: Text.AlignVCenter
                        anchors.horizontalCenterOffset: -6
                        anchors.horizontalCenter: chosSpecCh2.horizontalCenter
                        elide: Text.ElideMiddle
                        anchors.verticalCenter: chosSpecCh2.verticalCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    background: Rectangle {
                        implicitWidth: 50
                        implicitHeight: 25
                        border.color: chosSpecCh2.pressed ? myBackground2 : Qt.darker(myBackground2, 1.1)
                        border.width: chosSpecCh2.visualFocus ? 2 : 1
                        radius: 8
                        color: myBackground2
                    }

                    popup: Popup {
                        y: chosSpecCh2.height - 1
                        width: chosSpecCh2.width
                        implicitHeight: contentItem.implicitHeight
                        padding: 5
                        contentItem: ListView {
                            clip: true
                            implicitHeight: contentHeight + 10
                            model: chosSpecCh2.popup.visible ? chosSpecCh2.delegateModel : null
                            currentIndex: chosSpecCh2.highlightedIndex
                        }

                        background: Rectangle {
                            border.width: 1
                            border.color: myHighLighht
                            radius:8
                            color: myBackground
                        }
                    }
                    onActivated: {
                        specChar = chosSpecCh2.currentText
                    }
                }
            }
        }

        // encode/decode button
        Button {
            Layout.fillHeight: true
            Layout.topMargin: 0
            Layout.leftMargin: 0
            Layout.bottomMargin: 0
            Layout.fillWidth: true
            Layout.minimumHeight: 36
            Layout.maximumHeight: 36
            Layout.maximumWidth: key2six.width
            enabled: canIUseBtn()
            onClicked: {
                let myKey1 = []
                for (let i = 0; i < 36; i++) {
                    myKey1.push(key1six.children[i].text)
                }
                key1 = myKey1
                if (encOrDec) { //decode

                    if (textFileTab2.currentIndex) { //file
                        myData.decodeText(myInputText, myKey1, key2six.text, specChar)
                    } else { //text
                        myData.decodeText(inputText2.text, myKey1, key2six.text, specChar)
                    }
                } else { //encode
                    if (textFileTab2.currentIndex) { //file
                        myData.encodeText(myInputText, myKey1, key2six.text, specChar)
                    } else { //text 
                        myData.encodeText(inputText2.text, myKey1, key2six.text, specChar)
                    }
                }
                sol2.visible = true
                activeWindow = false
            }
            ToolTip {
                text: nameWhyEnDe
                visible: parent.hovered && !parent.enabled
                background: Rectangle {
                    color: myBackground2
                    border.color: myHighLighht
                    radius: 4
                    
                    Label {
                        color: "#F9D800"
                        font.pointSize: 12
                        font.family: "Roboto Medium"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 2
                        anchors.leftMargin: 2
                        anchors.bottomMargin: 2
                        anchors.topMargin: 2
                    }
                    
                }
                
            }
            background: Rectangle {
                anchors.fill: parent
                color: parent.down ? myHighLighht : (parent.hovered && parent.endable ? Qt.lighter(myBackground, 2) : myBackground)
                radius: 8


                Label{
                    text: encOrDec? nameDecode : nameEncode 
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Roboto Medium"
                    color: parent.parent.down ? myUpperBar : (parent.parent.hovered && parent.endable ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
                }
            }
        }
        
        SolutionSix {
            id: sol2
            visible: false
        }
    }

    function makeSix(){
        let component = Qt.createComponent("MyField.qml")
        if (component.status != Component.Ready) {
            if (component.status == Component.Error) {
                console.debug("Err:"+ component.errorString());
            }
        }
        
        for (let i = 0; i < 36; i++) {
            let object = component.createObject(key1six)
            object.Layout.fillHeight = true
            object.Layout.fillWidth = true
            object.font.pointSize = 14
            object.Layout.maximumHeight = 38
            object.Layout.maximumWidth = 38
        }
        for (let i = 0; i < 36; i++) {
            if (i < 29) {
                key1six.children[i].KeyNavigation.down = key1six.children[i + 6]
            } else if (i == 36) {
                key1six.children[i].KeyNavigation.down = key1six.children[0]
            } else {
                key1six.children[i].KeyNavigation.down = key1six.children[i - 19]
            }
            if (i > 5) {
                key1six.children[i].KeyNavigation.up = key1six.children[i - 6]
            } else if (i == 0) {
                key1six.children[i].KeyNavigation.up = key1six.children[35]
            } else {
                key1six.children[i].KeyNavigation.up = key1six.children[i + 29]
            }
            if (i) {
                key1six.children[i].KeyNavigation.left = key1six.children[i - 1]
            } else {
                key1six.children[i].KeyNavigation.left = key1six.children[35]
            }
            if (i < 35) {
                key1six.children[i].KeyNavigation.right = key1six.children[i + 1]
            } else {
                key1six.children[i].KeyNavigation.right = key1six.children[0]
            }
        }
    }

    /*function makeAlpha() {
        let component = Qt.createComponent("MyText.qml")
        for (let i = 0; i < 25; i++) {
            let object = component.createObject(abcHere2)
            object.Layout.fillHeight =true
            object.Layout.fillWidth = true
            object.font.pointSize = 9
        }
    }*/

    function veri(base, myAbc) {
        let count = 0;
        canIUseBtn()
        for (let j = 0;j < myAbc.length; j++) {
            count = 0
            for (let i = 0; i < myAbc.length; i++) {
                if (base.children[i].text == myAbc[j]) {
                    count++
                }
            }
            for (let i = 0; i < myAbc.length; i++) {
                if (count > 1) {
                    if (base.children[i].text == myAbc[j]) {
                        base.children[i].myCol = myCloseBtn
                        //abcHere2.children[j].color = myCloseBtn
                    }
                } else  if (count == 1) {
                    if (base.children[i].text == myAbc[j]) {
                        base.children[i].myCol = myHighLighht
                        //abcHere2.children[j].color = myHighLighht
                    }
                } else {
                    if (key1six.children[i].text == "" || !myAbc.includes(key1six.children[i].text)) {
                        base.children[i].myCol = "transparent"
                        //abcHere2.children[j].color = myUpperBar
                    }
                }
            }
        }
    }

    function canIUseBtn() {
        for (let i = 0; i < 36; i++) {
            if (key1six.children[i].myCol == "transparent" || key1six.children[i].myCol == myCloseBtn) {
                return false
            }
        }
        if (key2six.text == "") {
            return false
        }
        if (textFileTab2.currentIndex == 0 && inputText2.text == ""){
            return false
        }
        if (textFileTab2.currentIndex && (fileState2.color == myCloseBtn || fileState2.text == nameFileUnchosed)) {
            return false
        }
        return true
    }

    FileDialog {
        id: fileDialog2
        visible: false
        nameFilters: [nameSlctTXT]
        onAccepted: {
            fileState2.text = nameFileUnchosed
            fileState2.color = myUpperBar
            let url = String(fileDialog2.currentFile)
            let index = 0
            let urlCh = url.split("")
            for (let i =0; i <url.length; i++){
                if(urlCh[i] === "/") {index = i + 1;}
            }
            let filename = url.substring(index);
            fileState2.text = filename
            myData.verifyText(url)
            if (myInputText == ""){
                fileState2.text = nameEmpty
                fileState2.color = myCloseBtn
            } else {
                myInputText = myInputText.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
                myInputText = myInputText.toUpperCase()
            }
            canIUseBtn()
        }
        onRejected: {
            fileState2.text = nameFileUnchosed
            myInputText = ""
            canIUseBtn()
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2}D{i:12}D{i:1}D{i:14}D{i:16}D{i:17}
D{i:15}D{i:18}D{i:13}D{i:23}D{i:24}D{i:28}D{i:33}D{i:36}D{i:32}D{i:27}D{i:38}D{i:42}
D{i:37}D{i:48}D{i:49}D{i:47}D{i:46}D{i:60}D{i:64}D{i:59}D{i:22}
}
##^##*/

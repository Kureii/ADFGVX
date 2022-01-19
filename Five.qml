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
        makeFive()
        makeAlpha()
    }


    RowLayout {
        height: 24
        Layout.columnSpan: 2
        Layout.fillWidth: true
        Layout.topMargin: 8
        Layout.leftMargin: 32
        Layout.rightMargin: 32

        // chose alphabet
        ComboBox {
            id: chosAbc
            Layout.minimumHeight: 24
            Layout.maximumHeight: 24
            Layout.minimumWidth: 85
            Layout.maximumWidth: 85
            Layout.fillWidth: true
            currentIndex: 0
            font.family: "Poppins Medium"
            model:["J ❱❱ I", "W ❱❱ V", "Q ❱❱ K"]
            
            delegate: ItemDelegate {
                width: chosAbc.width - 10
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
                highlighted: chosAbc.highlightedIndex === index
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
                anchors.verticalCenter: chosAbc.verticalCenter
                anchors.right: chosAbc.right
                source: "icons/UpDown.svg"
                anchors.rightMargin: 6
                sourceSize.height: 10
                sourceSize.width: 10
                fillMode: Image.Pad

            }

            contentItem: Text {
                text: chosAbc.displayText
                font: chosAbc.font
                color: chosAbc.pressed ? myBackground : myUpperBar
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenterOffset: -6
                anchors.horizontalCenter: chosAbc.horizontalCenter
                elide: Text.ElideMiddle
                anchors.verticalCenter: chosAbc.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 25
                border.color: chosAbc.pressed ? myBackground2 : Qt.darker(myBackground2, 1.1)
                border.width: chosAbc.visualFocus ? 2 : 1
                radius: 8
                color: myBackground2
            }

            popup: Popup {
                y: chosAbc.height - 1
                width: chosAbc.width
                implicitHeight: contentItem.implicitHeight
                padding: 5
                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight + 10
                    model: chosAbc.popup.visible ? chosAbc.delegateModel : null
                    currentIndex: chosAbc.highlightedIndex
                }

                background: Rectangle {
                    border.width: 1
                    border.color: myHighLighht
                    radius:8
                    color: myBackground
                }
            }

            onActivated: {
                let myAbc = ""
                if (chosAbc.currentIndex == 0) {
                    myAbc = solidEngAlpha
                } else if (chosAbc.currentIndex == 1) {
                    myAbc = solidCsVAlpha
                } else {
                    myAbc = solidCsKAlpha
                }
                for (let i = 0; i < 22; i++) {
                    abcHere.children[i].text = myAbc[i]
                }
                chosSpecCh.model = Array.from(myAbc)
                veri(key1five, myAbc)
                
            }
        }

        // alphabet
        RowLayout {
            id: abcHere
            Layout.fillHeight: true
            Layout.fillWidth: true
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
            id: key1size
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumHeight: 235
            Layout.maximumWidth: 235
            Layout.minimumHeight: 235
            Layout.minimumWidth: 235
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
                id: key1five
                anchors.fill: parent
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.bottomMargin: 5
                anchors.topMargin: 5
                rows: 5
                columns: 5

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
            Layout.maximumWidth: key1size.width
            enabled: true
            background: Rectangle {
                anchors.fill: parent
                color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
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
                    color: parent.parent.down ? myUpperBar : (parent.parent.hovered ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
                }
            }
            onClicked: {
                if (chosAbc.currentIndex == 0) {
                    myData.sendRandom(solidEngAlpha)
                } else if (chosAbc.currentIndex == 1) {
                    myData.sendRandom(solidCsVAlpha)
                } else {
                    myData.sendRandom(solidCsKAlpha)
                }
                for (let i = 0; i < 25; i++) {
                    key1five.children[i].text = key1[i]
                    key1five.children[i].myCol = myHighLighht
                }
            }
        }

        
    }

    ColumnLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.rightMargin: 8
        Layout.bottomMargin: 2
        Layout.leftMargin: -6
        Layout.topMargin: -7
        Layout.maximumHeight:290
        Layout.minimumHeight:290

        
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
            id: key2five
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
                id: key2fiveVer
                color: myBackground
                border.width: 3
                border.color: "transparent"
                radius: 8
            }
            onTextChanged: {
                if(key2five.text != "") {
                    let tmp = key2five.cursorPosition
                    let myKey = key2five.text
                    myKey = myKey.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
                    myKey = myKey.replace(" ", "")
                    myKey = myKey.toUpperCase()
                    if (myKey.length <= 1) {
                        key2fiveVer.border.color = myCloseBtn
                    } else {
                        key2fiveVer.border.color = myHighLighht
                    }
                    key2five.text = myKey
                    key2five.cursorPosition = tmp
                }
                canIUseBtn()
            }
        }

        // encode or deecode
        TabBar {
            id: decEncBar
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
                id: encTabButtno
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                bottomPadding: 18
                padding: 8
                background: Rectangle {
                    color: encTabButtno.hovered
                            && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                    anchors.fill: parent
                    Label {
                        text: nameEncode
                        anchors.verticalCenter: parent.verticalCenter
                        font.weight: Font.Medium
                        font.family: "Poppins Medium"
                        anchors.verticalCenterOffset: decEncBar.currentIndex == 0 ? 2 : 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: encTabButtno.hovered
                                && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                    }

                    Rectangle {
                        height: 4
                        color: decEncBar.currentIndex == 0 ? myHighLighht : (encTabButtno.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
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
                id: decTabButton
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                bottomPadding: 18
                padding: 8
                background: Rectangle {
                    color: decTabButton.hovered
                            && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                    anchors.fill: parent
                    Label {
                        text: nameDecode
                        anchors.verticalCenter: parent.verticalCenter
                        font.weight: Font.Medium
                        font.family: "Poppins Medium"
                        anchors.verticalCenterOffset: decEncBar.currentIndex == 1 ? 2 : 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: decTabButton.hovered
                                && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                    }

                    Rectangle {
                        height: 4
                        color: decEncBar.currentIndex == 1 ? myHighLighht : (decTabButton.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
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
            id: stackFT
            width: 200
            height: 100
            Layout.minimumHeight: 100
            Layout.maximumHeight: 100
            Layout.fillWidth: true
            Layout.fillHeight: false
            clip:true
            initialItem:textFT
        
        }
        Flickable {
            id: textFT
            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: true
            TextArea.flickable: TextArea {
                id: inputText
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
                    let tmp = inputText.cursorPosition
                    let nl = false
                    if (inputText.text.includes("\n") || inputText.text.includes("\t")) {
                        inputText.text = inputText.text.replace("\n", "")
                        inputText.text = inputText.text.replace("\t", "")
                        nl = true
                    }
                    let myinputText = inputText.text
                    myinputText = myinputText.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
                    myinputText = myinputText.toUpperCase()
                    inputText.text = myinputText
                    if (nl) {
                        inputText.cursorPosition = tmp - 1
                    } else {
                        inputText.cursorPosition = tmp
                    }
                    canIUseBtn()
                }
            }
            ScrollBar.vertical: ScrollBar {}

        }

        ColumnLayout {
            id: fileFT
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: false

            Button {
                id: btnChoseFile
                enabled: activeWindow
                Layout.topMargin: 16
                Layout.fillHeight: true
                Layout.fillWidth: true
                background: Rectangle {
                    anchors.fill: parent
                    color: btnChoseFile.down ? myHighLighht : (btnChoseFile.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
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
                    fileDialog.visible = true
                    canIUseBtn()
                }
            }


            Label {
                id: fileState
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
            id: textFileTab
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
                id: textButton
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
                        anchors.verticalCenterOffset: textFileTab.currentIndex == 0 ? 2 : 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: parent.parent.hovered && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                    }

                    Rectangle {
                        height: 4
                        color: textFileTab.currentIndex == 0 ? myHighLighht : 
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
                    stackFT.pop(textFT)
                }
            }

            TabButton {
                id: fileButton
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
                        anchors.verticalCenterOffset: textFileTab.currentIndex == 1 ? 2 : 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: parent.parent.hovered && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                    }

                    Rectangle {
                        height: 4
                        color: textFileTab.currentIndex == 1 ? myHighLighht : (parent.parent.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) :
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
                    stackFT.push(fileFT)
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
                id: row
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
                    id: chosSpecCh
                    Layout.minimumHeight: 24
                    Layout.maximumHeight: 24
                    Layout.minimumWidth: 85
                    Layout.maximumWidth: 85
                    Layout.fillWidth: true
                    currentIndex: 0
                    font.family: "Poppins Medium"
                    model: chosAbc.currentIndex == 0 ? Array.from(solidEngAlpha) : (chosAbc.currentIndex == 1 ? Array.from(solidCsVAlpha) : Array.from(solidCsKAlpha))
                    
                    delegate: ItemDelegate {
                        width: chosSpecCh.width - 10
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
                        highlighted: chosSpecCh.highlightedIndex === index
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
                        anchors.verticalCenter: chosSpecCh.verticalCenter
                        anchors.right: chosSpecCh.right
                        source: "icons/UpDown.svg"
                        anchors.rightMargin: 6
                        sourceSize.height: 10
                        sourceSize.width: 10
                        fillMode: Image.Pad

                    }

                    contentItem: Text {
                        text: chosSpecCh.displayText
                        font: chosSpecCh.font
                        color: chosSpecCh.pressed ? myBackground : myUpperBar
                        verticalAlignment: Text.AlignVCenter
                        anchors.horizontalCenterOffset: -6
                        anchors.horizontalCenter: chosSpecCh.horizontalCenter
                        elide: Text.ElideMiddle
                        anchors.verticalCenter: chosSpecCh.verticalCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    background: Rectangle {
                        implicitWidth: 50
                        implicitHeight: 25
                        border.color: chosSpecCh.pressed ? myBackground2 : Qt.darker(myBackground2, 1.1)
                        border.width: chosSpecCh.visualFocus ? 2 : 1
                        radius: 8
                        color: myBackground2
                    }

                    popup: Popup {
                        y: chosSpecCh.height - 1
                        width: chosSpecCh.width
                        implicitHeight: contentItem.implicitHeight
                        padding: 5
                        contentItem: ListView {
                            clip: true
                            implicitHeight: contentHeight + 10
                            model: chosSpecCh.popup.visible ? chosSpecCh.delegateModel : null
                            currentIndex: chosSpecCh.highlightedIndex
                        }

                        background: Rectangle {
                            border.width: 1
                            border.color: myHighLighht
                            radius:8
                            color: myBackground
                        }
                    }
                    onActivated: {
                        specChar = chosSpecCh.currentText
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
            Layout.maximumWidth: key2five.width
            enabled: canIUseBtn()
            onClicked: {
                let myKey1 = []
                for (let i = 0; i < 25; i++) {
                    myKey1.push(key1five.children[i].text)
                }
                key1 = myKey1
                if (encOrDec) { //decode

                    if (textFileTab.currentIndex) { //file
                        let newText = myInputText
                        if (chosAbc.currentIndex == 0) {
                            while (newText.includes("J")) {
                                newText = newText.replace("J", "I")
                            }
                        } else if (chosAbc.currentIndex == 1) {
                            while (newText.includes("W")) {
                                newText = newText.replace("W", "V")
                            }
                        } else {
                            while (newText.includes("Q")) {
                                newText = newText.replace("Q", "K")
                            }
                        }
                        myData.decodeText(newText, myKey1, key2five.text, specChar)
                    } else { //text
                        let newText = inputText.text
                        if (chosAbc.currentIndex == 0) {
                            while (newText.includes("J")) {
                                newText = newText.replace("J", "I")
                            }
                        } else if (chosAbc.currentIndex == 1) {
                            while (newText.includes("W")) {
                                newText = newText.replace("W", "V")
                            }
                        } else {
                            while (newText.includes("Q")) {
                                newText = newText.replace("Q", "K")
                            }
                        }
                        myData.decodeText(newText, myKey1, key2five.text, specChar)
                    }
                } else { //encode
                    if (textFileTab.currentIndex) { //file
                        console.log("encode file:");
                        let newText = myInputText
                        if (chosAbc.currentIndex == 0) {
                            while (newText.includes("J")) {
                                newText = newText.replace("J", "I")
                            }
                        } else if (chosAbc.currentIndex == 1) {
                            while (newText.includes("W")) {
                                newText = newText.replace("W", "V")
                            }
                        } else {
                            while (newText.includes("Q")) {
                                newText = newText.replace("Q", "K")
                            }
                        }
                        console.log(newText);
                        myData.encodeText(newText, myKey1, key2five.text, specChar)
                    } else { //text
                        let newText = inputText.text
                        if (chosAbc.currentIndex == 0) {
                            while (newText.includes("J")) {
                                newText = newText.replace("J", 'I')
                            }
                        } else if (chosAbc.currentIndex == 1) {
                            while (newText.includes("W")) {
                                newText = newText.replace("W", "V")
                            }
                        } else {
                            while (newText.includes("Q")) {
                                newText = newText.replace("Q", "K")
                            }
                        }
                        myData.encodeText(newText, myKey1, key2five.text, specChar)
                    }
                }
                sol.visible = true
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
        
        Solution {
            id: sol
            visible: false
        }
    }

    function makeFive(){
        let component = Qt.createComponent("MyField.qml")
        if (component.status != Component.Ready) {
            if (component.status == Component.Error) {
                console.debug("Err:"+ component.errorString());
            }
        }
        
        for (let i = 0; i < 25; i++) {
            let object = component.createObject(key1five)
            object.Layout.fillHeight = true
            object.Layout.fillWidth = true
            object.font.pointSize = 14
            object.Layout.maximumHeight = 38
            object.Layout.maximumWidth = 38
        }
        for (let i = 0; i < 25; i++) {
            if (i < 19) {
                key1five.children[i].KeyNavigation.down = key1five.children[i + 5]
            } else if (i == 24) {
                key1five.children[i].KeyNavigation.down = key1five.children[0]
            } else {
                key1five.children[i].KeyNavigation.down = key1five.children[i - 19]
            }
            if (i > 4) {
                key1five.children[i].KeyNavigation.up = key1five.children[i - 5]
            } else if (i == 0) {
                key1five.children[i].KeyNavigation.up = key1five.children[24]
            } else {
                key1five.children[i].KeyNavigation.up = key1five.children[i + 19]
            }
            if (i) {
                key1five.children[i].KeyNavigation.left = key1five.children[i - 1]
            } else {
                key1five.children[i].KeyNavigation.left = key1five.children[24]
            }
            if (i < 24) {
                key1five.children[i].KeyNavigation.right = key1five.children[i + 1]
            } else {
                key1five.children[i].KeyNavigation.right = key1five.children[0]
            }
        }
    }

    function makeAlpha() {
        let component = Qt.createComponent("MyText.qml")
        for (let i = 0; i < 25; i++) {
            let object = component.createObject(abcHere)
            object.Layout.fillHeight =true
            object.Layout.fillWidth = true
            object.font.pointSize = 9
            if (chosAbc.currentIndex == 0) {
                object.text = solidEngAlpha[i]
            } else {
                object.text = solidCsVAlpha[i]
            }
        }
    }

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
                        abcHere.children[j].color = myCloseBtn
                    }
                } else  if (count == 1) {
                    if (base.children[i].text == myAbc[j]) {
                        base.children[i].myCol = myHighLighht
                        abcHere.children[j].color = myHighLighht
                    }
                } else {
                    if (key1five.children[i].text == "" || !myAbc.includes(key1five.children[i].text)) {
                        base.children[i].myCol = "transparent"
                        abcHere.children[j].color = myUpperBar
                    }
                }
            }
        }
    }

    function canIUseBtn() {
        for (let i = 0; i < 25; i++) {
            if (abcHere.children[i].myCol == myUpperBar || abcHere.children[i].myCol == myCloseBtn) {
                return false
            }
        }
        if (key2five.text == "") {
            return false
        }
        if (textFileTab.currentIndex == 0 && inputText.text == ""){
            return false
        }
        if (textFileTab.currentIndex && (fileState.color == myCloseBtn || fileState.text == nameFileUnchosed)) {
            return false
        }
        return true
    }

    FileDialog {
        id: fileDialog
        visible: false
        nameFilters: [ "Text files (*.txt)"]
        onAccepted: {
            fileState.text = nameFileUnchosed
            fileState.color = myUpperBar
            let url = String(fileDialog.currentFile)
            let index = 0
            let urlCh = url.split("")
            for (let i =0; i <url.length; i++){
                if(urlCh[i] === "/") {index = i + 1;}
            }
            let filename = url.substring(index);
            fileState.text = filename
            myData.verifyText(url)
            if (myInputText == ""){
                fileState.text = nameEmpty
                fileState.color = myCloseBtn
            } else {
                myInputText = myInputText.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
                myInputText = myInputText.toUpperCase()
            }
            canIUseBtn()
        }
        onRejected: {
            fileState.text = nameFileUnchosed
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

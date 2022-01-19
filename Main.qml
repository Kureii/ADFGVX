import QtQuick 2.9
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQuick.Timeline 1.0 
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects

Window {
    id: mainWindow
    visible: true
    width: 600
    height: 600
    color: "transparent"
    
    flags:  Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    //bools
    property bool eng: true
    property bool activeWindow: true
    property bool animationEnd: false
    property bool encOrDec:false 

    // text string
    property string nameRandom: "Random"
    property string nameKey1: "Key number 1"
    property string nameKey2: "Key number 2"
    property string nameTypeHere: "TYPE HERE"
    property string nameChoseFile: "Chose file"
    property string nameFile: "File"
    property string nameFileUnchosed: "File unchosed"
    property string nameSpcRpl: "Supplement characer:"
    property string nameEncode: "Encode"
    property string nameDecode: "Decode"
    property string nameSpecChar: "Char to replace spaces: "
    property string nameWhyEnDe: "You must fill all field for endable this button"
    property string nameEmpty: "File is empty."
    property string nameEncodeTxt: "Encoded text"
    property string nameOpenText: "Open text"
    property string nameSaveTxt: "Save text"
    property string nameSaveKeys: "Save keys"
    property string nameSlctTXT: "Text file (*.txt)"
    property var nameSaveImg: ["SVG (*.svg)"]
    property string nameTTRnd : "You must fill alphabet"
    property string nameAlpha : "Alphabet"

    // lists
    property var key1: []
    property var specChar: "A"

    // Alphabets
    readonly property string alpha: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    readonly property string solidEngAlpha: "ABCDEFGHIKLMNOPQRSTUVWXYZ"
    readonly property string solidCsVAlpha: "ABCDEFGHIJKLMNOPQRSTUVXYZ"
    readonly property string solidCsKAlpha: "ABCDEFGHIJKLMNOPRSTUVWXYZ"

    //COLOR CONSTANTS
    readonly property color myUpperBar: "#1a1512"
    readonly property color myBackground: "#201e1b"
    readonly property color myWhiteFont: "#e4f8ff"
    readonly property color myBackground2: "#acb1aa"
    readonly property color myHighLighht: "#3fa108"
    readonly property color myCloseImg: "#fcf8fe"
    readonly property color myCloseImgUnA: "#878589"
    readonly property color myCloseBtn: "#de2f05"

    property string myInputText: ""
    property string solution: ""
    property var solKey1: []
    property string solKey2: ""
    property string solText: ""
    property string solSpace: ""

    function makeBig() {
        window.x = 12
        window.y = 12
        window.width = 576
        window.height = 426
        window.color = myBackground2
        language.visible = false
        app.visible = true
        minimalise.visible = true
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        
        //effects
        Rectangle {
            id: windowGlow
            color: "#cf018500"
            radius: 8
            anchors.fill: window
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
        }
        FastBlur {
            source:windowGlow
            radius: 12
            anchors.fill: windowGlow
            antialiasing: true
            transparentBorder: true
            
        }
        HueSaturation {
            anchors.fill: window
            source: window
            saturation: activeWindow ? 0 : -.75
            lightness: activeWindow ? 0 : -0.25
        }
        HueSaturation {
            anchors.fill: windowGlow
            source: windowGlow
            saturation: activeWindow ? 0 : -.85
            lightness: activeWindow ? 0 : -0.25
            z: -1
        }

        // window
        Rectangle {
            id: window
            x: 138
            y: 145
            width: 324
            height: 100
            color: myBackground
            radius: 8
            border.color: myUpperBar
            border.width: 4

            GridLayout {
                anchors.fill: parent
                rowSpacing: 0
                columns: 1
                columnSpacing: 2
                
                //upperBar
                Rectangle {
                    id: upperBar
                    width: 200
                    height: 200
                    color: myUpperBar
                    radius: 8
                    Layout.rightMargin: 0
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
                                clickPos  = Qt.point(mouseX,mouseY)
                            }

                            onPositionChanged: {
                                var delta = Qt.point(mouseX-clickPos.x, mouseY-clickPos.y)
                                mainWindow.x += delta.x;
                                mainWindow.y += delta.y;
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
                                id: minimalise
                                width: 20
                                height: 20
                                flat: false
                                visible: animationEnd
                                Layout.minimumWidth: 20
                                Layout.minimumHeight: 20
                                Layout.maximumHeight: 30
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                background: Rectangle{
                                    id: rectangle
                                    color: parent.pressed ? Qt.tint(Qt.lighter(myUpperBar, 2.5), "#100c03FF") : (parent.hovered ? Qt.tint(Qt.lighter(myUpperBar, 3), "#100c03FF") : myUpperBar)
                                    radius: 4
                                    Rectangle{
                                        id: minBtn
                                        width: 12
                                        height: 2
                                        color: parent.parent.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 4
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        radius: 1
                                    }

                                }
                                onClicked: mainWindow.showMinimized()

                            }

                            Button {
                                width: 20
                                height: 20
                                flat: true
                                Layout.minimumWidth: 20
                                Layout.minimumHeight: 20
                                Layout.maximumHeight: 30
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                background: Rectangle{
                                    color: parent.pressed ? Qt.darker(myCloseBtn, 1.5) : (parent.hovered ? myCloseBtn : myUpperBar)
                                    radius: 4
                                    Rectangle{
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: 45
                                        color: parent.parent.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }
                                    Rectangle{
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: -45
                                        color: parent.parent.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }

                                }
                                onClicked: mainWindow.close()
                            }

                        }
                    }

                    Text {
                        y: 7
                        text: "ADFG(V)X"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 30
                        font.family: "Roboto Medium"
                        font.weight: Font.Medium
                        color: myWhiteFont
                    }

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

                GridLayout {
                    id: language
                    width: 300
                    height: 150
                    Layout.bottomMargin: 4
                    Layout.fillWidth: true
                    Layout.rightMargin: 4
                    Layout.leftMargin: 4
                    Layout.fillHeight: true
                    columns: 2

                    Label {
                        id: englishCzech
                        text: "Language / Jazyk"
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        Layout.columnSpan: 2
                        Layout.minimumHeight: 26
                        Layout.fillWidth: true
                        Layout.fillHeight: false
                        font.family: "Roboto Medium"
                        color: myWhiteFont
                    }
                    Button {
                        Layout.fillHeight: true
                        Layout.bottomMargin: 8
                        Layout.topMargin: 2
                        Layout.minimumHeight: 32
                        Layout.fillWidth: true
                        enabled: true
                        onClicked: {
                            myData.getLang("eng_US")
                            timeline.enabled = true
                            winSize.running = true
                        }
                        background: Rectangle {
                            id: english
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

                            Rectangle {
                                width: 10
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.topMargin: 0
                                anchors.bottomMargin: 0
                                anchors.rightMargin: 0
                                color: parent.color
                                
                            }

                            Label{
                                id: englishText
                                text: "English"
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Roboto Medium"
                                color: parent.parent.down ? myUpperBar : (parent.parent.hovered ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
                            }
                        }
                    }

                    Button {
                        Layout.fillHeight: true
                        Layout.bottomMargin: 8
                        Layout.topMargin: 2
                        Layout.minimumHeight: 32
                        Layout.fillWidth: true
                        enabled: true
                        background: Rectangle {
                            id: czech
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

                            Rectangle {
                                width: 10
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.topMargin: 0
                                anchors.bottomMargin: 0
                                anchors.leftMargin: 0
                                color: parent.color
                                
                            }

                            Label{
                                id: czechText
                                text: "Czech"
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Roboto Medium"
                                color: parent.parent.down ? myUpperBar : (parent.parent.hovered ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
                            }
                        }
                        onClicked: {
                            myData.getLang("cs_CZ")
                            timeline.enabled = true
                            winSize.running = true
                        }
                    }
                    
                }

                Rectangle {
                    color: "transparent"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.leftMargin: 4
                    Layout.bottomMargin: 4
                    Layout.rightMargin: 4

                    App {
                        id: app
                        visible:false

                    }

                    Rectangle {
                        id: mask
                        color: "transparent"
                        anchors.fill: parent
                        visible:false
                    }
                    
                    ThresholdMask {
                        id: myMask
                        anchors.fill: app
                        source: app
                        maskSource: mask
                        threshold: 1.0
                        spread: .2
                    }
                }
            }
        }
    }


    Connections {
        target: myData
        function onRandomized(list) {
            key1 = list
        }
        function onSolution(x) {
            solution = x
        }
        function onKey1(x) {
            solKey1 = x
        }
        function onKey2(x) {
            solKey2 = x
        }
        function onText(x) {
            solText = x
        }
        function onSpace(x) {
            solSpace = x
        }
        function onMyInputText(x) {
            myInputText = x
        }
        function onNameRandom(x) {
        nameRandom = x
        }
        function onNameKey1(x) {
        nameKey1 = x
        }
        function onNameKey2(x) {
        nameKey2 = x
        }
        function onNameTypeHere(x) {
        nameTypeHere = x
        }
        function onNameChoseFile(x) {
        nameChoseFile = x
        }
        function onNameFile(x) {
        nameFile = x
        }
        function onNameFileUnchosed(x) {
        nameFileUnchosed = x
        }
        function onNameSpcRpl(x) {
        nameSpcRpl = x
        }
        function onNameEncode(x) {
        nameEncode = x
        }
        function onNameDecode(x) {
        nameDecode = x
        }
        function onNameSpecChar(x) {
        nameSpecChar = x
        }
        function onNameWhyEnDe(x) {
        nameWhyEnDe = x
        }
        function onNameEmpty(x) {
        nameEmpty = x
        }
        function onNameEncodeTxt(x) {
        nameEncodeTxt = x
        }
        function onNameOpenText(x) {
        nameOpenText = x
        }
        function onNameSaveTxt(x) {
        nameSaveTxt = x
        }
        function onNameSaveKeys(x) {
        nameSaveKeys = x
        }
        function onNameSlctTXT(x) {
        nameSlctTXT = x
        }
        function onNameTTRnd(x) {
            nameTTRnd = x
        }
        function onNameAlpha(x) {
            nameAlpha = x
        }
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: winSize
                duration: 1000
                loops: 1
                running: false
                to: 1000
                from: 0
                onFinished: {
                    timeline.enabled = false
                    winSize.running = false
                    makeBig()

                }
            }
        ]
        startFrame: 0
        enabled: false
        endFrame: 1500



        KeyframeGroup {
            target: window
            property: "width"
            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: 576
                frame: 500
            }

            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: 325
                frame: 0
            }
        }

        KeyframeGroup {
            target: window
            property: "x"
            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: 12
                frame: 500
            }

            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: 138
                frame: 0
            }
        }

        KeyframeGroup {
            target: window
            property: "y"
            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: 12
                frame: 500
            }

            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: 150
                frame: 0
            }
        }

        KeyframeGroup {
            target: window
            property: "height"
            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: 426
                frame: 500
            }

            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: 124
                frame: 0
            }
        }

        KeyframeGroup {
            target: minimalise
            property: "visible"
            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: true
                frame: 1
            }

            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: false
                frame: 0
            }
        }

        KeyframeGroup {
            target: window
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myBackground2
                frame: 500
            }

            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myBackground
                frame: 0
            }
        }

        KeyframeGroup {
            target: minBtn
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myWhiteFont
                frame: 500
            }

            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myUpperBar
                frame: 0
            }
        }

        KeyframeGroup {
            target: language
            property: "visible"
            Keyframe {
                value: false
                frame: 500
            }

            Keyframe {
                value: true
                frame: 499
            }
        }

        KeyframeGroup {
            target: myMask
            property: "threshold"
            Keyframe {
                easing.type: Easing.InOutCubic
                value: .3
                frame: 0
            }

            Keyframe {
                easing.type: Easing.InOutCubic
                value: 0
                frame: 1000
            }
        }

        KeyframeGroup {
            target: english
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myBackground2
                frame: 500
            }

            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myBackground
                frame: 0
            }
        }

        KeyframeGroup {
            target: czech
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myBackground2
                frame: 500
            }

            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myBackground
                frame: 0
            }
        }

        KeyframeGroup {
            target: englishText
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myBackground2
                frame: 500
            }

            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myWhiteFont
                frame: 0
            }
        }

        KeyframeGroup {
            target: czechText
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myBackground2
                frame: 500
            }

            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myWhiteFont
                frame: 0
            }
        }

        KeyframeGroup {
            target: englishCzech
            property: "color"
            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myBackground2
                frame: 500
            }

            Keyframe {
                easing.bezierCurve: [0.645,0.045,0.355,1,1,1]
                value: myWhiteFont
                frame: 0
            }
        }
    }
}


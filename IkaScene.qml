import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import simplecrud

Pane {

    id: ikaScene
    property bool readyToContinue: false

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        Label {
            //Layout.fillWidth: true
            Layout.minimumHeight: 20
            Layout.maximumHeight: 20
            Layout.alignment: Qt.AlignHCenter
            text: "2. ΕΙΣΑΓΩΓΗ ΑΠΟΔΟΧΩΝ ΜΙΣΘΩΤΩΝ."
            font.bold: true
            font.pointSize: 16
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            text: "Εισάγετε παρακάτω τις μηνιαίες μικτές αποδοχές εφόσον απασχοληθήκατε ως μισθωτός/ή (ΙΚΑ, ΝΑΤ, Τράπεζες, ΔΕΚΟ κ.α.) από το 2002 και μετά."
            wrapMode: Text.Wrap
            font.pointSize: 15
        }

        ScrollView {

            Layout.fillHeight: true
            Layout.fillWidth: true

            GridLayout {

                id: pinakasIKA

                property var incomeCells: []
                property int startYear: 2002
                property int endYear: 2026
                property var months: ["ΙΑΝΟΥΑΡ.","ΦΕΒΡΟΥΑΡ.","ΜΑΡΤΙΟΣ","ΑΠΡΙΛΙΟΣ","ΜΑΪΟΣ","ΙΟΥΝΙΟΣ",
                                          "ΙΟΥΛΙΟΣ","ΑΥΓΟΥΣΤ.","ΣΕΠΤΕΜΒΡ.","ΟΚΤΩΒΡ.","ΝΟΕΜΒΡ.","ΔΕΚΕΜΒΡ."]

                columns: months.length + 1
                // rows: 26

                BasicLabel {
                    text: "ΕΤΟΣ"
                }

                // Month headers
                Repeater {
                    model: pinakasIKA.months

                    BasicLabel {
                        required property string modelData
                        text: modelData
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                // Years
                Repeater {
                    model: pinakasIKA.endYear - pinakasIKA.startYear + 1

                    BasicLabel {
                        required property int index
                        Layout.column: 0
                        Layout.row: 1 + index
                        text: pinakasIKA.startYear + index
                    }


                }

                Repeater {

                    model: pinakasIKA.endYear - pinakasIKA.startYear + 1

                    TableInput {
                        required property int index
                        property int monthIndex: 0 // Ιανουάριος όλα τα έτη
                        Layout.column: 1
                        Layout.row: 1 + index

                        Component.onCompleted: {

                            if (!pinakasIKA.incomeCells[index]) {

                                pinakasIKA.incomeCells[index] = []
                            }

                                pinakasIKA.incomeCells[index][monthIndex] = this
                            }

                        ContextMenu.menu: Menu {

                            width: 250


                            MenuItem {

                                text: "Εφαρμογή σε όλο το έτος"
                                onTriggered: {
                                    for(let i = 0; i < 12; i++) {
                                        pinakasIKA.incomeCells[menu.parent.index][i].text = menu.parent.text;
                                    }
                                }
                            }
                        }
                    }
                }

                Repeater {

                    model: pinakasIKA.endYear - pinakasIKA.startYear + 1

                    TableInput {
                        required property int index
                        property int monthIndex: 1 // Φεβρ
                        Layout.column: 2
                        Layout.row: 1 + index

                        Component.onCompleted: {

                            if (!pinakasIKA.incomeCells[index]) {

                                pinakasIKA.incomeCells[index] = []
                            }

                                pinakasIKA.incomeCells[index][monthIndex] = this
                            }

                        ContextMenu.menu: Menu {

                            width: 250


                            MenuItem {

                                text: "Εφαρμογή σε όλο το έτος"
                                onTriggered: {
                                    for(let i = 0; i < 12; i++) {
                                        pinakasIKA.incomeCells[menu.parent.index][i].text = menu.parent.text;
                                    }
                                }
                            }
                        }
                    }
                }

                Repeater {

                    model: pinakasIKA.endYear - pinakasIKA.startYear + 1

                    TableInput {
                        required property int index
                        property int monthIndex: 2 // Μαρτ
                        Layout.column: 3
                        Layout.row: 1 + index

                        Component.onCompleted: {

                            if (!pinakasIKA.incomeCells[index]) {

                                pinakasIKA.incomeCells[index] = []
                            }

                                pinakasIKA.incomeCells[index][monthIndex] = this
                            }

                        ContextMenu.menu: Menu {

                            width: 250


                            MenuItem {

                                text: "Εφαρμογή σε όλο το έτος"
                                onTriggered: {
                                    for(let i = 0; i < 12; i++) {
                                        pinakasIKA.incomeCells[menu.parent.index][i].text = menu.parent.text;
                                    }
                                }
                            }
                        }
                    }
                }

                Repeater {

                    model: pinakasIKA.endYear - pinakasIKA.startYear + 1

                    TableInput {
                        required property int index
                        property int monthIndex: 3 // Απρ
                        Layout.column: 4
                        Layout.row: 1 + index

                        Component.onCompleted: {

                            if (!pinakasIKA.incomeCells[index]) {

                                pinakasIKA.incomeCells[index] = []
                            }

                                pinakasIKA.incomeCells[index][monthIndex] = this
                            }

                        ContextMenu.menu: Menu {

                            width: 250


                            MenuItem {

                                text: "Εφαρμογή σε όλο το έτος"
                                onTriggered: {
                                    for(let i = 0; i < 12; i++) {
                                        pinakasIKA.incomeCells[menu.parent.index][i].text = menu.parent.text;
                                    }
                                }
                            }
                        }
                    }
                }

                Repeater {

                    model: pinakasIKA.endYear - pinakasIKA.startYear + 1

                    TableInput {
                        required property int index
                        property int monthIndex: 4 // Μαϊος
                        Layout.column: 5
                        Layout.row: 1 + index

                        Component.onCompleted: {

                            if (!pinakasIKA.incomeCells[index]) {

                                pinakasIKA.incomeCells[index] = []
                            }

                                pinakasIKA.incomeCells[index][monthIndex] = this
                            }

                        ContextMenu.menu: Menu {

                            width: 250


                            MenuItem {

                                text: "Εφαρμογή σε όλο το έτος"
                                onTriggered: {
                                    for(let i = 0; i < 12; i++) {
                                        pinakasIKA.incomeCells[menu.parent.index][i].text = menu.parent.text;
                                    }
                                }
                            }
                        }
                    }
                }

                Repeater {

                    model: pinakasIKA.endYear - pinakasIKA.startYear + 1

                    TableInput {
                        required property int index
                        property int monthIndex: 5 // Ιούνιος
                        Layout.column: 6
                        Layout.row: 1 + index

                        Component.onCompleted: {

                            if (!pinakasIKA.incomeCells[index]) {

                                pinakasIKA.incomeCells[index] = []
                            }

                                pinakasIKA.incomeCells[index][monthIndex] = this
                            }

                        ContextMenu.menu: Menu {

                            width: 250


                            MenuItem {

                                text: "Εφαρμογή σε όλο το έτος"
                                onTriggered: {
                                    for(let i = 0; i < 12; i++) {
                                        pinakasIKA.incomeCells[menu.parent.index][i].text = menu.parent.text;
                                    }
                                }
                            }
                        }
                    }
                }

                Repeater {

                    model: pinakasIKA.endYear - pinakasIKA.startYear + 1

                    TableInput {
                        required property int index
                        property int monthIndex: 6 // Ιουλ
                        Layout.column: 7
                        Layout.row: 1 + index

                        Component.onCompleted: {

                            if (!pinakasIKA.incomeCells[index]) {

                                pinakasIKA.incomeCells[index] = []
                            }

                                pinakasIKA.incomeCells[index][monthIndex] = this
                            }

                        ContextMenu.menu: Menu {

                            width: 250


                            MenuItem {

                                text: "Εφαρμογή σε όλο το έτος"
                                onTriggered: {
                                    for(let i = 0; i < 12; i++) {
                                        pinakasIKA.incomeCells[menu.parent.index][i].text = menu.parent.text;
                                    }
                                }
                            }
                        }
                    }
                }

                Repeater {

                    model: pinakasIKA.endYear - pinakasIKA.startYear + 1

                    TableInput {
                        required property int index
                        property int monthIndex: 7 // Αυγ
                        Layout.column: 8
                        Layout.row: 1 + index

                        Component.onCompleted: {

                            if (!pinakasIKA.incomeCells[index]) {

                                pinakasIKA.incomeCells[index] = []
                            }

                                pinakasIKA.incomeCells[index][monthIndex] = this
                            }

                        ContextMenu.menu: Menu {

                            width: 250


                            MenuItem {

                                text: "Εφαρμογή σε όλο το έτος"
                                onTriggered: {
                                    for(let i = 0; i < 12; i++) {
                                        pinakasIKA.incomeCells[menu.parent.index][i].text = menu.parent.text;
                                    }
                                }
                            }
                        }
                    }
                }

                Repeater {

                    model: pinakasIKA.endYear - pinakasIKA.startYear + 1

                    TableInput {
                        required property int index
                        property int monthIndex: 8 // Σεπτ
                        Layout.column: 9
                        Layout.row: 1 + index

                        Component.onCompleted: {

                            if (!pinakasIKA.incomeCells[index]) {

                                pinakasIKA.incomeCells[index] = []
                            }

                                pinakasIKA.incomeCells[index][monthIndex] = this
                            }

                        ContextMenu.menu: Menu {

                            width: 250


                            MenuItem {

                                text: "Εφαρμογή σε όλο το έτος"
                                onTriggered: {
                                    for(let i = 0; i < 12; i++) {
                                        pinakasIKA.incomeCells[menu.parent.index][i].text = menu.parent.text;
                                    }
                                }
                            }
                        }
                    }
                }

                Repeater {

                    model: pinakasIKA.endYear - pinakasIKA.startYear + 1

                    TableInput {
                        required property int index
                        property int monthIndex: 9 // Οκτ
                        Layout.column: 10
                        Layout.row: 1 + index

                        Component.onCompleted: {

                            if (!pinakasIKA.incomeCells[index]) {

                                pinakasIKA.incomeCells[index] = []
                            }

                                pinakasIKA.incomeCells[index][monthIndex] = this
                            }

                        ContextMenu.menu: Menu {

                            width: 250


                            MenuItem {

                                text: "Εφαρμογή σε όλο το έτος"
                                onTriggered: {
                                    for(let i = 0; i < 12; i++) {
                                        pinakasIKA.incomeCells[menu.parent.index][i].text = menu.parent.text;
                                    }
                                }
                            }
                        }
                    }
                }

                Repeater {

                    model: pinakasIKA.endYear - pinakasIKA.startYear + 1

                    TableInput {
                        required property int index
                        property int monthIndex: 10 // Νοε
                        Layout.column: 11
                        Layout.row: 1 + index

                        Component.onCompleted: {

                            if (!pinakasIKA.incomeCells[index]) {

                                pinakasIKA.incomeCells[index] = []
                            }

                                pinakasIKA.incomeCells[index][monthIndex] = this
                            }

                        ContextMenu.menu: Menu {

                            width: 250


                            MenuItem {

                                text: "Εφαρμογή σε όλο το έτος"
                                onTriggered: {
                                    for(let i = 0; i < 12; i++) {
                                        pinakasIKA.incomeCells[menu.parent.index][i].text = menu.parent.text;
                                    }
                                }
                            }
                        }
                    }


                }

                Repeater {

                    model: pinakasIKA.endYear - pinakasIKA.startYear + 1

                    TableInput {
                        required property int index
                        property int monthIndex: 11 // Δεκ
                        Layout.column: 12
                        Layout.row: 1 + index

                        Component.onCompleted: {

                            if (!pinakasIKA.incomeCells[index]) {

                                pinakasIKA.incomeCells[index] = []
                            }

                                pinakasIKA.incomeCells[index][monthIndex] = this
                            }

                        ContextMenu.menu: Menu {

                            width: 250

                            MenuItem {

                                text: "Εφαρμογή σε όλο το έτος"
                                onTriggered: {
                                    for(let i = 0; i < 12; i++) {
                                        pinakasIKA.incomeCells[menu.parent.index][i].text = menu.parent.text;
                                    }
                                }
                            }
                        }
                    }
                }

            }


        }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            Layout.maximumHeight: 40

            Button {
                Layout.rightMargin: 40
                Layout.bottomMargin: 20
                text: "ΣΥΝΕΧΕΙΑ"
                font.bold: true
                font.pointSize: 18
                Material.background: settings.primaryColor
                Material.foreground: "white"
                Material.elevation: 8

                onClicked: {

                    fadeOut.start();

                    for(let i = 0; i < 12; i++) {
                        for(let k = 0; k < 25; k++) {
                            PensionData.insertIncomeData(pinakasIKA.incomeCells[k][i].text, 0, k, i);
                        }
                    }

                    //PensionData.test();
                }
            }
        }
    }

    NumberAnimation {
        id: fadeOut
        target: ikaScene
        property: "opacity"
        from: 1
        to: 0
        duration: 300
        easing.type: Easing.InOutQuad

        onFinished: ikaScene.readyToContinue = true
    }

}

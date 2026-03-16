import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects
import simplecrud

Pane {

    id: plasmatikaScene
    property bool readyToContinue: false

    ColumnLayout {
        id: layout
        anchors.fill: parent
        spacing: 20

        Label {
            //Layout.fillWidth: true
            Layout.minimumHeight: 20
            Layout.maximumHeight: 20
            Layout.alignment: Qt.AlignHCenter
            text: "7. ΠΛΑΣΜΑΤΙΚΟΙ ΧΡΟΝΟΙ."
            font.bold: true
            font.pointSize: 16
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            text: "Εισάγετε παρακάτω όλα τα βασικά στοιχεία που χρειάζεται προκειμένου να προχωρήσετε στην καταχώρηση των αποδοχών."
            wrapMode: Text.Wrap
            font.pointSize: 15
        }

        Pane {

            Layout.minimumHeight: 500
            Layout.maximumHeight: 500
            Layout.fillWidth: true

            id: plasmatikaPane
            property int plasmatikaCount: 0
            property var inputs: []

            ColumnLayout {
                anchors.fill: parent

                Repeater {
                    model: plasmatikaPane.plasmatikaCount

                    RowLayout {

                        Layout.fillWidth: true

                        property int totalMonths: 0
                        property int eidosApodochon: 0
                        property double lastIncome: 0
                        property int customSignal: 0

                        spacing: 40

                        Component.onCompleted: {
                            plasmatikaPane.inputs.push(this);
                        }

                        BasicLabel {
                            text: "Κατηγορία:"
                        }

                        ComboBox {
                            Layout.minimumWidth: 240
                            model: ["ΣΤΡΑΤΙΩΤΙΚΗ ΘΗΤΕΙΑ", "ΧΡΟΝΟΣ ΤΕΚΝΩΝ", "ΧΡΟΝΟΣ ΣΠΟΥΔΩΝ", "ΚΕΝΟ ΑΣΦΑΛΙΣΗΣ"]
                        }

                        BasicLabel {
                            text: "Μήνες εξαγοράς:"
                        }

                        BasicInput {
                            //id: minesEksagorasInput
                            onTextChanged: parent.totalMonths = text
                        }

                        ComboBox {
                            Layout.minimumWidth: 300
                            model: ["Τελευταίος μισθός:", "Τελευταία εισφορά κλάδου σύνταξης:"]

                            onCurrentIndexChanged: {
                                parent.eidosApodochon = currentIndex;
                                parent.customSignal += 1;

                            }
                        }

                        BasicInput {
                            //id: lastIncomeInput
                            onTextChanged: {

                                if(parent.eidosApodochon === 0) {
                                    parent.lastIncome = text;
                                }
                                else {
                                    parent.lastIncome = text * 5;
                                }
                            }

                            // parent.onCustomSignalChanged: {
                            //     if(parent.eidosApodochon === 0) {
                            //         parent.lastIncome = text;
                            //     }
                            //     else {
                            //         parent.lastIncome = text * 5;
                            //     }
                            // }
                        }

                        Button {
                            text: "ΔΙΑΓΡΑΦΗ"
                            font.pointSize: 15
                            font.bold: true
                            Material.background: "#E91E63"
                            Material.foreground: "white"
                            onClicked: {
                                parent.visible = false;
                                plasmatikaPane.plasmatikaCount -= 1;
                            }

                        }
                    }
                }

                Button {
                    Layout.alignment: Qt.AlignCenter
                    text: "Εισαγωγή χρόνου"

                    font.bold: true
                    font.pointSize: 18
                    Material.background: settings.primaryColor
                    Material.foreground: "white"
                    Material.elevation: 8
                    onClicked: plasmatikaPane.plasmatikaCount += 1
                }


            }

        }

        RowLayout {
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignRight

            Button {
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: 40
                Layout.bottomMargin: 40
                text: "ΣΥΝΕΧΕΙΑ"
                font.bold: true
                font.pointSize: 18
                Material.background: settings.primaryColor
                Material.foreground: "white"
                Material.elevation: 8

                onClicked: {
                    fadeOut.start();

                    for(let i = 0; i < plasmatikaPane.inputs.length; i++) {
                        if(plasmatikaPane.inputs[i].visible === true) {

                            PensionData.calculateExtraPeriods(plasmatikaPane.inputs[i].totalMonths, plasmatikaPane.inputs[i].lastIncome);
                        }
                    }
                }
            }
        }
    }

    NumberAnimation {
        id: fadeOut
        target: plasmatikaScene
        property: "opacity"
        from: 1
        to: 0
        duration: 300
        easing.type: Easing.InOutQuad

        onFinished: plasmatikaScene.readyToContinue = true
    }

}

import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects
import simplecrud

Pane {

    id: basicInfoScene
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
            text: "1. ΕΙΣΑΓΩΓΗ ΒΑΣΙΚΩΝ ΣΤΟΙΧΕΙΩΝ."
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

            ColumnLayout {
                anchors.fill: parent

                RowLayout {

                    Layout.alignment: Qt.AlignHCenter
                    spacing: 60

                    BasicLabel {
                        Layout.minimumWidth: 100
                        Layout.maximumWidth: 100
                        text: "Όνομα:"
                    }

                    BasicInput {
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        id: nameInput
                    }

                    BasicLabel {
                        Layout.minimumWidth: 100
                        Layout.maximumWidth: 100
                        text: "Επίθετο:"
                    }

                    BasicInput {
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        id: lastnameInput
                    }
                }

                RowLayout {

                    Layout.alignment: Qt.AlignHCenter
                    spacing: 60

                    BasicLabel {
                        Layout.minimumWidth: 100
                        Layout.maximumWidth: 100
                        text: "Α.Φ.Μ:"
                    }

                    BasicInput {
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        id: afmInput
                    }

                    BasicLabel {
                        Layout.minimumWidth: 100
                        Layout.maximumWidth: 100
                        text: "Α.Μ.Κ.Α:"
                    }

                    BasicInput {
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        id: amkaInput
                    }

                }

                RowLayout {

                    Layout.alignment: Qt.AlignHCenter
                    spacing: 60

                    BasicLabel {
                        Layout.minimumWidth: 100
                        Layout.maximumWidth: 100
                        text: "Ηλικία (έτη):"
                    }

                    BasicInput {
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        id: ageYearsInput
                    }

                    BasicLabel {
                        Layout.minimumWidth: 100
                        Layout.maximumWidth: 100
                        text: "Ηλικία (μήνες):"
                    }

                    BasicInput {
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        id: ageMonthsInput
                    }

                }

                RowLayout {

                    Layout.alignment: Qt.AlignHCenter
                    Layout.minimumWidth: 680
                    Layout.maximumWidth: 680
                    spacing: 60

                    BasicLabel {
                        text: "Θα συνταξιοδοτηθείτε με διατάξεις Κ.Β.Α.Ε.;"

                        ToolTip.visible: ma.containsMouse
                        ToolTip.delay: 500
                        ToolTip.text: "Η ερώτηση αφορά ασφαλισμένους του τ. ΙΚΑ που θα συνταξιοδοτηθούν με χρόνο ασφάλισης σε βαρέα και ανθυγιεινά επαγγέλματα."

                        MouseArea {
                            id: ma
                            anchors.fill: parent
                            hoverEnabled: true
                        }

                    }

                    ComboBox {
                        id: bareaInput
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150

                        model: ["OXI", "NAI"]
                        currentIndex: 0
                    }
                }

                RowLayout {

                    Layout.alignment: Qt.AlignHCenter
                    Layout.minimumWidth: 680
                    Layout.maximumWidth: 680
                    spacing: 60

                    BasicLabel {
                        text: "Δικαιούστε σύνταξη αναπηρίας;"
                    }

                    ComboBox {
                        id: anapiriaInput
                        //property bool affirmative: currentIndex === 0
                        model: ["OXI", "NAI"]
                        currentIndex: 0
                    }

                    RowLayout {

                        Layout.fillWidth: true

                        visible: anapiriaInput.currentIndex === 1

                        BasicLabel {
                            text: "Ποσοστό αναπηρίας:"
                        }

                        ComboBox {
                            id: posostoAnapiriasInput
                            //property bool affirmative: currentIndex === 0
                            model: ["50% έως 66%", "67% έως 79%", "80% και άνω"]
                            currentIndex: 0
                        }
                    }
                }

                RowLayout {

                    Layout.alignment: Qt.AlignHCenter
                    Layout.minimumWidth: 680
                    Layout.maximumWidth: 680
                    spacing: 60

                    BasicLabel {
                        text: "Συνολικά έτη ασφάλισης (από όλους τους φορείς):"
                    }

                    BasicInput {
                        id: etiAsfalisisInput
                    }
                }

                RowLayout {

                    Layout.alignment: Qt.AlignHCenter
                    Layout.minimumWidth: 680
                    Layout.maximumWidth: 680
                    spacing: 60

                    BasicLabel {
                        text: "Συνολικά έτη διαμονής στην Ελλάδα:"
                    }

                    BasicInput {
                        id: residenceYearsInput
                    }
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

                    let posostoA = 0;
                    switch(posostoAnapiriasInput.currentIndex) {
                    case 0:
                        posostoA = 60;
                        break;
                    case 1:
                        posostoA = 80;
                        break;
                    case 2:
                        posostoA = 90;
                        break;
                    default:
                        posostoA = 0;
                        break;
                    }

                    let syntaxiBarea = 0;

                    if(bareaInput.currentIndex === 1) {
                        syntaxiBarea = 1;
                    }

                    let syntaxiAnapiria = 0;

                    if(anapiriaInput.currentIndex === 1) {
                        syntaxiAnapiria = 1;
                    }

                    PensionData.insertBasicInfo(nameInput.text, lastnameInput.text, afmInput.text,
                                                amkaInput.text, ageYearsInput.text,
                                                ageMonthsInput.text, syntaxiBarea,
                                                syntaxiAnapiria, posostoA,
                                                residenceYearsInput.text, etiAsfalisisInput.text);
                }
            }
        }
    }

    NumberAnimation {
        id: fadeOut
        target: basicInfoScene
        property: "opacity"
        from: 1
        to: 0
        duration: 300
        easing.type: Easing.InOutQuad

        onFinished: basicInfoScene.readyToContinue = true
    }

}

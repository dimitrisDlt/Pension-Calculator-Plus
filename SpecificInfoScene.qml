import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects
import simplecrud

Pane {

    id: specificInfoScene
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
            text: "6. ΕΙΔΙΚΕΣ ΠΛΗΡΟΦΟΡΙΕΣ."
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

                    Layout.fillHeight: true
                    //Layout.alignment: Qt.AlignHCenter
                    spacing: 60

                    BasicLabel {
                        //Layout.minimumWidth: 100
                       Layout.maximumWidth: 800

                        text: "Σε περίπτωση που εντοπιστεί παράλληλος χρόνος ασφάλισης από το 2002 και μετά δηλώστε τον φορέα που επιθυμείτε να κρατηθεί για τον υπολογισμό του μέσου όρου αποδοχών:"
                        wrapMode: Text.Wrap
                    }

                    ComboBox {
                        id: parallilosForeasInput
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        model: ["Ι.Κ.Α.", "Ο.Α.Ε.Ε./Ε.Τ.Α.Α.", "ΔΗΜΟΣΙΟ", "Ο.Γ.Α."]
                        currentIndex: 0
                    }

                }

                RowLayout {

                    Layout.fillHeight: true
                    //Layout.alignment: Qt.AlignHCenter
                    spacing: 60

                    BasicLabel {
                        //Layout.minimumWidth: 100
                        //Layout.maximumWidth: 100
                        text: "Έχετε παράλληλο χρόνο ασφάλισης πριν το 2002; Εάν ναι συμπληρώστε τους συνολικούς μήνες παράλληλων χρόνων:"

                        ToolTip.visible: mb.containsMouse
                        ToolTip.delay: 500
                        ToolTip.text: "Για την προσμέτρηση παραλλήλων διαστημάτων το ποσοστό εισφοράς που υπολογίζεται από την εφαρμογή είναι 20%."

                        MouseArea {
                            id: mb
                            anchors.fill: parent
                            hoverEnabled: true
                        }
                    }

                    BasicInput {
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        id: parallelMonthsInput
                    }

                }

                RowLayout {

                    Layout.fillHeight: true
                    //Layout.alignment: Qt.AlignHCenter
                    spacing: 60

                    BasicLabel {
                        //Layout.minimumWidth: 100
                        //Layout.maximumWidth: 100
                        text: "Θα συνταξιοδοτηθείτε από τον φορέα του Ο.Γ.Α.;"

                        ToolTip.visible: mc.containsMouse
                        ToolTip.delay: 500
                        ToolTip.text: "Η ερώτηση έχει σημασία καθότι όταν ο απονέμων φορέας είναι ο Ο.Γ.Α. εφαρμόζεται εντελώς διαφορετικός υπολογισμός."

                        MouseArea {
                            id: mc
                            anchors.fill: parent
                            hoverEnabled: true
                        }
                    }

                    ComboBox {
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        property bool affirmative: currentIndex === 1
                        model: ["ΟΧΙ", "ΝΑΙ"]
                        currentIndex: 0
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
                    PensionData.setForeasParallilon(parallilosForeasInput.currentIndex);
                    PensionData.setPre2002ParallelMonths(parallelMonthsInput.text);
                }
            }
        }
    }

    NumberAnimation {
        id: fadeOut
        target: specificInfoScene
        property: "opacity"
        from: 1
        to: 0
        duration: 300
        easing.type: Easing.InOutQuad

        onFinished: specificInfoScene.readyToContinue = true
    }

}

import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Dialogs
import simplecrud

Pane {

    id: resultScene
    property bool readyToRestart: false

    ColumnLayout {
        id: layout
        anchors.fill: parent
        spacing: 20

        Label {
            //Layout.fillWidth: true
            Layout.minimumHeight: 20
            Layout.maximumHeight: 20
            Layout.alignment: Qt.AlignHCenter
            text: "8. ΕΛΕΓΧΟΣ ΑΠΟΤΕΛΕΣΜΑΤΟΣ."
            font.bold: true
            font.pointSize: 16
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            text: "Ο υπολογισμός ολοκληρώθηκε. Πατήστε ΕΚΤΥΠΩΣΗ ΑΠΟΤΕΛΕΣΜΑΤΟΣ για να αποθηκεύσετε το αρχείο που περιλαμβάνει τον αναλυτικό υπολογισμό της σύνταξης."
            wrapMode: Text.Wrap
            font.pointSize: 15
        }

        Pane {

            Layout.fillHeight: true
            Layout.fillWidth: true

            Button {
                anchors.centerIn: parent
                text: "ΕΚΤΥΠΩΣΗ ΑΠΟΤΕΛΕΣΜΑΤΟΣ"
                font.bold: true
                font.pointSize: 18
                Material.background: settings.primaryColor
                Material.foreground: "white"
                Material.elevation: 8

                onClicked: {

                    fileDialog.open();

                }
            }

            FileDialog {
                    id: fileDialog
                    title: "Αποθήκευση αρχείου"
                    fileMode: FileDialog.SaveFile
                    nameFilters: ["Αρχείο PDF (*.pdf)"]

                    //currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
                    onAccepted: {
                        PensionData.calculateParallelMonths();
                        PensionData.calculateNationalPension();
                        PensionData.calculateContributoryPension();
                        PensionData.writeDocument(selectedFile);
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
                text: "ΕΠΑΝΥΠΟΛΟΓΙΣΜΟΣ"
                font.bold: true
                font.pointSize: 18
                Material.background: settings.primaryColor
                Material.foreground: "white"
                Material.elevation: 8

                onClicked: {
                    fadeOut.start();
                }
            }
        }
    }

    NumberAnimation {
        id: fadeOut
        target: resultScene
        property: "opacity"
        from: 1
        to: 0
        duration: 300
        easing.type: Easing.InOutQuad

        onFinished: resultScene.readyToRestart = true
    }

}

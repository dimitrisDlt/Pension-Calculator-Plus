import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Pane {

    id: introScene

    property bool readyToContinue: false

    ColumnLayout {

        anchors.fill: parent
        spacing: 20

        PensionLogoAnimation {
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            width: 600
            height: 600
        }

        BasicLabel {
            Layout.alignment: Qt.AlignCenter
            text: "Καλώς ήρθατε στον ψηφιακό υπολογιστή συντάξεων. Πατήστε το κουμπί συνέχεια για να ξεκινήσετε."
        }

        Button {
            Layout.alignment: Qt.AlignRight
            Layout.rightMargin: 40
            Layout.bottomMargin: 40
            text: "ΣΥΝΕΧΕΙΑ"
            font.bold: true
            font.pointSize: 18

            Material.foreground: "white"
            Material.background: settings.primaryColor
            Material.elevation: 8

            onClicked: fadeOut.start()
        }

    }

    NumberAnimation {
        id: fadeOut
        target: introScene
        property: "opacity"
        from: 1
        to: 0
        duration: 300
        easing.type: Easing.InOutQuad

        onFinished: introScene.readyToContinue = true
    }

}

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.VectorImage

Item {

    width: 420
    height: 260

    opacity: 0

    Behavior on opacity {
        NumberAnimation { duration: 700 }
    }

    Component.onCompleted: {
        opacity = 1
        spin.start()
        titleFade.start()
    }

    VectorImage {
        id: logo
        source: "qrc:/newlogo"
        //source: "assets/logo.svg"
        width: 420
        height: 280
        preferredRendererType: VectorImage.CurveRenderer
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40
        smooth: true

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                spin.start()
                titleFade.start()
            }
        }

        transform: Rotation {
            id: rot
            origin.x: logo.width/2
            origin.y: logo.height/2
            angle: 0
        }

        scale: 0.7
    }

    Text {
        id: title
        text: "Pension Calculator Plus"
        anchors.horizontalCenter: parent.horizontalCenter
        y: 420
        font.pixelSize: 46
        font.bold: true
        opacity: 0
        color: settings.isThemeDark ? "white" : "black"
    }

    SequentialAnimation {

        id: spin

        ParallelAnimation {

            NumberAnimation {
                target: rot
                property: "angle"
                from: -240
                to: 0
                duration: 900
                easing.type: Easing.OutBack
            }

            NumberAnimation {
                target: logo
                property: "scale"
                from: 0.6
                to: 1.0
                duration: 900
                easing.type: Easing.OutBack
            }
        }
    }

    NumberAnimation {
        id: titleFade
        target: title
        property: "opacity"
        from: 0
        to: 1
        duration: 800
        easing.type: Easing.InOutQuad
    }

}

import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects
import Qt.labs.settings
import Qt.labs.platform
import QtQuick.VectorImage

Window {
    id: window
    width: 1600
    height: 900
    visible: true
    title: qsTr("Υπολογισμός Ποσού Συντάξεων")


    color: "transparent"

    Settings {
        id: settings
        //property alias width: window.width
        //property alias height: window.height
        property color primaryColor: "#2F5755"
        property color accentColor: settings.primaryColor
        property bool isThemeDark: true
    }

    Material.accent: settings.accentColor

    Pane {
        id: pane
        anchors.fill: parent
        padding: 0

        Material.accent: settings.accentColor
        Material.theme: settings.isThemeDark ? Material.Dark : Material.Light

        ColumnLayout {
            anchors.fill: parent
            spacing: 20

            Rectangle {
                Layout.fillWidth: true
                Layout.minimumHeight: 70
                Layout.maximumHeight: 70
                color: settings.primaryColor

                layer.enabled: true
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowBlur: 10
                    shadowColor: settings.primaryColor
                }

                RowLayout {
                    anchors.fill: parent
                    spacing: 20

                    Item {
                        Layout.minimumWidth: 110
                        Layout.maximumWidth: 110
                    }

                    Label {
                        Layout.fillWidth: true
                        //Layout.alignment: Qt.AlignCenter
                        text: "Pension Calculator Plus."
                        font.bold: true
                        font.pointSize: 20
                        color: "white"
                        horizontalAlignment: Qt.AlignHCenter
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    VectorImage {
                        Layout.maximumHeight: 35
                        Layout.maximumWidth: 35
                        id: changeTheme
                        property bool darkTheme: settings.isThemeDark ? true : false
                        source: settings.isThemeDark ? "qrc:/sun.svg" : "qrc:/moon.svg"
                        width: 35
                        height: 35
                        fillMode: VectorImage.Stretch
                        preferredRendererType: VectorImage.CurveRenderer

                        ToolTip.visible: md.containsMouse
                        ToolTip.text: "Εναλλαγή θέματος εφαρμογής"

                        MouseArea {

                            id: md
                            anchors.fill: parent
                            hoverEnabled: true

                            onClicked: {
                                if(changeTheme.darkTheme) {
                                    changeTheme.darkTheme = false;
                                    settings.isThemeDark = false;
                                    changeTheme.source = "qrc:/moon.svg"
                                }
                                else {
                                    changeTheme.darkTheme = true;
                                    settings.isThemeDark = true;
                                    changeTheme.source = "qrc:/sun.svg"
                                }
                            }
                        }
                    }

                    VectorImage {
                        Layout.maximumHeight: 35
                        Layout.maximumWidth: 35
                        Layout.rightMargin: 20
                        id: settingsButton

                        source: "qrc:/settings.svg"
                        width: 35
                        height: 35
                        fillMode: VectorImage.Stretch
                        preferredRendererType: VectorImage.CurveRenderer
                        ToolTip.visible: me.containsMouse
                        ToolTip.text: "Ρυθμίσεις εφαρμογής"

                        MouseArea {
                            id: me
                            anchors.fill: parent
                            hoverEnabled: true

                            onClicked: {

                                settingsWindow.show();
                            }
                        }
                    }

                    Window {
                           id: settingsWindow
                           width: 720
                           height: 480
                           visible: false
                           title: "Ρυθμίσεις"

                           ColumnLayout {

                               anchors.fill: parent

                               Rectangle {
                                   Layout.fillWidth: true
                                   Layout.minimumHeight: 60
                                   Layout.maximumHeight: 60
                                   color: settings.primaryColor

                                   Label {
                                       anchors.centerIn: parent
                                       text: "ΡΥΘΜΙΣΕΙΣ ΕΦΑΡΜΟΓΗΣ"
                                       color: "white"
                                       font.pointSize: 18
                                       font.bold: true
                                   }
                               }

                               RowLayout {

                                   Layout.leftMargin: 40
                                   Layout.rightMargin: 40
                                   Layout.fillHeight: true
                                   Layout.fillWidth: true
                                   spacing: 20

                                   BasicLabel {
                                       //Layout.fillHeight: true
                                       Layout.fillWidth: true
                                       text: "Προεπιλεγμένο χρώμα:"
                                   }

                                   Button {
                                       // Layout.fillHeight: true
                                       // Layout.fillWidth: true
                                       text: "ΕΠΙΛΟΓΗ"
                                       Material.background: settings.primaryColor
                                       Material.foreground: "white"
                                       Material.elevation: 8
                                       font.bold: true
                                       font.pointSize: 16
                                       onClicked: {
                                           colorDialog.open();
                                       }
                                   }

                                   Rectangle {
                                       Layout.minimumHeight: 35
                                       Layout.minimumWidth: 35
                                       Layout.maximumHeight: 35
                                       Layout.maximumWidth: 35
                                       color: colorDialog.color
                                   }

                                   ColorDialog {
                                       id: colorDialog
                                       currentColor: settings.primaryColor
                                   }

                               }

                               Label {
                                   Layout.fillHeight: true
                                   Layout.fillWidth: true
                                   id: confirmLabel
                                   text: ""
                                   font.pointSize: 16
                                   color: "green"
                                   horizontalAlignment: Qt.AlignHCenter
                               }

                               RowLayout {

                                   Layout.fillHeight: true
                                   Layout.fillWidth: true
                                   Layout.bottomMargin: 40
                                   Layout.leftMargin: 40
                                   Layout.rightMargin: 40

                                   Button {

                                       Layout.alignment: Qt.AlignLeft
                                       text: "ΕΠΑΝΑΦΟΡΑ"
                                       Material.background: settings.primaryColor
                                       Material.foreground: "white"
                                       Material.elevation: 8
                                       font.bold: true
                                       font.pointSize: 16

                                       onClicked: {
                                           settings.primaryColor = "#2F5755";
                                           settings.accentColor = "#2F5755";
                                           confirmLabel.text = "Η επαναφορά ολοκληρώθηκε!";
                                       }
                                   }

                                   Item {
                                       Layout.fillWidth: true
                                   }

                                   Button {
                                       Layout.alignment: Qt.AlignRight
                                       text: "ΕΦΑΡΜΟΓΗ"
                                       Material.background: settings.primaryColor
                                       Material.foreground: "white"
                                       Material.elevation: 8
                                       font.bold: true
                                       font.pointSize: 16

                                       onClicked: {
                                           settings.primaryColor = colorDialog.color;
                                           settings.accentColor = colorDialog.color;
                                           confirmLabel.text = "Οι αλλαγές αποθηκεύτηκαν επιτυχώς!"
                                       }
                                   }
                               }
                           }
                       }
                }
            }

            Pane {
                Layout.fillHeight: true
                Layout.fillWidth: true

                StackLayout {

                    id: stack
                    anchors.fill: parent
                    currentIndex: 0

                    IntroScene {
                        id: scene1
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        onReadyToContinueChanged: {
                            if(scene1.readyToContinue === true) {
                                stack.currentIndex += 1;
                            }

                        }
                    }

                    BasicInfoScene {
                        id: scene2
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        onReadyToContinueChanged: stack.currentIndex += 1
                    }

                    IkaScene {

                        id: scene3
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        onReadyToContinueChanged: stack.currentIndex += 1
                    }

                    OaeeScene {
                        id: scene4
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        onReadyToContinueChanged: stack.currentIndex += 1
                    }

                    DimosioScene {
                        id: scene5
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        onReadyToContinueChanged: stack.currentIndex += 1
                    }

                    OgaScene {
                        id: scene6
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        onReadyToContinueChanged: stack.currentIndex += 1
                    }

                    SpecificInfoScene {
                        id: scene7
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        onReadyToContinueChanged: stack.currentIndex += 1
                    }

                    PlasmatikaScene {
                        id: scene8
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        onReadyToContinueChanged: stack.currentIndex += 1
                    }

                    ResultScene {
                        id: scene9
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        onReadyToRestartChanged: {
                            scene1.opacity = 1;
                            scene2.opacity = 1;
                            scene3.opacity = 1;
                            scene4.opacity = 1;
                            scene5.opacity = 1;
                            scene6.opacity = 1;
                            scene7.opacity = 1;
                            scene8.opacity = 1;
                            scene9.opacity = 1;
                            scene1.readyToContinue = false;
                            scene2.readyToContinue = false;
                            scene3.readyToContinue = false;
                            scene4.readyToContinue = false;
                            scene5.readyToContinue = false;
                            scene6.readyToContinue = false;
                            scene7.readyToContinue = false;
                            scene8.readyToContinue = false;
                            scene9.readyToRestart = false;
                            stack.currentIndex = 1;
                        }
                    }

                }

            }


        }
    }
}

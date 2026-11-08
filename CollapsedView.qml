import QtQuick
import QtQml
import Quickshell.Hyprland

Item {
    anchors.fill: parent

    Row {
        anchors.centerIn: parent
        spacing: 24

        // 1. Dynamic Workspace Pills
        Row {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 6

            Repeater {
                model: 10
                Rectangle {
                    property bool isActive: Hyprland.focusedWorkspace ? (index + 1) === Hyprland.focusedWorkspace.id : false
                    width: isActive ? 24 : 8
                    height: 8
                    radius: 4
                    color: isActive ? "#89bceb" : "#45475a"

                    Behavior on width { NumberAnimation { duration: 250; easing.type: Easing.OutExpo } }
                    Behavior on color { ColorAnimation { duration: 200 } }
                }
            }
        }

   
        // 3. Digital Clock
        Text {
            id: clockText
            anchors.verticalCenter: parent.verticalCenter
            text: Qt.formatTime(new Date(), "HH:mm")
            color: "#a6e3a1"
            font.pixelSize: 14
            font.bold: true

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clockText.text = Qt.formatTime(new Date(), "HH:mm")
            }
        }
    }
}
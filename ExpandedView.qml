import QtQuick
import Quickshell.Io

Item {
    anchors.fill: parent

    Process {
        id: localLauncher
    }

    Column {
        anchors.fill: parent
        anchors.margins: 4
        spacing: 12

        Rectangle {
            width: parent.width
            height: 20
            color: "transparent"
            
            Text {
                text: "Quick Launcher (Click here or press Esc to close)"
                color: "#fab387"
                font.bold: true
                font.pixelSize: 12
                anchors.centerIn: parent
            }
            
            MouseArea {
                anchors.fill: parent
                onClicked: notch.expanded = false
            }
        }

        Rectangle {
            width: parent.width
            height: 36
            color: "#313244"
            radius: 8
            border.color: "#45475a"
            border.width: 1

            TextInput {
                id: searchInput
                anchors.fill: parent
                anchors.margins: 10
                color: "#cdd6f4"
                font.pixelSize: 14
                verticalAlignment: TextInput.AlignVCenter
                
                Component.onCompleted: searchInput.forceActiveFocus()
                Keys.onEscapePressed: notch.expanded = false

                Text {
                    text: "Type command and press Enter..."
                    color: "#a6adc8"
                    visible: !searchInput.text
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                }

                onAccepted: {
                    if (searchInput.text !== "") {
                        // Safely launch via background shell evaluation
                        localLauncher.running = false
                        localLauncher.command = ["sh", "-c", searchInput.text + " &"]
                        localLauncher.running = true
                        
                        searchInput.text = ""
                        notch.expanded = false
                    }
                }
            }
        }
    }
}
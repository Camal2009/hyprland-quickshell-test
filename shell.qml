import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: PanelWindow {
            required property var modelData
            screen: modelData

            // Global background process for launching apps safely
            Process {
                id: globalLauncher
                command: ["sh", "-c", ""]
            }

            anchors {
                top: true
            }
            
            margins {
                top: 10 
            }

            WlrLayershell.keyboardFocus: notch.expanded ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

            width: notch.expanded ? 480 : 240
            height: notch.expanded ? 120 : 38
            color: "transparent"
            exclusionMode: ExclusionMode.Normal

            Rectangle {
                id: notch
                property bool expanded: false

                anchors.fill: parent
                color: Qt.rgba(0.12, 0.12, 0.18, 0.9) 
                radius: 19
                border.color: "#313244"
                border.width: 1

                Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutBack; easing.overshoot: 1.1 } }
                Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.OutBack; easing.overshoot: 1.1 } }

                MouseArea {
                    anchors.fill: parent
                    enabled: !notch.expanded
                    onClicked: notch.expanded = true
                }

                Loader {
                    anchors.fill: parent
                    anchors.margins: 10
                    source: notch.expanded ? "ExpandedView.qml" : "CollapsedView.qml"
                }
            }
        }
    }
}
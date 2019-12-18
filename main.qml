import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Window {
    id: root
    visible: true
    width: 320
    height: 480
    color: "#afafaf"
    title: qsTr("Miniscope DAQ")

    FileDialog {
        // Used to select user config file

        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            // Remove "file:///" from selected file name
            var path = fileDialog.fileUrl.toString();
            path = path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/,"");
            path = decodeURIComponent(path);

            // Send file name to c++ backend
            backend.userConfigFileName = path
            rbRun.enabled = true
        }
        onRejected: {
            console.log("Canceled")
        }
        visible: false
    }

    ColumnLayout {
        id: columnLayout
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        spacing: 10
        anchors.fill: parent

        RoundButton {
            id: rbSelectUserConfig
            height: 40
            text: "Select User Config File"
            Layout.minimumHeight: 40
            Layout.preferredHeight: 40
            Layout.fillHeight: false
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            font.family: "Arial"
            font.pointSize: 20
            font.bold: true
            font.weight: Font.Normal
            radius: 10
            background: Rectangle {
                radius: rbSelectUserConfig.radius
                border.width: 1
                color: "#a8a7fd"
            }
            onClicked: fileDialog.setVisible(1)

        }

        ScrollView {
            id: view
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.minimumHeight: 80
            Layout.preferredHeight: 80
            Layout.fillHeight: true
            Layout.rowSpan: 4
            TextArea {
                id: taConfigDesc
                text: backend.userConfigDisplay
                wrapMode: Text.WrapAnywhere
                anchors.fill: parent
                font.pointSize: 12
                background: Rectangle {
                    radius: rbSelectUserConfig.radius
                    anchors.fill: parent
                    border.width: 1
                    color: "#ebebeb"
                }
            }
        }

        RoundButton {
            id: rbRun
            height: 40
            radius: 10
            text: "Run"
            enabled: false
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredHeight: 40
            font.family: "Arial"
            font.bold: true
            font.pointSize: 20
            Layout.minimumHeight: 40
            Layout.fillHeight: false
            font.weight: Font.Normal
            background: Rectangle {
                color: "#a8a7fd"
                radius: rbRun.radius
                border.width: 1
            }

            Layout.fillWidth: true
            onClicked: backend.onRunClicked()
        }

        RowLayout {
            id: rowLayout
            height: 40
            Layout.minimumHeight: 40
            Layout.preferredHeight: 40
            Layout.fillHeight: false
            Layout.fillWidth: true
            spacing: 10

            RoundButton {
                id: rbHelp
                height: 40
                radius: 10
                text: "Help"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.family: "Arial"
                font.pointSize: 20
                font.bold: true
                font.weight: Font.Normal
                background: Rectangle {
                    color: "#a8a7fd"
                    radius: rbSelectUserConfig.radius
                    border.width: 1
                }
            }

            RoundButton {
                id: rbExit
                height: 40
                text: "Exit"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                radius: 10
                font.family: "Arial"
                font.pointSize: 20
                font.bold: true
                font.weight: Font.Normal
                background: Rectangle {
                    radius: rbSelectUserConfig.radius
                    border.width: 1
                    color: "#a8a7fd"
                }
                onClicked: Qt.quit()
            }
        }

    }
}

import QtQuick 2.2
import QtQuick.Window 2.0
import Sailfish.Silica 1.0
import QtQuick.Layouts 1.1

Page {
    id: root

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge
        VerticalScrollDecorator {}
        PullDownMenu {
            id: typeMenu
            MenuItem {
                text: qsTr("Setting")
                onClicked: {
                    // Handle the "Setting" action here
                }
            }
            MenuItem {
                text: qsTr("Add")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("EditTransationPage.qml"))
                }
            }
        }

        Column {
            spacing: Theme.paddingLarge
            id: column
            width: parent.width

            PageHeader {
                width: parent.width
                height: 100

                Row {
                    width: parent.width
                    height: parent.height
                    id: date_row

                    IconButton {
                        id: moveBackwardsButton
                        icon.source: "image://theme/icon-m-left"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: Theme.paddingSmall
                    }

                    Label {
                        width: parent.width - moveBackwardsButton.width - moveForwardsButton.width - (Theme.paddingSmall * 2)
                        text: qsTr("27/08 ~ 26/09/2024")
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    IconButton {
                        id: moveForwardsButton
                        icon.source: "image://theme/icon-m-right"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: Theme.paddingSmall
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 100
                color: "white"
                border.color: "gray"

                Row {
                    anchors.fill: parent
                    anchors.margins: Theme.paddingSmall
                    spacing: Theme.itemSizeSmall

                    // Left Column
                    Column {
                        width: parent.width * 0.27
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            text: qsTr("Income")
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("$0.00")
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    // Center Column
                    Column {
                        width: pparent.width * 0.27
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            text: qsTr("Expenses")
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("$0.00")
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    // Right Column
                    Column {
                        width: parent.width * 0.27
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            text: qsTr("Total")
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("$0.00")
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            Column {
                width: parent.width
                spacing: Theme.paddingSmall

                // First Row with date and amounts
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "black"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Mon")
                            color: "white"
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("01/09/2024")
                            color: "white"
                            width: parent.width * 0.45
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            color: "blue"
                            width: parent.width * 0.175
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("$0.00")
                            color: "red"
                            width: parent.width * 0.175
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Repeat the above Rectangle for additional transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Additional rows can follow the same structure
            }

            Column {
                width: parent.width
                spacing: Theme.paddingSmall

                // First Row with date and amounts
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "black"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Mon")
                            color: "white"
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("01/09/2024")
                            color: "white"
                            width: parent.width * 0.45
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            color: "blue"
                            width: parent.width * 0.175
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("$0.00")
                            color: "red"
                            width: parent.width * 0.175
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Repeat the above Rectangle for additional transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Additional rows can follow the same structure
            }

            Column {
                width: parent.width
                spacing: Theme.paddingSmall

                // First Row with date and amounts
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "black"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Mon")
                            color: "white"
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("01/09/2024")
                            color: "white"
                            width: parent.width * 0.45
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            color: "blue"
                            width: parent.width * 0.175
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("$0.00")
                            color: "red"
                            width: parent.width * 0.175
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Repeat the above Rectangle for additional transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Second Row with transaction details
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "lightgray"
                    border.color: "gray"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.rightMargin: Theme.paddingSmall

                        Text {
                            text: qsTr("Transfer")
                            width: parent.width * 0.3
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("Chase -> Lloyds Bank")
                            width: parent.width * 0.5
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item { // Spacer
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("$0.00")
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Additional rows can follow the same structure
            }
        }
    }
}

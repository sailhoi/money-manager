import QtQuick 2.6
import QtQuick.Window 2.0
import Sailfish.Silica 1.0
import QtQuick.Layouts 1.1
import QtQuick.LocalStorage 2.0
import "../Categories_Incomes_db.js" as Categories_Income
import "../Categories_Expenses_db.js" as Categories_Expenses
import "../JS/Accounts_db.js" as AccountsManager
import "../JS/AccountTypes_db.js" as AccountTypesManager




Page {
    id: root
    property date selectedDate: new Date()

    Component.onCompleted: {
        if(Categories_Income.getNumberOftables() === 0)
            Categories_Income.initializeDatabase();
            Categories_Expenses.initializeDatabase();
            AccountsManager.initializeDatabase();
            AccountTypesManager.initializeDatabase();
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge
        VerticalScrollDecorator {}
        PullDownMenu {
            id: typeMenu
            MenuItem {
                text: qsTr("Setting")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("SettingPage.qml"))
                }
            }
            MenuItem {
                text: qsTr("This month")
                onClicked: {
                    onClicked: {
                        // Reset the selected date to the current month and year
                        selectedDate = new Date()
                        dateLabel.text = Qt.formatDate(selectedDate, "MMMM yyyy")
                    }
                }
            }
            MenuItem {
                text: qsTr("Add")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("EditTransationPage.qml"),{dataContainer: root})
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

//                    IconButton {
//                        id: moveBackwardsButton
//                        icon.source: "image://theme/icon-m-left"
//                        anchors.verticalCenter: parent.verticalCenter
//                        anchors.left: parent.left
//                        anchors.leftMargin: Theme.paddingSmall
//                        onClicked: {
//                            // Decrease the month by 1, properly handling year change
//                            var newMonth = selectedDate.getMonth() - 1
//                            selectedDate.setMonth(newMonth)
//                            dateLabel.text = Qt.formatDate(selectedDate, "MMMM yyyy")
//                        }
//                    }

                    // Label to display the selected date
                    Label {
                        id: dateLabel
                        text: Qt.formatDate(selectedDate, "MMMM yyyy")
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        // Styling the text (optional)
                        font.bold: true
                        font.pointSize: 20
                        color: "white"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                var obj = pageStack.animatorPush("Sailfish.Silica.DatePickerDialog", { date: selectedDate })

                                obj.pageCompleted.connect(function(page) {
                                    page.accepted.connect(function() {
                                        selectedDate = page.date
                                        dateLabel.text = Qt.formatDate(selectedDate, "MMMM yyyy")
                                    })
                                })
                            }
                        }
                    }


//                    IconButton {
//                        id: moveForwardsButton
//                        icon.source: "image://theme/icon-m-right"
//                        anchors.verticalCenter: parent.verticalCenter
//                        anchors.right: parent.right
//                        anchors.rightMargin: Theme.paddingSmall
//                        onClicked: {
//                            // Increase the month by 1, properly handling year change
//                            var newMonth = selectedDate.getMonth() + 1
//                            selectedDate.setMonth(newMonth)
//                            dateLabel.text = Qt.formatDate(selectedDate, "MMMM yyyy")
//                        }
//                    }
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
                        width: parent.width * 0.26
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
                        width: parent.width * 0.26
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
                        width: parent.width * 0.26
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
                            text: qsTr("Sun")
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
                            text: qsTr("Chase 1 -> Lloyds Bank")
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
                            text: qsTr("Chase 2 -> Lloyds Bank")
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
                            text: qsTr("Chase 3 -> Lloyds Bank")
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
                            text: qsTr("02/09/2024")
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
                            text: qsTr("Chase 1 -> Lloyds Bank")
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
                            text: qsTr("Chase 2 -> Lloyds Bank")
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
                            text: qsTr("Chase 3 -> Lloyds Bank")
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
                            text: qsTr("Tue")
                            color: "white"
                            width: parent.width * 0.2
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: qsTr("03/09/2024")
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
                            text: qsTr("Chase 1 -> Lloyds Bank")
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
                            text: qsTr("Chase 2 -> Lloyds Bank")
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
                            text: qsTr("Chase 3 -> Lloyds Bank")
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
                            text: qsTr("Chase 4 -> Lloyds Bank")
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
                            text: qsTr("Chase 5 -> Lloyds Bank")
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
                            text: qsTr("Chase 6 -> Lloyds Bank")
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
                            text: qsTr("Chase 7 -> Lloyds Bank")
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
                            text: qsTr("Chase 8 -> Lloyds Bank")
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
                            text: qsTr("Chase 9 -> Lloyds Bank")
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
                            text: qsTr("Chase 10 -> Lloyds Bank")
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
                            text: qsTr("Chase 11 -> Lloyds Bank")
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

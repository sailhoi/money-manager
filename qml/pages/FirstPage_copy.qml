import QtQuick 2.0
import Sailfish.Silica 1.0
import "../database.js" as DB

Page {
    id: mainPage
    allowedOrientations: Orientation.All

    property string selectedDate: "All"

    ListModel {
        id: moneyModel
    }

    ListModel {
        id: filteredModel
    }

    Component.onCompleted: {
        DB.initializeDatabase(); // Initialize the database
        loadTransactions(); // Load transactions when the page is loaded
    }

    function loadTransactions() {
        DB.getTransactions(selectedDate, function(rows) {
            moneyModel.clear();
            for (var i = 0; i < rows.length; i++) {
                var item = rows.item(i);
                moneyModel.append({
                    type: item.type,
                    name: item.name,
                    amount: item.amount.toFixed(2),
                    date: item.date
                });
            }
            filterData();
        });
    }

    function filterData() {
        filteredModel.clear();
        for (var i = 0; i < moneyModel.count; i++) {
            var item = moneyModel.get(i);
            if (selectedDate === "All" || item.date === selectedDate) {
                filteredModel.append(item);
            }
        }
    }

    SilicaFlickable {
        anchors.fill: parent

        Column {
            width: parent.width
            spacing: Theme.paddingLarge

            Rectangle {
                width: parent.width
                height: 60
                color: Theme.primaryColor
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Money Manager")
                    font.bold: true
                    font.pixelSize: 24
                }
            }

            Button {
                text: qsTr("Selected Date: ") + selectedDate
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    var page = pageStack.push(Qt.resolvedUrl("DatePickerPage.qml"))
                    page.onDateSelected = function(date) {
                        if (date) {
                            selectedDate = date.toString(Qt.ISODate);
                            loadTransactions();
                            selectedDateText.text = qsTr("Selected Date: ") + selectedDate;
                        }
                    }
                }
            }

            ListView {
                width: parent.width
                height: parent.height - 60 - Theme.paddingLarge - 50
                model: filteredModel
                delegate: Item {
                    width: parent.width
                    height: 100
                    Rectangle {
                        width: parent.width
                        height: 100
                        color: (model.type === "Expense") ? "lightcoral" : "lightgreen"
                        border.color: "gray"
                        Column {
                            anchors.fill: parent
                            spacing: 5
                            Text {
                                text: model.name + ": " + model.amount
                                anchors.left: parent.left
                                anchors.leftMargin: Theme.paddingLarge
                            }
                            Text {
                                text: model.date
                                anchors.right: parent.right
                                anchors.rightMargin: Theme.paddingLarge
                                color: "gray"
                            }
                        }
                    }
                }
            }

            Row {
                spacing: Theme.paddingLarge
                Button {
                    text: qsTr("Add Expense")
                    onClicked: addExpenseDialog.open()
                }
                Button {
                    text: qsTr("Add Income")
                    onClicked: addIncomeDialog.open()
                }
            }
        }
    }

    Dialog {
        id: addExpenseDialog
        visible: false
        Column {
            spacing: Theme.paddingLarge

            TextField {
                id: expenseNameInput
                placeholderText: qsTr("Expense Name")
            }

            TextField {
                id: expenseAmountInput
                placeholderText: qsTr("Amount")
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }

            DatePicker {
                id: expenseDatePicker
            }
        }

        Row {
            spacing: Theme.paddingLarge
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            Button {
                text: qsTr("Cancel")
                onClicked: addExpenseDialog.close()
            }
            Button {
                text: qsTr("Add")
                onClicked: {
                    var name = expenseNameInput.text;
                    var amount = parseFloat(expenseAmountInput.text);
                    var date = expenseDatePicker.selectedDate ? expenseDatePicker.selectedDate.toString(Qt.ISODate) : "All";

                    DB.addTransaction("Expense", name, amount, date);
                    loadTransactions(); // Refresh the ListView
                    addExpenseDialog.close();
                }
            }
        }
    }

    Dialog {
        id: addIncomeDialog
        visible: false
        Column {
            spacing: Theme.paddingLarge

            TextField {
                id: incomeNameInput
                placeholderText: qsTr("Income Source")
            }

            TextField {
                id: incomeAmountInput
                placeholderText: qsTr("Amount")
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }

            DatePicker {
                id: incomeDatePicker
            }
        }

        Row {
            spacing: Theme.paddingLarge
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            Button {
                text: qsTr("Cancel")
                onClicked: addIncomeDialog.close()
            }
            Button {
                text: qsTr("Add")
                onClicked: {
                    var name = incomeNameInput.text;
                    var amount = parseFloat(incomeAmountInput.text);
                    var date = incomeDatePicker.selectedDate ? incomeDatePicker.selectedDate.toString(Qt.ISODate) : "All";

                    DB.addTransaction("Income", name, amount, date);
                    loadTransactions(); // Refresh the ListView
                    addIncomeDialog.close();
                }
            }
        }
    }
}

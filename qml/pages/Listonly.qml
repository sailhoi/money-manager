import QtQuick 2.0
import Sailfish.Silica 1.0
import "../database.js" as DB

Page {
    id: mainPage
    allowedOrientations: Orientation.All

    property string selectedDate: "All"
    property string selectedType: "All"
    property string selectedSort: "Date" // Property for selected sort order

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
                    amount: parseFloat(item.amount).toFixed(2),
                    date: item.date
                });
            }
            filterData();
        });
    }

    function filterData() {
        filteredModel.clear();
        var items = [];
        for (var i = 0; i < moneyModel.count; i++) {
            var item = moneyModel.get(i);
            if ((selectedDate === "All" || item.date === selectedDate) &&
                (selectedType === "All" || item.type === selectedType)) {
                items.push(item);
            }
        }

        // Sort items based on the selected sort order
        items.sort(function(a, b) {
            if (selectedSort === "Date") {
                return new Date(a.date) - new Date(b.date);
            } else if (selectedSort === "Amount") {
                return parseFloat(a.amount) - parseFloat(b.amount);
            } else {
                return 0; // Default case
            }
        });

        // Add sorted items to filteredModel
        for (var j = 0; j < items.length; j++) {
            filteredModel.append(items[j]);
        }

        // Update the contentHeight of the ListView
        updateListViewHeight();
    }

    function updateListViewHeight() {
        // Calculate total height of all items in the ListView
        var itemHeight = 100; // Height of each item in the ListView
        listView.contentHeight = filteredModel.count * itemHeight;
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
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

            PullDownMenu {
                id: typeMenu
                MenuItem {
                    text: qsTr("Setting")
                    onClicked: {
                    }
                }
                MenuItem {
                    text: qsTr("Add")
                    onClicked: {
                    }
                }
            }


            ComboBox {
                id: typeComboBox
                label: qsTr("Select Type")
                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("All")
                        onClicked: {
                            selectedType = "All";
                            filterData();
                        }
                    }
                    MenuItem {
                        text: qsTr("Income")
                        onClicked: {
                            selectedType = "Income";
                            filterData();
                        }
                    }
                    MenuItem {
                        text: qsTr("Expense")
                        onClicked: {
                            selectedType = "Expense";
                            filterData();
                        }
                    }
                }
            }

            ComboBox {
                id: sortComboBox
                label: qsTr("Sort By")
                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("Date")
                        onClicked: {
                            selectedSort = "Date";
                            filterData();
                        }
                    }
                    MenuItem {
                        text: qsTr("Amount")
                        onClicked: {
                            selectedSort = "Amount";
                            filterData();
                        }
                    }
                }
            }

            ListView {
                id: listView
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
                            Button {
                                text: qsTr("Delete")
                                onClicked: {
                                    // Call the delete function with the record's unique identifier
                                    DB.deleteTransaction(model.date);
                                    loadTransactions(); // Refresh the ListView
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

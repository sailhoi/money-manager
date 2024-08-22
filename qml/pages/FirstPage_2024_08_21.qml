import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../database.js" as DB

Page {
    id: root
    allowedOrientations: Orientation.All

    property string selectedDate: "All"
    property string selectedType: "All"
    property string selectedSort: "Date" // Property for selected sort order

    function addTransation(title) {

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

    Component.onCompleted: {
        DB.initializeDatabase(); // Initialize the database
        loadTransactions(); // Load transactions when the page is loaded
    }

    ListModel {
        id: moneyModel
    }

    ListModel {
        id: filteredModel
    }

    SilicaListView {
        id: transationList
        width: root.width
        height: root.height
        anchors.top: parent.top
        model: filteredModel
        header: PageHeader {
            title: qsTr("Transations")
        }
        Column {
            width: parent.width
            spacing: Theme.paddingLarge
            Row {
                width: parent.width
                ComboBox {
                    id: monthComboBox
                    width: parent.width / 2
                    label: "Month"

                    menu: ContextMenu {
                        MenuItem { text: "an option" }
                        MenuItem { text: "yet another option" }
                        MenuItem { text: "yet another option with a long label" }
                    }
                }

                ComboBox {
                    id: yearComboBox
                    width: parent.width / 2
                    label: "Year"

                    menu: ContextMenu {
                        MenuItem { text: "an option" }
                        MenuItem { text: "yet another option" }
                        MenuItem { text: "yet another option with a long label" }
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
        }
        ViewPlaceholder {
            enabled: moneyModel.count == 0
            text: "Please Create a transation."
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
        VerticalScrollDecorator {}
    }

    Label {
        Rectangle {
            width: parent.width
            color: "black"
            border.color: "gray"
            Row {
                anchors.fill: parent
                spacing: 5
                Text {
                    text: "Name"
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.paddingLarge
                    color: "white"
                }
                Text {
                    text: "Date"
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.paddingLarge
                    color: "white"
                }
            }
        }
    }
}

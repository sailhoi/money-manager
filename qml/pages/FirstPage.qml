import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../database.js" as DB


Page
{
    id: page
    allowedOrientations: Orientation.All

    // -----------------------------------------------------------------------

    property string selectedDate: "All"
    property string selectedType: "All"
    property string selectedSort: "Date" // Property for selected sort order

    // -----------------------------------------------------------------------

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
        // Get the current date when the page is loaded
        var today = new Date();
        var day = today.getDate();
        var month = today.getMonth() + 1; // Months are zero-based
        var year = today.getFullYear();

        // Format date as DD/MM/YYYY (you can adjust this format as needed)
        selectedDate = day + "/" + month + "/" + year;
    }

    ListModel {
        id: moneyModel
    }

    ListModel {
        id: filteredModel
    }

    SilicaFlickable
    {
        anchors { fill: parent; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
//        contentHeight: column.height

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

        Column
        {
            id: head_column
            width: parent.width
            spacing: Theme.paddingSmall

            PageHeader {
                title: qsTr("Transations")
            }

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

            PageHeader {
                width: parent.width
                height: 100

                Row {
                    height: parent.height
                    width: parent.width
                    id: date_row

                    IconButton {
                        id: moveBackwardsButton
                        icon.source: "image://theme/icon-m-left"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
//                        visible: !graph.reachedStart
                    }

                    Label {
                        width: parent.width - moveBackwardsButton.width - moveForwardsButton.width
                        text: selectedDate
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
//                        visible: graph.dayOffset > 0
                    }
                }
            }


            PageHeader {
                width: parent.width
                height: Theme.paddingLarge
                Rectangle {
                    id: listTitle
                    width: parent.width
                    height: 50
                    color: "black"
                    border.color: "gray"
                    Row {
                        anchors.fill: parent
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

            Column {
                id: body_column
                width: parent.width
                height: parent.height // Ensure the Column fills the parent's height

                ListView {
                    id: listElement
                    width: parent.width
                    height: parent.height // Ensure the ListView fills the remaining space in the Column
                    model: filteredModel

                    delegate: ListItem {
                        width: parent.width
                        _backgroundColor: (model.type === "Expense") ? "lightcoral" : "lightgreen"

                        onClicked: {
                            if (!menuOpen && pageStack.depth === 2) {
                                pageStack.animatorPush(Qt.resolvedUrl("FirstPage.qml"))
                            }
                        }

                        ListView.onRemove: animateRemoval()
                        enabled: !root.deletingItems
                        opacity: enabled ? 1.0 : 0.0
                        Behavior on opacity { FadeAnimator {}}

                        menu: Component {
                            ContextMenu {
                                MenuItem {
                                    text: "Delete"
                                    onClicked: remove()
                                }
                                MenuItem {
                                    text: "Second option"
                                }
                            }
                        }

                        Row {
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

                    VerticalScrollDecorator {} // Place the VerticalScrollDecorator inside the ListView to handle scrolling
                }
            }

        }
    }
}

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../../JS/Accounts_db.js" as AccountsManager

Page {
    id: categoriesPage
    property var type;

    property int typeID
    property string typeName

    SilicaListView {
        id: listView

        PullDownMenu {
            id: pullDownMenu

            MenuItem {
                text: qsTr("Add Account")
                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("AccountPage.qml"));
                    dialog.accepted.connect(function() {
                        if (dialog.name && dialog.name.trim() !== "") {
                            AccountsManager.insertAccount(dialog.name.trim(), typeID);
                            refreshItems();
                        } else {
                            console.error("Account name cannot be empty");
                        }
                    });
                }
            }

            MenuItem {
                text: qsTr("Reset Accounts")
                visible: listModel.count > 0
                onClicked: {
                    var confirmation = Remorse.popupAction(
                        root,
                        qsTr("Are you sure you want to reset all categories?"),
                        function() {
                            AccountsManager.resetDatabase();
                            refreshItems();
                        }
                    );
                }
            }
        }

        model: listModel
        anchors.fill: parent

        header: PageHeader {
            title: typeName
        }

        ViewPlaceholder {
            enabled: listModel.count === 0
            text: qsTr("No Account")
            hintText: qsTr("Pull down to add a new Account")
        }

        delegate: ListItem {
            id: delegate

            function remove() {
                remorseDelete(function() {
                    DBmanager.deleteCategory(modelData);
                    refreshItems();
                });
            }

            onClicked: {
                if (!menuOpen) {
                    var dialog = pageStack.push(Qt.resolvedUrl("AccountPage.qml"), {"accountID": model.account_id, "accountName": model.name});
                    dialog.accepted.connect(function() {
                        if (dialog.name && dialog.name.trim() !== "") {
                            if (dialog.name.trim() !== model.name) {
                                AccountsManager.updateAccount(model.account_id, dialog.name.trim());
                                refreshItems();
                            } else {
                                console.log("No changes to the category name");
                            }
                        } else {
                            console.error("Category name cannot be empty");
                        }
                        refreshItems();
                    });
                }
            }

            Label {
                x: Theme.horizontalPageMargin
                width: parent.width - 2 * x
                anchors.verticalCenter: parent.verticalCenter
                text: model.name
                truncationMode: TruncationMode.Fade
                font.capitalization: Font.Capitalize
            }

            menu: Component {
                ContextMenu {
                    MenuItem {
                        text: qsTr("Delete")
                        onClicked: remove()
                    }
                }
            }
        }
        VerticalScrollDecorator {}
    }

    ListModel {
        id: listModel
    }

    Component.onCompleted: refreshItems()

    function refreshItems() {
        listModel.clear(); // Clear the list model
        var accounts = AccountsManager.getAllAccounts(typeID); // Get accounts as an object

        // Iterate through the accounts object
        for (var accountId in accounts) {
            if (accounts.hasOwnProperty(accountId)) { // Ensure the property is directly on the object
                console.log("Account ID:", accountId, "Name:", accounts[accountId]); // Log account details

                // Append to the list model
                listModel.append({
                    "account_id": parseInt(accountId), // Ensure the ID is an integer
                    "name": accounts[accountId] // Set the account name
                });
            }
        }
    }
}

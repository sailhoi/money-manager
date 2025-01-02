import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../../JS/AccountTypes_db.js" as AccountTypesManager

Page {
    id: accountsPage

    property string newAccount

    SilicaListView {
        id: listView

        PullDownMenu {
            id: pullDownMenu

            MenuItem {
                text: qsTr("Add Account Type")
                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("EditAccountTypePage.qml"));
                    dialog.accepted.connect(function() {
                        if (dialog.name && dialog.name.trim() !== "") {
                            AccountTypesManager.insertAccountType(dialog.name.trim());
                            refreshItems();
                        } else {
                            console.error("Account Type name cannot be empty");
                        }
                    });
                }
            }

            MenuItem {
                text: qsTr("Reset Account Types")
                onClicked: {
                    var confirmation = Remorse.popupAction(
                        root,
                        qsTr("Are you sure you want to reset all accounts?"),
                        function() {
                            AccountTypesManager.resetDatabase();
                            refreshItems();
                        }
                    );
                }
            }
        }

        model: listModel
        anchors.fill: parent

        header: PageHeader {
            title: qsTr("Account Types")
        }

        ViewPlaceholder {
            enabled: listModel.count === 0
            text: qsTr("No account types available")
            hintText: qsTr("Pull down to add a new account type")
        }

        delegate: ListItem {
            id: delegate

            function remove() {
                remorseDelete(function() {
                    AccountTypesManager.deleteCategory(model.name);
                    refreshItems();
                });
            }

            onClicked: {
                if (!menuOpen) {
                    pageStack.animatorPush(Qt.resolvedUrl("AccountsPage.qml"), { "typeID": model.type_id, "typeName": model.name });
                }
            }

            Label {
                x: Theme.horizontalPageMargin
                width: parent.width - 2 * x
                anchors.verticalCenter: parent.verticalCenter
                text: model.name // Display and name
                truncationMode: TruncationMode.Fade
                font.capitalization: Font.Capitalize
            }
        }
        VerticalScrollDecorator {}
    }

    ListModel {
        id: listModel
    }

    Component.onCompleted: refreshItems()

    function refreshItems() {
        listModel.clear();
        var accountTypes = AccountTypesManager.getAllAccountTypes(); // Returns an object with type_id as keys
        for (var typeId in accountTypes) {
            if (accountTypes.hasOwnProperty(typeId)) {
                listModel.append({
                    "type_id": parseInt(typeId), // Convert the key back to an integer
                    "name": accountTypes[typeId]
                });
            }
        }
    }
}

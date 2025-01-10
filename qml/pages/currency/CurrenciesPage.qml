import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../../JS/Currencies_db.js" as CurrenciesManager


Page {
    id: categoriesPage

    property string newCategory

    SilicaListView {
        id: listView

        PullDownMenu {
            id: pullDownMenu

            MenuItem {
                text: qsTr("Add Category")
                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("Expense_CategoryPage.qml"));
                    dialog.accepted.connect(function() {
                        if (dialog.name && dialog.name.trim() !== "") {
                            DBmanager.insertCategory(dialog.name.trim());
                            refreshItems();
                        } else {
                            console.error("Category name cannot be empty");
                        }
                    });
                }
            }

            MenuItem {
                text: qsTr("Reset Categories")
//                visible: listModel.count > 0
                onClicked: {
                    var confirmation = Remorse.popupAction(
                        root,
                        qsTr("Are you sure you want to reset all currencies?"),
                        function() {
                            CurrenciesManager.resetDatabase();
                            refreshItems();
                        }
                    );
                }
            }
        }

        model: listModel
        anchors.fill: parent

        header: PageHeader {
            title: qsTr("Income Categories")
        }

        ViewPlaceholder {
            enabled: listModel.count === 0
            text: qsTr("No income categories")
            hintText: qsTr("Pull down to add a new category")
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
                    var dialog = pageStack.push(Qt.resolvedUrl("Expense_CategoryPage.qml"), {"categoryName": modelData});
                    dialog.accepted.connect(function() {
                        if (dialog.name && dialog.name.trim() !== "") {
                            if (dialog.name.trim() !== modelData) {
                                DBmanager.updateCategory(modelData, dialog.name.trim());
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

            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    margins: Theme.horizontalPageMargin
                }
                spacing: Theme.paddingSmall

                Label {
                    width: parent.width
                    text: model.title
                    truncationMode: TruncationMode.Fade
                    font.capitalization: Font.Capitalize
                }

                Label {
                    width: parent.width
                    text: model.currency + ": " + model.rate
                    truncationMode: TruncationMode.Fade
                    font.capitalization: Font.MixedCase
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: Theme.secondaryColor // Differentiates the rate visually
                }
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
        listModel.clear();
        var categories = CurrenciesManager.getAllCurrencies(); // Returns an object with currency_id as keys

        for (var currencyId in categories) {
            if (categories.hasOwnProperty(currencyId)) {
                listModel.append({
                    "type_id": currencyId, // Using the key directly as type_id
                    "title": categories[currencyId].title, // Access the title property,
                    "currency": categories[currencyId].currency,
                    "rate": parseFloat(categories[currencyId].rate), // Access and parse the rate property
                });
            }
        }
    }
}

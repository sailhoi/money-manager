import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../Categories_Expenses_db.js" as DBmanager

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
                visible: listModel.count > 0
                onClicked: {
                    var confirmation = Remorse.popupAction(
                        root,
                        qsTr("Are you sure you want to reset all categories?"),
                        function() {
                            DBmanager.reset();
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

            Label {
                x: Theme.horizontalPageMargin
                width: parent.width - 2 * x
                anchors.verticalCenter: parent.verticalCenter
                text: modelData
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
        listModel.clear();
        var categories = DBmanager.getAllCategories();
        for (var i = 0; i < categories.length; i++) {
            listModel.append({ "name": categories[i] });
        }
    }
}

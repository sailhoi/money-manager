import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../../JS/Currencies_db.js" as CurrenciesManager

Page {
    id: currenciesPage

    property string newAccount

    SilicaListView {
        id: listView

        PullDownMenu {
            id: pullDownMenu

            MenuItem {
                text: qsTr("Add Currency")
                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("EditCurrencyPage.qml"));
                    dialog.accepted.connect(function() {
                        if (dialog.name && dialog.name.trim() !== "") {
                            CurrenciesManager.insertCurrency(dialog.currency_id, dialog.name.trim(), dialog.rate);
                            refreshItems();
                        } else {
                            console.error("Currency name cannot be empty");
                        }
                    });
                }
            }

            MenuItem {
                text: qsTr("Reset Currencies")
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
            title: qsTr("Currencies")
        }

        ViewPlaceholder {
            enabled: listModel.count === 0
            text: qsTr("No currencies available")
            hintText: qsTr("Pull down to add a new currency")
        }

        delegate: ListItem {
            id: delegate

            function remove() {
                remorseDelete(function() {
                    CurrenciesManager.deleteCurrency(model.type_id);
                    refreshItems();
                });
            }

            onClicked: {
                if (!menuOpen) {
                    pageStack.animatorPush(Qt.resolvedUrl("CurrencyPage.qml"), { "typeID": model.type_id, "typeName": model.name });
                }
            }

            Label {
                x: Theme.horizontalPageMargin
                width: parent.width - 2 * x
                anchors.verticalCenter: parent.verticalCenter
                text: model.name // Display name
                truncationMode: TruncationMode.Fade
                font.capitalization: Font.Capitalize
            }
            Label {
                x: Theme.horizontalPageMargin
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                text: model.rate // Display rate
                truncationMode: TruncationMode.Fade
                font.pixelSize: Theme.fontSizeExtraSmall
                horizontalAlignment: Text.AlignRight
            }
        }
        VerticalScrollDecorator {}
    }

    ListModel {
        id: listModel
    }

    onStatusChanged: {
        if (page.status === PageStatus.Activating) {
            CurrenciesManager.initializeDatabase();
            refreshItems();
        }
    }

    function refreshItems() {
        listModel.clear();
        var currencies = CurrenciesManager.getAllCurrencies(); // Returns an object with type_id as keys
        for (var currencyId in currencies) {
            if (currencies.hasOwnProperty(currencyId)) {
                listModel.append({
                    "type_id": currencyId,
                    "name": currencies[currencyId].name,
                    "rate": currencies[currencyId].rate
                });
            }
        }
    }
}

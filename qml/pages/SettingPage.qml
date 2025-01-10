import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: mainPage

    ListModel {
        id: pagesModel

        ListElement {
            page: ""
            title: "Calculator"
            section: ""
        }
        ListElement {
            page: ""
            title: "PC Manager"
            section: ""
        }
        ListElement {
            page: ""
            title: "Help"
            section: ""
        }
        ListElement {
            page: ""
            title: "Feedback"
            section: ""
        }
        ListElement {
            page: ""
            title: "Rate it"
            section: ""
        }
        ListElement {
            page: "TransactionSettingsPage"
            title: "Transaction Settings"
            subtitle: "Monthly Start Date, Carry-over Setting, Period, Other"
            section: "Trans."
        }
        ListElement {
            page: ""
            title: "Repeat Setting"
            section: "Trans."
        }
        ListElement {
            page: ""
            title: "Copy-Paste Setting"
            section: "Trans."
        }
        ListElement {
            page: "IncomeCategoriesPage.qml"
            title: "Income Category Setting"
            section: "Category/Accounts"
        }
        ListElement {
            page: "Expense_CategoriesPage.qml"
            title: "Expenses Category Setting"
            section: "Category/Accounts"
        }
        ListElement {
            page: "account/AccountTypesPage.qml"
            title: "Accounts Setting"
            subtitle: "Account Group, Accounts, Include in totals, Transfer-Expenses, Deleted accounts Setting, Card expenses display config"
            section: "Category/Accounts"
        }
        ListElement {
            page: "BudgetsSettingPage.qml"
            title: "Budgets Setting"
            section: "Category/Accounts"
        }
        ListElement {
            page: "BackupSettingPage.qml"
            title: "Backup"
            subtitle: "Export, Import, A complate reset"
            section: "Setting"
        }
        ListElement {
            page: "PasscodeSettingPage.qml"
            title: "Passcode"
            section: "Setting"
        }
        ListElement {
            page: "MainCurrencySettingPage.qml"
            title: "Main Currency Setting"
            subtitle: "Currenly Currency"
            section: "Setting"
        }
        ListElement {
            page: "currency/CurrenciesPage.qml"
            title: "Sub Currency Setting"
            subtitle: "List on Sub Currency"
            section: "Setting"
        }
        ListElement {
            page: ""
            title: "Alarm Setting"
            section: "Setting"
        }
        ListElement {
            page: ""
            title: "Style"
            section: "Setting"
        }
        ListElement {
            page: ""
            title: "Application Icon"
            section: "Setting"
        }
        ListElement {
            page: ""
            title: "Language Setting"
            section: "Setting"
        }
        ListElement {
            page: "ResetDatabasePage.qml"
            title: "Data Reset"
            section: "Setting"
        }
    }

    SilicaListView {
        id: listView
        anchors.fill: parent
        model: pagesModel
        header: PageHeader { title: "Components" }
        section {
            property: 'section'
            delegate: SectionHeader {
                text: section
            }
        }
        delegate: BackgroundItem {
            width: listView.width
            Label {
                id: firstName
                text: model.title
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
            }
            onClicked: pageStack.animatorPush(Qt.resolvedUrl(page))
        }
        VerticalScrollDecorator {}
    }
}






import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import Nemo.Time 1.0

Page
{
    id: edittransationpage
    property QtObject dataContainer: null
    property string transationTitleText: null
    property string transationTitle: null
    allowedOrientations: Orientation.All

    // -----------------------------------------------------------------------

        property var eventMod

    // -----------------------------------------------------------------------

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            anchors.fill: parent

            PageHeader {
                title: qsTr("New Transation")
            }

            ComboBox {
                id: typeComboBox
                label: qsTr("Select Type")
                currentIndex: 1
                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("Income")
                    }
                    MenuItem {
                        text: qsTr("Expense")
                    }
                    MenuItem {
                        text: qsTr("Transfer")
                    }
                }
            }

            ValueButton {
                property date selectedDate

                function openDateDialog() {
                    var obj = pageStack.animatorPush("Sailfish.Silica.DatePickerDialog",
                                                     { date: selectedDate })

                    obj.pageCompleted.connect(function(page) {
                        page.accepted.connect(function() {
                            value = page.dateText
                            selectedDate = page.date
                        })
                    })
                }

                label: "Date"
                value: Qt.formatDate(new Date())
                width: parent.width
                onClicked: openDateDialog()
            }

            TextField {
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Number"
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: phoneField.focus = true

//                horizontalAlignment: textAlignment
                backgroundStyle: textInputPage.editorStyle
            }
            TextField {
                placeholderText: "Note"
                width: parent.width
            }
            TextArea {
                width: parent.width
                height: Screen.height / 4
                label: "Description"
                placeholderText: label
            }
        }
    }
}

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: datePickerPage

    signal onDateSelected(var date) // Signal to pass selected date back to the main page

    SilicaFlickable {
        anchors.fill: parent

        Column {
            width: parent.width
            spacing: Theme.paddingLarge

            DatePicker {
                id: datePicker
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                text: qsTr("Select Date")
                onClicked: {
                    var selectedDate = datePicker.selectedDate;
                    datePickerPage.onDateSelected(selectedDate); // Emit the signal with the selected date
                    pageStack.pop(); // Close the date picker page
                }
            }
        }
    }
}

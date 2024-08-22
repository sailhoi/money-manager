import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.calendar 1.0

Dialog {

    property var eventMod

    canAccept: eventLabelTextField.text

    Component.onCompleted: {
        console.log(isNaN(eventMod.startTime.getTime()));
        if (isNaN(eventMod.startTime.getTime())) eventMod.setStartTime(new Date(), CalendarEvent.SpecClockTime)
        if (isNaN(eventMod.endTime.getTime())) eventMod.setEndTime(new Date(), CalendarEvent.SpecClockTime)
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            anchors.fill: parent
            DialogHeader{}
            ValueButton {
                width: parent.width
                label: "Date: "
                value: Qt.formatDate(eventMod.startTime, Qt.SystemLocaleShortDate)
                onClicked: {
                    var dialog = pageStack.push("Sailfish.Silica.DatePickerDialog",
                                                { date: eventMod.startTime });
                    dialog.accepted.connect(function() {
                        eventMod.setStartTime(new Date(dialog.year, dialog.month - 1, dialog.day,
                                              eventMod.startTime.getHours(),
                                              eventMod.startTime.getMinutes()),
                                              CalendarEvent.SpecClockTime);
                    });
                }
            }
            ValueButton {
                width: parent.width
                label: "Start time: "
                value: Qt.formatTime(eventMod.startTime, "HH:mm")
                onClicked: {
                    var dialog = pageStack.push("Sailfish.Silica.TimePickerDialog",
                                                { hour: eventMod.startTime.getHours(),
                                                  minute: eventMod.startTime.getMinutes() });
                    dialog.accepted.connect(function() {
                        eventMod.setStartTime(new Date(eventMod.startTime.getFullYear(),
                                                      eventMod.startTime.getMonth(),
                                                      eventMod.startTime.getDate(),
                                                      dialog.hour, dialog.minute),
                                              CalendarEvent.SpecClockTime);
                    });
                }
            }
            ValueButton {
                width: parent.width
                label: "End time: "
                value: Qt.formatTime(eventMod.endTime, "HH:mm")
                onClicked: {
                    var dialog = pageStack.push("Sailfish.Silica.TimePickerDialog",
                                                { hour: eventMod.endTime.getHours(),
                                                  minute: eventMod.endTime.getMinutes()});
                    dialog.accepted.connect(function() {
                        eventMod.setEndTime(new Date(eventMod.endTime.getFullYear(),
                                                    eventMod.endTime.getMonth(),
                                                    eventMod.endTime.getDate(),
                                                    dialog.hour, dialog.minute),
                                            CalendarEvent.SpecClockTime);
                    });
                }
            }
            TextField {
                id: eventLabelTextField
                width: parent.width
                text: eventMod.displayLabel
                label: "Event"
                placeholderText: label
            }
            TextField {
                id: locationTextField
                width: parent.width
                text: eventMod.location
                label: "Location"
                placeholderText: label
            }
        }
    }
    onAccepted: {
        eventMod.displayLabel = eventLabelTextField.text;
        eventMod.location = locationTextField.text;
        eventMod.save();
    }
}

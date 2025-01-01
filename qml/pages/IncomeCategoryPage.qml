import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property string name
    property string categoryName

    PageHeader {
        id: selectLabel
        title: categoryName != ""
              ? qsTr("Category")
              : qsTr("New category")
    }

    TextField {
        id: nameField
        width: parent.width
        anchors {
            top: selectLabel.bottom
            topMargin: Theme.paddingLarge
        }
        placeholderText: qsTr("Name", "placeholder for category name")
        text: categoryName // Prepopulate with existing category name if editing
    }

    onDone: {
        if (result === DialogResult.Accepted)
            name = nameField.text
    }
}

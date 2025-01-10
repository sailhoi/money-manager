import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property string name
    property int typeID
    property string typeName

    PageHeader {
        id: selectLabel
        title: typeName != "" ? typeName : qsTr("New Account Type")
    }

    TextField {
        id: nameField
        width: parent.width
        anchors {
            top: selectLabel.bottom
            topMargin: Theme.paddingLarge
        }
        placeholderText: qsTr("Name", "placeholder for account type name")
        text: categoryName // Prepopulate with existing category name if editing
    }

    onDone: {
        if (result === DialogResult.Accepted)
            name = nameField.text
    }
}

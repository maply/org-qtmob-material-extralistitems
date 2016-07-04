import QtQuick 2.5
import QtQuick.Layouts 1.2
import Material 0.2
import Material.ListItems 0.1 as ListItem

ListItem.BaseListItem {
    id: listItem

    height: maximumLineCount == 2 ? Units.dp(72) : Units.dp(88)
    width: parent.width
    margins: 0

    property alias text: label.text
    property alias subText: subLabel.text
    property alias valueText: valueLabel.text

    property alias subIconSource: subIcon.source

    property alias imageSource: image.source
    property alias defaultImageBackgroundColor: defaultImageBackground.color
    property alias defaultImageSource: defaultImage.source

    property alias action: actionItem.children
    property alias secondaryItem: secondaryItem.children
    property alias content: contentItem.children

    property alias itemLabel: label
    property alias itemSubLabel: subLabel
    property alias itemValueLabel: valueLabel

    interactive: !contentItem.showing

    dividerInset: actionItem.visible ? listItem.height : 0

    property int maximumLineCount: 2

    GridLayout {
        anchors.fill: parent

        anchors.leftMargin: listItem.margins
        anchors.rightMargin: listItem.margins

        columns: 4
        rows: 1
        columnSpacing: Units.dp(16)

        Item {
            id: actionItem

            Layout.preferredWidth: Units.dp(80)
            Layout.preferredHeight: listItem.height
            Layout.alignment: Qt.AlignCenter
            Layout.column: 1

            visible: true

            Image {
                id: image
                property bool valid: imageSource !== ""

                asynchronous: true
                cache: true
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }
                width: parent.width
                height: parent.height
                fillMode: Image.PreserveAspectCrop
                visible: source != ""
            }
            Item {
                id: defaultImageBox
                visible: !(image.visible)

                width: parent.width
                height: parent.height

                Rectangle {
                    id: defaultImageBackground
                    anchors.fill: parent
                    color: "grey"
                }

                Image {
                    id: defaultImage
                    width: parent.width / 4
                    height: width
                    anchors.centerIn: parent
                }
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.column: 2

            spacing: Units.dp(3)

            RowLayout {
                Layout.fillWidth: true

                spacing: Units.dp(8)

                Label {
                    id: label

                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true

                    maximumLineCount: 2
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                    style: "subheading"
                    lineHeight: 0.85
                    textFormat: Text.StyledText
                }

                Label {
                    id: valueLabel

                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: visible ? implicitWidth : 0
                    Layout.rightMargin: Units.dp(8)

                    color: Theme.light.subTextColor
                    elide: Text.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    style: "body1"
                    visible: text != ""
                }
            }

            Item {
                id: contentItem

                Layout.fillWidth: true
                Layout.preferredHeight: showing ? subLabel.implicitHeight : 0

                property bool showing: visibleChildren.length > 0
            }

            Row {

                Layout.fillWidth: true
                Layout.preferredHeight: implicitHeight * maximumLineCount/subLabel.lineCount
                visible: subIcon.visible || subLabel.visible
                spacing: Units.dp(8)

                Image {
                    id: subIcon
                    width: visible ? Units.dp(16) : 0
                    height: width
                    visible: source !== ""
                }

                Label {
                    id: subLabel

                    color: Theme.light.subTextColor
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    style: "body1"
                    width: parent.width - subIcon.size
                    visible: text != "" && !contentItem.showing
                    maximumLineCount: listItem.maximumLineCount - 1
                }
            }
        }

        Item {
            id: secondaryItem
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: childrenRect.width
            Layout.preferredHeight: parent.height
            Layout.column: 4

            visible: children.length > 0
        }
    }
}

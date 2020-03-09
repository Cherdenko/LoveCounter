import QtQuick 2.0
import Felgo 3.0

Page {
    property string coupleImage : ""
    id: settings
    title: qsTr("Love Counter")
    rightBarItem:  NavigationBarRow{


        IconButtonBarItem{
            icon: IconType.info
            title: qsTr("Info")
            onClicked:   navigationStack.push(Qt.resolvedUrl("LoveCounterInfoPage.qml"))
        }

    }
    onPopped:{
        partner1.focus = false
        partner2.focus = false
        storage.setValue("partner2",partner2.text);
        storage.setValue("partner1",partner1.text);

    }

    Column{

        id: contentCol

        anchors.left: parent.left
        anchors.top: parent.top;
        anchors.right: parent.right
        anchors.margins: contentPadding
        spacing: contentPadding

        AppText{
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(22)
            font.bold: true
            text:qsTr("Settings:")
        }

        AppText{
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(12)
            font.bold: true
            text: qsTr("Your name:")

        }
        AppTextField{
            id: partner1
            width: parent.width
            showClearButton: true
            placeholderText: "Name 1"
            //inputMethodHints: Qt.ImhNoPredictiveText
        }
        AppText{
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(12)
            font.bold: true;
            text: qsTr("The name of your partner")
        }

        AppTextField{
            id: partner2
            width: parent.width
            showClearButton: true
            placeholderText: "Name 2"
            //inputMethodHints: Qt.ImhNoPredictiveText

        }

        AppText{
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(12)
            font.bold: true
            text: qsTr("Please enter the date when you got together")
        }

        AppTextField{
            id: dateInput
            width: parent.width
            showClearButton: true
            placeholderText: qsTr("Click here to insert the date")
            inputMethodHints: Qt.ImhNoPredictiveText
            clickEnabled: true
            onClicked: {
                nativeUtils.displayDatePicker(new Date(), new Date('1899-01-01T00:00:00'), new Date())
            }

        }
        AppText{
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(12)
            font.bold: true
            text: qsTr("Select your own custom picture")
        }
        AppButton{

            text: qsTr("Select Image")
            onClicked:{nativeUtils.displayImagePicker(qsTr("Select Image"))}

        }

        AppTextField{
            id: dummy
            visible: false
        }
        AppTextField{
            id:dummyImagePath
            visible: false
        }


        Connections{
            target: nativeUtils


            onImagePickerFinished:{
                if(accepted){
                    dummyImagePath.text = path
                    storage.setValue("coupleImage",  dummyImagePath.text)
                }
            }

            onDatePickerFinished:{
                var day = ""
                var month = "0"
                var tempMonth = 0
                if(accepted)  {
                    if(date.getUTCDate() < 10 ) day = "0" + date.getUTCDate()
                    else if(date.getUTCDate() >= 10 ) day = date.getUTCDate()
                    if(date.getUTCMonth() + 1 < 10) {
                        tempMonth = + date.getUTCMonth() +1
                        month += tempMonth
                    }
                    else if(date.getUTCMonth() + 1 >= 10){
                        tempMonth = date.getUTCMonth() +1
                        month = tempMonth
                    }

                    var relationShipDate = date
                    var displayValue = day + "."+ month + "." + date.getUTCFullYear()
                    dummy.text = date
                    dateInput.text = displayValue
                    storage.setValue("startOfRelationShip", dummy.text)
                    storage.setValue("startOfRelationShipString", dateInput.text.trim())
                    storage.setValue("firstAppStart", true)

                }
            }
        }


        Storage{
            id: storage

            Component.onCompleted: {
                partner1.text = storage.getValue("partner1")
                partner2.text = storage.getValue("partner2")
                dateInput.text = storage.getValue("startOfRelationShipString")
                dummy.text = storage.getValue("startOfRelationShip")
                dummyImagePath.text = storage.getValue("coupleImage")
            }
        }
    }

}

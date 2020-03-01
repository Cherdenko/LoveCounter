import QtQuick 2.0
import Felgo 3.0
Page {

    id: settings
    title: qsTr("Love Counter")

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
            font.pixelSize: sp(12)
            text:qsTr("It Seems like you are starting the app for the first time :) <br\> The App will need some Information first, before we beginn. This information is only stored locally and will never be send to anyone !")
        }

//        AppText{
//            width: parent.width
//            font.pixelSize: sp(12)
//            color: Theme.secondaryTextColor
//            font.italic: true
//            text: qsTr("Hint: you can quickly find something by typing 'London'...")
//            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
//        }

        AppText{
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(12)
            font.bold: true
            text: qsTr("Lets' start with your name first.")

        }
        AppTextField{
            id: partner1
            width: parent.width
            showClearButton: true
            placeholderText: "Name 1"
            inputMethodHints: Qt.ImhNoPredictiveText

        }
        AppText{
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(12)
            font.bold: true;
            text: qsTr("And the name of your partner")
        }

        AppTextField{
            id: partner2
            width: parent.width
            showClearButton: true
            placeholderText: "Name 2"
            inputMethodHints: Qt.ImhNoPredictiveText
        }

        AppText{
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(12)
            font.bold: true
            text: qsTr("And lastly the date when you both got together")
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
        AppTextField{
            id: dummy
            visible: false
        }

        Connections{
            target: nativeUtils

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
                    var displayValue = day + " : "+ month + " : " + date.getUTCFullYear()
                    dummy.text = date
                dateInput.text = displayValue
                }
            }


        }


            AppButton{
                id:acceptSettings
                width: parent.width
                text: qsTr("Accept Settings")
                onClicked: storage.saveSettings()

            }
        }



    Storage{
        id: storage

        Component.onCompleted: {
           partner1.text = storage.getValue("partner1")
           partner2.text = storage.getValue("partner2")
           dateInput.text = storage.getValue("startOfRelationShipString")
           dummy.text = storage.getValue("startOfRelationShip")

        }

        function saveSettings(){
             if((partner1.text != undefined || partner1.text != "") && (partner2.text != undefined || partner2.text != "") && ( dateInput.text != undefined || dateInput.text != "")){
                storage.setValue("partner1", partner1.text.trim());
                storage.setValue("partner2",partner2.text.trim());
                storage.setValue("startOfRelationShip", dummy.text)
                storage.setValue("startOfRelationShipString", dateInput.text.trim())

                 console.debug(storage.getValue("partner1"))
                 console.debug(storage.getValue("partner2"))
                 console.debug(storage.getValue("startOfRelationShip"))
                 navigationStack.pop(Qt.resolvedUrl(settings))
             } else{

             }
    }




    }

}


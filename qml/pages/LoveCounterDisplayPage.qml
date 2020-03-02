import QtQuick 2.5
import Felgo 3.0

Page {


    id: displayPage



    rightBarItem:  NavigationBarRow{

        IconButtonBarItem{
            id: refreshBar
            icon: IconType.refresh
            onClicked: refresh()
        }

        IconButtonBarItem{
            icon: IconType.cogs
            title: qsTr("Settings")
            onClicked: navigationStack.push(Qt.resolvedUrl("LoveCounterSettingsPage.qml"))
        }

    }


    AppFlickable{
        id : flickAblePageS
        anchors.fill: parent
        contentHeight: defaultColumn.height



        Column{

            id: defaultColumn
            width: parent.width
            anchors.left: parent.left
            anchors.top: parent.top;
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            //        anchors.margins: contentPadding
            spacing: contentPadding

            AppImage{

                id: coupleImage
                width: screenWidth
                fillMode: Image.PreserveAspectFit
                verticalAlignment: Image.AlignTop
                source: "../../assets/coupleDefault.jpeg"
                horizontalAlignment: AppImage.AlignHCenter

            }




//            AppText{
//                font.family: "Arial"
//                id:togetherSince
//                width: parent.width
//                horizontalAlignment: AppText.AlignHCenter
//                color: "#4B0014"
//                text: qsTr("You are together since: " + settings.getValue("startOfRelationShipString"))
//                wrapMode: "WrapAtWordBoundaryOrAnywhere"






//            }
            AppText{

                id: centerItem
                width: parent.width
                horizontalAlignment: AppText.AlignHCenter
                text: qsTr("This means: ")

            }

            AppText {
                id: displayYears
                width: parent.width
                horizontalAlignment: AppText.AlignHCenter
                text: getDates("Year") + qsTr(" Years")

            }
            AppText {
                id: displayMonths
                width: parent.width
                horizontalAlignment: AppText.AlignHCenter
                text:getDates("Months") + qsTr(" Months")

            }
            AppText {
                id: displayDays
                width: parent.width
                horizontalAlignment: AppText.AlignHCenter
                text: getDates("Date") + qsTr(" Days")

            }








        }
        Rectangle{
            y: textInPicture.y
            color: "#4B0014"
            width: parent.width
            height: textInPicture.height

        }
        AppText{
            id: textInPicture
            width: parent.width
            horizontalAlignment: AppText.AlignHCenter
            y: coupleImage.height -20
            font.family: "Arial"
            color: "white"
            text: settings.getValue("startOfRelationShipString")
        }
    }
    Storage{

        id: settings

        Component.onCompleted: {
            var partner1 = settings.getValue("partner1")
            var partner2 = settings.getValue("partner2")
            var zusammenSeit = settings.getValue("startOfRelationShip")
            displayPage.title = partner1 + " & " + partner2

            if(partner1 === undefined || partner2 === undefined || zusammenSeit === undefined ) executeOrder66()
        }


    }


    function refresh(){
        var partner1 = settings.getValue("partner1")
        var partner2 = settings.getValue("partner2")
        var zusammenSeit = settings.getValue("startOfRelationShip")
        togetherSince.text = 'You are together since: ' + settings.getValue("startOfRelationShipString")
        displayPage.title = partner1 + " & " + partner2
        togetherSince.update()
        getDates("UPDATE_ALL")

    }
    function getDates(value){
        var dateNow = new Date();
        var dateGotTogether = new Date(settings.getValue("startOfRelationShip"))
        console.debug(dateNow + dateGotTogether)
        var diff = null
        if(value === "Year"){
            diff =new Date(dateNow.getTime() - dateGotTogether.getTime())
            if(diff.getUTCFullYear() -1970 === 0){ displayYears.visible = false
                return false
            } else return diff.getUTCFullYear() -1970 != 0
        }
        if(value === "Months"){
            diff =new Date(dateNow.getTime() - dateGotTogether.getTime())
            if(diff.getUTCMonth() === 0 ){
                displayMonths.visible = false
                return false
            } else return diff.getUTCMonth()
        }
        if(value === "Date"){
            diff =new Date(dateNow.getTime() - dateGotTogether.getTime())
            return diff.getUTCDate() - 1
        }

        if(value === "UPDATE_ALL"){
            displayYears.text = new Date(dateNow.getTime() - dateGotTogether.getTime()).getUTCFullYear() -1970 + qsTr(" Years")
            displayMonths.text = new Date(dateNow.getTime() - dateGotTogether.getTime()).getUTCMonth() + qsTr(" Months")
            displayDays.text = new Date(dateNow.getTime() - dateGotTogether.getTime()).getUTCDate() - 1 + qsTr(" Days")
        }

    }
    function executeOrder66(){
        defaultColumn.visible = false
    }
}


import QtQuick 2.5
import Felgo 3.0

 FlickablePage{


    id: displayPage

    // set contentHeight of flickable to allow scrolling
   flickable.contentHeight: displayDays.y + 100







    // set false to hide the scroll indicator, it is visible by default


    rightBarItem:  NavigationBarRow{

//        IconButtonBarItem{
//            id: refreshBar
//            icon: IconType.refresh
//            onClicked: refresh()
//        }

        IconButtonBarItem{
            icon: IconType.cogs
            title: qsTr("Settings")
            onClicked: navigationStack.push(Qt.resolvedUrl("LoveCounterSettingsPage.qml"))
        }

    }

        Rectangle{
            id: spacerForImageToSmall
            color: "#4B0014"
            y: coupleImage.y
            width: parent.width
            height: coupleImage.height
        }

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
//            Rectangle{
//                id: animationHeader
//                width: parent.width
//              height: dp(20)
//                color: "red"

//            }
//            AnimatedImage{

//                y:animationHeader.bottom
//                width: parent.width

//                height: px(220)
//                id: animation
//                source: "../../assets/animiertes-herz-bild-0886.gif"
//            }



        }


        Rectangle{
            y: textInPicture.y - 5
            color: "#4B0014"
            width: parent.width
            height: textInPicture.height +10


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


//    }
    Storage{

        id: settings

        Component.onCompleted: {
           if(settings.getValue("firstAppStart") === false ||settings.getValue("firstAppStart") === undefined){
                executeOrder66()
            return
           }
            var partner1 = settings.getValue("partner1")
            var partner2 = settings.getValue("partner2")
            var zusammenSeit = settings.getValue("startOfRelationShip")
            displayPage.title = partner1 + " & " + partner2
            if(settings.getValue("coupleImage") !== "")
                coupleImage.source = settings.getValue("coupleImage")
            if(partner1 === undefined || partner2 === undefined || zusammenSeit === undefined ) executeOrder66()
        }


    }


    Connections{
        target: navStack
        onPopped:{
            refresh()
        }
    }

    function refresh(){
        if(settings.getValue("firstAppStart") === false ||settings.getValue("firstAppStart") === undefined){
             executeOrder66()
         return
        }
        var partner1 = settings.getValue("partner1")
        var partner2 = settings.getValue("partner2")
        var zusammenSeit = settings.getValue("startOfRelationShip")
        textInPicture.text =  settings.getValue("startOfRelationShipString")
        displayPage.title = partner1 + " & " + partner2
        if(settings.getValue("coupleImage") !== "")
            coupleImage.source = settings.getValue("coupleImage")
        getDates("UPDATE_ALL")



    }
    function getYear(dateNow, dateGotTogether){
        var diff =new Date(dateNow.getTime() - dateGotTogether.getTime())
        if(diff.getUTCFullYear() -1970 === 0){
            displayYears.visible = false
            return false
        } else{
            displayYears.visible = true
            return diff.getUTCFullYear() -1970
        }
    }
    function getMonth(dateNow, dateGotTogether){
        var diff =new Date(dateNow.getTime() - dateGotTogether.getTime())
        if(diff.getUTCMonth() === 0 ){
            displayMonths.visible = false
            return false
        } else{
            displayMonths.visible = true
            return diff.getUTCMonth()
        }
    }
    function getDay(dateNow, dateGotTogether){
        var diff =new Date(dateNow.getTime() - dateGotTogether.getTime())
        if(diff.getUTCDate === 0){
            displayDays.visible = false
            return false
        }else{
        displayDays.visible = true
        return diff.getUTCDate() - 1
        }
    }

    function getDates(value){
        var dateNow = new Date();
        var dateGotTogether = new Date(settings.getValue("startOfRelationShip"))
        if(value === "Year"){
             return getYear(dateNow, dateGotTogether)
        }
        if(value === "Months"){
            return getMonth(dateNow, dateGotTogether)
        }
        if(value === "Date"){
            return getDay(dateNow, dateGotTogether)
        }


        if(value === "UPDATE_ALL"){
            displayYears.text = getYear(dateNow, dateGotTogether) + qsTr(" Years")
            displayMonths.text = getMonth(dateNow, dateGotTogether) + qsTr(" Months")
            displayDays.text = getDay(dateNow, dateGotTogether) + qsTr(" Days")
        }



    }
    function executeOrder66(){
        displayPage.title = "Love Counter"
        centerItem.visible = false
        displayYears.visible = false
        displayMonths.visible = false
        displayDays.visible = false


    }



}


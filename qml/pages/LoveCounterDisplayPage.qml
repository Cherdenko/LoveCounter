import QtQuick 2.5
import Felgo 3.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

FlickablePage{


    id: displayPage

    // set contentHeight of flickable to allow scrolling
    flickable.contentHeight: displayDays.y + 100

    rightBarItem:  NavigationBarRow{
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
             color: "#4B0014"
            id: centerItem
            width: parent.width
            horizontalAlignment: AppText.AlignHCenter
            text: qsTr("This means: ")

        }

        AppText {
            color: "#4B0014"
            id: displayYears
            width: parent.width
            horizontalAlignment: AppText.AlignHCenter
            text: getDates("Year") + " " + qsTr("Year(s)")

        }
        AppText {
            color: "#4B0014"
            id: displayMonths
            width: parent.width
            horizontalAlignment: AppText.AlignHCenter
            text: qsTr("or") + " "+getDates("Months") + " " + qsTr("Month(s)")

        }
        AppText {
             color: "#4B0014"
            id: displayDays
            width: parent.width
            horizontalAlignment: AppText.AlignHCenter
            text: qsTr("or") + " " + getDates("Date") + " " +qsTr("Day(s)")

        }

            AppText{
                color: "#4B0014"
                id: settingsTip
                visible: false
                width: parent.width
                horizontalAlignment:  AppText.AlignHCenter
                wrapMode: "WrapAtWordBoundaryOrAnywhere"
                text: qsTr("This seems to be your first app start. Please go to the settings, which you can access in the right top corner :)")



            }




    }
    // this is experimental as a ProgressBar
    //    Column{

    //        id: levelDisplayColumn
    //        property real value: 1.0
    //        anchors.left: parent.left
    //        anchors.top:  defaultColumn.bottom;
    //        anchors.right: parent.right
    //        anchors.verticalCenter: parent.verticalCenter
    //        spacing: contentPadding


    //        Rectangle {
    //          color: "white"
    //          property alias text: timeText.text
    //          width: 200
    //          height: 200

    //          Text {
    //            id: timeText
    //            font.family: fontLight.name
    //            color: "#66bcb7"
    //            font.pixelSize: 10
    //            anchors.centerIn: parent
    //          }

    //          Row{
    //            id: circle

    //            property color circleColor: "transparent"
    //            property color borderColor: "#66bcb7"
    //            property int borderWidth: 2
    //            anchors.centerIn: parent
    //            width: parent.width-10
    //            height: width

    //            Item{
    //              width: parent.width/2
    //              height: parent.height
    //              clip: true

    //              Item{
    //                id: part1
    //                width: parent.width
    //                height: parent.height
    //                clip: true
    //                rotation: levelDisplayColumn.value > 0.5 ? 360 : 180 + 360*levelDisplayColumn.value
    //                transformOrigin: Item.Right

    //                Rectangle{
    //                  width: circle.width-(circle.borderWidth*2)
    //                  height: circle.height-(circle.borderWidth*2)
    //                  radius: width/2
    //                  x:circle.borderWidth
    //                  y:circle.borderWidth
    //                  color: circle.circleColor
    //                  border.color: circle.borderColor
    //                  border.width: circle.borderWidth
    //                  smooth: true
    //                }
    //              }
    //            }

    //            Item{
    //              width: parent.width/2
    //              height: parent.height
    //              clip: true

    //              Item{
    //                id: part2
    //                width: parent.width
    //                height: parent.height
    //                clip: true
    //                rotation: levelDisplayColumn.value <= 0.5 ? 180 : 360*(levelDisplayColumn.value)
    //                transformOrigin: Item.Left

    //                Rectangle{
    //                  width: circle.width-(circle.borderWidth*2)
    //                  height: circle.height-(circle.borderWidth*2)
    //                  radius: width/2
    //                  x: -width/2
    //                  y: circle.borderWidth
    //                  color: circle.circleColor
    //                  border.color: circle.borderColor
    //                  border.width: circle.borderWidth
    //                  smooth: true
    //                }
    //              }
    //            }
    //          }
    //        }

    //    }

    //    Rectangle {
    //        id: rectForItems
    //        y: centerItem.y
    //        x: centerItem.x
    //        width: parent.width
    //        height: displayDays.y - centerItem.y + centerItem.height
    //        color: "transparent"
    //        anchors.bottom: displayDays.bottom
    //        border.color: "#4B0014"
    //        border.width: 2
    //    }
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
        text: storage.getValue("startOfRelationShipString")
    }


    ////////////// Here ends the display section
    Storage{

        id: storage

        Component.onCompleted: {
            storage.setValue("startOfRelationShip", undefined)
            storage.setValue("startOfRelationShipString", undefined )
            storage.setValue("firstAppStart", undefined)
            storage.setValue("coupleImage", undefined)
            storage.setValue("partner1", undefined)
            storage.setValue("partner2", undefined)
            if(storage.getValue("firstAppStart") === false || storage.getValue("firstAppStart") === undefined){
                executeOrder66()
                return
            }
            var partner1 = storage.getValue("partner1")
            var partner2 = storage.getValue("partner2")
            var zusammenSeit = storage.getValue("startOfRelationShip")
            displayPage.title = partner1 + " & " + partner2
            if(storage.getValue("coupleImage") !== "")
                coupleImage.source = storage.getValue("coupleImage")

        }


    }


    Connections{
        target: navStack
        onPopped:{
            console.debug(page)
            refresh()
        }
    }

    function refresh(){
        storage.update()
        if(storage.getValue("firstAppStart") === false ||storage.getValue("firstAppStart") === undefined){
            executeOrder66()
            return
        }
        if(storage.getValue("firstAppStart") === true){
            settingsTip.visible = false
            centerItem.visible = true
            displayYears.visible = true
            displayMonths.visible = true
            displayDays.visible = true
        }
        var partner1 = storage.getValue("partner1")
        var partner2 = storage.getValue("partner2")
        var zusammenSeit = storage.getValue("startOfRelationShip")
        textInPicture.text =  storage.getValue("startOfRelationShipString")
        displayPage.title = partner1 + " & " + partner2
        getDates("UPDATE_ALL")

        if(storage.getValue("coupleImage") !== undefined) coupleImage.source = storage.getValue("coupleImage")





    }
//    function getYear(dateNow, dateGotTogether){
//        var diff =new Date(dateNow.getTime() - dateGotTogether.getTime())
//        if(diff.getUTCFullYear() -1970 === 0){
//            displayYears.visible = false
//            return false
//        } else{
//            displayYears.visible = true
//            return diff.getUTCFullYear() -1970
//        }
//    }
//    function getMonth(dateNow, dateGotTogether){
//        var diff =new Date(dateNow.getTime() - dateGotTogether.getTime())
//        if(diff.getMonth() === 0 ){
//            displayMonths.visible = false
//            return false
//        } else{
//            displayMonths.visible = true
//            return diff.getMonth()
//        }
//    }
//    function getDay(dateNow, dateGotTogether){
//        var diff =new Date(dateNow.getTime() - dateGotTogether.getTime())
//        if(diff.getDate === 0){
//            displayDays.visible = false
//            return false
//        }else{
//            displayDays.visible = true
//            return diff.getDate() - 1
//        }
//    }
    function getYear(dateNow, dateGotTogether){
        var diff =new Date(dateNow.getTime() - dateGotTogether.getTime())
//        if(diff.getUTCFullYear() -1970 === 0){
//            displayYears.visible = false
//            return false
//        } else{
            displayYears.visible = true
            return diff.getUTCFullYear() -1970
        //}
    }
    function getMonth(dateNow, dateGotTogether){
        var d1Y = dateGotTogether.getFullYear();
        var d2Y = dateNow.getFullYear();
        var d1M = dateGotTogether.getMonth();
        var d2M = dateNow.getMonth();
        var diff = (d2M+12*d2Y)-(d1M+12*d1Y);
//        if(diff === 0 ){
//            displayMonths.visible = false
//            return false
//        } else{
            displayMonths.visible = true
            return diff
        //}
    }
    function getDay(dateNow, dateGotTogether){
      var diff = Math.floor((dateNow - dateGotTogether) / (1000*60*60*24))
//        console.debug(diff)
//        if(diff === 0){
//            displayDays.visible = false
//            return false
//        }else if(diff === 1 ){
//            displayDays.visible = true
//            return diff
//        } else {
        displayDays.visible = true
        return  diff
    //}
    }


    function getDates(value){
        var dateNow = new Date();
        var dateGotTogether = new Date(storage.getValue("startOfRelationShip"))
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
            displayYears.text = getYear(dateNow, dateGotTogether) + " " + qsTr("Year(s)")
            displayMonths.text = qsTr("or") + " " +  getMonth(dateNow, dateGotTogether) + " " + qsTr("Month(s)")
            displayDays.text = qsTr("or") + " " + getDay(dateNow, dateGotTogether) + " " + qsTr("Day(s)")
        }



    }
    function executeOrder66(){
        displayPage.title = "Love Counter"
        settingsTip.visible = true
        centerItem.visible = false
        displayYears.visible = false
        displayMonths.visible = false
        displayDays.visible = false
    }



}


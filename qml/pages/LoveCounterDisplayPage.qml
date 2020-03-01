import QtQuick 2.5
import Felgo 3.0

Page {


    id: displayPage

    Connections{
    }


        rightBarItem:  NavigationBarRow{

            IconButtonBarItem{

                icon: IconType.cogs
                title: qsTr("Settings")
                onClicked: navigationStack.push(Qt.resolvedUrl("LoveCounterSettingsPage.qml"))


            }
            IconButtonBarItem{
                icon: IconType.refresh
                onClicked: refresh()
            }
        }
        Column{

            anchors.left: parent.left
            anchors.top: parent.top;
            anchors.right: parent.right
            anchors.margins: contentPadding
            spacing: contentPadding

            AppImage{
                anchors.fill: parent.parent
                fillMode: Image.PreserveAspectCrop
                source: "../../assets/coupleDefault.jpg"

            }

            AppText{

                id:togetherSince
                text: qsTr("You are together since: " + settings.getValue("startOfRelationShipString"))
                wrapMode: "WrapAtWordBoundaryOrAnywhere"
                font.bold: true
                anchors.centerIn: parent.Center
            }


            AppText{
                text: qsTr("This means: ")
            }

            AppText {
                id: displayYears
                text: getDates("Year") + qsTr(" Years")            }
            AppText {
                id: displayMonths
                text: getDates("Months") + qsTr(" Months")
            }
            AppText {
                id: displayDays
                text:  getDates("Date") + qsTr(" Days")

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
            //            if(partner1 === undefined || partner2 === undefined || zusammenSeit === undefined ){navigationStack.push(Qt.resolvedUrl("LoveCounterSettingsPage.qml"))
        }


        function getDates(value){
            var dateNow = new Date();
            var dateGotTogether = new Date(settings.getValue("startOfRelationShip"))
            console.debug(dateNow + dateGotTogether)

            if(value === "Year"){
                var diff =new Date(dateNow.getTime() - dateGotTogether.getTime())
                return diff.getUTCFullYear() -1970
            }
            if(value === "Months"){
                var diff =new Date(dateNow.getTime() - dateGotTogether.getTime())
                return diff.getUTCMonth()
            }
            if(value === "Date"){
                var diff =new Date(dateNow.getTime() - dateGotTogether.getTime())
                return diff.getUTCDate() - 1
            }

            if(value = "UPDATE_ALL"){
                displayYears.text = new Date(dateNow.getTime() - dateGotTogether.getTime()).getUTCFullYear() -1970 + qsTr(" Years")
                displayMonths.text = new Date(dateNow.getTime() - dateGotTogether.getTime()).getUTCMonth() + qsTr(" Months")
                displayDays.text = new Date(dateNow.getTime() - dateGotTogether.getTime()).getUTCDate() - 1 + qsTr(" Days")
            }


        }

        Storage{

            id: settings

            Component.onCompleted: {
                var partner1 = settings.getValue("partner1")
                var partner2 = settings.getValue("partner2")
                var zusammenSeit = settings.getValue("startOfRelationShip")
                displayPage.title = partner1 + " & " + partner2
                if(partner1 === undefined || partner2 === undefined || zusammenSeit === undefined ){navigationStack.push(settings)
                    onpo
                }

            }


        }
    }


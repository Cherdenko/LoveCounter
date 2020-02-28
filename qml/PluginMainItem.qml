import Felgo 3.0
import QtQuick 2.0
import "helper"
import "pages"

Item {
    anchors.fill: parent

    // app content with plugin list
    NavigationStack {
        id: pluginMainItem

        // initial page contains list if plugins and opens pages for each plugin when selected
        ListPage {
            id: page
            title: qsTr("Felgo Plugins")

//            model: ListModel {
//                ListElement { type: "In-App Purchases"; name: "Soomla"
//                    detailText: "In-App Purchases & Virtual Currency"; image: "../assets/logo-soomla.png" }
//            }

            delegate: PluginListItem {
                visible: name !== "GameCenter" || Theme.isIos

                onSelected: {
                    switch (name) {
                    case "Soomla":
                        page.navigationStack.push(soomlaPage)
                        break
                    }
                }
            }

            section.property: "type"
            section.delegate: SimpleSection { }
        }
    }
}

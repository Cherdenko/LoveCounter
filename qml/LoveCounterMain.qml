import Felgo 3.0
import QtQuick 2.0

App {

    onInitTheme: {
//        if(settings.getValue("colorCode") === undefined || settings.getValue("colorCode"))
            Theme.navigationBar.backgroundColor = "#4B0014"


    }

    id: app
    LoveCounterMainItem{}

}

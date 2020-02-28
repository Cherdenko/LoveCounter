import Felgo 3.0
import QtQuick 2.0
import "pages"
import "helper"

/*/////////////////////////////////////
  NOTE:
  Additional integration steps are needed to use Felgo Plugins, for example to add and link required libraries for Android and iOS.
  Please follow the integration steps described in the plugin documentation of your chosen plugins:
  - Soomla: https://felgo.com/doc/plugin-soomla/

  To open the documentation of a plugin item in Qt Creator, place your cursor on the item in your QML code and press F1.
  This allows to view the properties, methods and signals of Felgo Plugins directly in Qt Creator.

/////////////////////////////////////*/

App {
   licenseKey: "D5B07516C653A611D5BBE3173E9CD61510BF76EF92CD28968F4C6D400FDF4848F1762C242C85615C8ADC8B161472C49B1F6CCACA4FC9A5EE00951AC5567FAD9B11FA9963093850DB74112649A888B1237D0DF339EBB95DFF1418D759902436B0206DC20E5406B321F37B77E4A8C69B11B75E7D575E573807CB31B20D41DFF6E94656718559349CE2735D4588E5719A753E408AB8DBB8392529DCEFEC46002FE53873E5CBCE30AF2456E5983C62E30070B138302B53512D1D69F85088C28A69CA991294C84AB5C75DA8AAA67062F20FB844CC468F64FCA40C663D3DA6593E257A0AA6D4AF3095FDC9B06314370458183D58EEB1188E12EA9E7EF5C324BF8944DC1470EDC0F85A7CCAB330D42F51EFE7DA43125AC4FCC78E0B83DCE8F175ACF1A8F0C94A2DC51AF93456CA8CAE4B8416A33C86EC9C476244F777892118F892F2E8"
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"

    // This item contains example code for the chosen Felgo Plugins
    // It is hidden by default and will overlay the QML items below if shown


   property int numberAppStarts
   Component.onCompleted: {
    var tempNumberAppStart = settings.getValue("numberAppStarts")
       console.log(numberAppStart)
    if(tempNumberAppStart === undefined){

        NativeUtils.displayDatePicker()
            tempNumberAppStart = 0
    }
    else
        tempNumberAppStart++
    settings.setValue("numberAppStarts", tempNumberAppStarts)
    numberAppStarts = tempNumberAppStart
   }

    PluginMainItem {
        id: pluginMainItem
        z: 1           // display the plugin example above other items in the QML code below
        visible: false // set this to true to show the plugin example

        // keep only one instance of these plugin-pages alive within app
        // this prevents crashes due to destruction of plugin items when popping pages from the stack
        property alias soomlaPage: soomlaPage

        SoomlaPage {
            id: soomlaPage
            visible: true
            onPushed: soomlaPage.listView.contentY = soomlaPage.listView.originY
            onPopped: { soomlaPage.parent = pluginMainItem; visible = false }
        }
    }

    NavigationStack {

        Page {
            title: qsTr("Main Page")

            Image {
                source: "../assets/felgo-logo.png"
                anchors.centerIn: parent
            }
        }

    }
}

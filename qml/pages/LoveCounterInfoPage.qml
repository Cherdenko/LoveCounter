import QtQuick 2.0
import Felgo 3.0

Page {
    id: infoPage
    title: "New Page"
    backgroundColor:  "#4B0014"
    navigationBarHidden: true
    IconButton{
        id: closeButton
        icon: IconType.close
        x: 0
        y:0
        onClicked: navigationStack.pop(Qt.resolvedUrl(infoPage))
        color: "#4B0014"
    }

    Column{

        id: informationColumn
        spacing: dp(Theme.navigationBar.defaultBarItemPadding)

        width: parent.width

        anchors.left: parent.left
        anchors.top: closeButton.bottom;
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        AppText{
            color: "white"
            font.bold: true
            text: "Some Information:"
        }
        AppText{
           width: parent.width
           color: "white"
            wrapMode: "WrapAtWordBoundaryOrAnywhere"
            text: "A little bit to my person first: I am currently an apprentice for the position of an application developer(I am allowed to call myself that as soon as im finished) in a small company in the south of germany. So this app was created to get a better understanding on how mobil apps work, and i think i learned quite a bit. <br\> So you might be asking youself, whats the purpose of this app : <br\> <br\> In the first place to please my girlfriend, as she's annoyed by the ads (of some of the competitors) and i thought i could do something like that myself!.<br\> <br\> In future versions you might find a changelog here :)"
        }
        AppText{
            color: "white"
            width: parent.width
            wrapMode: "WrapAtWordBoundaryOrAnywhere"
            text: "PS: Of course you can contact me anytime via Email if you have suggestions or want to critisize anything "
        }
        AppTextField {
            width: parent.width
            color: "white"
            text:  "DEsourCeDev@gmail.com"
        }

    }

}

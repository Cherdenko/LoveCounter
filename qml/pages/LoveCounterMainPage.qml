import QtQuick 2.0
import Felgo 3.0

Page {

    readonly property real contentPadding: dp(Theme.navigationBar.defaultBarItemPadding)
    property alias childNavigationStack: navStack

    useSafeArea: false
    // Page should only be in Charge of showing data, not getting data
    //The Item  should be in charge to get the data
    NavigationStack {

        id: navStack


        LoveCounterDisplayPage{}


    }
}

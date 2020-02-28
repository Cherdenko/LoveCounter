import Felgo 3.0
import QtQuick 2.5
import "../helper"

ListPage {

    title: "Soomla Plugin"

    listView.header: Column {
        width: parent.width

        SectionDescription { text: "If you want, you can support my work by buying me a coffee" }



        SectionHeader { text: "Example" }
        SectionContent { contentItem: Row {
                spacing: dp(10)
                anchors.horizontalCenter: parent.horizontalCenter

                AppText { text: "Credits:" }
                AppText { text: "" + creditsCurrency.balance }
                AppText { text: "Goodies:" }
                AppText { text: "" + goodieGood.balance }
            }
        }
    }



   model : ListModel {
        ListElement { section: "Small Coffee"; name: "0,99€" }

        ListElement { section: "Medium Coffee"; name: "1,99" }
    }

    delegate: SimpleRow {
        text: name

        onSelected: {
            if (index === 0) {
                store.buyItem(creditsPack.itemId)
            }
            else if (index === 1) {
                store.buyItem(goodieGood.itemId)
            }
            else if (index === 2) {
                store.giveItem(noadsGood.itemId)
            }
            else if (index ===3) {
                store.takeItem(noadsGood.itemId)
            }
            else if (index === 4) {
                store.buyItem(noadsGood.itemId)
            }
            else if (index === 5) {
                store.restoreAllTransactions()
            }
        }
    }

    section.property: "section"
    section.delegate: SimpleSection { }

    // This rectangle represents an ad banner within your app

    Store {
        id: store

        version: 1
        secret: Constants.soomlaSecret
        androidPublicKey: Constants.soomlaAndroidPublicKey

        // Virtual currencies within the game
        currencies: [
            Currency {
                id: creditsCurrency
                itemId: Constants.creditsCurrencyItemId
                name: "Credits"
            }
        ]



        // Goods contain either single-use, single-use-pack or lifetime goods
        goods: [            // Life-time goods can be restored from the store
            LifetimeGood {
                id: smallCoffee
                itemId: Constants.smallCoffee
                name: "No Ads"
                description: "Buy this item to remove the app banner"
                purchaseType: StorePurchase { id: noAdPurchase; productId: smallCoffee.itemId; price: 0.99; }
            },
            LifetimeGood {
                id: mediumCoffee
                itemId: Constants.mediumCoffee
                name: "No Ads"
                description: "Buy this item to remove the app banner"
                purchaseType: StorePurchase { id: mediumCoffee1; productId: noadsGood.itemId; price: 1.99; }
            }
        ]

        onItemPurchased: {
            console.debug("Purchases item:", itemId)
            NativeDialog.confirm("Info", "Successfully bought: " + itemId, null, false)
        }

        onInsufficientFundsError: {
            console.debug("Insufficient funds for purchasing item")
            NativeDialog.confirm("Error",
                                 "Insufficient credits for buying a goodie, get more credits now?",
                                 function(ok) {
                                     if (ok) {
                                         // Trigger credits purchase right from dialog
                                         store.buyItem(creditsPack.itemId)
                                     }
                                 },
                                 true)
        }

        onRestoreAllTransactionsFinished: {
            console.debug("Purchases restored with success:", success)
        }
    }
}

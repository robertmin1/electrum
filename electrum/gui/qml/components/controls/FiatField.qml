import QtQuick 2.15
import QtQuick.Controls 2.0

import org.electrum 1.0

TextField {
    id: amountFiat

    required property TextField btcfield

    font.family: FixedFont
    placeholderText: qsTr('Amount')
    inputMethodHints: Qt.ImhDigitsOnly
    validator: RegularExpressionValidator {
        regularExpression: Daemon.fx.fiatAmountRegex
    }

    onTextChanged: {
        if (amountFiat.activeFocus)
            btcfield.text = text == ''
                ? ''
                : Config.satsToUnits(Daemon.fx.satoshiValue(amountFiat.text))
    }

    Connections {
        target: Daemon.fx
        function onQuotesUpdated() {
            amountFiat.text = btcfield.text == ''
                ? ''
                : Daemon.fx.fiatValue(Config.unitsToSats(btcfield.text))
        }
    }

}

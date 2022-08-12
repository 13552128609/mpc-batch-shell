"use strict";

module.exports = {
    extend: (web3) => {
        function insertMethod(name, call, params, inputFormatter, outputFormatter) {
            return new web3._extend.Method({ name, call, params, inputFormatter, outputFormatter });
        }

        function insertProperty(name, getter, outputFormatter) {
            return new web3._extend.Property({ name, getter, outputFormatter });
        }

        web3._extend({
            property: 'storeman',
            methods:
                [
                    insertMethod('addValidMpcXrpTx', 'storeman_addValidMpcXrpTx', 1, [null], null),
                    insertMethod('signMpcXrpTransaction', 'storeman_signMpcXrpTransaction', 1, [null], null),
                ],
            properties:[],
        });
    }
};



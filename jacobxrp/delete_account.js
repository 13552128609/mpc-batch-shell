'use strict';
const RippleAPI = require('ripple-lib').RippleAPI;

const keypairs = require('ripple-keypairs')

const dropsPerXrp = 1000000


function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}


/**
 *
 * @param api              : xrp API obj;
 * @param senderKeyPair    : identify the account to be destroy;
 * @param receiver         : To who the remain coin will be send to when destroy 'senderKeyPair' account;
 * @param flag
 * @return {Promise<void>}
 */
async function delete_account(api, senderKeyPair, receiver, flag) {

    let from = senderKeyPair;

    console.log("from:", from)


    async function doPrepare() {

        const rawTx = {
            TransactionType: "AccountDelete",
            Account: from.addr,
            Destination: receiver,
            Fee: api.xrpToDrops("5"),

            //  Memos: [
            //     {
            //         Memo: {
            //             MemoType: api.convertStringToHex('test'),
            //             MemoFormat: api.convertStringToHex('text/plain'),
            //             MemoData: api.convertStringToHex('texted data')
            //         }
            //     }
            // ]
            Memos: [
                // 1) 下面这个报错： [ValidationError(Serialized transaction does not match original txJSON. See `error.data`
                // {"Memo": {
                //     // "MemoType": "CrossChainInfo",
                //     // "MemoFormat": "plain",
                //     "MemoData": "00687474703a2f2f6578616d706c652e636f657263"
                // }}

                // 2) 下面这个报错：  [ValidationError(Serialized transaction does not match original txJSON. See `error.data`
                // {
                //     "Memo": {
                //         "MemoType": "687474703a2f2f6578616d706c652e636f6d2f6d656d6f2f67656e65726963",
                //         "MemoData": "72656e74"
                //     }
                // }

                // 3) 成功：( 源自 https://xrpl.org/transaction-common-fields.html  中的片段 )
                {
                    "Memo": {
                        "MemoType": "687474703a2f2f6578616d706c652e636f6d2f6d656d6f2f67656e65726963",
                        "MemoData": "72656e74"
                    }
                },

                // 3) 成功：
                {"Memo":{
                    "MemoData":"7465787465642064617461",
                        "MemoFormat":"746578742F706C61696E",
                        "MemoType":"74657374"}}
            ]
        }

        const preparedTx = await api.prepareTransaction(rawTx)
        const maxLedgerVersion = preparedTx.instructions.maxLedgerVersion
        console.log("Prepared transaction instructions:", preparedTx.txJSON)
        console.log("Transaction cost:", preparedTx.instructions.fee, "XRP")
        console.log("Transaction expires after ledger:", maxLedgerVersion)

        return preparedTx.txJSON
    }

    try {
        let  txJSON = await doPrepare()
        console.log("Delete account txJSON: ", txJSON);


        var signed_tx = api.sign(txJSON, from.keyPair)

        let tx_data = await api.submit(signed_tx.signedTransaction).catch(e => {console.log("catch submit error: ", JSON.stringify(e));});
        console.log("tx_data:", tx_data)

        let txinfo = await api.getTransaction(tx_data.tx_json.hash, {}).catch(e=>{
            console.log("immediate get txinfo catch error: ", e)
        })
        console.log("immediate get txinfo:", txinfo)

        const delatMs = 100000
        await sleep(delatMs)
        txinfo = await api.getTransaction(tx_data.tx_json.hash, {}).catch(e => {
            console.log(`after ${delatMs} milli-second get txinfo catch error:`, e)
        })
        console.log(`after ${delatMs} milli-second get txinfo:`, txinfo)

        let info = await api.getAccountInfo(from.addr)
        console.log("From account info: ", JSON.stringify(info,null,2));
        info = await api.getAccountInfo(receiver)
        console.log("To account info: ", JSON.stringify(info,null,2));

    }catch (e) {
        console.log("catch error: ", e);
        // console.log("error data: ", e.data);
    }
}


function getTestnetAccount(accountName) {

    let accountGetter = {}

    accountGetter["test_2021_account1"] = function getter() {


        const mysecret = "shAsnKprWtiHfRhE2PRMayWHEx2eZ"    // WYH：  address:  rHRar5S6VTVMWdeYXyh8k4pJ9h7TE2nxB5
        const keyPair = keypairs.deriveKeypair(mysecret)
        let pair = {
            keyPair:keyPair,
            priv:keyPair.privateKey,
            pub: keyPair.publicKey,
            addr:keypairs.deriveAddress(keyPair.publicKey)
        }
        //console.log('pair: ',pair )
        return pair;
    }


    accountGetter["latest_new_account"] = function getter() {
        const mysecret = "snhEHvN2YrotQSTMjCwaCNggkSA4s"    // WYH： 03-17 apply, address:  rf5P17wAC6o7FTQZX6ui7ekGbeWz9TZX2f
        const keyPair = keypairs.deriveKeypair(mysecret)
        let pair = {
            keyPair:keyPair,
            priv:keyPair.privateKey,
            pub: keyPair.publicKey,
            addr:keypairs.deriveAddress(keyPair.publicKey)
        }
        //console.log('pair: ',pair )
        return pair;
    }


    if ( accountGetter[accountName] ) return accountGetter[accountName]()

    return null
}


/**
 *  Test to delete account that has more than 1000 Txs
 *
 * @param url
 * @param flag
 * @param accountName
 * @param receiver
 * @return {Promise<void>}
 */
async function main_delete_manyTxAccount(url, flag, accountName, receiver, amount){
    const api = new RippleAPI({
        // server: 'wss://s1.ripple.com:51234' // Public rippled server
        server: url ,// Public rippled server,
        maxFeeXRP: 5*dropsPerXrp + '',
        timeout: 10*1000,
        // trace:true
    });

    await api.connect({connectionTimeout:10*1000}).then( async () => {
        console.log('Connected');

        const senderKeyPair = getTestnetAccount(accountName);
        if(!senderKeyPair) {
            console.log("Can not found sender account of name: ", accountName);
            return
        }

        delete_account(api, senderKeyPair, receiver, flag).finally(async ()=>{
            await api.disconnect();
        })

    }).catch(e => {
        console.error(" Catch error: ", e);
    })
}


const MAIN_NET = 'wss://s1.ripple.com/'

const TEST_NET = "wss://s.altnet.rippletest.net:51233"


// Note:

// main_delete_manyTxAccount(TEST_NET, 'TEST_NET', "latest_new_account", "rDTFv9qeDeVdantBrEnW8npRzV8KX18XSH", 0)



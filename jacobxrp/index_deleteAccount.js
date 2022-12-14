'use strict';
const RippleAPI = require('ripple-lib').RippleAPI;
const keypairs = require('ripple-keypairs')
const elliptic = require('elliptic')
const bip39 = require("bip39");
const bip32 = require("ripple-bip32");
const createKeccakHash = require('keccak');
const Secp256k1 = elliptic.ec('secp256k1');
const ripple_binary_codec = require("ripple-binary-codec");
const hashjs = require("hash.js");
const Web3 = require("web3")
const my = "r9SrZQddT4fDUQXWexsHLjtbvy44d9rt5v"
const BN = require('bn.js')
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

//const host="192.168.1.179"
const host="127.0.0.1"
const mpcBasePort = 40000;
const web3 = new Web3(new Web3.providers.HttpProvider("http://"+host+":40001"))
//console.log("web3:", web3)


const web3Mpc = require("./web3Mpc.js");
web3Mpc.extend(web3);



async function getDeleteAccountTx(api,from,receiver){
	const rawTx = {
            TransactionType: "AccountDelete",
            Account: from.addr,
            Destination: receiver,
            Fee: api.xrpToDrops("5"),
            
            Memos: [
                /*             
                {
                    "Memo": {
                        "MemoType": "687474703a2f2f6578616d706c652e636f6d2f6d656d6f2f67656e65726963",
                        "MemoData": "72656e74"
                    }
                },
                */
                // 3) ?ɹ???
                
                {"Memo":{
                    "MemoData":"7465787465642064617461",
                        "MemoFormat":"746578742F706C61696E",
                        "MemoType":"74657374"}
               }
               
            ]
        }

        const preparedTx = await api.prepareTransaction(rawTx)
        const maxLedgerVersion = preparedTx.instructions.maxLedgerVersion
        console.log("Prepared transaction instructions:", preparedTx.txJSON)
        console.log("Transaction cost:", preparedTx.instructions.fee, "XRP")
        console.log("Transaction expires after ledger:", maxLedgerVersion)

        return preparedTx.txJSON
        //return preparedTx
	
	}


// wss://s.altnet.rippletest.net:51233
async function main(){
  console.log("start:                     ")
  const api = new RippleAPI({
        server: 'wss://s.altnet.rippletest.net:51233', // Public rippled server
        timeout:20*1000
  });

  await api.connect()
  console.log("connected")

  let info;



  // let curLedger = await api.getLedgerVersion();

  // for(let i=curLedger-10; i<curLedger; i++){
  //   let info = await api.getLedger({ledgerVersion: i, includeTransactions:true, includeAllData:true});
  //   console.log(JSON.stringify(info,null,2));
  // }
  let dest = await getSecretPair();
  let from = await  getGpkPair(); 

  //console.log("dest:", dest)
  console.log("from:", from)
  
  let myDestAddr = "0xf1Cf205442bEA02e51E2C68FF4cc698e5879663C"
  let TokenPair = "216"
  const value = "15000"
  let txJson = await getDeleteAccountTx(api,from,"rpnDG6Xw7vH2CzpBqR2gCbqiHU3g5BAthy")

  let txObj = JSON.parse(txJson);


  let signedTransaction = await xrp_ec_sign(txObj,from.keyPair);
  console.log("signedTransaction:", signedTransaction);


  let txhash = await api.submit(signedTransaction);
  console.log("txhash:", txhash) 
  await api.disconnect();
}






async function  xrp_ec_sign(txObj, keypair) {
  console.log("xrp_ec_sign keypair:",keypair)
      
      txObj.SigningPubKey = keypair.publicKey;
      console.log("keypair.publicKey:",keypair.publicKey)
			
			console.log("\n@@@@@@@@@txObj",JSON.stringify(txObj),"\n")
      let signingData = ripple_binary_codec.encodeForSigning(txObj);
      let txhash = hashjs.sha512().update(Buffer.from(signingData,'hex')).digest().slice(0, 32);
      console.log("=========================txhash:", Buffer.from(txhash).toString('hex'))
      // let input = {
      //   "txData":'0x'+Buffer.from(txhash).toString('hex'),
      //   "PKBytes":"0x2e9ad92f5f541b6c2ddb672a70577c252aaa8b9b8dfdff9a5381912395985d12dc18f19ecb673a3b675697ae97913fcb69598c089f6d66ae7a3f6dc179e4da56",
      //   "ChainType":"XRP"
      // }

      let input = {
        "txData":JSON.stringify(txObj),
        "TxHash": "0x"+Buffer.from(txhash).toString('hex'),
        "PKBytes":"0x2e9ad92f5f541b6c2ddb672a70577c252aaa8b9b8dfdff9a5381912395985d12dc18f19ecb673a3b675697ae97913fcb69598c089f6d66ae7a3f6dc179e4da56",
        "ChainType":"XRP"
      }


      console.log("input:", input)

      for(let i=2; i<22; i++){
        let port  = mpcBasePort+i
        let webf = new Web3(new Web3.providers.HttpProvider("http://"+host+":"+port))
        web3Mpc.extend(webf);
        await webf.storeman.addValidMpcXrpTx(input)
          console.log("addValidMpcXrpTx %d success",i);
      }
      let sigO = await web3.storeman.signMpcXrpTransaction(input)
      console.log("sigO:",sigO)
      let sig = sigO.SignedData


      
      // // let signed_result = Secp256k1.sign(txhash, Buffer.from(keypair.privateKey,'hex'), {
      // //     canonical: true,
      // // })
      // console.log("signed_result:", signed_result)

      // let vvv = Secp256k1.verify(Buffer.from(txhash).toString('hex'), signed_result, keypair.publicKey,'hex')
      // console.log("verify vvvvv :", vvv)




      txObj.TxnSignature = sig.toUpperCase().slice(2)
      console.log("txObj.TxnSignature:", txObj.TxnSignature);


      let local_serialized = ripple_binary_codec.encode(txObj);
      return local_serialized
}


function getGpkPair() {
  let gpk = "0x9e03be7e1ac63ccce6bd921d412216fe9e7c371a50b540009217103a8a5c8ddf9d9f8297890e3bac155b58b35757c16ae8fe89bb8410cee3cf5c4c5348d2db60"
  let pubkey = Secp256k1.keyFromPublic("04"+gpk.slice(2), 'hex')
  let compressed = pubkey.getPublic(true, 'hex')
  console.log("pubkey compressed:", compressed)
  
  let addr = keypairs.deriveAddress(compressed.toUpperCase())
  //let addr = keypairs.deriveAddress("04"+gpk.slice(2))
  console.log("getGpkPair addr:", addr)
  let pair = {
    priv: "",
    pub: compressed.toUpperCase(),
    addr
  }
  pair.keyPair = {privateKey:pair.priv, publicKey:pair.pub}
  console.log("getGpkPair pair:", pair)

  return pair
}



function getPrivPair(){
  let raw = "303bc5cc3af0f655430909a4a3add6a411fa9c4b7f182a8d2a1a419614e818f0"
  let pubKey = Secp256k1.keyFromPrivate(raw).getPublic().encodeCompressed()
  let pair = {
    priv: "00" + raw, 
    pub: Buffer.from(pubKey).toString('hex').toUpperCase(),
    addr: keypairs.deriveAddress(Buffer.from(pubKey).toString('hex'))
  }
  pair.keyPair = {privateKey:pair.priv, publicKey:pair.pub}
  //console.log("pair:", pair)
  return pair
}

function getSecretPair() {  // many money
  const mysecret = "shw9ftW4K1aaeFave2JNaYpKPEBiZ"
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

async function getmnemonicPair() {
  let mnemonic = "whale weasel funny tool dinner kid shield enrich build address wasp rent"
  
  const seed = await bip39.mnemonicToSeed(mnemonic) // add second argument for 25th word encrypted
  const m = bip32.fromSeedBuffer(seed)
  const keyPair = m.derivePath("m/44'/144'/0'/0/0").keyPair.getKeyPairs()
  let pair = {
    keyPair:keyPair,
    priv:keyPair.privateKey,
    pub: keyPair.publicKey,
    addr:keypairs.deriveAddress(keyPair.publicKey)
  }
  console.log('getmnemonicPair pair: ',pair )
  return pair
}

async function ec_verify() {
  const BN = require("bn.js")
  //let gpk = "042e9ad92f5f541b6c2ddb672a70577c252aaa8b9b8dfdff9a5381912395985d12dc18f19ecb673a3b675697ae97913fcb69598c089f6d66ae7a3f6dc179e4da56"
  let gpk = "022e9ad92f5f541b6c2ddb672a70577c252aaa8b9b8dfdff9a5381912395985d12"
  const e = "f4511f8b9943c1bea62d9593e4931641eea2aec1342ea08f904300f0b6515a43"
  //const rs = "435a238b9b433d29d5eaf556ff4f7bd3e3ba64b2c45c324923a35ca5ce8ef4613de02f04c472cd81de49cb6728224ef0d6ae09f723ab2f16bdc9dddc7190bed800"

  const rs = {
    r: new BN("435a238b9b433d29d5eaf556ff4f7bd3e3ba64b2c45c324923a35ca5ce8ef461", 16),
    s: new BN("3de02f04c472cd81de49cb6728224ef0d6ae09f723ab2f16bdc9dddc7190bed8", 16),
    recoveryParam:0
  }

  let vvv = Secp256k1.verify(e, rs, gpk,'hex')
  console.log("verify:", vvv)


  let pk = Secp256k1.recoverPubKey(e, rs, 0)
  console.log("Pk:", pk)
}
//ec_verify()
main()

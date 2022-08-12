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
const gpk = "0x82b353d8a2876597e3dca564b9f2a78f89bc802424a99898f2a4269146ea31eb4dce6d002f5d7489b42b84bda8b864598553cb984b8c9e36f326b65c10e1314e"

const host="192.168.1.179"
const web3 = new Web3(new Web3.providers.HttpProvider("http://"+host+":31901"))
//console.log("web3:", web3)


const web3Mpc = require("./web3Mpc.js");
web3Mpc.extend(web3);




async function main(){
  console.log("start:                     ")
  const api = new RippleAPI({
    server: 'wss://s.altnet.rippletest.net:51233' // Public rippled server
  });

  await api.connect()
  console.log("connected")

  let info;




  let from = await  getmnemonicPair(); 
  let dest = await  getGpkPair();
  //console.log("dest:", dest)
  console.log("from:", from)
  
  let myDestAddr = "0xf1Cf205442bEA02e51E2C68FF4cc698e5879663C"
  let TokenPair = "216"
  const value = "30000000"

  let payment_info =  {
    "source": {
      "address": from.addr,
      "maxAmount": {
        "value": "33000000",
        "currency": "drops"
      }
    },
    "destination": {
      "address": "r33a3EQ8TYSoniHYFwyJoUV4QeEKWkSVeH",
      "amount": {
        "value": "33000000",
        "currency": "drops"
      }
    },
    "memos": [
      {
        "type": "CrossChainInfo",
        "format": "text/plain",
        "data": "05NaN"
      }
    ]
  }


  // let payment_info = {
  //   "source": {
  //       "address": from.addr,
  //       "maxAmount": {
  //           "value": value,
  //           "currency": "drops"
  //       },
  //   },
  //   "destination": {
  //       "address": dest.addr,
  //       "amount": {
  //           "value": value,
  //           "currency": "drops"
  //       },
  //   },
  //   "memos": [
  //       {
  //           "type": "CrossChainInfo",
  //           "format": "text/plain",
  //           "data": TokenPair+myDestAddr
  //       }
  //   ]
  // };

  let preparePayment = await api.preparePayment(from.addr, payment_info);
  console.log("preparePayment:", preparePayment);

  let txObj = JSON.parse(preparePayment.txJSON);
  txObj.LastLedgerSequence = parseInt(txObj.LastLedgerSequence)+600




  let signed_tx = api.sign(preparePayment.txJSON, from.keyPair);
  let signedTransaction = signed_tx.signedTransaction
  console.log("api.sign signedTransaction:", signedTransaction);



  let txhash = await api.submit(signedTransaction);
  console.log("txhash:", txhash)


  await api.disconnect();
}





function getGpkPair() {
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


main()

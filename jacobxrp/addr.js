const bip39 = require("bip39");
const bip32 = require("ripple-bip32");
const ripple = require('ripple-keypairs')

async function main() {
let mnemonic = bip39.generateMnemonic()

console.log('mnemonic: ' + mnemonic)
const seed = await bip39.mnemonicToSeed(mnemonic) // add second argument for 25th word encrypted
console.log('seed: ', seed)
const m = bip32.fromSeedBuffer(seed)
console.log('m: ', m)
const keyPair = m.derivePath("m/44'/144'/0'/0/0").keyPair.getKeyPairs()
const address = ripple.deriveAddress(keyPair.publicKey)

console.log('privateKey: ' + keyPair.privateKey)
console.log('publicKey: ' + keyPair.publicKey)
console.log('address: ' + address)
}

main()


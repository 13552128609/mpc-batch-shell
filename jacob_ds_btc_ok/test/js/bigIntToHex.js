const Web3=require('web3')

var web3=new Web3();
console.log(web3)

//console.log(web3._extend.utils.toHex(16))
console.log(web3._extend.utils.toDecimal(0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798).toString(10))
console.log(web3._extend.utils.toDecimal(0x6b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c296).toString(10))


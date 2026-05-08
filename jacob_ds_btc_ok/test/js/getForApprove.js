const ipc = "/home/jacob/wanchain/mpc-batch-shell/jacob_ds_btc_ok/nodes/n01/data/mpc.ipc"

const Web3 = require("web3")
var net = require('net');
var web3 = new Web3();
web3.setProvider(new Web3.providers.IpcProvider(ipc, net))
var mpcWeb3 = require('./web3Mpc')
mpcWeb3.extend(web3)

async function main() {
	// for(;;) {
	// 	web3.storeman.getForApprove(0,(err, result) => {
	// 		console.log(`result ${Date.now()}`,JSON.stringify(result,null,2));			
	// 			if (err) {
	// 				console.error("getForApprove error", err)
	// 				return
	// 			}				
	// 		})
		
		
	// 	await sleep(1000)
	// }
	
	console.log(`web3.storeman=`,web3.storeman);
	console.log(`web3.storeman.getForApprove=`,web3.storeman.getForApprove);
	
	web3.storeman.getForApprove(0, (err, result) => {
		console.log(`result`,result.length);
	})
}


async function sleep(time) {
	return new Promise(function (resolve, reject) {
		setTimeout(function () {
			resolve();
		}, time);
	});
}


main()

// node getForApprove.js

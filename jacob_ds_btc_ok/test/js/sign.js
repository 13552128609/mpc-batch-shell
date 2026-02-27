const ipc = "/home/jacob/wanchain/mpc-batch-shell/jacob_ds_btc_ok/nodes/n01/data/mpc.ipc"

const Web3 = require("web3")
const conf = require("./data").conf
console.log(conf)

var net = require('net');
var web3 = new Web3();
web3.setProvider(new Web3.providers.IpcProvider(ipc, net))
var mpcWeb3 = require('./web3Mpc')
mpcWeb3.extend(web3)

//console.log(web3)

var hashData = null

var NUM = 20
var BATCH = 5

const argv = process.argv;

function usageAndExit() {
	console.error('Usage: node sign.js <NUM> <BATCH> <pk> <curve> <alg>');
	process.exit(1);
}

async function main() {
	if (argv.length < 7) {
		usageAndExit()
	}

	NUM = parseInt(argv[2])
	BATCH = parseInt(argv[3])
	const pk = argv[4]
	const curve = argv[5]
	const alg = argv[6]

	if (!Number.isFinite(NUM) || !Number.isFinite(BATCH) || !pk || !curve || !alg) {
		usageAndExit()
	}

	let signDataS = []
	for (let i = 0; i < NUM; i++) {
		if (parseInt(i) === 0) {
			hashData = conf.hashData
		} else {
			//hashData = web3.sha3(hashData, {encoding: 'hex'}); //todo should restore
			hashData = conf.hashData
		}
		let signData = {
			pk,
			curve,
			alg,
			hashData: [hashData],
			rawData: [conf.rawData],
			extern: conf.extern,
		}
		signDataS.push(signData)
		//console.log(signDataS.length)
	}

	let allBegin=Date.now()
	let remain = BATCH //todo 10
	var signed = 0
	while (parseInt(signDataS.length) != 0) {
		for (let j = 0; j < remain; j++) {
			let signDataTemp = {}
			Object.assign(signDataTemp, signDataS.pop())
			//console.log("signDataTemp", signDataTemp)
			//console.log("web3.storeman", web3.storeman)
			let begin=Date.now()
			//web3.storeman.signByApprove(signDataTemp, async (err, result) => {
			web3.storeman.signByApprove(signDataTemp, (err, result) => {
				signed++
				let end=Date.now()
				console.log(`signDataTemp ${signed}`,signDataTemp);
				console.log(`result ${signed}`,result);
				console.log("signedNum",signed,"status", err==null?'success':err, "result", result==null?'null':result.ResultType,"incentive",result!=null?result.IncntData:'null',
					"during",parseInt((end-begin)/1000),"begin",parseInt(begin/1000),"end",parseInt(end/1000),"beginDate",(new Date(begin)), "endDate",(new Date(end)))
				remain = remain + 1
				if(parseInt(signed) == parseInt(NUM)){
					console.log("lastNum",NUM,"allTime",(Date.now()-allBegin)/1000)
				}

			})
		}
		remain = 0
		await sleep(100)
	}
}


async function sleep(time) {
	return new Promise(function (resolve, reject) {
		setTimeout(function () {
			resolve();
		}, time);
	});
}


main()

// node sign.js 5 5 0x0293b298cc0f913f47dcb1a4e505f3baf1c859d62306f81e18d4ecd07a1e25862e7fb440fd6d54daab96a32cd2e9d2c8d7c7428e926633a5195ddfa79b0173ab 0x01 0x01
// node sign.js 5 5 0x5b983948cc5ac7e7c86f8befb4a4ac551dede33d3026ebc7558d45264a21b583ff3ff0797071dda8dfea85288a8f53a6040819b992684cc2a6a7422803d2db07 0x00 0x00
// node sign.js 5 5 0x5e3d7446ae8be69ac15941f82243a776b87868f52e6e99bd8050fbe3f5a4b48f07df1e4149f5ccdadf32334efdee740e449f585c1817ace1034890c467dc6d80 0x00 0x01
// node sign.js 5 5 0x5e3d7446ae8be69ac15941f82243a776b87868f52e6e99bd8050fbe3f5a4b48f07df1e4149f5ccdadf32334efdee740e449f585c1817ace1034890c467dc6d80 0x00 0x02

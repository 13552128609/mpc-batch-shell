const ipc = "/home/jacob/mpc-batch-shell/jacob_ds_btc_ok/nodes/n01/data/mpc.ipc"

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

async function main() {
	console.log(argv[2])
	console.log(argv[3])
	NUM = parseInt(argv[2])
	BATCH=parseInt(argv[3])

    let signDataS = []
    for (let i = 0; i < NUM; i++) {
        if (parseInt(i) === 0) {
            hashData = conf.hashData
        } else {
            //hashData = web3.sha3(hashData, {encoding: 'hex'}); //todo should restore
            hashData = conf.hashData
        }
        let signData = {
            pk: conf.pk,
            curve: conf.curve,
            alg: conf.alg,
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
            web3.storeman.signByApprove(signDataTemp, async (err, result) => {
		    signed++
		    let end=Date.now()
		    if(parseInt(signed) == parseInt(NUM)){
    				console.log("lastNum",NUM,"allTime",(Date.now()-allBegin)/1000)
		    }
                console.log("signedNum",signed,"status", err==null?'success':err, "result", result==null?'null':result.ResultType,"incentive",result!=null?result.IncntData:'null',
			"during",parseInt((end-begin)/1000),"begi",parseInt(begin/1000),"end",parseInt(end/1000))
                remain = remain + 1
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

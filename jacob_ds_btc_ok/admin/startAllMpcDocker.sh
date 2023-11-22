
image='wanchain/mpc-peer-debug:latest'

index=1

loglevel=3

ROOTPATH="/home/qjia/mpc-batch-shell/jacob_ds_btc_ok"

for nodeKey  in $(cat ../conf/grpConf/nodeKeyList|awk '{print $1}')
do
        if [ ${index} -lt 10 ];then
                p2pPort=5000${index}
                rpcPort=6000${index}
                datadir=../nodes/'n0'${index}/data                
                ksdir=../nodes/'n0'${index}/ks
		nodename='n0'${index}
        else
                p2pPort=500${index}
                rpcPort=600${index}
                datadir=../nodes/'n'${index}/data                
                ksdir=../nodes/'n'${index}/ks
		nodename='n'${index}

        fi
    container="mpc_"$index
    mpccmd="/mpc-bin/schnorrmpc --verbosity 3 --port $p2pPort --rpc --rpcport $rpcPort --rpcapi 'admin,debug,storeman,web3' --storeman  --datadir /mpc-nodes/data --keystore /mpc-nodes/ks --password /mpc-cfg/pwd.json --ipcpath /mpc-nodes/data/mpc.ipc --maxpeers 500 --nodekey /mpc-nodes/data/nodekey --threshold 17 --totalnodes 21  --bootnodes 'enode://227ea0bbf86764014a1bc0d123ee18edc6e79b5e602f2f4706a985369bbfc7cfd91f2a14f1c71aad137c814abf6659342213fb7c4af1eb114dea37d51d6e0fbf@35.89.118.52:30000'  >  /tmp/node${index} 2>&1 &"
    mpccmd="/usr/bin/pwd"
    cmd="sudo docker run \
	    --rm \
        --name $container \
        -p $p2pPort:$p2pPort -p $p2pPort:$p2pPort/udp -p $mpcport:8545 \
        -v $ROOTPATH/bin:/mpc-bin \
        -v $ROOTPATH/nodes/$nodename:/mpc-nodes \
        -v $ROOTPATH/conf/cfg:/mpc-cfg \
        -v /tmp:/tmp \
        -v $ROOTPATH/cmd:/mpc-cmd \
        -d $image \
	--port $p2pPort \
	--verbosity $loglevel \
        "
	echo $cmd
	`$cmd 1>&2`
  	((index++))
done

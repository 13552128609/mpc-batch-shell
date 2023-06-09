index=1

for nodeKey  in $(cat ../conf/cfg/nodeList)
do 
  	if [ ${index} -lt 10 ];then
		p2pPort=3000${index}
		rpcPort=4000${index}
		datadir=../nodes/'n0'${index}/data
		prof=../nodes/'n0'${index}/data/mpc.prof
		ksdir=../nodes/'n0'${index}/ks
	else
		p2pPort=300${index}
		rpcPort=400${index}
		datadir=../nodes/'n'${index}/data
		prof=../nodes/'n'${index}/data/mpc.prof
		ksdir=../nodes/'n'${index}/ks

	fi
	echo "datadir" + $datadir
	echo "nodekey" + $datadir+"/nodekey"
    cat $datadir"/nodekey"
#nohup ~/jacobbtc/schnorrmpc --verbosity 5 --port $p2pPort --rpc --rpcport $rpcPort --rpcapi 'admin,debug,storeman,web3' --storeman  --datadir $datadir --keystore $ksdir --password ./cfg/pwd.json --ipcpath $datadir/mpc.ipc --maxpeers 500 --nodekey $datadir/nodekey --threshold 17 --totalnodes 21  --bootnodes "enode://227ea0bbf86764014a1bc0d123ee18edc6e79b5e602f2f4706a985369bbfc7cfd91f2a14f1c71aad137c814abf6659342213fb7c4af1eb114dea37d51d6e0fbf@127.0.0.1:30000"  >  /tmp/node${index} 2>&1 &
#nohup ~/jacobbtc/schnorrmpc --verbosity 3 --port $p2pPort --rpc --rpcport $rpcPort --rpcapi 'admin,debug,storeman,web3' --storeman  --datadir $datadir --keystore $ksdir --password ./cfg/pwd.json --ipcpath $datadir/mpc.ipc --maxpeers 500 --nodekey $datadir/nodekey --threshold 17 --totalnodes 21  --bootnodes "enode://227ea0bbf86764014a1bc0d123ee18edc6e79b5e602f2f4706a985369bbfc7cfd91f2a14f1c71aad137c814abf6659342213fb7c4af1eb114dea37d51d6e0fbf@127.0.0.1:30000"  >  /tmp/node${index} 2>&1 &
##pprof
nohup ../bin/schnorrmpc --verbosity 3 --port $p2pPort --rpc --rpcport $rpcPort --rpcapi 'admin,debug,storeman,web3' --storeman  --datadir $datadir --keystore $ksdir --password ../conf/cfg/pwd.json --ipcpath $datadir/mpc.ipc --maxpeers 500 --nodekey $datadir/nodekey --threshold 17 --totalnodes 21  --bootnodes "enode://227ea0bbf86764014a1bc0d123ee18edc6e79b5e602f2f4706a985369bbfc7cfd91f2a14f1c71aad137c814abf6659342213fb7c4af1eb114dea37d51d6e0fbf@127.0.0.1:30000"  >  /tmp/node${index} 2>&1 &
  ((index++))

#  if [ ${index} -gt $1 ]; then
#	  break
#  fi
done

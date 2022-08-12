index=1

for nodeKey  in $(cat ./cfg/nodeList)
do 
  	if [ ${index} -lt 10 ];then
		p2pPort=3000${index}
		datadir=./'n0'${index}/data
		ksdir=./'n0'${index}/ks
	else
		p2pPort=300${index}
		datadir=./'n'${index}/data
		ksdir=./'n'${index}/ks

	fi
	echo "datadir" + $datadir
	nohup ./schnorrmpc --verbosity 3 --port $p2pPort --storeman  --datadir $datadir --keystore $ksdir --password ./cfg/pwd.json --ipcpath $datadir/mpc.ipc --maxpeers 500 --nodekey $datadir/nodekey --threshold 17 --totalnodes 21  --bootnodes "enode://227ea0bbf86764014a1bc0d123ee18edc6e79b5e602f2f4706a985369bbfc7cfd91f2a14f1c71aad137c814abf6659342213fb7c4af1eb114dea37d51d6e0fbf@127.0.0.1:30000"  >  /tmp/node${index} 2>&1 &

  ((index++))
done

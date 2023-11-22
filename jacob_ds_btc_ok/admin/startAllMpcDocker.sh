
image='wanchain/mpc-peer-debug:latest'

index=1

cmd=/bin/schnorrmpc --verbosity 3 --port $p2pPort --rpc --rpcport $rpcPort --rpcapi 'admin,debug,storeman,web3' --storeman  --datadir /nodes/data --keystore /nodes/ks --password /cfg/pwd.json --ipcpath /nodes/data/mpc.ipc --maxpeers 500 --nodekey /nodes/data/nodekey --threshold 17 --totalnodes 21  --bootnodes "enode://227ea0bbf86764014a1bc0d123ee18edc6e79b5e602f2f4706a985369bbfc7cfd91f2a14f1c71aad137c814abf6659342213fb7c4af1eb114dea37d51d6e0fbf@35.89.118.52:30000"  >  /tmp/node${index} 2>&1 &

for nodeKey  in $(cat ../conf/grpConf/nodeKeyList|awk '{print $1}')
do
        if [ ${index} -lt 10 ];then
                p2pPort=3000${index}
                rpcPort=4000${index}
                datadir=../nodes/'n0'${index}/data                
                ksdir=../nodes/'n0'${index}/ks
        else
                p2pPort=300${index}
                rpcPort=400${index}
                datadir=../nodes/'n'${index}/data                
                ksdir=../nodes/'n'${index}/ks

        fi
        echo "datadir" + $datadir
        echo "nodekey" + $datadir+"/nodekey"
    cat $datadir"/nodekey"
    
    container="mpc_"$index
    
    cmd="sudo docker run \
        --name $container \        
        -p $p2pPort:$p2pPort -p $p2pPort:$p2pPort/udp -p $mpcport:8545 \
        -v /home/ubuntu/mpc-batch-shell/jacob_ds_btc_ok/bin:/bin \
        -v /home/jacob/mpc-batch-shell/jacob_ds_btc_ok/nodes/n10:/nodes \
        -v /home/jacob/mpc-batch-shell/jacob_ds_btc_ok/conf/cfg:/cfg \   
        -d $image
        -exec $cmd
        "
echo $cmd
#`$cmd 1>&2`

  ((index++))
  
done

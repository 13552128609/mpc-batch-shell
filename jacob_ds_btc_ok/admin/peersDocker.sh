
image='wanchain/mpc-peer-debug:latest'

index=1

loglevel=3

ROOTPATH="/home/qjia/mpc-batch-shell/jacob_ds_btc_ok/"

for nodeKey  in $(cat ../conf/grpConf/nodeKeyList|awk '{print $1}')
do
        if [ ${index} -lt 10 ];then
                p2pPort=3000${index}
                rpcPort=4000${index}
                datadir=../nodes/'n0'${index}/data                
                ksdir=../nodes/'n0'${index}/ks
		nodename='n0'${index}
        else
                p2pPort=300${index}
                rpcPort=400${index}
                datadir=../nodes/'n'${index}/data                
                ksdir=../nodes/'n'${index}/ks
		nodename='n'${index}

        fi
    container="mpc_"$index
echo && echo " ********************************************************* "
echo $container

cmd="sudo docker exec  -i $container /mpc-bin/schnorrmpc attach /mpc-nodes/data/mpc.ipc < $ROOTPATH/cmd/peers.cmd"
#echo $cmd
eval $cmd
#`$cmd 2>&1`
  ((index++))
echo && echo " ********************************************************* "

done

echo && echo " ********************************************************* "
echo "mpc_boot"
cmd="sudo docker exec  -i mpc_boot /mpc-bin/schnorrmpc attach /mpc-nodes/data/mpc.ipc < $ROOTPATH/cmd/peers.cmd"
eval $cmd
echo && echo " ********************************************************* "

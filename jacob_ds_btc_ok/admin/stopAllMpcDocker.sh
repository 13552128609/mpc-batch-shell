
image='wanchain/mpc-peer-debug:latest'

index=1

loglevel=3

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
    cmd="sudo docker stop $container"
echo $cmd
`$cmd 1>&2`

  ((index++))
done

cmd="sudo docker stop mpc_boot"
`$cmd 1>&2`


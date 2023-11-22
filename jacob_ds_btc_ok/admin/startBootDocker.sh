
image='wanchain/mpc-peer-debug:latest'

index=1

ROOTPATH="/home/qjia/mpc-batch-shell/jacob_ds_btc_ok"

loglevel=3
    p2pPort=50000
    nodename=boot
    container="mpc_boot"
    cmd="sudo docker run \
	    --rm \
        --name $container \
        -p $p2pPort:$p2pPort -p $p2pPort:$p2pPort/udp \
        -v $ROOTPATH/bin:/mpc-bin \
        -v $ROOTPATH/nodes/$nodename:/mpc-nodes \
        -v $ROOTPATH/conf/cfg:/mpc-cfg \
        -v /tmp:/tmp \
        -d $image \
	--port $p2pPort \
	--verbosity $loglevel \
        "
echo $cmd
`$cmd 1>&2`

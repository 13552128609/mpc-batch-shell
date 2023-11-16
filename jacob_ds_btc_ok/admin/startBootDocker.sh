
image='wanchain/mpc-peer-debug:latest'

index=1

loglevel=3
    p2pPort=30000
    nodename=boot
    container="mpc_boot"
    cmd="sudo docker run \
	    --rm \
        --name $container \
        -p $p2pPort:$p2pPort -p $p2pPort:$p2pPort/udp \
        -v /home/ubuntu/mpc-batch-shell/jacob_ds_btc_ok/bin:/mpc-bin \
        -v /home/ubuntu/mpc-batch-shell/jacob_ds_btc_ok/nodes/$nodename:/mpc-nodes \
        -v /home/ubuntu/mpc-batch-shell/jacob_ds_btc_ok/conf/cfg:/mpc-cfg \
        -v /tmp:/tmp \
        -d $image \
	--port $p2pPort \
	--verbosity $loglevel \
        "
echo $cmd
`$cmd 1>&2`

ROOTPATH="/home/qjia/mpc-batch-shell/jacob_ds_btc_ok/"
for container in $(docker ps | grep openstoreman9 | awk '{print $NF}')
do
	echo && echo " ********************************************************* "
	echo $container

	cmd="sudo docker exec  -i $container /osm/schnorrmpc/bin/schnorrmpc attach /osm/schnorrmpc/data/gwan.ipc < $ROOTPATH/cmd/peers.cmd"
	echo $cmd
	eval $cmd
	echo && echo " ********************************************************* "
done

        container='openstoreman_bootnode'
	echo && echo " ********************************************************* "
	echo $container
	cmd="sudo docker exec  -i $container /osm/schnorrmpc/bin/schnorrmpc attach /osm/schnorrmpc/data/gwan.ipc < $ROOTPATH/cmd/peers.cmd"
	eval $cmd
	echo && echo " ********************************************************* "

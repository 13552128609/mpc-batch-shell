ROOTPATH="/home/qjia/mpc-batch-shell/jacob_ds_btc_ok/"
for container in $(docker ps | grep openstoreman |grep -v openstoreman9 | awk '{print $NF}')
do
	echo && echo " ********************************************************* "
	echo $container

	cmd="sudo docker exec  -i $container sh -c 'cp  /root/.pm2/logs/schnorrmpc-leader-error* /osm/schnorrmpc/data/'"
	cmd1="sudo docker exec  -i $container sh -c 'cp  /root/.pm2/logs/schnorrmpc-error* /osm/schnorrmpc/data/'"
	echo $cmd
	echo $cmd1
	eval $cmd
	eval $cmd1
	echo && echo " ********************************************************* "
done


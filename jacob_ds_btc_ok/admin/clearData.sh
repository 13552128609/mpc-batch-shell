rm -r ../nodes/boot/data/schnorrmpc
rm -r ../nodes/boot/data/storeman

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
  rm -r $datadir/schnorrmpc
  rm -r $datadir/storeman
  ((index++))
done
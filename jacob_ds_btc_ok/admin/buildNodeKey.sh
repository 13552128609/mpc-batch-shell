index=1
for nodeKey  in $(cat ../conf/grpConf/nodeKeyList|awk '{print $1}')
do 
  echo ${index} ${nodeKey}

  	if [ ${index} -lt 10 ];then
		mkdir -p ../nodes/'n0'${index}/data
		mkdir -p ../nodes/'n0'${index}/bin
		mkdir -p ../nodes/'n0'${index}/ks
		touch ../nodes/'n0'${index}/data/nodekey
		echo ${nodeKey} > ../nodes/'n0'${index}/data/nodekey
		#ln -s ~/jacob/bin/schnorrmpc ./'n0'${index}/bin/schnorrmpc
	else
		mkdir -p ../nodes/'n'${index}/data
		mkdir -p ../nodes/'n'${index}/bin
		mkdir -p ../nodes/'n'${index}/ks
		touch  ../nodes/'n'${index}/data/nodekey
		echo ${nodeKey} > ../nodes/'n'${index}/data/nodekey
		#ln -s ~/jacob/bin/schnorrmpc ./'n'${index}/bin/schnorrmpc
	fi
  ((index++))
done

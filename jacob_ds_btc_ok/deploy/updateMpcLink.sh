index=1
for nodeKey  in $(cat ./cfg/nodeList)
do 
  echo ${index} ${nodeKey}

  	if [ ${index} -lt 10 ];then
		#mkdir -p ./'n0'${index}/data
		#mkdir -p ./'n0'${index}/bin
		#touch ./'n0'${index}/data/nodekey
		#echo ${nodeKey} > ./'n0'${index}/data/nodekey
		rm -rf ./'n0'${index}/bin/schnorrmpc
		ln -s ~/jacob/schnorrmpc ./'n0'${index}/bin/schnorrmpc
	else
		#mkdir -p ./'n'${index}/data
		#mkdir -p ./'n'${index}/bin
		#touch  ./'n'${index}/data/nodekey
		#echo ${nodeKey} > ./'n'${index}/data/nodekey
		rm -rf ./'n'${index}/bin/schnorrmpc
		ln -s ~/jacob/schnorrmpc ./'n'${index}/bin/schnorrmpc
	fi
  ((index++))
done

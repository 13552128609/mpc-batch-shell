index=1
for nodeKey  in $(cat ../conf/cfg/nodeList)
do 
  echo ${index} ${nodeKey}

  	if [ ${index} -lt 10 ];then
		cp ../conf/groupConf/groupInfo.json ../nodes/'n0'${index}/data/groupInfo.json
	else
		cp ../conf/groupConf/groupInfo.json ../nodes/'n'${index}/data/groupInfo.json
	fi
  ((index++))
done

echo "done"

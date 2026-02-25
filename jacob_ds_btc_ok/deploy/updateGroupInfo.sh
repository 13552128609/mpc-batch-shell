index=1
for nodeKey  in $(cat ../conf/grpConf/nodeKeyList|awk '{print $1}')
do 
  echo ${index} ${nodeKey}

  	if [ ${index} -lt 10 ];then
		cp ../conf/grpConf/groupInfo.json ../nodes/'n0'${index}/data/groupInfo.json
	else
		cp ../conf/grpConf/groupInfo.json ../nodes/'n'${index}/data/groupInfo.json
	fi
  ((index++))
done

echo "done"

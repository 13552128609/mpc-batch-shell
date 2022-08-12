index=1
for nodeKey  in $(cat ./cfg/nodeList)
do 
  echo ${index} ${nodeKey}

  	if [ ${index} -lt 10 ];then
		cp ./cfg/groupInfo.json ./'n0'${index}/data/groupInfo.json
	else
		cp ./cfg/groupInfo.json ./'n'${index}/data/groupInfo.json
	fi
  ((index++))
done

echo "done"

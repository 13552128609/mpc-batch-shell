index=1
i=0
j=0

myNodeKeyList=$(cat ../conf/groupConf/nodeKeyList| awk '{print $1}')
echo "myNodeKeyList:"${myNodeKeyList}

rm ../conf/cfg/nodeList
for key in  ${myNodeKeyList}
do
	nodeKeyList[$j]=${key}
	let j++
	# 用新的nodeKey组装出新的nodeKeyList
	echo "${key}" >> ../conf/cfg/nodeList
done

echo $wa

for nodeKey  in $(cat ../conf/cfg/nodeList)
do 
  	if [ ${index} -lt 10 ];then
        echo "${nodeKeyList[$i]}" > ../nodes/'n0'${index}/data/nodekey
	else
        echo "${nodeKeyList[$i]}" > ../nodes/'n'${index}/data/nodekey
	fi
  let i++
  let index++
done



echo "done"

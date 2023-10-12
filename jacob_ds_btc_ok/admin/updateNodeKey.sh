index=1
i=0
j=0

myNodeKeyList=$(cat ../conf/grpConf/nodeKeyList| awk '{print $1}')
echo "myNodeKeyList:"${myNodeKeyList}

for key in  ${myNodeKeyList}
do
	nodeKeyList[$j]=${key}
	let j++
done

echo $wa

for nodeKey  in $(cat ../conf/grpConf/nodeKeyList| awk '{print $1}')
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

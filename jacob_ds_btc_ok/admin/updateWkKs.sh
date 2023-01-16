index=1
i=0
j=0

mywkAddrList=$(cat ../conf/groupConf/WorkingAddList | awk '{print $1}')
echo "mywkAddrList:"${mywkAddrList}

rm ../conf/cfg/wkAddrList
for wa in  ${mywkAddrList}
do
	wkAddrList[$j]=${wa}
	let j++
	# 用新的nodeKey组装出新的nodeKeyList
	echo "${wa}" >> ../conf/cfg/wkAddrList
done

echo $wa

for nodeKey  in $(cat ../conf/cfg/nodeList)
do 
  	if [ ${index} -lt 10 ];then
		cp -rf ../conf/groupConf/ks/${wkAddrList[$i]} ../nodes/'n0'${index}/ks
	else
		cp -rf ../conf/groupConf/ks/${wkAddrList[$i]} ../nodes/'n'${index}/ks
	fi
  let i++
  let index++
done

echo "done"

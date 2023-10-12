index=1
i=0
j=0

mywkAddrList=$(cat ../conf/grpConf/WorkingAddList | awk '{print $1}')
echo "mywkAddrList:"${mywkAddrList}

for wa in  ${mywkAddrList}
do
	wkAddrList[$j]=${wa}
	let j++
done

echo $wa

for nodeKey  in $(cat ../conf/grpConf/nodeKeyList|awk '{print $1}')
do 
  	if [ ${index} -lt 10 ];then
		cp -rf ../conf/grpConf/ks/${wkAddrList[$i]} ../nodes/'n0'${index}/ks
	else
		cp -rf ../conf/grpConf/ks/${wkAddrList[$i]} ../nodes/'n'${index}/ks
	fi
  let i++
  let index++
done

echo "done"

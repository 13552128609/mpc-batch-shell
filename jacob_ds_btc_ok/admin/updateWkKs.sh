index=1
indexKs=0
i=0
j=0

gpk=$(cat ./cfg/gpkList)
echo "gpk:"${gpk}

mywkAddrList=$(cat ./cfg/wkAddrList)
echo "mywkAddrList:"${mywkAddrList}

for wa in  $(cat ./cfg/wkAddrList)
do
	wkAddrList[$j]=${wa}
	let j++
done

echo $wa

for nodeKey  in $(cat ./cfg/nodeList)
do 
  	if [ ${index} -lt 10 ];then
		rm -rf ./'n0'${index}/ks
		mkdir -p ./'n0'${index}/ks
		cp -rf ./cfg/mpc_internal_aws/ks/${gpk}'_0'${indexKs} ./'n0'${index}/ks/${gpk} 
		cp -rf ./cfg/mpc_internal_aws/ks/${wkAddrList[$i]} ./'n0'${index}/ks
		echo "cp -rf ./cfg/mpc_internal_aws/ks/${wkAddrList[$i]} ./'n0'${index}/ks"
	else
		rm -rf ./'n'${index}/ks
		mkdir -p ./'n'${index}/ks
		cp -rf ./cfg/mpc_internal_aws/ks/${wkAddrList[$i]} ./'n'${index}/ks
		echo "cp -rf ./cfg/mpc_internal_aws/ks/${wkAddrList[$i]} ./'n'${index}/ks"
		if [ ${indexKs} -lt 10 ];then
			cp -rf ./cfg/mpc_internal_aws/ks/${gpk}'_0'${indexKs} ./'n'${index}/ks/${gpk} 
		else
			cp -rf ./cfg/mpc_internal_aws/ks/${gpk}'_'${indexKs} ./'n'${index}/ks/${gpk} 
		fi
	fi
  ((index++))
  ((indexKs++))
  let i++
done

echo "done"

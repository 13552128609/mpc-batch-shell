index=1
index1=0
gpk=$(cat ../conf/grpConf/gpk)

echo ${#gpk}
echo ${gpk:4}

if [ ${#gpk} -gt 130 ]; then
    gpk="0x"${gpk:4}
fi

for nodeKey  in $(cat ../conf/grpConf/nodeKeyList|awk '{print $1}')
do 
  echo ${index} ${nodeKey}

  	if [ ${index} -lt 10 ];then
		cp ../conf/grpConf/gpkKs/${gpk}'_0'${index1} ../nodes/'n0'${index}/ks/${gpk}
	else
  	    if [ ${index} -eq 10 ];then
		    cp ../conf/grpConf/gpkKs/${gpk}'_0'${index1} ../nodes/'n'${index}/ks/${gpk}
        else
		    cp ../conf/grpConf/gpkKs/${gpk}'_'${index1} ../nodes/'n'${index}/ks/${gpk}
        fi
	fi
  ((index++))
  ((index1++))
done

echo "done"

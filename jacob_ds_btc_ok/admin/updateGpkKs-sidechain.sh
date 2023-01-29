index=1
index1=0
gpk=$(cat ../conf/groupConf2/gpk)

echo ${#gpk}
echo ${gpk:4}

if [ ${#gpk} -gt 130 ]; then
    gpk="0x"${gpk:4}
fi

for nodeKey  in $(cat ../conf/cfg/nodeList)
do 
  echo ${index} ${nodeKey}

  	if [ ${index} -lt 10 ];then
		cp ../conf/groupConf2/gpkKs/${gpk}'_0'${index1} ../nodes/'n0'${index}/ks/${gpk}
	else
  	    if [ ${index} -eq 10 ];then
		    cp ../conf/groupConf2/gpkKs/${gpk}'_0'${index1} ../nodes/'n'${index}/ks/${gpk}
        else
		    cp ../conf/groupConf2/gpkKs/${gpk}'_'${index1} ../nodes/'n'${index}/ks/${gpk}
        fi
	fi
  ((index++))
  ((index1++))
done

echo "done"

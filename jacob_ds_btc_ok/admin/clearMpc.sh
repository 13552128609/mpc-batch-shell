#!/bin/bash
echo $1
echo $2
for((index=$1;index<=$2;index++))
do
    if [ ${index} -lt 10 ];then
        nodeName='n0'${index}
    else
        nodeName='n'${index}

    fi
    echo $nodeName
    ps -ef | grep schnorrmpc | grep -v grep | grep -v attach | grep $nodeName |awk '{print $2}'| xargs kill -9

done

#!/bin/bash
for((index=$1;index<=$2;index++))
do
    if [ ${index} -lt 10 ];then
        nodeName='n0'${index}
    else
        nodeName='n'${index}

    fi
    ps -ef | grep schnorrmpc | grep -v grep | grep -v attach | grep $nodeName |awk '{print $2}'| xargs kill -9
done

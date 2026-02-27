#!/bin/bash
DIR=$(cd "$(dirname "$0")" && pwd)
# 这样无论你在哪执行，路径永远指向 test.sh 所在目录的上一层
. "$DIR/../const.sh"
echo $BKSHELL_PATH

for (( i = 0; i<$1; ++i)); do
    echo "storeman.signByApprove({pk:'0x5e3d7446ae8be69ac15941f82243a776b87868f52e6e99bd8050fbe3f5a4b48f07df1e4149f5ccdadf32334efdee740e449f585c1817ace1034890c467dc6d80',curve:'0x00',alg:'0x02',hashData:['0x5c37529010e2f7a9ec225e516e6b79478f117cdf45d1796cd034d48b901d8d41'],rawData:['0x5c37529010e2f7a9ec225e516e6b79478f117cdf45d1796cd034d48b901d8d41'],extern:'jacob'})" | $BKSHELL_PATH 1  &
done

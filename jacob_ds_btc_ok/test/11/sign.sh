#!/bin/bash

DIR=$(cd "$(dirname "$0")" && pwd)
# 这样无论你在哪执行，路径永远指向 test.sh 所在目录的上一层
. "$DIR/../const.sh"
echo $BKSHELL_PATH
for (( i = 0; i<$1; ++i)); do
    echo "storeman.signByApprove({pk:'0x0293b298cc0f913f47dcb1a4e505f3baf1c859d62306f81e18d4ecd07a1e25862e7fb440fd6d54daab96a32cd2e9d2c8d7c7428e926633a5195ddfa79b0173ab',curve:'0x01',alg:'0x01',hashData:['0x5c37529010e2f7a9ec225e516e6b79478f117cdf45d1796cd034d48b901d8d41'],rawData:['0x5c37529010e2f7a9ec225e516e6b79478f117cdf45d1796cd034d48b901d8d41'],extern:'jacob'})" | $BKSHELL_PATH 1  &
done

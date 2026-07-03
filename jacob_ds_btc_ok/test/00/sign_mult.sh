#!/bin/bash

DIR=$(cd "$(dirname "$0")" && pwd)
# 这样无论你在哪执行，路径永远指向 test.sh 所在目录的上一层
. "$DIR/../const.sh"
echo $BKSHELL_PATH

for (( i = 0; i<$1; ++i)); do
    echo "storeman.signByApprove({pk:'0x5b983948cc5ac7e7c86f8befb4a4ac551dede33d3026ebc7558d45264a21b583ff3ff0797071dda8dfea85288a8f53a6040819b992684cc2a6a7422803d2db07',curve:'0x00',alg:'0x00',hashData:['0x5c37529010e2f7a9ec225e516e6b79478f117cdf45d1796cd034d48b901d8d41','0x5c37529010e2f7a9ec225e516e6b79478f117cdf45d1796cd034d48b901d8d42'],rawData:['0x5c37529010e2f7a9ec225e516e6b79478f117cdf45d1796cd034d48b901d8d41','0x5c37529010e2f7a9ec225e516e6b79478f117cdf45d1796cd034d48b901d8d42'],extern:'jacob'})" | $BKSHELL_PATH 1  &
done

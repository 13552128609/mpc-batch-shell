#!/bin/bash

for (( i = 0; i<$1; ++i)); do
    echo "storeman.signByApprove({pk:'0x2e9ad92f5f541b6c2ddb672a70577c252aaa8b9b8dfdff9a5381912395985d12dc18f19ecb673a3b675697ae97913fcb69598c089f6d66ae7a3f6dc179e4da56',curve:'0x00',alg:'0x02',hashData:['0x5c37529010e2f7a9ec225e516e6b79478f117cdf45d1796cd034d48b901d8d41','0x5d822a3b0c7e531cef44e1c8027d29c8443bc822fa7fc22f9e4ddef3c69356eb'],rawData:['0x5c37529010e2f7a9ec225e516e6b79478f117cdf45d1796cd034d48b901d8d41','0x5d822a3b0c7e531cef44e1c8027d29c8443bc822fa7fc22f9e4ddef3c69356eb'],extern:'jacob'})" | ./bk.sh 1  &
done

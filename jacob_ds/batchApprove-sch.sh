#!/bin/bash

for (( i = 1; i<22; ++i)); do
#for (( i = 1; i<2; ++i)); do
    echo "storeman.approve([{pk:'0x187e19758482e42e2db023593ed76acc5bf3b6edd776fc63b2c129d7d00dbd5d087e4eb7b14473f2458fdc3846f8ac8a960240d8cf20e0afe6163c7ec41bd495',curve:'0x01',alg:'0x00',hashData:['0x5c37529010e2f7a9ec225e516e6b79478f117cdf45d1796cd034d48b901d8d41','0x5d822a3b0c7e531cef44e1c8027d29c8443bc822fa7fc22f9e4ddef3c69356eb'],rawData:['0x5c37529010e2f7a9ec225e516e6b79478f117cdf45d1796cd034d48b901d8d41','0x5d822a3b0c7e531cef44e1c8027d29c8443bc822fa7fc22f9e4ddef3c69356eb'],extern:'jacob'}])" | ./bk.sh  ${i} & 
done

#!/bin/bash

for (( i = 1; i<22; ++i)); do
#for (( i = 1; i<2; ++i)); do
    echo "storeman.approveData([{pk:'0x187e19758482e42e2db023593ed76acc5bf3b6edd776fc63b2c129d7d00dbd5d087e4eb7b14473f2458fdc3846f8ac8a960240d8cf20e0afe6163c7ec41bd495',data:'0x5678',curve:'0x01'}])" | ./bk.sh  ${i} & 
done
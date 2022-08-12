#!/bin/bash

for (( i = 1; i<22; ++i)); do
#for (( i = 1; i<2; ++i)); do
    echo 'storeman.addValidMpcXrpTx({txData:"0x1234",TxHash:"0xdd4c3c532b265089aa1bca21b572faa4bf42b952581619f90af9cda4669432bf",PKBytes:"0x2e9ad92f5f541b6c2ddb672a70577c252aaa8b9b8dfdff9a5381912395985d12dc18f19ecb673a3b675697ae97913fcb69598c089f6d66ae7a3f6dc179e4da56",ChainType:"XRP"})' | ./bk.sh  ${i} & 
done

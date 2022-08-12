#!/bin/bash
for (( i = 1; i<22; ++i)); do
    echo 'storeman.approveMpcBtcTran([{Version:1,TxIn:[{PreviousOutPoint:{Hash:"b536ad7724251502d75380d774ecb5c015fd8a191dd6ceb05abf677e281b81e1",Index:789},SignatureScript:"ss",Sequence:234,PkScript:"ps"}],TxOut:[{Value:0x1234,PkScript:"pkScript"}],LockTime:1234,From:"0x2e9ad92f5f541b6c2ddb672a70577c252aaa8b9b8dfdff9a5381912395985d12dc18f19ecb673a3b675697ae97913fcb69598c089f6d66ae7a3f6dc179e4da56"}])' | ./bk_rpc.sh  ${i} & 
done

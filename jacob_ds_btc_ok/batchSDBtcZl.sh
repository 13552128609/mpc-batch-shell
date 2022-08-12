#!/bin/bash
# reverse order
#for (( i = 0; i<$1; ++i)); do
#    echo 'storeman.signMpcBtcTransaction({"Version":1,"LockTime":0,"From":"0x2e9ad92f5f541b6c2ddb672a70577c252aaa8b9b8dfdff9a5381912395985d12dc18f19ecb673a3b675697ae97913fcb69598c089f6d66ae7a3f6dc179e4da56","TxOut":[{"Value":100000,"PkScript":"76a914af49d8bb3ba52aff1b64346f24dff6d47653c01188ac"},{"Value":94000,"PkScript":"76a9146ae1372d767dba6e0b0350b4ed28045273eebfc988ac"}],"TxIn":[{"PreviousOutPoint":{"Hash":"860b7ca45ab41d639eb366936f732fa2fae0a52619eb69f2f89cdb870b64da22","Index":0},"SignatureScript":"76a9146ae1372d767dba6e0b0350b4ed28045273eebfc988ac","Sequence":4294967295,"PkScript":""}]})' | ./bk.sh 1  & 
#done

# normal order
for (( i = 0; i<$1; ++i)); do
    echo 'storeman.signMpcBtcTransaction({"Version":1,"LockTime":0,"From":"0x2e9ad92f5f541b6c2ddb672a70577c252aaa8b9b8dfdff9a5381912395985d12dc18f19ecb673a3b675697ae97913fcb69598c089f6d66ae7a3f6dc179e4da56","TxOut":[{"Value":100000,"PkScript":"76a914ccac3661ef285fc1b579ade1114fb0341ff6b39888ac"},{"Value":94000,"PkScript":"76a9142436df0553c3f94395bd4bb1954d69067985c45088ac"}],"TxIn":[{"PreviousOutPoint":{"Hash":"22da640b87db9cf8f269eb1926a5e0faa22f736f9366b39e631db45aa47c0b86","Index":0},"SignatureScript":"76a9142436df0553c3f94395bd4bb1954d69067985c45088ac","Sequence":4294967295,"PkScript":""}]})' | ./bk.sh 1  & 
done

#!/bin/bash

for (( i = 1; i<26; ++i)); do
#for (( i = 1; i<2; ++i)); do
    echo 'storeman.addValidMpcBtcTx({"Version":1,"LockTime":0,"From":"0xb332e3519e3fa5acff123c9faf94054c3929a32be331698d680e43e8a38aeb0527a6ddcc8f1b635a52870ad73fcc89ac87abab5ffcdb3bdef021a376adbb03d6","TxOut":[{"Value":155000,"PkScript":"0x76a914af49d8bb3ba52aff1b64346f24dff6d47653c01188ac"}],"TxIn":[{"PreviousOutPoint":{"Hash":"28a6a9ae6391f81ff9e7e529818442a4f139fcb5b6f2d0e0a3baee2770308c21","Index":0},"SignatureScript":"0x76a9146ae1372d767dba6e0b0350b4ed28045273eebfc988ac","Sequence":4294967295,"PkScript":""}]})' | ./bk.sh  ${i} & 
done

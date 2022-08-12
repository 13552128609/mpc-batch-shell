#!/bin/bash

for (( i = 1; i<26; ++i)); do
#for (( i = 1; i<2; ++i)); do
    echo 'storeman.addValidMpcBtcTx({"Version":1,"LockTime":0,"From":"0xb332e3519e3fa5acff123c9faf94054c3929a32be331698d680e43e8a38aeb0527a6ddcc8f1b635a52870ad73fcc89ac87abab5ffcdb3bdef021a376adbb03d6","TxIn":[{"PreviousOutPoint":{"Hash":"15871a8c0743237796b7472ba1f5eb24bcf67ffa357ca8b16b998d50e6d445f1","Index":0},"SignatureScript":"0x20667176726361a0496de325f84dd0aa7cbb632f258da88b4d616d6cbe27bd43567576a9146ae1372d767dba6e0b0350b4ed28045273eebfc988ac","Sequence":4294967295,"PkScript":""},{"PreviousOutPoint":{"Hash":"15871a8c0743237796b7472ba1f5eb24bcf67ffa357ca8b16b998d50e6d445f1","Index":1},"SignatureScript":"0x76a9146ae1372d767dba6e0b0350b4ed28045273eebfc988ac","Sequence":4294967295,"PkScript":""}],"TxOut":[{"PkScript":"0x76a914af49d8bb3ba52aff1b64346f24dff6d47653c01188ac","Value":2800000}]})' | ./bk.sh  ${i} & 
done

#!/bin/bash

for (( i = 0; i<$1; ++i)); do
    echo 'storeman.signMpcBtcTransaction({"Version":1,"LockTime":0,"From":"0xb332e3519e3fa5acff123c9faf94054c3929a32be331698d680e43e8a38aeb0527a6ddcc8f1b635a52870ad73fcc89ac87abab5ffcdb3bdef021a376adbb03d6","TxIn":[{"PreviousOutPoint":{"Hash":"d0dba0b6fff69beae696ffa841ac6f3e4332a644c95840e27e579e875bc078e7","Index":0},"SignatureScript":"0x76a9146ae1372d767dba6e0b0350b4ed28045273eebfc988ac","Sequence":4294967295,"PkScript":""},{"PreviousOutPoint":{"Hash":"d0dba0b6fff69beae696ffa841ac6f3e4332a644c95840e27e579e875bc078e7","Index":1},"SignatureScript":"0x20667176726361a0496de325f84dd0aa7cbb632f258da88b4d616d6cbe27bd43567576a914b472a266d0bd89c13706a4132ccfb16f7c3b9fcb88ac","Sequence":4294967295,"PkScript":""}],"TxOut":[{"PkScript":"0x76a914af49d8bb3ba52aff1b64346f24dff6d47653c01188ac","Value":145000}]})' | ./bk.sh 1  & 
done

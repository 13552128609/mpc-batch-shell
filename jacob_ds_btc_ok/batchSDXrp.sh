#!/bin/bash

for (( i = 0; i<$1; ++i)); do
    echo 'storeman.signMpcXrpTransaction({txData:'{"TransactionType":"Payment","Account":"rpnDG6Xw7vH2CzpBqR2gCbqiHU3g5BAthy","Destination":"r9SrZQddT4fDUQXWexsHLjtbvy44d9rt5v","Amount":"15000","Flags":2147483648,"Memos":[{"Memo":{"MemoData":"323136307866314366323035343432624541303265353145324336384646346363363938653538373936363343","MemoType":"43726F7373436861696E496E666F","MemoFormat":"746578742F706C61696E"}}],"LastLedgerSequence":14769845,"Fee":"12","Sequence":14450060,"SigningPubKey":"029E03BE7E1AC63CCCE6BD921D412216FE9E7C371A50B540009217103A8A5C8DDF"}',TxHash:'0xdd4c3c532b265089aa1bca21b572faa4bf42b952581619f90af9cda4669432bf',PKBytes:'0x2e9ad92f5f541b6c2ddb672a70577c252aaa8b9b8dfdff9a5381912395985d12dc18f19ecb673a3b675697ae97913fcb69598c089f6d66ae7a3f6dc179e4da56',ChainType:'XRP'})' | ./bk.sh 1  & 
done

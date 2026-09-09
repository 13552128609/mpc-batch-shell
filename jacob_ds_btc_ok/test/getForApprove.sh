#!/bin/bash

DIR=$(cd "$(dirname "$0")" && pwd)
# 这样无论你在哪执行，路径永远指向 test.sh 所在目录的上一层
. "$DIR/const.sh"
echo $BKSHELL_PATH
for((;;));do

	for (( i = 1; i<26; ++i)); do
	echo "storeman.getForApprove(86400)" | $BKSHELL_PATH ${i}  &
	done
	sleep 2
done

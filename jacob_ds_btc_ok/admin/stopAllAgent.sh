ps -ef | grep node |grep -v grep | grep index.js | awk '{print $2}' | xargs kill -9

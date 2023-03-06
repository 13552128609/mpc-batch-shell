ps -ef | grep mongod | grep -v grep | awk '{print $2}' | xargs sudo kill -2

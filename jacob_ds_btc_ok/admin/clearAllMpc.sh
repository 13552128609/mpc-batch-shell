
ps -ef | grep schnorrmpc | grep -v grep | grep -v attach |awk '{print $2}'| xargs kill -9 

find ../nodes -type d -name "schnorrmpc" | xargs rm -rf

find ../nodes -type d -name "storeman" | xargs rm -rf

# awk '{print $2}' | xargs kill -9



ps -ef | grep schnorrmpc | grep -v grep | grep -v attach |awk '{print $2}'| xargs kill -9 

#find ~/jacob -type d -name "schnorrmpc" | xargs rm -rf 

#find ~/jacob -type d -name "storeman" | xargs rm -rf 

# awk '{print $2}' | xargs kill -9


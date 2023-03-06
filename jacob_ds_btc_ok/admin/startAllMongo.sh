# /var/lib/mongodb

for i in {1,2,3,4,5,6,7,8}; do	
#  echo "docker run -itd --name mongo${i} --log-driver local -p 27${i}17:27017 -v /var/lib/mongodb${i}:/var/lib/mongodb  mongo"
#  docker run -itd --name mongo${i} -p 27${i}17:27017 -v /var/lib/mongodb${i}:/var/lib/mongodb mongo
 mkdir -p /data/db/mongodb${i}
 nohup mongod --port 27${i}17 --bind_ip 127.0.0.1 --dbpath /data/db/mongodb${i}  >/tmp/mongodb${i} 2>&1 &
done

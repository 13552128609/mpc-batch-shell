# /var/lib/mongodb

for i in {1,2,3,4,5,6,7,8}; do	
#  echo "docker run -itd --name mongo${i} --log-driver local -p 27${i}17:27017 -v /var/lib/mongodb${i}:/var/lib/mongodb  mongo"
#  docker run -itd --name mongo${i} -p 27${i}17:27017 -v /var/lib/mongodb${i}:/var/lib/mongodb mongo
 rm -rf  /data/db/mongodb${i}
 mkdir -p /data/db/mongodb${i}
done

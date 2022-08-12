echo $1
port1=37101
port=`expr ${port1} + $1`
echo $port
/home/jacob/wanchain/src/github.com/wanchain/go-mpc/build/bin/schnorrmpc attach  http://44.233.241.210:${port}

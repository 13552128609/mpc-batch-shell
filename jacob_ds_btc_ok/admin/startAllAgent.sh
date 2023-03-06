# /var/lib/mongodb

waddress=(
'0xd6697b9c959b247a0b74f2e669431483856fa170'
'0xf7b62db74468b674e6bf6bcdcf9bae3d576629d3'
'0xa0eb4aae4ef481623dc70fada8c93a87a8d6642a'
'0x30ddab2b2e8ddaf5adbdfc237151ab38de71ef2d'
'0x063a9fddc5acaa0312cff3cbfaa31c130ac719cc'
'0x86730197a10d16674eb4bfd572cfe57dba13f05d'
'0x68e888738137796954161e62d8eb3c3fb326225b'
'0x8fab9e9442783a0d821194e92b24562dd74fed1f'
'0xc4917d7e3fa0a7eea29ab2b8678698d1364de696'
'0x3b4affc40f7b04d1469cca4ba88e6907f51776c6'
'0x2f30827fb47d520338eb9ac02bbe3d0c0899ca17'
)

cd /home/jacob/wanchain/storeman-agent-js

cfg=/home/jacob/mpc-batch-shell/jacob_ds_btc_ok/

for i in {1,2,3,4,5,6,7,8}; do	
#for i in {1,8}; do	
  # leader=
  # if [ $i = 1 ]; then
  #   leader=--leader
  # fi

  # echo ${leader}
  # echo ${waddress[${i} - 1]}
  
  # nohup node ./index.js --testnet --waddress=${waddress[${i} - 1]} --password=${cfg}/conf/cfg/pwd.json --keystore=${cfg}/nodes/n0${i}/ks --dbip=127.0.0.1 --dbport=27${i}17 --mpcpath=${cfg}/nodes/n0${i}/data >  /tmp/agent${i} 2>&1 &

  nohup node ./index.js \
  --testnet \
  --waddress=${waddress[${i} - 1]} \
  --password=${cfg}/conf/cfg/pwd.json \
  --keystore=${cfg}/nodes/n0${i}/ks \
  --dbip=127.0.0.1 \
  --dbport=27${i}17 \
  --mpcipc=${cfg}/nodes/n0${i}/data/mpc.ipc \
  --chainCount=1 \
  --chain1=WAN \
  --url1=http://139.198.104.233:18545 \
  --mpcpath=${cfg}/nodes/n0${i}/data \
  >  /tmp/agent${i} 2>&1 &
done

# /var/lib/mongodb

waddress=(
    '0xacd98dd88471d826e9f7a86e917dd8d912d25f94'
    '0xe070132a9017b256de8513b48d472a99629f5a25'
    '0x9009b741ca9ae4691166f6f0b5cf47d3162e9430'
    '0xcfb935ff32d0c78ae23ca17fdeeb746f07e52a69'
    '0xc9e605d58ab45124e029d8c61be4ef7115479fd3'
    '0x10f3120770112533468db0c39722f6c18776b0c8'
    '0x44ba9c00e11ce7f1c0b5ef44d105051d12a973a5'
    '0x26013bcd0f3896caacadae834e3a6850e753e451'
)

cd /home/jsw/code/wanchain/js-storeman-agent

cfg=/home/jsw/13552128609/mpc-batch-shell/jacob_ds_btc_ok

for i in {1,2,3,4,5,6,7,8}; do	
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
  --mpc \
  --mpcipc=${cfg}/nodes/n0${i}/data/mpc.ipc \
  --mpcpath=${cfg}/nodes/n0${i}/data \
  >  /tmp/agent${i} 2>&1 &
done


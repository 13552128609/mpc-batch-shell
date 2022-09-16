#nohup ~/jacob/schnorrmpc --verbosity 5 --port 30000 --storeman --datadir ./boot/data --keystore ~/jacob/boot/ks --password ~/jacob/cfg/pwd.json --ipcpath ./boot/data/mpc.ipc --maxpeers 500 --nodekey ./boot/data/nodekey --threshold 17 --totalnodes 21 --bootnodes enode://227ea0bbf86764014a1bc0d123ee18edc6e79b5e602f2f4706a985369bbfc7cfd91f2a14f1c71aad137c814abf6659342213fb7c4af1eb114dea37d51d6e0fbf@127.0.0.1:30000 > /tmp/boot.log 2>&1 &
nohup ../bin/schnorrmpc --verbosity 3 --port 30000 --storeman --datadir ../nodes/boot/data --keystore ../nodes/boot/ks --password ../conf/cfg/pwd.json --ipcpath ../nodes/boot/data/mpc.ipc --maxpeers 500 --nodekey ../nodes/boot/data/nodekey --threshold 17 --totalnodes 21 --bootnodes enode://227ea0bbf86764014a1bc0d123ee18edc6e79b5e602f2f4706a985369bbfc7cfd91f2a14f1c71aad137c814abf6659342213fb7c4af1eb114dea37d51d6e0fbf@127.0.0.1:30000 > /tmp/boot.log 2>&1 &

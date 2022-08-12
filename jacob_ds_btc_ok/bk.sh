echo $1

if [ $1 -lt 10 ];then
	ipcPath=./'n0'$1/data/mpc.ipc
else
	ipcPath=./'n'$1/data/mpc.ipc
fi
echo "ipcPath:"$ipcPath
#	echo "admin.peers.length" | ~/jacob/schnorrmpc attach $ipcPath 
./schnorrmpc attach $ipcPath 

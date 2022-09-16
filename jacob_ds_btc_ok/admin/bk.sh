echo $1

if [ $1 -lt 10 ];then
	ipcPath=../nodes/'n0'$1/data/mpc.ipc
else
	ipcPath=../nodes/'n'$1/data/mpc.ipc
fi
echo "ipcPath:"$ipcPath
#	echo "admin.peers.length" | ~/jacob/schnorrmpc attach $ipcPath 
../bin/schnorrmpc attach $ipcPath 

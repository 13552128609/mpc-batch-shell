#!/bin/bash
echo $1
#!/bin/bash
# 1. 获取脚本文件所在的绝对路径
# $0 是当前脚本的文件名
# dirname 获取目录部分
# cd 进去后再 pwd 确保拿到的是不受执行位置影响的绝对路径
SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)

# 2. 将当前目录压入栈，并进入脚本所在目录
# pushd 会记录你当前的位置，并切换到新目录
pushd "$SCRIPT_DIR" > /dev/null


# --- 在这里编写你的业务逻辑 ---
if [ $1 -lt 10 ];then
	ipcPath=../nodes/'n0'$1/data/mpc.ipc
else
	ipcPath=../nodes/'n'$1/data/mpc.ipc
fi
echo "ipcPath:"$ipcPath
#	echo "admin.peers.length" | ~/jacob/schnorrmpc attach $ipcPath 
../bin/schnorrmpc attach $ipcPath 
# ---------------------------

# 3. 任务结束后，弹出栈顶目录，自动回到初始执行目录
pushd_back=$(popd > /dev/null)



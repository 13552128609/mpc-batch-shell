# ubuntu
#FROM ubuntu:20.04
FROM ubuntu:18.04
MAINTAINER Jacob
WORKDIR /root
EXPOSE 1000
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y vim
RUN apt-get install -y net-tools

ENTRYPOINT ["/mpc-bin/schnorrmpc","--storeman","--datadir", "/mpc-nodes/data", "--keystore","/mpc-nodes/ks", "--password","/mpc-cfg/pwd.json","--ipcpath","/mpc-nodes/data/mpc.ipc","--maxpeers","500","--nodekey","/mpc-nodes/data/nodekey","--threshold","17","--totalnodes","21","--bootnodes","enode://227ea0bbf86764014a1bc0d123ee18edc6e79b5e602f2f4706a985369bbfc7cfd91f2a14f1c71aad137c814abf6659342213fb7c4af1eb114dea37d51d6e0fbf@35.89.118.52:30000"]

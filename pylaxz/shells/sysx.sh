#! /bin/env bash
flag=$1
case "$flag" in
--sys-upgrade)
sudo apt update && sudo apt upgrade -y
;;

--sys-setup)
    cat <<EOF
    setting up enviroment, this will take some time ...
EOF
sudo apt update && sudo apt upgrade -y && \
sudo apt install xsel imwheel gvfs-fuse exfat-fuse cifs-utils \
net-tools build-essential cmake unzip zip pixz pkg-config \
kazam git vlc vscode gcc g++ python3 python3-dev python3-pip \
vim nano curl wget tar
;;

--port-service)
read -p "which port [ALL] : " uservar
if [ $uservar != "" ] ; then
    sudo lsof -i:$uservar
else
    sudo lsof -i -P -n | grep LISTEN
fi
;;

--scan-host)
read -p "IPADDRESS : [localhost]" uservar
    sudo nmap -sTU -O $uservar
;;

--is-installed)
read -p "which package [ list ALL] " uservar
if [ $uservar != "" ] ; then
    apt list --installed | grep -i $uservar;
else
    sudo dpkg-query -Wf '${Installed-size}\t${Package}\n' | column -t
fi

;;

esac
#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
CMD='\e[32m'
NL='echo '

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

--opencv-pi)
cat << EOF
sudo apt-get install python3-venv
python3 -m venv env
source env/bin /activate
pip install pip --upgrade
pip install opencv-python numpy opencv-contrib-python
sudo apt-get install libatlas-base-dev libhdf5-dev libhdf5-serial-dev libatlas-base-dev libjasper-dev libqtgui4  libqt4-test
EOF
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
read -p "IPADDRESS : [localhost] " uservar
    nmap -sTU -O $uservar
;;

--scan-ssh)
# port ? ip ?
    nmap -sV -p 22 192.168.0.1/24
;;

--fing)
    nmap 192.168.0.1/24
;;

--is-installed)
read -p "which package [ list ALL] " uservar
if [ $uservar != "" ] ; then
    apt list --installed | grep -i $uservar;
else
    sudo dpkg-query -Wf '${Installed-size}\t${Package}\n' | column -t
fi
;;

--has-internet)
    echo -e "Checking internet connection ..." ;
    wget -q -T 1 --spider http://example.com ;
    if [ $? -eq 0 ] ; then echo "Internet connection is Good." ;
    else echo -e "No Internet Connection!" ;
    fi
;;

esac
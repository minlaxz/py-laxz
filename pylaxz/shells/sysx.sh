#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'

function has_sudo() {
    dpkg-query -l sudo >/dev/null 2>&1
    return $?
}

case "$1" in
--apt-upgrade)
    has_sudo
    if [[ $? == 0 ]]; then
        echo -e "${OUTUPT}"
        sudo apt update && sudo apt upgrade -y
        echo -e "${RESET}${NL}"
    else
        echo -e "${ERROR}'sudo' is needed.${RESET}${NL}"
    fi
    ;;

--sys-setup)
    echo -e "${HEAD}Setting up the Enviroment,${RESET} ${NL}${OUTUPT}this will take some time ..."
    sudo apt update && sudo apt upgrade -y && sudo apt install xsel imwheel gvfs-fuse exfat-fuse cifs-utils net-tools build-essential cmake unzip zip pixz pkg-config kazam git vlc vscode gcc g++ python3 python3-dev python3-pip vim nano curl wget tar
    echo -e "${NL}DONE !${RESET}${NL}"
    ;;

--which-bin)
    read -p "Which command [NONE] : " uservar
    dpkg -S $uservar
    ;;

--opencv-pi)
    echo -e "${OUTPUT}
sudo apt-get install python3-venv
python3 -m venv env
source env/bin /activate
pip install pip --upgrade
pip install opencv-python numpy opencv-contrib-python
sudo apt-get install libatlas-base-dev libhdf5-dev libhdf5-serial-dev libatlas-base-dev libjasper-dev libqtgui4  libqt4-test
"
    ;;

esac

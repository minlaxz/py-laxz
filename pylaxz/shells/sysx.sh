#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'
WARN='\e[3;33m'

function changeRoot() {
    cd $(dirname "$0")
    cd ..
}

function refMd() {
    ref=$1
    changeRoot
    python3 -B -c "from utils.logxs import printf; printf(${ref}, _int=1, _md=1)"
}

function refMdSelf() {
    ref="'No Reference : _by myself_'"
    changeRoot
    python3 -B -c "from utils.logxs import printf; printf(${ref}, _int=1, _md=1)"
}

function oneLineOutput() {
    line=$1
    echo -e "${OUTPUT}$line${RESET}"
}

function descriptionOutput() {
    line=$1
    echo -e "${WARN}Description : $line ${RESET}"
}

function warningOutput() {
    line=$1
    echo -e "${ERROR}Warning : $line ${RESET}"
}

function doesHasSudo() {
    dpkg-query -l sudo >/dev/null 2>&1
    return $?
}

case "$1" in
--sys-upgrade)
    oneLineOutput "Upgrading the system."
    doesHasSudo
    if [[ $? == 0 ]]; then
        echo -e "${OUTPUT}"
        sudo apt update && sudo apt upgrade -y
        echo -e "${RESET}${NL}"
    else
        warningOutput "[Error] 'sudo' is needed."
    fi
    ;;

--sys-setup)
    oneLineOutput "Setting up the Enviroment."
    descriptionOutput "this will take some minutes ..."
    if ((${EUID:-0} || "$(id -u)")); then
        # Not Root
        doesHasSudo
        if [[ $? == 0 ]]; then
                sudo apt-get update && sudo apt-get upgrade && sudo apt-get install xsel imwheel gvfs-fuse exfat-fuse cifs-utils net-tools \
                build-essential cmake unzip zip pixz pkg-config git gcc \
                g++ python3-dev vim curl wget tar apt-transport-https \
                ca-certificates curl gnupg-agent software-properties-common
        else
            warningOutput "[Error] 'sudo' is needed."
        fi
    else
        apt-get update && apt-get upgrade -y && apt-get install xsel imwheel \
            gvfs-fuse exfat-fuse cifs-utils net-tools \
            build-essential cmake unzip zip pixz pkg-config \
            git gcc g++ python3-dev vim curl wget tar
    fi
    descriptionOutput "Executed."
    cat<<EOF
            xsel imwheel
            gvfs-fuse exfat-fuse cifs-utils net-tools 
            build-essential cmake unzip zip pixz pkg-config 
            git gcc g++ python3-dev vim curl wget tar
EOF
    ;;

--sys-which-bin)
    read -p "Which command: " uservar
    dpkg -S $uservar
    ;;

    # --opencv-pi)
    #     echo -e "${OUTPUT}
    # sudo apt-get install python3-venv
    # python3 -m venv env
    # source env/bin /activate
    # pip install pip --upgrade
    # pip install opencv-python numpy opencv-contrib-python
    # sudo apt-get install libatlas-base-dev libhdf5-dev libhdf5-serial-dev libatlas-base-dev libjasper-dev libqtgui4  libqt4-test
    # "
    #     ;;

esac

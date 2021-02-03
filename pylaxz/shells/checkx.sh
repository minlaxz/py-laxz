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

function has_wget() {
    dpkg-query -l wget >/dev/null 2>&1
    return $?
}

function has_nmap() {
    dpkg-query -l nmap >/dev/null 2>&1
    return $?
}

case "$1" in
--has-internet)
    has_wget
    if [[ $? == 0 ]]; then
        echo -e "${HEAD}Checking internet connection ...${RESET}"
        wget -q -T 1 --spider http://example.com
        if [ $? -eq 0 ]; then
            echo -e "${OUTPUT}Internet connection is Good.${RESET}${NL}"
        else
            echo -e "${OUTPUT}No Internet Connection!${RESET}${NL}"
        fi
    else
        echo -e "${ERROR}'wget' is needed.${RESET}${NL}"
    fi

    ;;
--port-service)
    has_sudo
    if [[ $? == 0 ]]; then
        read -p "which port [ALL] : " uservar
        if [ $uservar != "" ]; then
            sudo lsof -i:$uservar
        else
            sudo lsof -i -P -n | grep -i "LISTEN"
        fi
    else
        echo -e "${ERROR}'sudo' is needed.${RESET}${NL}"
    fi
    ;;

--nmap-scan)
    has_nmap
    if [[ $? == 0 ]]; then
        read -p "Enter 's GATEWAY IPADDRESS: " gateway
        read -p "1.SPECIFIC HOST : 2.SPECIFIC PORT : 3.NETWORK > " uservar
        case "$uservar" in
        1)
            has_sudo
            if [[ $? == 0 ]]; then
                read -p "Enter SPECIFIC HOST's IPADDRESS: " uservar
                sudo nmap -sTU -O $uservar
            else
                echo -e "${ERROR}'sudo' is needed.${RESET}${NL}"
            fi
            ;;
        2)
            read -p "Enter SPECIFIC PORT: " uservar
            nmap -sV -p ${uservar} ${gateway}/24
            ;;
        3)
            nmap ${gateway}/24
            ;;
        *) echo -e "Not an option." ;;
        esac
    else
        echo "'nmap' is needed."
    fi
    ;;

--is-installed)
    read -p "which package [ list ALL] " uservar
    if [ $uservar != "" ]; then
        apt list --installed | grep -i $uservar
    else
        has_sudo
        if [[ $? == 0 ]]; then
            sudo dpkg-query -Wf '${Installed-size}\t${Package}\n' | column -t
        else
            echo "'sudo' is needed."
        fi
    fi
    ;;

*) ;;

esac

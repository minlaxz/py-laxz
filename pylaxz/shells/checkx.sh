#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'
WARN='\e[3;33m'

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

function has_internet() {
    wget -q -T 5 --spider http://example.com
    return $?
}

function error_no_wget() {
    echo -e "${ERROR}'wget' is needed.${RESET}${NL}"
}

function error_no_sudo() {
    echo -e "${ERROR}'sudo' is needed.${RESET}${NL}"
}

function error_no_nmap() {
    echo -e "${ERROR}'nmap' is needed.${RESET}${NL}"
}

function error_no_internet() {
    echo -e "${ERROR}'Internet Connection' is needed.${RESET}"
}

case "$1" in
--has-internet)
    has_wget
    if [[ $? == 0 ]]; then
        echo -e "${HEAD}Checking internet connection ...${RESET}"
        has_internet
        if [ $? -eq 0 ]; then
            echo -e "${OUTPUT}Internet connection is Good.${RESET}${NL}"
        else
            error_no_internet
        fi
    else
        error_no_wget
    fi

    ;;
--port-service)
    has_sudo
    if [[ $? == 0 ]]; then
        read -p "which port [ALL] : " port
        if [ $port != "" ]; then
            sudo lsof -i:$port
        else
            sudo lsof -i -P -n | grep -i "LISTEN"
        fi
    else
        error_no_sudo
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
                error_no_sudo
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
        error_no_nmap
    fi
    ;;

--all-info)
    echo -e "${OUTPUT}"
    cat /etc/*-release | uniq -u
    echo -e "${RESET}"
    ;;

--domain-ip)
    read -p "Enter Domain Name > " uservar
    has_internet
    if [[ $? -eq 0 ]]; then
        echo -e "${OUTPUT}$(dig a +short $uservar) ${RESET}"
    else
        error_no_internet
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
            error_no_sudo
        fi
    fi
    ;;

*) ;;

esac

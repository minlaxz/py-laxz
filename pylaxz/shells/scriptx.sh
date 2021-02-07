#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'
WARN='\e[3;33m'

version=0.2.10
case "$1" in
--help-long)
    printf "    --lxz-DE        this will remind me to install what i need.\n"
    printf "    --help-long     show this help message and exit\n"
    printf "    --version       show help version\n\n"

    # printf "    --expose            exposing local service or fs to the internet\n\n"

    printf "    --how-enc           Show help how to encrypt.\n"
    printf "    --how-dec           Show help how to decrypt.\n"
    printf "    --how-compress      Show help how to parallel compress.\n"
    printf "    --how-decompress    Show help how to parallel decompress.\n"
    printf "    --how-copy          Copy with Progress Bar.\n"
    printf "    --how-safe-rm       Safe remove.\n"
    printf "    --how-find-mv       Help on find and move\n\n"

    printf "    --sys-upgrade       package update and upgrade\n"
    printf "    --sys-setup         setting up linux system with essential dependencies\n"
    printf "    --is-installed      check a package or software is installed.\n\n"

    printf "    --has-internet      check internet status from bash.\n"
    printf "    --port-service      get service on specific port.\n"
    printf "    --scan-host         scan port on given host. {need nmap}\n\n"
    printf "    --issue-opencv      issues about opencv.\n\n"
;;

--help-lxz)
printf "FOR ALL ARCH:"
printf "    --lxz-DE\n"
printf "    --help\n"
printf "    --version\n\n"

printf "    --has-internet\n\n"

printf "    --how-enc\n"
printf "    --how-dec\n"
printf "    --how-compress\n"
printf "    --how-decompress\n"
printf "    --how-copy\n"
printf "    --how-safe-rm\n"
printf "    --how-find-mv\n"
printf "    --issue-opencv\n\n"

printf "FOR x86_64 ARCH\n"
printf "    --sys-upgrade\n"
printf "    --sys-setup\n\n"

printf "    --port-service\n"
printf "    --scan-host\n\n"
printf "    --is-installed\n\n"

printf "pylaxz -L --help-long TL;DR\n"
;;

--lxz-DE)
    cat <<EOF
xsel imwheel gvfs-fuse exfat-fuse cifs-utils
net-tools build-essential cmake unzip zip pixz pkg-config
kazam git vlc vscode gcc g++ python3 python3-dev python3-pip
vim nano curl wget tar 
EOF
;;

--version)
    cat <<EOF
shell script version : $version
EOF
;;

--issue-opencv)
cat << EOF
"installing required build dependencies."
    sudo apt install cmake gcc g++ git ffmpeg
"to support python3."
    sudo apt install python3-dev python3-numpy
"GTK support for GUI features, Camera support (v4l), Media Support (ffmpeg, gstreamer) etc."
    sudo apt install libavcodec-dev libavformat-dev libswscale-dev
    sudo apt install libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev
"to support gtk3"
    sudo apt install libgtk-3-dev
"optional Dependencies"
    sudo apt install libpng-dev libjpeg-dev libopenexr-dev libtiff-dev libwebp-dev
"https://github.com/pjreddie/darknet/issues/1886#issuecomment-547668240 > "
    sudo apt install libopencv-dev
EOF
;;

*)
    cat <<EOF
Nothing for $flag yet.
EOF
;;

esac

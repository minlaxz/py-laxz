#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'
WARN='\e[3;33m'

function descriptionOutput() {
    line=$1
    echo -e "${WARN}Description : $line ${RESET}"
}

function warningOutput() {
    line=$1
    echo -e "${ERROR}Warning : $line ${RESET}"
}

case "$1" in

--do-h265)
    descriptionOutput "Convert(Encode) H264 to H265."
    if [[ $(find ./ -name '*.mp4' | wc -l) == 1 ]]; then
        find ./ -name '*.mp4' -exec bash -c 'ffmpeg -i $0 -vcodec libx265 -crf 28 ${0/mp4/r.mp4}' {} \;
    else
        warningOutput "More than one video is found in current dir."
        read -p "Enter Name : " h264
        ffmpeg -i ${h264}.mp4 -vcodec libx265 -crf 28 ${h264}.r.mp4
    fi
    descriptionOutput "Done."
    ;;

esac

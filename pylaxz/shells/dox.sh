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

case "$1" in

--do-h265)
    descriptionOutput "Convert(Encode) H264 to H265."
    if [[ $(find ./ -name '*.mp4' | wc -l) == 1 ]]; then
        find ./ -name '*.mp4' -exec bash -c 'ffmpeg -i $0 -vcodec libx265 -crf 28 ${0/mp4/r.mp4}' {} \;
    else
        warningOutput "More than one video is found in current dir."
        read -p "Enter Name (without .mp4) : " h264
        ffmpeg -i ${h264}.mp4 -vcodec libx265 -crf 28 ${h264}.r.mp4
    fi
    descriptionOutput "Executed."
    refMd "'Referenced [Here](https://unix.stackexchange.com/a/38380/318519)'"
    ;;

--do-qr)
    descriptionOutput "Generate QR Code."
    read -p "Any String: " usrstr
    qr "${usrstr}"
    ;;

--do-mod-h265)
    descriptionOutput "Convert(Encode) H264 to H265. MANUAL"
    oneLineOutput "Resonable value for H265 is 24 ~ 30."
    oneLineOutput "(lower=higher bit rate <bigger size>)."
    read -p "Enter CRF value (4, 6, 8, [28], even NO.): " crf
    read -p "Enter Name (without .mp4) : " h264
    ffmpeg -i ${h264}.mp4 -vcodec libx265 -crf ${crf} ${h264}.r.mp4
    descriptionOutput "Executed."
    refMd "'Referenced [Here](https://unix.stackexchange.com/a/38380/318519)'"
    ;;

--do-ts-mp4)
    descriptionOutput "Convert(Encode) TS to MP4."
    if [[ $(find ./ -name '*.ts' | wc -l) == 1 ]]; then
        find ./ -name '*.ts' -exec bash -c 'ffmpeg -i $0 -c:v libx264 -c:a aac ${0/ts/mp4}' {} \;
    else
        warningOutput "More than one video is found in current dir."
        read -p "Enter Name (without .ts): " ts
        ffmpeg -i ${ts}.mp4 -vcodec libx265 -crf 28 ${ts}.r.mp4
    fi
    descriptionOutput "Executed."
    refMd "'Referenced [Here](https://askubuntu.com/a/716457/944917)'"
    ;;

--do-wg)
    descriptionOutput "Generate wireguard VPN."
    ./wgcf generate
    sudo wg-quick down ./cf-warp.conf && sudo wg-quick up ./cf-warp.conf
    descriptionOutput "Executed."
    ;;
esac

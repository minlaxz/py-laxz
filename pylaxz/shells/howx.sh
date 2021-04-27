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

--how-find-mv)
    descriptionOutput "FIND and MOVE."
    oneLineOutput "find . -maxdepth 2 -name '*.mp4' -exec mv {} . \;"
    refMdSelf
    ;;

--how-copy)
    descriptionOutput "COPY with Progress bar."
    oneLineOutput "rsync -ah --progress FROM_FILE TO_FILE"
    refMdSelf
    ;;

--how-compress)
    descriptionOutput "Parallel COMPRESS (needs pixz)."
    oneLineOutput "tar cvf - ./FILE | pixz -p 4 > COMPRESS.tpxz"
    refMdSelf
    ;;

--how-decompress)
    descriptionOutput "Parallel DECOMPRESS (needs pixz)."
    oneLineOutput "pixz -x -p 4 < COMPRESS.tpxz | tar xv -C path/to/dir"
    refMdSelf
    ;;

--how-enc)
    descriptionOutput "----encrypt with password----"
    oneLineOutput "openssl enc -aes-256-cbc -salt -pbkdf2 -in ORIG_FILE -out ENCTYPTED"
    oneLineOutput "echo 'TEXT' | openssl enc -e -aes-256-cbc -a -salt -pbkdf2"
    echo -e "${NL}"
    descriptionOutput "----encrypt with keyfile----"
    oneLineOutput "openssl rand 256 >symme.key"
    oneLineOutput "openssl enc -aes-256-cbc -salt -pbkdf2 -in ORIG_FILE -out ENCRYPTED -k KEYFILE"
    oneLineOutput "echo 'TEXT' | openssl enc -e -aes-256-cbc -a -salt -pbkdf2 -k KEYFILE"
    refMd "'More on my gist [RSA-Encryption](https://gist.github.com/minlaxz/71a997c38665aa2fe530a6b4ba4308ed#rsa-encryptions)'"
    ;;

--how-dec)
    descriptionOutput "----decrypt with password----"
    oneLineOutput "openssl enc -aes-256-cbc -d -salt -pbkdf2 -in ENCRYPTED -out ORIG_FILE"
    oneLineOutput "echo 'CIPHER-TEXT' | openssl enc -e -aes-256-cbc -a -d -salt -pbkdf2"
    echo -e "${NL}"
    descriptionOutput "----decrypt with keyfile----"
    oneLineOutput "openssl enc -aes-256-cbc -d -salt -pbkdf2 -in ENCRYPTED -out ORIG_FILE -k KEYFILE"
    oneLineOutput "CIPHER-TEXT' | openssl enc -e -aes-256-cbc -a -salt -pbkdf2 -d -k KEYFILE"
    refMd "'More on my gist [RSA-Decryption](https://gist.github.com/minlaxz/71a997c38665aa2fe530a6b4ba4308ed#rsa-decryptions)'"
    ;;

--how-safe-rm)
    descriptionOutput "Safe REMOVE (needs trash-cli)."
    oneLineOutput "alias rm='trash-put' >> bash-alias"
    refMd "'Referenced [Here](https://github.com/andreafrancia/trash-cli#trash-cli---command-line-interface-to-freedesktoporg-trash)'"
    ;;

--how-pypi)
    descriptionOutput "Compiling PYPI (needs twine)."
    oneLineOutput "python setup.py bdist_wheel or sdist"
    oneLineOutput "twine upload dist/* --verbose"
    refMdSelf
    EOF
    ;;

--how-forward-ssh)
    descriptionOutput "Forward SSH."
    echo -e "${WARN}"
    cat <<EOF
    These commands should be run in local machine.
    Forwarding remote port to local port
    REMOTE PORT => LOCAL PORT
EOF
    echo -e "${RESET}"

    echo -e "${OUTPUT}"
    cat <<EOF
    "ssh -L 2222:localhost:22 -C -N -l RUSER RHOST"
    RHOST localhost 22 => LHOST localhost 2222
    "ssh -L 0.0.0.0:2222:localhost:22 -C -N -l RUSER RHOST"
    RHOST localhost 22 => LHOST ipaddress 2222
    "ssh -L localhost:2222:0.0.0.0:22 -C -N -l RUSER RHOST"
    RHOST ipaddress 22 => LHOST localhost 2222
EOF
    echo -e "${RESET}"
    refMdSelf
    ;;

--how-reverse-ssh)
    descriptionOutput "Reverse SSH."
    oneLineOutput "ssh -R 2222:localhost:22 laxz@192.168.0.16 -N"
    refMdSelf
    ;;

--how-monitor-bandwidth)
    descriptionOutput "Bandwidth Monitoring."
    echo -e "${OUTPUT}"
    cat <<EOF
    # 1. Overall bandwidth - nload, bmon, slurm, bwm-ng, cbm, speedometer, netload

    # 2. Overall bandwidth (batch style output) - vnstat, ifstat, dstat, collectl

    # 2. Bandwidth per socket connection - iftop, iptraf, tcptrack, pktstat, netwatch, trafshow

    # 3. Bandwidth per process - nethogs
EOF
    echo -e "${RESET}"
    refMdSelf
    ;;

--how-nc-tx-rx)
    descriptionOutput "How to send and receive file with 'ncat'."
    echo -e "${OUTPUT}"
    cat <<EOF
    MINIMAL
        TX => nc -w 3 IPADDRESS 1234 < giving_a_file
        RX => nc -l -p 1234 > receiving_a_file

        TX => tar cf - ./FILE | nc -w 3 IPADDRESS 1234
        RX => nc -l -p 1234 | tar x

        TX => dd if=/dev/hda3 | gzip -9 | nc -l -p 1324
        RX => nc IPADDRESS 1234 | pv -b > FILE.gz

        TX => tar -zcf - ./FILE | pv | nc -l -p 1234 -q 5
        RX => ncat IPADDRESS 1234 | pv | tar -zxf -

    VPS => PRIVATE
        TX => ncat -l -p 1234 < FILE
        RX => ncat -w 3 RHOST 1234 > FILE
EOF
    echo -e "${RESET}"
    refMdSelf
    ;;

--how-src-conns)
    descriptionOutput "How many active connections are established to this specific local port."
    oneLineOutput 'ss -tun src ipaddress(optional):PORT | grep -i "estab" | wc -l'
    refMdSelf
    ;;

--how-dst-conns)
    descriptionOutput "How many active connections are established from local to specific remote ipaddress."
    oneLineOutput 'ss -tun dst IPADDRESS:port(optional) | grep -i "estab" | wc -l'
    refMdSelf
    ;;

--how-wireguard)
    descriptionOutput "How to quick setup Wireguard."
    echo -e "${OUTPUT}"
    cat <<EOF
    sudo apt install wireguard git dh-autoreconf libglib2.0-dev intltool build-essential libgtk-3-dev libnma-dev libsecret-1-dev network-manager-dev resolvconf
    git clone https://github.com/max-moser/network-manager-wireguard && cd $_
    ./autogen.sh --without-libnm-glib
    ./configure --without-libnm-glib --prefix=/usr --sysconfdir=/etc --libdir=/usr/lib/x86_64-linux-gnu --libexecdir=/usr/lib/NetworkManager --localstatedir=/var
    make && sudo make install
EOF
    echo -e "${RESET}"
    oneLineOutput "Check in Settings/Networks/VPNs"
    oneLineOutput "used wgcf, test speed 18MB/s"

    ;;

--how-pkg-github)
    descriptionOutput "Docker and Github Packages."
    oneLineOutput "cat PAT | docker login https://docker.pkg.github.com -u minlaxz --password-stdin"
    oneLineOutput "docker tag LOCAL_IMG:TAG docker.pkg.github.com/USERNAME/REPO/NAME:TAG"
    oneLineOutput "docker push docker.pkg.github.com/USERNAME/REPO/NAME:TAG"
    refMd "'Referenced [Here](https://docs.github.com/en/packages/guides/configuring-docker-for-use-with-github-packages#authenticating-with-a-personal-access-token)'"
    ;;

--how-ts-to-mp4)
    descriptionOutput "How to convert ts file to mp4."
    oneLineOutput "ffmpeg -i INPUT.ts -c:v libx264 -c:a aac OUTPUT.mp4"
    refMd "'Referenced [Here](https://askubuntu.com/a/716457/944917)'"
    ;;

--how-h264-to-h265)
    descriptionOutput "How to convert (compress/encode) h264 to h265."
    oneLineOutput "ffmpeg -i INPUT.mp4 -vcodec libx265 -crf 28 OUTPUT.mp4"
    refMd "'Referenced [Here](https://unix.stackexchange.com/a/38380/318519)'"
    ;;

--how-trim-vid)
    descriptionOutput "How to trim a video with ffmpeg."
    oneLineOutput "ffmpeg -i INPUT.mp4 -ss 00:19:00 -to 01:08:37 -c:v copy -c:a copy OUTPUT.mp4"
    refMd "'Referenced [Here](https://www.arj.no/2018/05/18/trimvideo/)'"
    ;;

esac

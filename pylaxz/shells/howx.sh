#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'
WARN='\e[3;33m'

case "$1" in

--how-find-mv)
    echo -e "${HEAD}FIND and MOVE"
    echo -e "${RESET}${OUTPUT}"
    cat <<EOF
    "find . -maxdepth 2 -name '*.mp4' -exec mv {} . \;"
EOF
    ;;

--how-copy)
    echo -e "${HEAD}COPY with Progress bar"
    echo -e "${RESET}${OUTPUT}"
    cat <<EOF
    "rsync -ah --progress FROM_FILE TO_FILE"
EOF
    ;;

--how-compress)
    echo -e "${HEAD}Parallel COMPRESS (needs pixz)"
    echo -e "${RESET}${OUTPUT}"
    cat <<EOF
    "tar cvf - ./FILE | pixz -p 4 > COMPRESS.tpxz"
EOF
    ;;

--how-decompress)
    echo -e "${HEAD}Parallel DECOMPRESS (needs pixz)"
    echo -e "${RESET}${OUTPUT}"
    cat <<EOF
    "pixz -x -p 4 < COMPRESS.tpxz | tar xv -C path/to/dir"
EOF
    ;;

--how-enc)
    echo -e "${HEAD}   ENCRYPTION   ${RESET}"
    echo -e "${WARN}----with password----${RESET}"

    echo -e "${OUTPUT}"
    cat <<EOF
    "openssl enc -aes-256-cbc -salt -pbkdf2 -in ORIG_FILE -out ENCTYPTED"
    "echo 'TEXT' | openssl enc -e -aes-256-cbc -a -salt -pbkdf2"
EOF
    echo -e "${RESET}"

    echo -e "${WARN}----with keyfile----${RESET}"
    echo -e "${OUTPUT}"
    cat <<EOF
    "openssl rand 256 >symme.key"
    "openssl enc -aes-256-cbc -salt -pbkdf2 -in ORIG_FILE -out ENCRYPTED -k KEYFILE"
    "echo 'TEXT' | openssl enc -e -aes-256-cbc -a -salt -pbkdf2 -k KEYFILE"
EOF
    echo -e "${RESET}"
    echo -e "${WARN}Read_RSA_Encryption @ https://gist.github.com/minlaxz/71a997c38665aa2fe530a6b4ba4308ed#rsa-encryptions"
    ;;

--how-dec)
    echo -e "${HEAD}   DECRYPTION   ${RESET}"
    echo -e "${WARN}----with password----${RESET}"

    echo -e "${OUTPUT}"
    cat <<EOF
    "openssl enc -aes-256-cbc -d -salt -pbkdf2 -in ENCRYPTED -out ORIG_FILE"
    "echo 'CIPHER-TEXT' | openssl enc -e -aes-256-cbc -a -d -salt -pbkdf2"
EOF
    echo -e "${RESET}"

    echo -e "${WARN}----with keyfile----${RESET}"
    echo -e "${OUTPUT}"
    cat <<EOF
    "openssl enc -aes-256-cbc -d -salt -pbkdf2 -in ENCRYPTED -out ORIG_FILE -k KEYFILE"
    "CIPHER-TEXT' | openssl enc -e -aes-256-cbc -a -salt -pbkdf2 -d -k KEYFILE"
EOF
    echo -e "${RESET}"
    echo -e "${WARN}Read_RSA_Decryption @ https://gist.github.com/minlaxz/71a997c38665aa2fe530a6b4ba4308ed#rsa-decryptions"
    ;;

--how-safe-rm)
    echo -e "${HEAD}Safe REMOVE (needs trash-cli)"
    echo -e "${RESET}${OUTPUT}"
    cat <<EOF
    "alias rm='trash-put' >> bash-alias"
EOF
    ;;

--how-pypi)
    echo -e "${HEAD}Compiling PYPI (needs twine)"
    echo -e "${RESET}${OUTPUT}"
    cat <<EOF
    "python setup.py bdist_wheel or sdist"
    "twine upload dist/* --verbose"
EOF
    ;;

--how-forward-ssh)
    echo -e "${HEAD}Forward SSH REMOVE${RESET}"
    echo -e "${WARN}"
    cat <<EOF
    These commands should be run in local machine.
    Forwarding remote port to local port
    REMOTE PORT => LOCAL PORT
EOF
    echo -e "${RESET}${OUTPUT}"
    cat <<EOF
    "ssh -L 2222:localhost:22 -C -N -l RUSER RHOST"
    RHOST localhost 22 => LHOST localhost 2222
    "ssh -L 0.0.0.0:2222:localhost:22 -C -N -l RUSER RHOST"
    RHOST localhost 22 => LHOST ipaddress 2222
    "ssh -L localhost:2222:0.0.0.0:22 -C -N -l RUSER RHOST"
    RHOST ipaddress 22 => LHOST localhost 2222
EOF
    ;;

--how-reverse-ssh)
    echo -e "${HEAD}Reverse SSH"
    echo -e "${RESET}${OUTPUT}"
    cat <<EOF
    "ssh -R 2222:localhost:22 laxz@192.168.0.16 -N"
EOF
    ;;

--how-monitor-bandwidth)
    echo -e "${HEAD}Monitor Bandwidth"
    echo -e "${RESET}${OUTPUT}"
    cat <<EOF
    # 1. Overall bandwidth - nload, bmon, slurm, bwm-ng, cbm, speedometer, netload

    # 2. Overall bandwidth (batch style output) - vnstat, ifstat, dstat, collectl

    # 2. Bandwidth per socket connection - iftop, iptraf, tcptrack, pktstat, netwatch, trafshow

    # 3. Bandwidth per process - nethogs
EOF
    ;;

--how-nc-tx-rx)
    echo -e "${OUTPUT}"
    cat <<EOF
Decription : How to send and receive file with 'ncat'
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
    ;;

--how-src-conns)
    echo -e "${OUTPUT}"
    cat <<EOF
Decription : How many active connections are established to this specific local port
    TCP UDP: {SRC}
        ss -tun src ipaddress(optional):PORT | grep -i "estab" | wc -l
EOF
    echo -e "${RESET}"
    ;;

--how-dst-conns)
    echo -e "${OUTPUT}"
    cat <<EOF
Decription : How many active connections are established to this specific remote ipaddress
    TCP UDP: {DST}
        ss -tun dst IPADDRESS:port(optional) | grep -i "estab" | wc -l
EOF
    echo -e "${RESET}"
    ;;

--how-wireguard)
    echo -e "${OUTPUT}"
    cat <<EOF
sudo apt install wireguard git dh-autoreconf libglib2.0-dev intltool build-essential libgtk-3-dev libnma-dev libsecret-1-dev network-manager-dev resolvconf
git clone https://github.com/max-moser/network-manager-wireguard && cd $_
./autogen.sh --without-libnm-glib
./configure --without-libnm-glib --prefix=/usr --sysconfdir=/etc --libdir=/usr/lib/x86_64-linux-gnu --libexecdir=/usr/lib/NetworkManager --localstatedir=/var
make && sudo make install

Check in Settings/Networks/VPNs
used wgcf, test speed 18MB/s
EOF
    echo -e "${RESET}"
    ;;

--how-pythonanywhere)
    echo -e "${OUTPUT}"
    cat <<EOF
In python anywhere bash
pip3.8 install --user pythonanywhere
EOF
    echo -e "${RESET}"
;;

--how-docker-github)
cat<<EOF
cat $PAT | docker login https://docker.pkg.github.com -u minlaxz --password-stdin
EOF
;;
esac

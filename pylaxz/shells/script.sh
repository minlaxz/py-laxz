#! /bin/env bash
version=1.0
flag=$1
case "$flag" in
--help-long)
    printf "    --lxz-DE        this will remind me to install what i need.\n"
    printf "    --help-long     show this help message and exit\n"
    printf "    --version       show lxz version\n\n"

    # printf "    --expose            exposing local service or fs to the internet\n\n"

    printf "    --how-enc           Show help how to encrypt.\n"
    printf "    --how-dec           Show help how to decrypt.\n"
    printf "    --how-compress      Show help how to parallel compress.\n"
    printf "    --how-decompress    Show help how to parallel decompress.\n"
    printf "    --how-copy          Copy with Progress Bar.\n"
    printf "    --how-safe-rm       Safe remove.\n\n"

    printf "    --sys-upgrade       package update and upgrade\n"
    printf "    --sys-setup         setting up linux system with essential dependencies\n\n"

    printf "    --has-internet      check internet status from bash.\n"
    printf "    --port-service      get service on specific port.\n"
    printf "    --scan-host         scan port on given host. {need nmap}\n\n"

    printf "    --issue-opencv      issues about opencv.\n\n"

    printf "    --is-installed      check a package or software is installed.\n\n"
;;

--help)
printf "    --lxz-DE\n"
printf "    --help\n"
printf "    --version\n\n"
printf "    --how-enc\n"
printf "    --how-dec\n"
printf "    --how-compress\n"
printf "    --how-decompress\n"
printf "    --how-copy\n"
printf "    --how-safe-rm\n\n"
printf "    --sys-upgrade\n"
printf "    --sys-setup\n\n"
printf "    --has-internet\n"
printf "    --port-service\n"
printf "    --scan-host\n\n"
printf "    --issue-opencv\n"
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

--how-copy)
cat << EOF
rsync -ah --progress $1 $2
EOF
;;

--how-safe-rm)
cat << EOF
sudo apt install trash-cli
echo "alias rm='trash-put' >> bash-alias
EOF
;;

--how-enc)
echo "openssl enc -aes-256-cbc -salt -pbkdf2 -in ORIG_FILE -out ENCTYPTED"
echo "echo 'TEXT' | openssl enc -e -aes-256-cbc -a -salt -pbkdf2"
echo ""
echo "openssl rand 256 >symme.key"
echo "openssl enc -aes-256-cbc -salt -pbkdf2 -in ORIG_FILE -out ENCRYPTED -k KEYFILE"
echo "echo 'TEXT' | openssl enc -e -aes-256-cbc -a -salt -pbkdf2 -k KEYFILE"
echo "FOR RSA https://gist.github.com/minlaxz/71a997c38665aa2fe530a6b4ba4308ed#rsa-encryptions"
;;

--how-dec)
echo "openssl enc -aes-256-cbc -d -salt -pbkdf2 -in ENCRYPTED -out ORIG_FILE"
echo "echo 'CIPHER-TEXT' | openssl enc -e -aes-256-cbc -a -d -salt -pbkdf2"
echo ""
echo "openssl enc -aes-256-cbc -d -salt -pbkdf2 -in ENCRYPTED -out ORIG_FILE -k KEYFILE"
echo "echo 'CIPHER-TEXT' | openssl enc -e -aes-256-cbc -a -salt -pbkdf2 -d -k KEYFILE"
echo "FOR RSA https://gist.github.com/minlaxz/71a997c38665aa2fe530a6b4ba4308ed#rsa-encryptions"
;;

--how-compress)
echo "Need pixz"
echo "tar cvf - ./FILE | pixz -p 4 > COMPRESS.tpxz"
;;

--how-decompress)
echo "Need pixz"
echo "pixz -x -p 4 < COMPRESS.tpxz | tar xv -C path/to/dir"
;;

--sys-upgrade)
sudo apt update && sudo apt upgrade -y
;;

--sys-setup)
    cat <<EOF
    setting up enviroment, this will take some time ...
EOF
sudo apt update && sudo apt upgrade -y && \
sudo apt install vlc
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
read -p "IPADDRESS : [localhost]" uservar
    sudo nmap -sTU -O $uservar
;;

--has-internet)
    echo -e "Checking internet connection ..." ;
    wget -q -T 1 --spider http://example.com ;
    if [ $? -eq 0 ] ; then echo "Internet connection is Good." ;
    else echo -e "No Internet Connection!" ;
    fi
;;

--is-installed)
read -p "which package [ list ALL] " uservar
if [ $uservar != "" ] ; then
    apt list --installed | grep -i $uservar;
else
    sudo dpkg-query -Wf '${Installed-size}\t${Package}\n' | column -t
fi

;;

*)
    cat <<EOF
Nothing for $flag yet.
EOF
;;

esac

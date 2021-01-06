#! /bin/env bash
version=1.0
flag=$1
case "$flag" in
"" | --help )
    printf "    --test      test\n"
    printf "    --help      print this help message and exit\n"
    printf "    --version   print lxz helper version\n\n"

    # printf "    --copy              copy files and directories with progess\n"
    # printf "    --remove            safe remove files and directories\n\n"

    # printf "    --expose            exposing local service or fs to the internet\n"

    # printf "    --encrypt           encrypt given {file} with aes256\n"
    # printf "    --decrypt           decrypt lxz encrpyted {enc_file} aes256\n"
    # printf "    --gen-pw            generate a password\n\n"

    printf "    --how-enc           Show help how to encrypt.\n"
    printf "    --how-dec           Show help how to decrypt.\n"
    printf "    --how-compress      Show help how to parallel compress.\n"
    printf "    --how-decompress    Show help how to parallel decompress.\n\n"


    printf "    --sys-upgrade       package update and upgrade\n"
    printf "    --sys-setup         setting up linux system with essential dependencies\n\n"

    printf "    --has-internet      check internet status from bash.\n"
    printf "    --port-service      get service on specific port.\n"
    printf "    --scan-host         scan port on given host. {need nmap}\n\n"
    ;;
    
--test)
    cat <<EOF
Testing OK!
EOF
;;

--version)
    cat <<EOF
shell script version : $version
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
read -p "which port ? > default all LISTEN : " uservar
if [ $uservar != "" ] ; then
    sudo lsof -i:$uservar
else
    sudo lsof -i -P -n | grep LISTEN
fi
;;

--scan-host)
read -p "IPADDRESS : " uservar
    sudo nmap -sTU -O $uservar
;;

--has-internet)
    echo -e "Checking internet connection ..." ;
    wget -q -T 1 --spider http://example.com ;
    if [ $? -eq 0 ] ; then echo "Internet connection is Good." ;
    else echo -e "No Internet Connection!" ;
    fi
;;

*)
    cat <<EOF
Nothing for $flag yet.
EOF
;;

esac

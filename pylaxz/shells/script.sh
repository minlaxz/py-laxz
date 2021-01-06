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

    printf "    --sys-upgrade       package update and upgrade\n"
    printf "    --sys-setup         setting up linux system with essential dependencies\n\n"

    printf "    --has-internet            check internet status from bash.\n"
    printf "    --port-service                get service on specific port.\n"
    printf "    --scan-host               scan port on given host. {need nmap}\n\n"
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

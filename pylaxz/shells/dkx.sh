#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'

function has_docker() {
    dpkg-query -l docker >/dev/null 2>&1
    return $?
}

case "$1" in
--dk-help)
    echo -e "${HEAD}build:${RESET}"
    echo -e "${CMD}docker build -f ./Dockerfile -t username/repo:tag .${RESET}${NL}"
    
    echo -e "${HEAD}superuser bash:${RESET}"
    echo -e "${CMD}docker run --rm -it --gpus all --device /dev/video0:/dev/video0
    -v /home/laxz/:/tf -v /tmp/.X11-unix:/tmp/.X11-unix --ipc=host
    -e DISPLAY=$DISPLAY -p 8889:8888 minlaxz/ml-devel:cv-dark bash${RESET}${NL}"
 
    echo -e "${HEAD}user bash:${RESET}"
    echo -e "${CMD}-u 1000:1000${RESET}${NL}"

    echo -e "${HEAD}save image:${RESET}"
    echo -e "${CMD}docker save username/repo:tag | tar cvf - | pixz -p 4 >COMPRESS.tpxz${RESET}${NL}"

    echo -e "${HEAD}load image:${RESET}"
    echo -e "${CMD}docker load < COMPRESS.tar.gz${RESET}${NL}"

    echo -e "${HEAD}commit container:${RESET}"
    echo -e "${CMD}docker commit -m 'MSG' CONTAINER_NAME username/repo:tag${RESET}${NL}"

    echo -e "${HEAD}push container:${RESET}"
    echo -e "${CMD}docker push minlaxz/alpine:v3.1.1${RESET}"
    echo -e "${CMD}docker push localhost:5050/alpine:latest${RESET}${NL}"

    echo -e "${HEAD}local registery:${RESET}"
    echo -e "${CMD}docker run -d --name localreg -p 5050:5000 registry:latest${RESET}${NL}"

    echo -e "${HEAD}pull:${RESET}"
    echo -e "${CMD}docker pull localhost:5050/alpine${RESET}"
    echo -e "${CMD}docker pull alpine:latest${RESET}"
    ;;

--dk-install)
    has_docker
    if [[ $? == 0 ]] ; then
        echo -e "${HEAD}${OUTUPT}docker is already installed.${RESET}${NL}"
    else
        echo "Docker installation. TODO"
    fi
;;

esac

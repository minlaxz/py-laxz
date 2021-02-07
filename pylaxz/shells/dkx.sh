#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'
WARN='\e[3;33m'

COMPOSE_FILE='/usr/local/bin/docker-compose'

function has_sudo() {
    dpkg-query -l sudo >/dev/null 2>&1
    return $?
}

function has_docker() {
    dpkg-query -l docker >/dev/null 2>&1
    return $?
}

function has_internet() {
    wget -q -T 1 --spider http://example.com
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

--install-docker-compose)
    if [[ -f $COMPOSE_FILE ]]; then
        echo -e "${WARN}${HEAD}'docker-compose' is already installed.${RESET}"
        echo -e "${WARN}Note: If the command 'docker-compose' fails AFTER installation, 
        check your PATH. You can also create a symbolic link to '/usr/bin'"
        echo -e "${OUTPTU}For example 'sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose'${RESET}"
    else
        has_internet
        if [[ $? -eq 0 ]]; then
            sudo curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose
            echo -e "${WARN}'docker-compose' is installed.${RESET}"
        else
            echo -e "${ERROR}'Internet Connection' is needed.${RESET}"
        fi
    fi
    ;;

--install-docker-engine)
    has_docker
    if [[ $? -eq 0 ]]; then
        echo -e "${WARN}${HEAD}'docker' is already installed."
    else
        has_internet
        if [[ $? -eq 0 ]]; then
            sudo apt-get remove docker docker-engine docker.io containerd runc
            sudo apt-get update
            sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu$(lsb_release -cs)stable"
            sudo apt-get update
            sudo apt-get install docker-ce docker-ce-cli containerd.io
            sudo usermod -aG docker $USER
        else
            echo -e "${ERROR}'Internet Connection' is needed.${RESET}"
        fi
    fi
    ;;

*)
    echo -e "${HEAD}${ERROR}>>>dkx.sh: Internal Error<<<${RESET}"
    ;;

esac

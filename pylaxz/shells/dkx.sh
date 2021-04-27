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

function doesHasInternet() {
    wget -q -T 1 --spider http://example.com
    return $?
}

function has_sudo() {
    dpkg-query -l sudo >/dev/null 2>&1
    return $?
}

function has_compose() {
    docker-compose >/dev/numm 2>&1
    return $?
}

function doesHasDocker() {
    dpkg-query -l docker >/dev/null 2>&1
    return $?
}

function doessHasMachine() {
    docker-machine >/dev/null 2>&1
    return $?
}

case "$1" in
--dk-basics)
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

--dk-ps-stopped)
    echo -e "${OUTPUT}"
    docker ps -f "status=exited"
    echo -e "${RESET}"
    ;;

--dk-ps-stopped-id)
    echo -e "${OUTPUT}"
    docker ps -f "status=exited" --format "{{.ID}}"
    echo -e "${RESET}"
    ;;
    
--dk-port-bindings)
    if [[ ! $2 ]]; then
        bash $(dirname "$0")"/dkx.sh" --dk-ps-short
        read -p "Enter Container ID: " cid
    else
        cid=$2
    fi
    echo -e "${OUTPUT}"
    docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}' $cid
    # docker container port ID (also works)
    echo -e "${RESET}"
    ;;

--dk-stats)
    if [[ ! $2 ]]; then
        bash $(dirname "$0")"/dkx.sh" --dk-ps-short
        read -p "Enter Container ID: " cid
    else
        cid=$2
    fi
    docker stats $cid
    ;;

--dk-i-compose)
    has_compose
    if [[ $? -eq 0 ]]; then
        echo -e "${WARN}${HEAD}'docker-compose' is already installed at : $(which docker-compose)${RESET}"
        echo -e "${WARN}Note: If the command 'docker-compose' fails AFTER installation, 
        check your PATH. You can also create a symbolic link to '/usr/bin'"
        echo -e "${OUTPTU}For example 'sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose'${RESET}"
    else
        doesHasInternet
        if [[ $? -ne 0 ]]; then
            warningOutput "No Internet Connection."
        else
            sudo curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose
            echo -e "${WARN}'docker-compose' is installed.${RESET}"
        fi
    fi
    ;;

--dk-i-engine)
    doesHasDocker
    if [[ $? -eq 0 ]]; then
        warningOutput "'docker' is already installed."
    else
        doesHasInternet
        if [[ $? -ne 0 ]]; then
            warningOutput "No Internet Connection."
        else
            sudo apt-get remove docker docker-engine docker.io containerd runc
            sudo apt-get update
            sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
            curl -fsSL https://get.docker.com -o get-docker.sh
            sh get-docker.sh && rm ./get-docker.sh
            sudo usermod -aG docker $USER
        fi
    fi
    ;;

--dk-i-machine)
    doessHasMachine
    if [[ $? -eq 0 ]]; then
        echo -e "${WARN}${HEAD}docker-machine is already installed at : $(which docker-machine)"
    else
        doesHasInternet
        if [[ $? -eq 0 ]]; then
            base=https://github.com/docker/machine/releases/download/v0.16.0 &&
                curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
                sudo mv /tmp/docker-machine /usr/local/bin/docker-machine &&
                chmod +x /usr/local/bin/docker-machine
        else
            warningOutput "No Internet Connection."
        fi
    fi
    ;;

--dk-net-tips)
    echo -e "https://stackoverflow.com/a/41294598/10582082"
    echo -e "### Deprecated ... --link"
    echo -e "docker run --rm -it --name alp_name ${HEAD}--link${RESET} busy_bee:bb alpine:latest"
    echo -e "docker run --rm -it --name busy_bee ${HEAD}--link${RESET} alp_name:alp  busybox:latest"
    echo -e "### ... ..."
    echo -e "docker network connect multi-host-network container1"
    echo -e "docker run -itd --network=multi-host-network busybox"
    echo -e "docker network connect --ip 10.10.36.122 multi-host-network container2"
    echo -e "docker network connect --link container1:c1 multi-host-network container2"

    ;;

--dk-ps)
    echo -e "${OUTPUT}"
    docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.Image}}\t{{.Command}}"
    echo -e "${RESET}"
    ;;

--dk-ps-short)
    echo -e "${OUTPUT}"
    docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"
    echo -e "${RESET}"
    ;;

--dk-ip)
    if [[ ! $2 ]]; then
        bash $(dirname "$0")"/dkx.sh" --dk-ps-short
        read -p "Enter Container ID: " cid
    else
        cid=$2
    fi
    echo -e "${OUTPUT}"
    # docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}"
    echo -e "IP: " $(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $cid)
    echo -e "${RESET}"
    ;;

*)
    echo -e "${HEAD}${ERROR}>>>dkx.sh: Internal Error $?<<<${RESET}"
    ;;

esac

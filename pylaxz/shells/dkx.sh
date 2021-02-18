#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'
WARN='\e[3;33m'

function has_compose() {
    docker-compose >/dev/numm 2>&1
    return $?
}

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

function has_machine() {
    docker-machine >/dev/null 2>&1
    return $?
}

function error_no_internet() {
    echo -e "${ERROR}'Internet Connection' is needed.${RESET}"
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

--dk-inspect-port-bindings)
    read -p "ENter ID: " INSTANCE_ID
    docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}' $INSTANCE_ID
    # docker container port ID (also works)
    ;;

--dk-stats)
    read -p "ID : " INSTANCE_ID
    docker stats $INSTANCE_ID
    ;;

--dk-install-compose)
    has_compose
    if [[ $? -eq 0 ]]; then
        echo -e "${WARN}${HEAD}'docker-compose' is already installed at : $(which docker-compose)${RESET}"
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
            error_no_internet
        fi
    fi
    ;;

--dk-install-engine)
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
            error_no_internet
        fi
    fi
    ;;

--dk-install-machine)
    has_machine
    if [[ $? -eq 0 ]]; then
        echo -e "${WARN}${HEAD}docker-machine is already installed at : $(which docker-machine)"
    else
        has_internet
        if [[ $? -eq 0 ]]; then
            base=https://github.com/docker/machine/releases/download/v0.16.0 &&
                curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
                sudo mv /tmp/docker-machine /usr/local/bin/docker-machine &&
                chmod +x /usr/local/bin/docker-machine
        else
            error_no_internet
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
    docker ps --format "table {{.ID}}\t{{.Name}}\t{{.Ports}}\t{{.Image}}\t{{.Command}}"
    echo -e "${RESET}"
    ;;

--dk-ip)
    echo -e "${OUTPUT}"
    docker ps --format "table {{.ID}}\t{{.Name}}\t{{.Image}}\t{{.Ports}}"
    echo -e "${RESET}"
    read -p "Container ID?: " id
    echo -e "${OUTPUT}"
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $id
    echo -e "${RESET}"
    ;;

*)
    echo -e "${HEAD}${ERROR}>>>dkx.sh: Internal Error<<<${RESET}"
    ;;

esac

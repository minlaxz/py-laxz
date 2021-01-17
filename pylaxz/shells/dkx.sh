#! /bin/env bash
flag=$1
case "$flag" in
--dk-help)
cat<<EOF
    build:
        docker build -f ./Dockerfile -t username/repo:tag .
    su-bash-run:
        docker run --rm -it --gpus all --device /dev/video0:/dev/video0
        -v /home/laxz/:/tf -v /tmp/.X11-unix:/tmp/.X11-unix --ipc=host
        -e DISPLAY=$DISPLAY -p 8889:8888 minlaxz/ml-devel:cv-dark bash
    bash-run:
        su-bash-run plus -u 1000:1000
    save:
        docker save username/repo:tag | tar cvf - | pixz -p 4 > COMPRESS.tpxz
        docker save minlaxz/alpine:v3.1.1 | pixz > alpine.tpxz
    load:
        docker load < COMPRESS.tar.gz
        docker load < alpine.tpxz
    commit:
        docker commit -m "MSG" CONTAINER_NAME username/repo:tag
    push:
        docker push minlaxz/alpine:v3.1.1        
        docker push localhost:5050/alpine:latest
    local-reg:
        docker run -d --name localreg -p 5050:5000 registry:latest
    pull:
        docker pull localhost:5050/alpine
        docker pull alpine:latest
EOF
;;

esac
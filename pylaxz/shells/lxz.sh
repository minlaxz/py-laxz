#!/bin/bash

version='lxz-2.0.0' # version  -- [main.major.minor]

if [[ ! -f ./pylaxz/shells/conf.lxz ]]; then
    bash ./pylaxz/shells/auto.sh
fi

if [ $# -eq 0 ]; then
    printf "[--help | -h] for usage.\n"

else
    stVar=$1 #major
    ndVar=$2 #monir
    rdVar=$3 #in-case

    case "$stVar" in
    --help) bash ./pylaxz/shells/help.sh ;; #done
    --version) printf "$version\n" ;;       #done

    # --update) selfUpdate ;;
    --developer) notify-send 'Gotcha' 'This is developed by minlaxz' ;;

    --network)
        if [[ $ndVar == --[hH]* || $ndVar == "" ]]; then
            bash ./pylaxz/shells/help.sh --network
        fi
        ;;
    esac
fi

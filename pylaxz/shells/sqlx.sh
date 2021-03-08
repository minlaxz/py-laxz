#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'
WARN='\e[3;33m'

case "$1" in
--sql-api)
    enc_api_1='U2FsdGVkX18HFwjAgrMVpD5SBurhFqzwpzJ+quyNIvY/Op08mieLQwFbWQByuW4Zl3oqxfkz0lsZxMjkMY3MCw/QSF875/UgyZNvWmfN5VY='
    enc_api_2='U2FsdGVkX19wT36Fl44ZL7lOahDkjvWSf9vGdwPzO024X9fG/Icr3lOYCaE0nlLnpgoVTKx3YJwf8F+40WpHuCrKOPfLt/z3sSAvc8V+4d0='
    enc_api_3='U2FsdGVkX1+2YwaTWwzjTMCEkNwVb38+9NcdLxFENtRbDkCRN+BQ63RIclgw8dn6ZlakDJ/z3L4SK6lfHQaMCxzP5GZpx6HgySBv24F1LR8='
    echo -e "${HEAD}${WARN}Caution : X FUNCTION${RESET}"

    echo -e "${OUTPUT}1.C1-Deleted >- ${enc_api_1}${RESET}"
    echo -e "${OUTPUT}2.C1 >- ${enc_api_2}${RESET}"
    echo -e "${OUTPUT}3.C2 >- ${enc_api_3}${RESET}"
    read -p "Which one?: " choice
    case "$choice" in
    1)
        echo $enc_api_1 | openssl enc -e -aes-256-cbc -a -d -salt -pbkdf2
        ;;
    2)
        echo $enc_api_2 | openssl enc -e -aes-256-cbc -a -d -salt -pbkdf2
        ;;
    3)
        echo $enc_api_3 | openssl enc -e -aes-256-cbc -a -d -salt -pbkdf2
        ;;
    *)
        echo -e "${ERROR}Invalid.${RESET}"
        ;;
    esac
    ;;

--sql-serve)
    read -p "Enter Port [6969]: " port
    if [[ $port == "" ]]; then
        port=6969
    fi
    sudo python3 -m http.server $port
    ;;
esac

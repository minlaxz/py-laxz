#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'
WARN='\e[3;33m'

case "$1" in
--x-outline-api)
    enc_api='U2FsdGVkX18HFwjAgrMVpD5SBurhFqzwpzJ+quyNIvY/Op08mieLQwFbWQByuW4Zl3oqxfkz0lsZxMjkMY3MCw/QSF875/UgyZNvWmfN5VY='
    echo -e "${HEAD}${WARN}Caution : X FUNCTION${RESET}"
    echo -e "${OUTPUT}DECRYPT >- ${enc_api}${RESET}"
    echo $enc_api | openssl enc -e -aes-256-cbc -a -d -salt -pbkdf2
;;
esac
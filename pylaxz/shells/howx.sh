#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'

case "$1" in

--how-find-mv)
cat<<EOF
cmd:
    find . -maxdepth 2 -name "*.mp4" -exec mv {} . \;
explain:
    search for files in a directory hierarchy.
    -maxdepth levels
    -name pattern
    -exec command ;
EOF
;;

--how-copy)
cat << EOF
cmd:
    rsync -ah --progress FROM_FILE TO_FILE
explain:
    a fast, versatile, remote (and local) file-copying tool
    -a, --archive
    -h, --human-readable
    --progress
EOF
;;

--how-compress)
echo "Need pixz"
cat<<EOF
cmd:
    tar cvf - ./FILE | pixz -p 4 > COMPRESS.tpxz
explain:
    -c, --create
    -v, --verbose
    -f, --file ARCHIVE (- means print data to stdout)
    > redirect to tpxz file
EOF
;;

--how-decompress)
echo "Need pixz"
cat<<EOF
cmd:
    pixz -x -p 4 < COMPRESS.tpxz | tar xv -C path/to/dir
explain:
    < reirect file stream to pixz
    -x, --extract, --get
    -v, --verbose
    -C, --directory DIR
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


--how-safe-rm)
cat << EOF
sudo apt install trash-cli
echo "alias rm='trash-put' >> bash-alias
EOF
;;

--how-pypi)
echo -e "$HEAD HOW TO COMPILE BDIST SDIST$RESET"
echo -e "${CMD}python setup.py bdist_wheel or sdist ${NL}twine upload dist/* --verbose${RESET}"
esac
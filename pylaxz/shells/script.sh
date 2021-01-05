#! /bin/env bash
flag=$1
case "$flag" in
"" | --[hH]* )
    printf "       --test      test\n"
    printf "       --help      print this help message and exit\n"
    printf "       --version   print lxz helper version\n\n"

    printf "       --copy      copy files and directories with progess\n"
    printf "       --remove    safe remove files and directories\n\n"

    printf "       --expose    exposing local service or fs to the internet\n"

    printf "       --encrypt   encrypt given {file} with aes256\n"
    printf "       --decrypt   decrypt lxz encrpyted {enc_file} aes256\n"
    printf "       --gen-pw  generate a password\n\n"

    printf "       --package   package update and upgrade\n"
    printf "       --setup-sys setting up linux system with essential dependencies\n\n"
    ;;
    
--test)
    cat <<EOF

Testing OK!

EOF
    ;;
*)
    cat <<EOF

No help for $flag.

EOF

    ;;
esac

flag=$1
case "$flag" in
"")
    printf "       --help      print lxz help message and exit.\n"
    printf "       --version   print lxz version.\n\n"

    printf "       --copy      copy files and directories with progess.\n"
    printf "       --remove    safe remove files and directories.\n\n"

    printf "       --expose    EXPOSING local service or file-system to the Internet.\n"
    printf "       --network   handle the networks.\n\n"

    printf "       --encrypt   encrypt given {file} with aes256.\n"
    printf "       --decrypt   decrypt lxz encrpyted {enc_file} aes256.\n"
    printf "       --generate  generate a password.\n\n"

    printf "       --package   package update and upgrade.\n\n"
    ;;
--network)
    cat <<EOF

lxz'Network.

EOF
    ;;
*)
    cat <<EOF

No help for $flag.

EOF

    ;;
esac

#! /bin/env bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'
WARN='\e[3;33m'

function has_curl() {
    dpkg-query -l curl >/dev/null 2>&1
    return $?
}

has_curl
if [[ $? -ne 0 ]]; then
    echo -e "${ERROR}'curl' is needed.${RESET}"
    exit 1
fi

generate_server_rename() {
    read -p "Enter Server Name: " name
    cat <<EOF
{"name":"$name"}
EOF
}

generate_user_name() {
    read -p "Enter New User Name: " name
    cat <<EOF
{"name":"$name"}
EOF
}

generate_id_datalimit() {
    read -p "Enter DataLimit Bytes: " bytes
    cat <<EOF
{"limit":{"bytes":$bytes}}
EOF
}

generate_user_rename() {
    read -p "Enter User reName: " name
    cat <<EOF
{"name":"$name"}
EOF
}

read -p "API URL ? " API_URL

case "$1" in

--outline-server-info)
    curl --insecure -s -H "Content-Type: application/json" -X GET $API_URL/server | jq '.'
    ;;

--outline-rename-server)
    curl --insecure -s -H "Content-Type: application/json" -d "$(generate_server_rename)" -X PUT $API_URL/name
    ;;

--outline-get-lists)
    curl --insecure -s -H "Content-Type: application/json" -X GET $API_URL/access-keys | jq '.accessKeys'
    ;;

--outline-metrics-one)
    curl --insecure -s -H "Content-Type: application/json" -X GET $API_URL/access-keys | jq '.accessKeys'
    read -p "Enter ID: " id
    curl --insecure -s -H "Content-Type: application/json" -X GET $API_URL/metrics/transfer | jq --arg id "$id" '.bytesTransferredByUserId[$id]'
    # curl --insecure -s -H "Content-Type: application/json" -X GET $API_URL/access-keys | jq  --arg id "$id" '.accessKeys[$id]'
    ;;

--outline-create-new)
    curl --insecure -s -H "Content-Type: application/json" -d "$(generate_user_name)" -X POST $API_URL/access-keys
    if [[ $? -eq 0 ]]; then
        echo -e "${HEAD}${OUTPUT}SUCCESS${RESET}"
    fi
    ;;

--outline-id-datalimit)
    curl --insecure -s -H "Content-Type: application/json" -X GET $API_URL/access-keys | jq '.accessKeys'
    read -p "Enter ID : " id
    curl --insecure -H "Content-Type: application/json" -d "$(generate_id_datalimit)" -X PUT $API_URL/access-keys/${id}/data-limit
    if [[ $? -eq 0 ]]; then
        echo -e "${OUTPUT}SUCCESS : ${id} : ${limit} ${RESET}"
    fi
    ;;

--outline-rename-user)
    curl --insecure -s -H "Content-Type: application/json" -X GET $API_URL/access-keys | jq '.accessKeys'
    read -p "Enter ID : " id
    curl --insecure -H "Content-Type: application/json" -d "$(generate_user_rename)" -X PUT $API_URL/access-keys/${id}/name
    ;;

--outline-metrics-transfer)
    curl --insecure -s -H "Content-Type: application/json" -X GET $API_URL/metrics/transfer | jq '.bytesTransferredByUserId'
    ;;
*)
    echo -e "${ERROR}not an option.${RESET}"
    ;;
esac

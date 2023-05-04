#! /bin/bash

source .env

RED='\e[0;31m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
BOLD='\e[1m'
END='\e[0m'
ROOT_PATH=$PWD

pprint() {
    printf "\n${GREEN}${BOLD}$1${END}\n"
}

wprint() {
    printf "\n${BLUE}${BOLD}$1${END}\n"
}

eprint() {
    printf "\n${RED}${BOLD}$1${END}\n"
}

printInputText() {
    printf "\n${GREEN}${BOLD}$1${END}"
}

printInfoText() {
    printf "\e[1;${LIGHT_CYAN:-96}m$1${END}"
}

createVirtualHost() {
    wprint "Coping \`example.dev file\` to \`$url.conf\`"
    cp ${ROOT_PATH}/config/ngnix/template/example.dev.conf ${ROOT_PATH}/config/ngnix/sites/${url}.conf

    cd config/ngnix/sites
    wprint 'Replacing server_name'
    sed -i -e "s,--url--,$url,g" ${url}.conf

    NEW_DIR="/var/www/"${directory}
    wprint 'Replacing server root'
    sed -i -e "s,--directory--,$NEW_DIR,g" ${url}.conf

    tmp_file="$url.conf-e"
    if [[ -f "$tmp_file" ]]; then
        rm ${tmp_file}
    fi

    cd ${ROOT_PATH}
    askCopyConfigToDockerNginx
}

copyConfigToDockerNginx() {
#	parent_path=$( cd ../../.. "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
	for entry in ${ROOT_PATH}/config/ngnix/sites/*
	do
        cp "$entry" ${ROOT_PATH}/docker/nginx/sites
	done
	wprint 'Copied successfully!'

    docker restart $(docker-compose ps -q nginx | awk '{print $1}')
    wprint 'NGINX Restarted!'

    sudo echo "127.0.0.1        $url" >> /etc/hosts
    wprint 'Changed Hosts files!'
    wprint "Go To: $url"
    wprint 'Enjoy :)'
}

askCopyConfigToDockerNginx() {
    printInputText "Do you want to copy ngnix virtual host file (y/n)? "
    read -r answer

    if echo "$answer" | grep -iq "^y"; then
        copyConfigToDockerNginx
    else
        echo No
        exit
    fi
}

callConfiguration() {
    printInputText "Enter relative path according to .env \`APPLICATION\` config such as (your-project-directory/public)."
    printInfoText "\n${APPLICATION}/"
    read -r directory

    printInfoText "\nPS: chrome does not support .dev domain any more!"
    printInputText "web url (example.local): "
    read -r url

    wprint "Project Path: ${APPLICATION}/$directory"
    wprint "\b\bUrl: $url"

    printInputText "Are you want to continue (y/n)? "
    read -r answer

    if echo "$answer" | grep -iq "^y"; then
        createVirtualHost
    else
        eprint exit
        exit
    fi
}

printInputText "Do you want to new ngnix virtual host file (y/n)? "
read -r answer

if echo "$answer" | grep -iq "^y"; then
    callConfiguration
else
    eprint No
fi

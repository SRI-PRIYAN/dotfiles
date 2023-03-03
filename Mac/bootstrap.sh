#!/usr/bin/env zsh

git pull origin master;

function install() {
    rsync --exclude "bootstrap.sh" \
            -avh --no-perms . ~;
    
    source ~/.bashrc;
}

if [[ $1 == "--force" || $1 == "-f" ]]; then
    install;
else
    read -p "This might overwrite the already existing files in the home directory. Are you sure? [y/n] : ";

    if [[ ${REPLY} == "y" || ${REPLY} == "Y" ]]; then
        install;
    fi
fi
unset install;
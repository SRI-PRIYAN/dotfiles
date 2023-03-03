#!/usr/bin/env bash

git pull origin master;

function install_dotfiles() {
    rsync --exclude "bootstrap.sh" \
            --exclude "*.json" \
            -avh --no-perms . ~;
    
    source ~/.bashrc;
}

if [[ $1 == "--force" || $1 == "-f" ]]; then
    install_dotfiles;
else
    read -p "This might overwrite the already existing files in the home directory. Are you sure? [y/n] : ";

    if [[ ${REPLY} == "y" || ${REPLY} == "Y" ]]; then
        install_dotfiles;
    fi
fi
unset install_dotfiles;
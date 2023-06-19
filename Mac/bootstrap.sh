#!/usr/bin/env zsh

git pull origin master;

function install_dotfiles() {
    rsync --exclude "bootstrap.sh" \
        --exclude "*.json" \
        -avh --no-perms . ~;

    source ~/.zshrc;
}

if [[ $1 == "--force" || $1 == "-f" ]]; then
    install_dotfiles;
else
    echo -n "This might overwrite the already existing files in the home dir. Are you sure? [y/n]: "
    read reply;

    if [[ ${reply} == "y" || ${reply} == "Y" ]]; then
        install_dotfiles;
    fi
fi
unset install_dotfiles;

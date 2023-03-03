#!/usr/bin/env zsh

git pull origin master;

function install() {
    rsync --exclude "bootstrap.sh" \
            -avh --no-perms . ~;
    
    source ~/.zshrc;
}

if [[ $1 == "--force" || $1 == "-f" ]]; then
    install;
else
	echo -n "This might overwrite the already existing files in the home dir. Are you sure? [y/n]: "
    read reply;

    if [[ ${reply} == "y" || ${reply} == "Y" ]]; then
        install;
    fi
fi
unset install;

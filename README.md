# Dotfiles

## Preview

[![terminal.png](https://i.postimg.cc/dtkv6BJS/terminal.png)](https://postimg.cc/zVr9XTbn)

## Description

* Configure Bash with these dotfiles.

* Increase your workflow with the help of automated functions and aliases.

## Requirements

* You must have the bash shell running on your machine. If you have Linux or Mac, it comes inbuilt. If you are running windows, you probably want to use WSL(Windows Subsystem for Linux).

* Install 'python3' and its package manager 'pip' on the bash shell if you haven't already.

  ```bash
    sudo apt-get install python3
    sudo apt-get install python3-pip
  ```

* And some additional light-weight python modules.

  ```bash
    pip3 install beautifulsoup4
    pip3 install requests
    pip3 install lxml
  ```

## Installation

* Install git if you haven't already.

  ```bash
    sudo apt-get install git
  ```

* Clone this repository to your local machine anywhere you want. The bootstrap script will pull in the latest version and copy the files into your home directory.

  ```bash
    git clone "https://github.com/SRI-PRIYAN/dotfiles.git" && cd dotfiles && source bootstrap.sh
  ```

* To update, `cd` into your local `dotfiles` repository and then :

  ```bash
    source bootstrap.sh
  ```

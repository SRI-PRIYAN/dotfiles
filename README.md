# Dotfiles

## Preview

![terminal.png](https://i.postimg.cc/dtkv6BJS/terminal.png)

## Description

* Configure Bash with these dotfiles.

* Increase your workflow with the help of automated functions and aliases.

## Requirements

* You must have the bash shell running on your machine. If you have Linux or Mac, it comes inbuilt. If you are running windows, you probably want to use WSL(Windows Subsystem for Linux) or Git Bash.

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

* Clone this repository in your home directory. The bootstrap script will pull in the latest version and copy the files into your home directory.

  ```bash
    git clone "https://github.com/SRI-PRIYAN/dotfiles.git" && cd dotfiles && source bootstrap.sh
  ```

* To update, `cd` into your local `dotfiles` repository and then :

  ```bash
    source bootstrap.sh
  ```

## Functions

1. ### codeforces

    * If you are taking part in a [codeforces](https://codeforces.com/contests) contest, then you might not want to waste your time in creating template code, input and output files.

    * To automate that process, I've written the `codeforces` function which makes use of the `webscraper.py` and gets the job done.

    * The `webscraper.py` uses the BeautifulSoup library, parses the html page, gets the number of problems and creates folders for each problem with the template code, sample input and output files.

    * All you have to do is,

      ```bash
        codeforces <contest_id>
      ```

      ![codeforces.png](https://i.postimg.cc/CxD7wXj5/codeforces.png)

2. ### grade

    * Now that we've automated the process of creating the sample input and output files, we can even automate the process of testing the code against those files. The `grade` function exactly does that.

    * It takes in the source code (cpp or c file) as argument.

      ```bash
        grade source_file.cpp
      ```

      ![grade.png](https://i.postimg.cc/Sxb4QXXh/grade.png)

3. ### Others

    * There are quite a few functions like `compile`, `class`, `comdep`, `out`.

    * Check them out in the `.functions` file for their usage.

## Thanks to

* [Mathias Bynens](https://mathiasbynens.be/) and his [dotfiles repository](https://github.com/mathiasbynens/dotfiles).

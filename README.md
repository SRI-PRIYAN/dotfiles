# Dotfiles

## Installation

* Recommended to have oh-my-zsh and python3 installed. Clone this repository in your home directory. The bootstrap script will pull in the latest version and copy the files into your home directory.

  ```sh
    cd ~ && git clone "https://github.com/SRI-PRIYAN/dotfiles.git" && cd dotfiles/Mac && source bootstrap.sh
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

      ![codeforces.png](https://i.postimg.cc/PrFYLcmS/image.png)

2. ### grade

    * Now that we've automated the process of creating the sample input and output files, we can even automate the process of testing the code against those files. The `grade` function exactly does that.

    * It takes in the source code (cpp or c file) as argument.

      ```sh
        grade source_file.cpp
      ```

      ![grade.png](https://i.postimg.cc/029cGLKx/image.png)

3. ### zz

    * Fuzzy Find and `cd` into any previously visited directory conviniently.

    * Utilizes `z` (zsh plugin) which keeps track of already visited directories and `fzf` which is used for Fuzzy Finding.

      [![zz.gif](https://i.postimg.cc/5tqbKFMp/zz-new.gif)](https://postimg.cc/QBt2HCCW)

## Configs

1. ### Delta

    * Checkout `.gitconfig` for delta configuration.

    * To install delta: `brew install git-delta`

      [![image.png](https://i.postimg.cc/Df9gcC7r/image.png)](https://postimg.cc/yWTc1ygx)

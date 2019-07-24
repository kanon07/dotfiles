Dotfiles repository
====

## Overview
.vimrc .bashrc .tmux.conf .dir_corors etc

## Usage

#### proxy
    git config --global http.proxy http://cache.ccs.kogakuin.ac.jp:8080
    git config --global https.proxy http://cache.ccs.kogakuin.ac.jp:8080

#### clone
    git clone http://github.com/kanon07/dotfiles.git

#### Install
    cd dotfiles
    ./setup.sh

#### without proxy or appear bug in vim-insert-mode
    git checkout noproxy
    or
    git checkout nolexima

    ./setup.sh

## Author

[kanon07](https://github.com/kanon07)

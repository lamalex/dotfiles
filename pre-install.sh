#!/bin/bash

# Check if Homebrew is installed
if [ $(uname) == 'Darwin' ]; then
    if [ ! -f "`which brew`" ]; then
        echo 'Installing homebrew'
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo 'Updating homebrew'
        brew update
    fi
    brew tap homebrew/bundle  # Install Homebrew Bundle
fi

# Change default shell
if [[  $SHELL != *"zsh"* ]]; then
  echo 'Changing default shell to zsh'
  chsh -s `which zsh`
else
  echo 'Already using zsh'
fi

# Check if oh-my-zsh is installed
OMZDIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZDIR" ]; then
  echo 'Installing oh-my-zsh'
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo 'Updating oh-my-zsh'
  zsh -i -c upgrade_oh_my_zsh
fi


#!/bin/bash

## install xcode
sudo xcodebuild -license
sudo xcode-select --install

## install homebrew zsh ansible
mkdir ~/.homebrew
curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/.homebrew
brew update
brew install zsh
brew install ansible

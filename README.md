## 使い方
https://github.com/yasuomatsuoka/dotfiles にある dotfiles も ansible でセットする
```
$ xcode-select --install
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install ansible
$ git clone git@github.com:yasuomatsuoka/mac_setup.git
$ cd mac_setup
$ ansible-playbook site.yml -i hosts --ask-become-pass 
```

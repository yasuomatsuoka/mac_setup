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

rictyフォントでバッククオートが化けるので、シェルで修正する

```
$ brew install fontforge
$ cat script/fontforge.sh                                                                                                                                                ~ 1
#!/usr/bin/env fontforge

Open($1)
Select(0u0060)
SetGlyphClass("base")
Generate($1)
$ chmod u+x script/fontforge.sh
$ ./script/fontforge.sh Library/Fonts/Ricty-Regular.ttf      
```
参考: https://qiita.com/uKLEina/items/ff0877871fc425952b92

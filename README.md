# 使い方
## 0. 手元に持ってくる
```bash
git clone git@github.com:yasuomatsuoka/mac_setup
```

## 1. 初回シェル実行とzsh初期設定
homebrew は `~/.homebrew` にインストールする。

### 初回シェル実行
```bash
$ ./scripts/inital.sh
```


### zshの設定 (ansibleでうまく設定できなかった)

```bash
$ tail /etc/shells                                   
# one of these shells.

/bin/bash
/bin/csh
/bin/dash
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
/Users/yasuo/.homebrew/bin/zsh # 追加

$ chsh -s /Users/yasuo/.homebrew/bin/zsh
```

### ターミナルの再起動

## 2.ansible実行
パスワードが必要なタイミングで聞かれるように実行する。
ｚｓｈ関連の設定ファイルはPreztoのインストールのため削除するので注意。
brew cask のインストール先は `~/Applications` 以下に作成する。
```
$ ansible-playbook site.yml -i hosts --ask-become-pass 
```

## 3. zsh Prezto の設定
Preztoの設定をansible化できていないので手動で下記を行う
- .zsh系を Prezto でつくる
```bash
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

- .zshrcの必要な設定を入れる (https://github.com/yasuomatsuoka/dotfiles/blob/master/.zshrc)
- 好みにPreztoをカスタマイズ
  - `'autosuggestions'` の拡張は絶対に入れておきたい

## 4. terminal再起動

## メモ
- ricty を入れていないので入れる

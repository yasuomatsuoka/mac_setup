# 使い方

## 0. 手元に持ってくる

```bash
git clone git@github.com:yasuomatsuoka/mac_setup
```

## 1. 初回シェル実行と zsh 初期設定

homebrew は `~/.homebrew` にインストールする。

### .zshrc に設定読み込み
zsh Prezto を使うので直接設定しない

```
$ cat ~/.zshrc
if [ -e ~/mac_setup//dotfiles/zshrc ]; then
    source ~/mac_setup//dotfiles/zshrc
fi
```

### 初回シェル実行
xcode homebrew zsh ansible をインストール
```bash
$ u+x ./scripts/inital.sh
$ ./scripts/inital.sh
```

### zsh の設定 (ansible でうまく設定できなかった)

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

## 2.ansible 実行

パスワードが必要なタイミングで聞かれるように実行する。
zsh関連の設定ファイルは Prezto のインストールのため削除するので注意。
brew cask のインストール先は `~/Applications` 以下に作成する。

```
$ ansible-playbook site.yml -i hosts --ask-become-pass
```

## 3. zsh Prezto の設定

Prezto の設定を ansible 化できていないので手動で下記を行う

- .zsh 系を Prezto でつくる

```bash
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

- .zshrc の必要な設定を入れる (https://github.com/yasuomatsuoka/mac_setup/blob/master/dotfiles/zshrc)
- 好みに Prezto をカスタマイズ
  - autosuggestions の拡張は絶対に入れておきたい
  - テーマは pure

## 4. terminal 再起動
再起動する

## 5. terminal に Iceberg Coloer Scheme を設定
http://cocopon.github.io/iceberg.vim/ から zip をダウンロードして `.termial` の拡張子をダブルクリックで反映される

## メモ
### 個別実行方法

```bash
ansible-playbook -i hosts site.yml --tags osx_defaults
ansible-playbook -i hosts site.yml --tags mas
ansible-playbook -i hosts site.yml --tags homebrew
ansible-playbook -i hosts site.yml --tags homebrew_cask
ansible-playbook -i hosts site.yml --tags ricty
```

### 4kより解像度が低いディスプレイを使う時用
```
# フォントスムージング処理にカラーフリンジを使用しないをオフにする
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

# アンチエイリアシングの強度を調整 0-3
defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

# logoutする
```

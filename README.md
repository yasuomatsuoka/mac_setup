# 使い方

## 0. 手元に持ってくる

```bash
git clone git@github.com:yasuomatsuoka/mac_setup
```

## 注意

- この手順では, mac にマルチアカウントを作る前提なので､homebrew は `~/.homebrew` にインストールされる
- brew cask は `~/Applications` にインストールされる
- マルチアカウントにしないのであれば､ 「初回シェル実行」を実行せずに手動で「xcode, homebrew, zsh, ansible」をインストールする
- マルチアカウントにしないのであれば､ `roles/homebrew_cask/tasks/main.yml` にある `install_options` を削除する

## 1. 初回シェル実行と zsh 初期設定

### .zshrc を仮設定

あとで `zsh Prezto` を使って設定するので､ここでは `.zshrc` は下記のようにするだけにする｡
(homebrew の path なども zshrc に書かれている)

```
$ cat ~/.zshrc
if [ -e ~/mac_setup//dotfiles/zshrc ]; then
    source ~/mac_setup//dotfiles/zshrc
fi
```

### 初回シェル実行

shell ファイルを使って､ 「xcode, homebrew, zsh, ansible」をインストールする｡
homebrew は､ `~/.homebrew` にインストールされる｡

```bash
$ u+x ./scripts/inital.sh
$ ./scripts/inital.sh
```

### zsh の設定 (ansible でうまく自動化ができなかった)

`/etc/shells` に brew でインストールした zsh を設定

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
```

```
$ chsh -s /Users/yasuo/.homebrew/bin/zsh
```

## 2.ansible 実行

- zsh 関連の設定ファイルは Prezto のインストールのため削除するので注意する
- brew cask のインストール先は `~/Applications` 以下に作成する

```
$ ansible-playbook site.yml -i hosts --ask-become-pass
```

## 3. zsh Prezto の設定 (ansible でうまく自動化ができなかった)

- Prezto 環境を作るために.zshrc を shell で書き換える

WIP: 最新の方法を調べてから内容を変更する｡ https://github.com/yasuomatsuoka/mac_setup/blob/69c9801cb0c88e06acfab0c5c654c2b0ef73fc9c/roles/macos/tasks/main.yml#L28 で prezto をインストールしている

```bash
$ rm ~/.zshrc
$ setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

- .zshrc に homebrew のパスなど必要な設定を入れる
  - 参考: https://github.com/yasuomatsuoka/mac_setup/blob/master/dotfiles/zshrc (.zshrc からリンクはしない)
- 好みに Prezto をカスタマイズ
  - autosuggestions の拡張は絶対に入れる
  - テーマは pure に設定

## 4. terminal の再起動して zprezto を有効化する

GUI で普通に再起動する

## 5. terminal に ayu Coloer Scheme を設定

https://github.com/hwyncho/ayu-Terminal-app から zip をダウンロードして `.termial` の拡張子をダブルクリックで反映される

## メモ

### 個別実行方法

```bash
ansible-playbook -i hosts site.yml --tags osx_defaults
ansible-playbook -i hosts site.yml --tags mas
ansible-playbook -i hosts site.yml --tags homebrew
ansible-playbook -i hosts site.yml --tags homebrew_cask
```

### 4k より解像度が低いディスプレイを使う時用

```
# フォントスムージング処理にカラーフリンジを使用しないをオフにする
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

# アンチエイリアシングの強度を調整 0-3
defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

# logoutする
```

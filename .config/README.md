# dotfiles

[yadm](https://yadm.io/)を使ってdotfilesを管理

## Setup

> [!NOTE]
> [yadm bootstrap](https://yadm.io/docs/bootstrap#) を使ってコマンド実行量を減らす

1. Install [Homebrew](https://brew.sh/)
2. Install gh,yadm
  ```sh
  $ brew install gh yadm
  $ gh auth login # chose SSH, other chose yes.
  ```
3. brew bundle --global
4. Reboot
5. Change google-japanese ime
6. Launch essential Application
  - karabiner-elements, Rectangle, Clipy, hammerspoon
  - `defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"`

## Zsh

`/etc/zshenv` に以下を記載する必要がある。

```sh
ZDOTDIR=$HOME/.config/zsh
```

## NeoVim

AstroNvimを利用しており、別リポジトリで管理している。

### Maintenance

```sh
# invoke lazygit
$ yadm enter lazygit
```
---

## Referance

- [Dotfiles の整頓とバージョン管理：XDG Base Directory Specification と YADM の活用ガイド](https://qiita.com/LuckyWindsck/items/ef8ae12a3450344d8902#%E5%AE%9F%E9%9A%9B%E3%81%AB-yadm-%E3%82%92%E8%A9%A6%E3%81%97%E3%81%A6%E3%81%BF%E3%82%88%E3%81%86)

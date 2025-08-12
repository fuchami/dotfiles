# dotfiles

dotfilesは[yadm](https://yadm.io/)を使って管理しています。

## Setup

1. Install [Homebrew](https://brew.sh/)
2. Install gh,yadm
  ```sh
  $ brew install gh yadm
  $ gh auth login # chose SSH, other chose yes.

  $ git clone git@github.com:fuchami/dotfiles.git
  ```
3. exec `yadm bootstrap`
5. Reboot
6. add `etc/zshenv`
  ```etc/zshenv
  ZDOTDIR=$HOME/.config/zsh
  ```
6. Change google-japanese ime
  - 空白を半角に
7. Launch essential Application
  - karabiner-elements, Rectangle, Clipy, hammerspoon

### Maintenance

```sh
# invoke lazygit
$ yadm enter lazygit
```
---

## Referance

- [Dotfiles の整頓とバージョン管理：XDG Base Directory Specification と YADM の活用ガイド](https://qiita.com/LuckyWindsck/items/ef8ae12a3450344d8902#%E5%AE%9F%E9%9A%9B%E3%81%AB-yadm-%E3%82%92%E8%A9%A6%E3%81%97%E3%81%A6%E3%81%BF%E3%82%88%E3%81%86)

# dotfiles

dotfilesは[yadm](https://yadm.io/)を使って管理しています。

## Setup

```sh
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install minima tools (gh, yadm)
brew install gh yadm
gh auth login # chose SSH, other chose yes.
yadm clone --bootstrap git@github.com:fuchami/dotfiles.git
```

### Maintenance

```sh
# invoke lazygit
$ yg 
or
$ yadm enter lazygit
```

---

## Referance

- [Dotfiles の整頓とバージョン管理：XDG Base Directory Specification と YADM の活用ガイド](https://qiita.com/LuckyWindsck/items/ef8ae12a3450344d8902#%E5%AE%9F%E9%9A%9B%E3%81%AB-yadm-%E3%82%92%E8%A9%A6%E3%81%97%E3%81%A6%E3%81%BF%E3%82%88%E3%81%86)


# dotfiles

```bash
$ git clone https://github.com/fuchami/dotfiles ~/dotfiles
$ make
```

---


## その他手動で設定するものたち

### mac setting

- trackpad
  - タップでクリック
  - 軌道の速さ:最速に
  - MissionControl -> 4本指で上スワイプ
  - 3本指ドラッグ有効
- keyboard
  - リピート最速
  - capslock -> control に変更

### Application

- iTerm2
  - General -> Prefereces から/dotfiles/iterm2 のディレクトリを指定
- Rectangle
  - settings/RectangleConfig.json をインポート
- google-japanese-ime
  - settings/keymap.txt をインポート
- Karabiner-elements
  - Exchange semicolon and colon
  - コマンドキー（左右どちらでも）を単体で押した時に、英数・かなをトグルで切り替える(rev2)

### Other

#### chrome extension

- Vimium
- ato-ichinen
- Black Menu

(これも管理したい)

#### zsh pligin

以下をインストール

- Prezto

#### Astronvim
- https://github.com/fuchami/astronvim_config

---

## reference:
- https://dev.classmethod.jp/articles/joined-mac-dotfiles-customize/

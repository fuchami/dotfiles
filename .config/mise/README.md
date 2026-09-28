# mise 設定メモ

このディレクトリは [mise](https://mise.jdx.dev/) のグローバル設定。
**開発ツール（ランタイム・CLI）・brew パッケージ・macOS のシステム設定（defaults）を宣言的に管理**している。

- 設定ファイル（dotfiles）自体の管理は yadm のまま（`~/.config` 以下）
- パッケージ・defaults は「宣言と実機の差分を埋める」形で適用される（冪等・何度実行しても安全）

## ファイル構成

| ファイル               | 役割                                                        |
|------------------------|-------------------------------------------------------------|
| `config.toml`          | エントリポイント + `[tools]`（開発ツールのバージョン管理）  |
| `conf.d/packages.toml` | brew 残留分の宣言（macOS 専用 / mise registry 非対応の formula・cask・taps） |
| `conf.d/macos.toml`    | Dock / Finder / トラックパッドなどの defaults 宣言          |

`conf.d/*.toml` は mise が自動で読み込む（アルファベット順）。

## よく使うコマンド

```sh
# 状態の確認（宣言と実機の乖離を見る。--missing は乖離があれば exit 1）
mise bootstrap status
mise bootstrap status --missing

# 何が行われるか事前確認（dry-run）
mise bootstrap --only packages,macos-defaults --dry-run

# 適用（packages + macOS defaults のみ。dotfiles は触らない）
mise bootstrap --only packages,macos-defaults

# アップデート
mise bootstrap packages upgrade               # 一括更新（auto_updates 系のアプリは自己更新のためスキップ）
mise bootstrap packages upgrade brew:neovim   # 個別更新
mise upgrade                                  # [tools]（ランタイム・CLI 22本）の更新（別系統なので両方回す）
```

## パッケージの増減

```sh
# 追加（conf.d/packages.toml に書き込まれてインストールされる）
mise bootstrap packages use brew:ripgrep --path ~/.config/mise/conf.d/packages.toml
mise bootstrap packages use brew-cask:firefox --path ~/.config/mise/conf.d/packages.toml

# 削除（宣言から外したら、未宣言パッケージを掃除）
# ※ まず --dry-run で確認すること
mise bootstrap packages prune --manager brew --dry-run

# 一覧・状態確認
mise bootstrap packages status
```

直接 `conf.d/packages.toml` を編集してから `mise bootstrap --only packages` でも同じ。

## macOS defaults の変更

1. `conf.d/macos.toml` を編集（キーは https://macos-defaults.com/ で調べる）
2. 適用・確認

```sh
mise bootstrap macos defaults apply --dry-run
mise bootstrap macos defaults apply
mise bootstrap macos defaults status
```

適用後、Dock/Finder は反映まで再起動が必要（`post-defaults` hook で `killall Dock` は自動実行される）。

## 開発ツール（`[tools]`）の管理

開発ランタイム・CLI ツールは brew と別に mise がバージョン管理する（Linux サーバでも `mise install` だけで同じ構成が再現できる）。

```sh
mise use -g ruby@3     # グローバルに導入（config.toml の [tools] に追記される）
mise ls                # 導入済みツールの一覧
mise upgrade           # 全ツールを更新
```

現在の構成（22本）:

| カテゴリ | ツール |
|---|---|
| ランタイム | `ruby@3` `deno@2` `node@26` `go@1` `uv` |
| コア CLI | `bat` `fd` `fzf` `jq` `lsd` `ripgrep` |
| shell | `sheldon` `zoxide` `oh-my-posh` |
| dev tools | `delta` `gh` `ghq` `task` `lazygit` `neovim` |
| TUI | `yazi` `herdr` |

※ `latest` 指定でも `mise.lock` に解決済みバージョンが記録されるため再現性は確保される。

### brew からの移行（完了）

2026-09 に CLI ツール21本を brew → mise へ移行した（経緯は `migrate-guide.md`）。
`conf.d/packages.toml` には macOS 専用 / mise registry 非対応のもの（`git` `tree` `wget` `mosh` `imagemagick` `poppler` `yadm` `nb` `opencode-v2` 等）のみを残す。
Linux サーバでは `mise install` のみで `[tools]` が揃う（`git` 等は distro のパッケージマネージャで入れる）。

## 新マシンのセットアップ

```sh
# Homebrew と mise を導入後
yadm clone git@github.com:fuchami/dotfiles.git
yadm bootstrap   # 内部で mise bootstrap --only packages,macos-defaults --yes を実行
mise install     # [tools]（22本）も入れる（--only 対象外のため個別実行）
```

※ `xwmx/taps/nb` は mise が tap formula を解決できず bootstrap が失敗することがある（2026.9.12 時点）。
   その場合は `brew install xwmx/taps/nb` を別途実行する。

## 新マシンでの手動設定（自動化できないもの）

`mise bootstrap` では再現できない設定。初回セットアップ後に手動で行う。

- **Apple ID / iCloud**: サインイン、iCloud Drive の有効化（Finder の iCloud 連携もこれに依存）
- **TCC 権限**（初回起動時のダイアログで許可）
  - 画面収録: Raycast / terminal-browser など
  - アクセシビリティ: Karabiner-Elements / AeroSpace
  - フルディスクアクセス: 必要な開発ツール
- **キーボード**: 入力ソースに Google日本語入力を追加（システム設定 > キーボード > 入力ソース）。キーボード配列は ABC
- **Bluetooth**: トラックパッド / キーボード / マウスのペアリング
- **npm グローバルパッケージ**: mise の node 配下に `npm i -g @mariozechner/claude-bridge @mermaid-js/mermaid-cli neovim @switchbot/homebridge-switchbot homebridge-tplink-smarthome`
- **その他**: Wi-Fi、壁紙、Dock に並べるアプリ、アカウント系アプリのサインイン（Slack / Spotify / LINE / Google Drive など）

## 注意事項

- 公式ドキュメント: https://mise.jdx.dev/bootstrap.html （packages / defaults のリファレンスもリンク先）

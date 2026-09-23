# mise 設定メモ

このディレクトリは [mise](https://mise.jdx.dev/) のグローバル設定。
**brew パッケージと macOS のシステム設定（defaults）を宣言的に管理**している。

- 設定ファイル（dotfiles）自体の管理は yadm のまま（`~/.config` 以下）
- パッケージ・defaults は「宣言と実機の差分を埋める」形で適用される（冪等・何度実行しても安全）

## ファイル構成

| ファイル | 役割 |
|---|---|
| `config.toml` | エントリポイント（内容の説明のみ） |
| `conf.d/packages.toml` | brew formula / cask / taps の宣言 |
| `conf.d/macos.toml` | Dock / Finder / トラックパッドなどの defaults 宣言 |

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
```

## パッケージの増減

```sh
# 追加（conf.d/packages.toml に書き込まれてインストールされる）
mise bootstrap packages use brew:ripgrep
mise bootstrap packages use brew-cask:firefox

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

## 新マシンのセットアップ

```sh
# Homebrew と mise を導入後
yadm clone git@github.com:fuchami/dotfiles.git
yadm bootstrap   # 内部で mise bootstrap --only packages,macos-defaults --yes を実行
```

## 注意事項

- **AeroSpace は未宣言**（`conf.d/packages.toml` の TODO 参照）
  tap 配信 cask の評価に Ruby 3+ が必要で、システム ruby（2.6）では不可のため保留中。
  ruby3 導入後（例: `mise use -g ruby@3`）にコメントアウトを外して有効化する
- **brew services は管理外**（borders / herdr / mactop / ollama）。mise は `brew services` 非対応なので、サービス管理は引き続き brew 側
- 公式ドキュメント: https://mise.jdx.dev/bootstrap.html （packages / defaults のリファレンスもリンク先）

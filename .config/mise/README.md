# mise 設定メモ

このディレクトリは [mise](https://mise.jdx.dev/) のグローバル設定。
**開発ツール（ランタイム・CLI）・brew パッケージ・macOS のシステム設定（defaults）を宣言的に管理**している。


## ファイル構成

| ファイル               | 役割                                                        |
|------------------------|-------------------------------------------------------------|
| `config.toml`          | エントリポイント + `[tools]`（開発ツールのバージョン管理）  |
| `conf.d/packages.toml` | brew 残留分の宣言（macOS 専用 / mise registry 非対応の formula・cask・taps） |
| `conf.d/macos.toml`    | Dock / Finder / トラックパッドなどの defaults 宣言          |


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
mise bootstrap packages upgrade brew:wget     # 個別更新
mise upgrade                                  # [tools] の更新（別系統なので両方回す）
```

## パッケージの増減

```sh
# 追加（conf.d/packages.toml に書き込まれてインストールされる）
mise bootstrap packages use brew:mosh --path ~/.config/mise/conf.d/packages.toml
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

ランタイム・CLI ツールは mise がバージョン管理する。Linux サーバでも `mise install` だけで同じ構成が揃う
（`conf.d/packages.toml` は macOS 専用 / mise registry 非対応のみ。Linux では `git` 等は distro のパッケージマネージャで入れる）。

```sh
mise use -g <tool>      # 追加（config.toml の [tools] に記録される）
mise install --dry-run  # 入る予定の確認
mise upgrade            # 全ツールを更新
```

`latest` 指定でも `mise.lock` に解決済みバージョンが記録されるため再現性は確保される。

### 注意

- `xwmx/taps/nb` は mise が tap formula を解決できず bootstrap が失敗することがある（2026.9.12 時点）。
  その場合は `brew install xwmx/taps/nb` を別途実行する
- `opencode` は `[tools]` に追加しない（mise registry 版は v1 系しか取れず、現行 v2 にダウングレードされる）

## 注意事項

- 公式ドキュメント: https://mise.jdx.dev/bootstrap.html （packages / defaults のリファレンスもリンク先）

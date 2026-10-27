# mise

[mise](https://mise.jdx.dev/) のグローバル設定。開発ツール・brew パッケージ・macOS defaults を宣言的に管理する。

## ファイル構成

| ファイル | 役割 |
|---|---|
| `config.toml` | エントリポイント + `[tools]`（開発ツールのバージョン） |
| `conf.d/packages.toml` | brew パッケージ（macOS 専用・mise registry 非対応分） |
| `conf.d/macos.toml` | Dock / Finder / トラックパッドなどの defaults |

## 開発ツール（`[tools]`）

`config.toml` の `[tools]` を編集して管理する。

```sh
mise install --dry-run  # 入る予定の確認
mise upgrade            # 全ツールを更新
```

`latest` 指定でも `mise.lock` に解決済みバージョンが記録されるので、再現性は確保される。

## brew package

追加・削除は `conf.d/packages.toml` を編集してから適用する。

```sh
# 削除（宣言から外したら、未宣言パッケージを掃除）
# ※ まず --dry-run で確認すること
mise bootstrap packages prune --manager brew --dry-run

# 適用
mise bootstrap --only packages --dry-run
mise bootstrap --only packages

# アップデート
mise bootstrap packages upgrade               # 一括更新（auto_updates 系のアプリは自己更新のためスキップ）
mise bootstrap packages upgrade brew:wget     # 個別更新

# 一覧・状態確認
mise bootstrap packages status
```

## macOS defaults

`conf.d/macos.toml` を編集して適用する。

```sh
mise bootstrap macos defaults apply --dry-run
mise bootstrap macos defaults apply
mise bootstrap macos defaults status
```

- キーは https://macos-defaults.com/ で確認
- Dock/Finder は再起動が必要。`killall Dock` は `post-defaults` hook で自動実行される

## 一括適用

```sh
# 状態の確認（宣言と実機の乖離を見る。--missing は乖離があれば exit 1）
mise bootstrap status
mise bootstrap status --missing

# 適用（packages + macOS defaults のみ。dotfiles は触らない）
mise bootstrap --only packages,macos-defaults
```

## 注意

- `opencode` は `[tools]` に入れない（registry 版は v1 系しか取れず、現行 v2 にダウングレードされるため）。
- 公式ドキュメント: https://mise.jdx.dev/bootstrap.html

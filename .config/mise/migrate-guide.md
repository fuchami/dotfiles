# brew bootstrap.packages → mise [tools] 移行ガイド

作成日: 2026-09-28

## 目的

`[bootstrap.packages]`（brew ベース）で管理している CLI ツール・ランタイムのうち、
mise `[tools]` で管理できるものを移行し、**Linux サーバでも同じ構成を `mise install` だけで再現できる**ようにする。

- brew に残すのは「macOS 専用のもの」「mise registry に存在しないもの」のみ
- `[bootstrap.macos.*]`（defaults）は今回の対象外。そのまま維持

## 現状（移行前の調査結果）

| 設定ファイル | 内容 |
|---|---|
| `config.toml` | `[tools]` は ruby@3 のみ |
| `conf.d/packages.toml` | brew formula 35本 + brew-cask 13本 + taps 4件 |
| `conf.d/macos.toml` | macOS defaults（対象外） |

移行に有利な点（確認済み）:

- **PATH は `~/.local/share/mise/shims` が `/opt/homebrew/bin` より前** → mise 版が優先されるので、brew と併存させながら段階的に切替可能
- **zshrc はコマンド名呼びのみ**（`eval "$(sheldon source)"` など、`/opt/homebrew` 直書きなし）→ シェル設定の修正は不要
- `brew uses --installed node` は空、`brew deps yazi` も空 → brew 側アンインストール時の依存破壊なし

## 分類

### A. mise `[tools]` に移行する（21本）

すべて aqua/core バックエンドで Linux バイナリ配布あり。

| カテゴリ | mise での名前 | バックエンド | brew での名前（異なる場合） |
|---|---|---|---|
| ランタイム | `deno` | core | |
| | `node` | core | |
| | `go` | core | |
| | `uv` | aqua:astral-sh/uv | |
| コア CLI | `bat` | aqua:sharkdp/bat | |
| | `fd` | aqua:sharkdp/fd | |
| | `fzf` | aqua:junegunn/fzf | |
| | `jq` | aqua:jqlang/jq | |
| | `lsd` | aqua:lsd-rs/lsd | |
| | `ripgrep` | aqua:BurntSushi/ripgrep | |
| shell | `sheldon` | aqua:rossmacarthur/sheldon | |
| | `zoxide` | aqua:ajeetdsouza/zoxide | |
| | `oh-my-posh` | aqua:JanDeDobbeleer/oh-my-posh | jandedobbeleer/oh-my-posh/oh-my-posh |
| dev tools | `delta` | aqua:dandavison/delta | git-delta |
| | `gh` | aqua:cli/cli | |
| | `ghq` | aqua:x-motemen/ghq | |
| | `task` | aqua:go-task/task | go-task |
| | `lazygit` | aqua:jesseduffield/lazygit | |
| | `neovim` | aqua:neovim/neovim | |
| TUI | `yazi` | aqua:sxyazi/yazi | |
| | `herdr` | aqua:herdrdev/herdr | |

### B. brew に残す

| 理由 | ツール |
|---|---|
| macOS 専用 | `bash`（macOS の bash 3.2 対策）、`mactop`、`felixkratz/formulae/borders`、cask 全13本 |
| mise registry になし | `git`（asdf でソースビルドのみ・非現実的）、`tree`、`wget`、`mosh`、`imagemagick`、`poppler`（conda のみ or ビルド重い）、`pkgconf`（ビルドヘルパー） |
| 判断の結果残留 | `anomalyco/tap/opencode-v2`、`ollama`、`hyfetch`、`xwmx/taps/nb`、`luarocks`、`xdg-ninja` |
| 新規追加（prune 対策） | **`yadm`** — brew ではインストール済みだが未宣言で、現状でも `prune` を実行すると消される危険がある |

Linux では `git`/`tree`/`wget`/`mosh`/`imagemagick`/`poppler` は distro のパッケージマネージャ（apt/dnf）で入れる。

### C. トラップ・注意点

1. **opencode【重要】**: mise registry の `opencode`（aqua:anomalyco/opencode）は GitHub Releases ベースで **v1系（1.18.x）しか取れない**。現行の v2.0.18 は `opencode.ai/files/bin/` 配布の別系統。`mise use -g opencode` すると **v1 にダウングレードされる** ので絶対にやらない。→ brew 残留（tap formula は Linux 対応済みだが、Linux では公式 install script を使う運用とする）
2. **npm グローバルパッケージ 6個** が brew node 配下にある → mise node 移行時に再インストールが必要:
   - `@mariozechner/claude-bridge`
   - `@mermaid-js/mermaid-cli`
   - `@switchbot/homebridge-switchbot`
   - `homebridge-tplink-smarthome`
   - `neovim`
   - `npm`
3. **ollama**: aqua 版は CLI バイナリのみ（`ollama serve` は手動起動）。macOS では brew で残す判断済み。
4. **taps 整理**: `jandedobbeleer/oh-my-posh` は不要になるので削除。`xwmx/taps`（nb）、`anomalyco/tap`（opencode-v2）、`felixkratz/formulae`（borders）は残す。
5. **prune は必ず `--dry-run` で確認**してから実行する。

## 移行後の構成

### `config.toml` の `[tools]`（22本: ruby + 移行21本）

```toml
[tools]
ruby = "3"
# --- runtimes ---
deno = "2"
node = "26"
go = "1"
uv = "latest"
# --- core CLI ---
bat = "latest"
fd = "latest"
fzf = "latest"
jq = "latest"
lsd = "latest"
ripgrep = "latest"
# --- shell ---
sheldon = "latest"
zoxide = "latest"
oh-my-posh = "latest"
# --- dev tools ---
delta = "latest"
gh = "latest"
ghq = "latest"
task = "latest"
lazygit = "latest"
neovim = "latest"
# --- TUI ---
yazi = "latest"
herdr = "latest"
```

※ `latest` 指定でも `mise.lock` に解決済みバージョンが記録されるため再現性は確保される。

### `conf.d/packages.toml`（brew 残留分）

- taps: `anomalyco/tap`、`felixkratz/formulae`、`xwmx/taps`
- formula: `yadm` `bash` `tree` `wget` `xdg-ninja` `hyfetch` `luarocks` `pkgconf` `git` `mosh` `imagemagick` `poppler` `ollama` `mactop` `xwmx/taps/nb` `anomalyco/tap/opencode-v2` `felixkratz/formulae/borders`
- cask: 現行13本そのまま

## 実行手順

```sh
# 1. mise 側に追加（PATH は shims 優先のため即切替。brew 版は残ったまま併存）
mise use -g bat fd fzf jq lsd ripgrep sheldon zoxide oh-my-posh \
  delta gh ghq task lazygit neovim yazi herdr \
  deno@2 node@26 go@1 uv

# 2. 検証（shims 経由になっていること）
mise ls
which bat node delta task    # ~/.local/share/mise/shims/ を指すこと
node --version && go version && nvim --version | head -1

# 3. npm グローバルパッケージを mise node 配下に再インストール
npm i -g @mariozechner/claude-bridge @mermaid-js/mermaid-cli neovim \
  @switchbot/homebridge-switchbot homebridge-tplink-smarthome

# 4. 動作確認（数日併用推奨）後、packages.toml を編集:
#    - 移行21本の brew 宣言を削除
#    - yadm の宣言を追加
#    - jandedobbeleer/oh-my-posh の tap 宣言を削除

# 5. brew 側を掃除（必ず dry-run で確認してから）
mise bootstrap packages prune --manager brew --dry-run
mise bootstrap packages prune --manager brew

# 6. 最終確認
mise bootstrap status --missing   # 乖離なしで exit 0 になること

# 7. README.md を新構成に更新（コマンド例・ファイル構成表・新マシン手順）
```

## Linux サーバでの運用（移行後）

- dotfiles clone → `mise install` のみで `[tools]` の22本が入る（brew 不要）
- `mise bootstrap --only packages` は macOS 専用ステップになるので、yadm bootstrap を OS 分岐させる（Linux では `mise install` のみ）
- `git`/`tree`/`wget`/`mosh`/`imagemagick`/`poppler` は apt/dnf で個別インストール

## チェックリスト

- [x] `mise use -g` で 21本追加（2026-09-28 実施）
- [x] `mise install` 成功、`mise ls` で全バージョン表示
- [x] `which` で shims 経由を確認
- [x] npm グローバルパッケージ再インストール
- [x] packages.toml 編集（21本削除 / yadm 追加 / tap 整理）（2026-09-29 実施）
- [x] `prune --dry-run` → 確認 → 実行（53 formulae 削除）
- [x] `mise bootstrap status --missing` — packages 29件 / tools 22件すべて installed（macos defaults の既存乖離1件のみ・移行と無関係）
- [x] README.md 更新
- [x] このガイドは履歴として保持

## 実施結果（2026-09-29 完了）

- `conf.d/packages.toml`: 移行21本の宣言を削除、`brew:yadm` を追加、`jandedobbeleer/oh-my-posh` の tap を削除
- `mise bootstrap packages prune --manager brew`: formula 53本を削除（移行21本 + nb / node / neovim の依存パッケージ群）
- `xwmx/taps/nb` は mise（2026.9.12）が tap formula を解決できず prune / install とも失敗 → nb 宣言のみ一時コメントアウトして prune を実行し、後で復元。nb 本体は `brew install xwmx/taps/nb` で復帰
- `deno` / `gh` / `herdr` は brew 側の旧バージョンが prune で残ったため `brew uninstall` で直接削除
- 検証: 全パッケージ・全22ツールが `installed`、主要コマンドは shims / 正常動作を確認
- mise（2026.9.12）のバグ: `xwmx/taps/nb` は API メタデータ不在（404）のため tap formula を解決できず、`prune` / `bootstrap --only packages` がいずれも失敗する。nb を宣言から外せば回避可能（今回は一時コメントアウトで対応）。将来の mise 更新で修正確認のこと

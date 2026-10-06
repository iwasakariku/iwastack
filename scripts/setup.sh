#!/usr/bin/env bash
# iwastack セットアップスクリプト (Bash)
# 使い方:
#   ./scripts/setup.sh /path/to/my-new-repo   # プロジェクトにインストール
#   ./scripts/setup.sh --global               # グローバルにインストール

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
AGENTS_SRC="$REPO_ROOT/.agents"
TEMPLATES_SRC="$REPO_ROOT/templates"

if [ "${1:-}" = "--global" ]; then
    GLOBAL_DIR="$HOME/.gemini/config"
    mkdir -p "$GLOBAL_DIR/agents" "$GLOBAL_DIR/skills"
    echo "[iwastack] グローバル環境 (~/.gemini/config) にインストールしています..."
    cp -r "$AGENTS_SRC/agents/"* "$GLOBAL_DIR/agents/"
    cp -r "$AGENTS_SRC/skills/"* "$GLOBAL_DIR/skills/"
    echo "[iwastack] グローバルインストールが完了しました！"
    exit 0
fi

TARGET_DIR="${1:-.}"
mkdir -p "$TARGET_DIR/.agents"

echo "[iwastack] プロジェクトへのインストールを開始します: $TARGET_DIR"
cp -r "$AGENTS_SRC/"* "$TARGET_DIR/.agents/"

if [ ! -f "$TARGET_DIR/AGENTS.md" ]; then
    cp "$TEMPLATES_SRC/AGENTS.md" "$TARGET_DIR/AGENTS.md"
    echo "  + AGENTS.md テンプレートを作成しました"
else
    echo "  ! 既存の AGENTS.md が存在するためスキップしました"
fi

echo "[iwastack] インストールが完了しました！"

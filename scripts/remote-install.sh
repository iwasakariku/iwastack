#!/usr/bin/env bash
# iwastack Remote Installer (Bash)
# 使い方:
#   curl -fsSL https://raw.githubusercontent.com/iwasakariku/iwastack/main/scripts/remote-install.sh | bash

set -euo pipefail

REPO_OWNER="iwasakariku"
REPO_NAME="iwastack"
BRANCH="main"
RAW_BASE="https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/$BRANCH"

echo "=========================================="
echo "  iwastack Remote Installer (No-clone)   "
echo "=========================================="

TARGET_DIR="$(pwd)"
echo "[iwastack] インストール先: $TARGET_DIR"

AGENTS_DIR="$TARGET_DIR/.agents/agents"
SKILLS_DIR="$TARGET_DIR/.agents/skills"

mkdir -p \
  "$AGENTS_DIR" \
  "$SKILLS_DIR/iwasaka-greenfield" \
  "$SKILLS_DIR/iwasaka-fullcycle" \
  "$SKILLS_DIR/iwasaka-plan-gate" \
  "$SKILLS_DIR/iwasaka-adversarial-review" \
  "$SKILLS_DIR/iwasaka-investigation" \
  "$SKILLS_DIR/iwasaka-ship-gate"

FILES=(
  ".agents/agents/iwasaka-persona.md"
  ".agents/agents/iwasaka-product.md"
  ".agents/agents/iwasaka-scout.md"
  ".agents/agents/iwasaka-refuter.md"
  ".agents/agents/iwasaka-reviewer.md"
  ".agents/agents/iwasaka-red-tester.md"
  ".agents/skills/iwasaka-greenfield/SKILL.md"
  ".agents/skills/iwasaka-fullcycle/SKILL.md"
  ".agents/skills/iwasaka-plan-gate/SKILL.md"
  ".agents/skills/iwasaka-adversarial-review/SKILL.md"
  ".agents/skills/iwasaka-investigation/SKILL.md"
  ".agents/skills/iwasaka-ship-gate/SKILL.md"
)

for file in "${FILES[@]}"; do
  echo "  ⬇️ ダウンロード中: $file"
  curl -fsSL "$RAW_BASE/$file" -o "$TARGET_DIR/$file"
done

if [ ! -f "$TARGET_DIR/AGENTS.md" ]; then
  echo "  ⬇️ ダウンロード中: AGENTS.md"
  curl -fsSL "$RAW_BASE/templates/AGENTS.md" -o "$TARGET_DIR/AGENTS.md"
else
  echo "  ! 既存の AGENTS.md が存在するためスキップ"
fi

echo ""
echo "🎉 [iwastack] インストールが完了しました！"

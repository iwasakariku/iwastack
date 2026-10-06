# iwastack 導入・運用ガイド (Adoption Guide)

新リポジトリでの利用方法、**グリーンフィールド（新規開発）** と **ブラウンフィールド（既存開発）** の使い分け、および **gstack との比較と補強点** について解説します。

---

## 1. 新しいリポジトリへの導入方法

iwastack を別プロジェクトで利用する方法は主に2つあります。

### 方法 A: プロジェクトへの同梱（推奨: チーム共有・CI連携）
リポジトリ直下に `.agents/` と `AGENTS.md` を配置し、プロジェクトのコード規約・エージェント設定としてGit管理します。

```powershell
# iwastack ディレクトリから対象リポジトリへコピー
.\scripts\setup.ps1 -TargetPath C:\Users\rikut\develop\my-new-project
```

```bash
# または Git Submodule / 手動コピー
cp -r /path/to/iwastack/.agents /path/to/my-new-project/.agents
cp /path/to/iwastack/templates/AGENTS.md /path/to/my-new-project/AGENTS.md
```

### 方法 B: グローバル環境への登録（個人環境で全プロジェクト共通化）
PC内のすべてのプロジェクトで `iwasaka-*` サブエージェントやスキルを利用可能にします。

```powershell
.\scripts\setup.ps1 -Global
```
> `~/.gemini/config/agents/` および `~/.gemini/config/skills/` にインストールされます。どのリポジトリを Antigravity で開いても即座に利用可能になります。

---

## 2. グリーンフィールド vs ブラウンフィールドの使い分け

プロジェクトの成熟度に応じて、重視すべき原則と呼び出すスキルが異なります。

| 観点 | グリーンフィールド (新規開発 0→1) | ブラウンフィールド (既存リポジトリ 1→10) |
|---|---|---|
| **最優先目標** | **①LPで需要を実測 ➔ ②インフラからフロントまで一気通貫で実動確認** | **既存の振る舞い・契約を絶対に壊さない** (デグレ防止) |
| **主軸スキル** | [**`iwasaka-greenfield`**](../.agents/skills/iwasaka-greenfield/SKILL.md) ➔ `iwasaka-fullcycle` | [**`iwasaka-investigation`**](../.agents/skills/iwasaka-investigation/SKILL.md) ➔ `iwasaka-fullcycle` |
| **主軸エージェント** | `iwasaka-product` (LP企画・UX・最重要垂直シナリオ)<br>`iwasaka-persona` (司令塔) | `iwasaka-scout` (既存調査)<br>`iwasaka-refuter` (反証)<br>`iwasaka-reviewer` (3レンズ) |
| **第0ステップ** | **【LP先行公開】**<br>ペラ1枚HTMLを即日公開し、Fake Door (CTR 5%以上 & Waitlist) で需要を実測。 | **【現状と影響の棚卸し】**<br>読み取り専用で呼び出し経路、依存関係、認証手順を網羅調査。 |
| **第1ステップ** | **【一気通貫ウォーキングスケルトン】**<br>インフラ〜DB〜API〜フロントの全層を貫く最小垂直スライスを実デプロイし実動確認。 | **【REDテスト固定】**<br>製品コードは触らず、仕様や不具合を再現する失敗テストをロック。 |
| **設計の姿勢** | **YAGNI・シンプルさ最優先**。<br>150行なら1ファイル、過剰な抽象化を避ける。 | **既存踏襲・契約完全不変**。<br>既存パターンを徹底模倣、API/DTO契約を厳守。 |
| **変更の分離** | 完璧な多層構造を最初から作らず、動く1本を先行。 | **「構造移動」と「挙動変更」を絶対に混ぜない**。 |
| **人間ゲート** | ①「LP需要合格」 ➔ ②「一気通貫デプロイ疎通OK」 | ①「計画OK」 ➔ ②「スモークOK」 ➔ ③「PRして」 |


---

## 3. gstack との比較と補強ポイント

### gstack (YC Garry Tan) の特徴
- **強み**: 0→1の創業者/ソロ開発者向け。CEO（製品ビジョン）、Designer（UI/UX）、QA Lead（ブラウザ自動化）など役割がプロダクト企画寄りで分かりやすい。
- **弱み**: プロンプト指示中心であり、泥臭いエンタープライズのマルチテナント境界、大規模リファクタ、本番バグの根本原因究明、実測による厳格な反証ステップが手薄。

### iwastack による補強と差分

```
┌────────────────────────────────────────────────────────┐
│                   gstack (プロダクト構想寄り)            │
│  [CEO] ───> [Designer] ───> [Eng Manager] ───> [Build] │
└───────────────────────────┬────────────────────────────┘
                            │
                            ▼ 以下の泥臭い現場の守りを iwastack で補強
┌────────────────────────────────────────────────────────┐
│                   iwastack (現場・実装・実測の守り)       │
│  ・ iwasaka-product (非目標の徹底切り捨て & UXモデル化) │
│  ・ iwasaka-scout (読み取り専用で既存コード徹底調査)      │
│  ・ iwasaka-refuter (「否決前提」の敵対的反証)          │
│  ・ iwasaka-red-tester (製品コード触らず失敗テストロック) │
│  ・ iwasaka-reviewer (正しさ / 認可 / API契約の3レンズ)   │
│  ・ 人間ゲート厳守 (「計画OK」と「実機スモーク」を渡さない)│
└────────────────────────────────────────────────────────┘
```

1. **プロダクト構想の補強 (`iwasaka-product`)**:
   - gstack の CEO/Designer の良さを取り込みつつ、iwastack 流に「非目標（Out of Scope）の事前宣言」「体感価値の8割を生む2割の機能に絞る (YAGNI)」を徹底。
2. **「AIを信じない」仕組みの補強 (`iwasaka-refuter`)**:
   - gstack が前進（Build）を重視するのに対し、iwastack は「成果物を壊しにいく反証専任」を常設。
3. **契約の破壊防止 (`iwasaka-reviewer`)**:
   - 単なるコードレビューではなく、「認可・テナント境界」「API契約チェーン」のレンズを固定化。
4. **TDDの厳格化 (`iwasaka-red-tester`)**:
   - 製品コードを一切触らせない専用テスターにより、「偽緑（最初から通ってしまう無意味なテスト）」を物理的に排除。

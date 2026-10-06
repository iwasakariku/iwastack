# iwastack

> **Mind as Code** — 860超のAIコーディングセッションから蒸留した開発原則・行動パターンと、Google Antigravity向けカスタムサブエージェント＆スキルの開発スタック。

---

## 概要

`iwastack` は、実際の開発現場で検証された「実測主義（Evidence over claims）」「スコープ厳格制御」「人間ゲートの維持」「敵対的検証」をコードおよび設定として体系化したスタックです。

- **AIに丸投げしない**: 不可逆な操作や意思決定は人間が握り、AIには「調査・実装・独立レビュー・反証」を委任する。
- **AIに壊させてから信じる**: 成果物は「否決前提」で読み、前提の崩れや実測との乖離を機械的に突く。
- **仕組みで再発防止する**: 人間の注意ではなく、型・lint・テスト・フックで品質を担保する。

---

## ディレクトリ構成

```text
iwastack/
├── .agents/
│   ├── agents/          # Antigravity カスタムサブエージェント定義
│   │   ├── iwasaka-persona.md      # 司令塔・全行動原則を体現したペルソナ
│   │   ├── iwasaka-product.md      # プロダクト構想・UXモデル・MVP定義 (0→1)
│   │   ├── iwasaka-scout.md        # 読み取り専用偵察エージェント
│   │   ├── iwasaka-refuter.md      # 否決前提の敵対的反証エージェント
│   │   ├── iwasaka-reviewer.md     # 3レンズ独立レビュアー
│   │   └── iwasaka-red-tester.md   # 製品コードを触らないRED専任テスター
│   │
│   └── skills/          # Antigravity ワークスペーススキル
│       ├── iwasaka-greenfield/     # 新規立ち上げ・骨組み先行 (Walking Skeleton)
│       ├── iwasaka-fullcycle/      # チケット駆動フルサイクル開発手順
│       ├── iwasaka-plan-gate/      # 計画書・質問ファイル・受入基準契約
│       ├── iwasaka-adversarial-review/ # 敵対的検証・反証手順
│       ├── iwasaka-investigation/  # 障害対応・根本原因究明・ログ調査
│       └── iwasaka-ship-gate/      # 出荷ゲート・PR・Done記録
│
├── docs/                # 運用・導入ガイド
│   └── adoption-guide.md           # グリーンフィールド vs ブラウンフィールド使い分けガイド
├── scripts/             # セットアップスクリプト
│   ├── setup.ps1                   # PowerShell インストーラー (ローカル / グローバル)
│   └── setup.sh                    # Bash インストーラー
├── templates/           # プロジェクトテンプレート
│   └── AGENTS.md                   # 新規プロジェクト用ルール定義
└── iwasaka-brain/       # 蒸留された知識ベース (Mind as Code 全50ファイル)
    ├── profile/         # 役割、AIツールスタック、活動リズム
    ├── domains/         # 領域別ナラティブ（データ基盤、WMS、機器連携など）
    ├── patterns/        # 行動の型（調査、計画、レビュー、スモーク、チケットフロー）
    ├── principles/      # 判断原則（実測主義、スコープ制御、マルチテナント安全など）
    ├── prompts/         # 場面別の依頼テンプレート
    ├── faq/             # 想定問答集
    └── timeline/        # 月次ナラティブ (2026-06〜10)
```

---

## 提供するサブエージェント（`.agents/agents/`）

| エージェント | 種別 | 主な役割 |
|---|---|---|
| **`iwasaka-persona`** | 司令塔 / メイン | 実測主義、人間ゲート厳守、スコープ制御を貫き、サブエージェントを指揮してタスクを完遂する。メインとしても利用可能。 |
| **`iwasaka-product`** | 構想 / 仕様 | プロダクト構想・UXモデル設計・MVP定義。非目標（Out of Scope）を明確にし、8割の価値を生む2割のコア機能に集中。 |
| **`iwasaka-scout`** | 読み取り専用 | 実装前のコード経路・既存パターン・チケット文脈・ローカル認証手順を網羅調査。 |
| **`iwasaka-refuter`** | 読み取り専用 | 計画書やPRを「否決前提」で読み、前提の崩れや主張と実コード・実測の乖離を暴く。良い点は書かない。 |
| **`iwasaka-reviewer`** | 読み取り専用 | 「正しさ」「認可・テナント境界」「API契約」の3レンズで客観的に検査し、`must-fix / optional / スコープ外` に分類。 |
| **`iwasaka-red-tester`** | テスト専任 | 製品コードには一切手を触れず、仕様の穴・境界値・異常系を突く失敗テスト（RED）のみを作成・ロック。 |

---

## 提供するスキル（`.agents/skills/`）

| スキル | 概要 |
|---|---|
| **`iwasaka-greenfield`** | **【新規開発用】** 要件定義 → 技術選定 → 骨組み先行 (Walking Skeleton) → 人間ゲート「骨組みOK」 → 初期CI構築。 |
| **`iwasaka-fullcycle`** | **【実装標準】** 偵察 → 質問ファイル（yes/no） → 計画書 ＆ 反証 → 人間ゲート「計画OK」 → REDテスト作成・ロック → GREEN実装 → 独立レビュー2巡 → スモーク → PR作成 → Done記録 |
| **`iwasaka-plan-gate`** | 調査先行、非目標の明示、DoD策定、質問ファイル（yes/no形式）の作成、承認ゲート「計画OK」「骨組みOK」の運用。 |
| **`iwasaka-adversarial-review`** | 5大原則（良い点は書かない、一次情報裏取り、確信のない指摘は出さない、深刻度と確度、読み取り専用）による反証手順。 |
| **`iwasaka-investigation`** | 生ログからの障害トリアージ、初発/再発切り分け、直前変更との因果検証、「どこに実装ある？」経路追跡、対症療法拒否。 |
| **`iwasaka-ship-gate`** | 出荷ゲート（型・テスト・lint・DI起動スモーク全緑）、merge commit必須のPR作成、定型クローズ記録（実施内容・採らなかった案・未決・残作業）。 |

---

## 新しいリポジトリでの利用・導入方法

詳細な実践運用マトリクスは [**導入・運用ガイド (`docs/adoption-guide.md`)**](./docs/adoption-guide.md) をご覧ください。

### 1. プロジェクトへの導入（推奨）
対象プロジェクトに `.agents/` とルール定義 `AGENTS.md` をインストールします：
```powershell
.\scripts\setup.ps1 -TargetPath C:\path\to\your-project
```

### 2. グローバル環境への登録
全プロジェクトで共通して `iwastack` を使いたい場合：
```powershell
.\scripts\setup.ps1 -Global
```

---

## 機密ポリシー

本リポジトリに含まれるナレッジおよび設定ファイルは、固有名詞（顧客名、取引先名、社内システム名、個人名、アカウント、IP、URL、トークンなど）をすべて除去・抽象化済みです。安心してオープンソース開発や個人開発のベースとしてご利用いただけます。

---

## ライセンス

[MIT License](./LICENSE) © 2026 iwasakariku



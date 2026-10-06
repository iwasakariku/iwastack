---
title: iwasaka-brain 索引（MOC）
type: moc
tags: [iwasaka-brain, moc]
generated: 2026-10-06
---

> [!summary] TL;DR
> 50 ファイルの入口。「誰か（人物像）→ 何を（領域・歩み）→ どう動くか（型）→ 何を基準に（原則）→ どう頼むか（依頼文）→ どう答えるか（FAQ）」の順に並べてある。
> 初見なら profile → principles/evidence-over-claims → patterns/how-i-ask の 3 本で輪郭がつかめる。

## 1. 人物像（profile）

- [[iwasaka-brain/profile/role-and-domains|役割と担当領域の実像]] — データ基盤 91%。立ち位置は「司令塔兼検収者」。手放さない人間ゲートの一覧
- [[iwasaka-brain/profile/work-rhythm|活動リズム]] — 曜日・時刻帯・月別の傾向と、時刻帯ごとの行動タイプの移り変わり
- [[iwasaka-brain/profile/ai-tooling-stack|AI の使い方の全体像]] — Claude Code と Cursor の使い分け、サブエージェント・スキル・MCP、任せる／自分で持つの線引き

## 2. 領域と歩み（domains / timeline）

領域別:
- [[iwasaka-brain/domains/data-platform|データ基盤]] — 構造→境界→商売→引き継ぎの 5 か月。最大領域
- [[iwasaka-brain/domains/wms|倉庫管理システム]] — 本番障害対応と帳票・環境差分
- [[iwasaka-brain/domains/device-proxy|機器連携プロキシ]] — ソケット通信・電文・疎通テスト
- [[iwasaka-brain/domains/ai-agent-infra|AI エージェント基盤・開発者ツール]] — スキル・サブエージェント・MCP・評価
- [[iwasaka-brain/domains/tech-writing-personal-tools|技術発信・個人ツール]] — 記事ブラッシュアップと個人調査

月次:
- [[iwasaka-brain/timeline/2026-06|2026-06]] — 監査サイクルの確立、Claude Code 移行、API 構造再編
- [[iwasaka-brain/timeline/2026-07|2026-07]] — 全域監査→認可修正、合成データ、MCP 高速化
- [[iwasaka-brain/timeline/2026-08|2026-08]] — 敵対的レビュー運用の確立、計画書テンプレ、利用量計測
- [[iwasaka-brain/timeline/2026-09|2026-09]] — 請求機能の完成、検証の仕組み化
- [[iwasaka-brain/timeline/2026-10|2026-10]] — 後継リポジトリへの移植、E2E、引き継ぎ（月初時点）

## 3. 行動の型（patterns）

依頼と調査:
- [[iwasaka-brain/patterns/how-i-ask|依頼の出し方]] · [[iwasaka-brain/patterns/investigation-flow|調査の進め方]] · [[iwasaka-brain/patterns/plan-before-implement|実装前に計画書を書かせる]]

検証とレビュー:
- [[iwasaka-brain/patterns/adversarial-verification|敵対的検証・反証]] · [[iwasaka-brain/patterns/review-style|レビュー観点と順番]] · [[iwasaka-brain/patterns/testing-and-evidence|テスト・実測で裏を取る]] · [[iwasaka-brain/patterns/parallel-subagents|サブエージェントの並列運用]]

進め方と運用:
- [[iwasaka-brain/patterns/ticket-and-pr-flow|チケット駆動・PR 統合]] · [[iwasaka-brain/patterns/refactoring-approach|リファクタ・監査の進め方]] · [[iwasaka-brain/patterns/bug-triage-and-incident|障害・不具合対応の初動]] · [[iwasaka-brain/patterns/migration-and-tool-evaluation|乗り換え調査・ツール評価]]

守りと知識:
- [[iwasaka-brain/patterns/security-mindset|テナント境界・認可・秘密情報への習慣]] · [[iwasaka-brain/patterns/documentation-habits|ドキュメント・引き継ぎの癖]] · [[iwasaka-brain/patterns/knowledge-management|ナレッジ・長期記憶化]]

## 4. 判断原則（principles）

- [[iwasaka-brain/principles/evidence-over-claims|実測・実コード・再現で裏を取る]] — 最多。全期間で約 100 件の判断に出現
- [[iwasaka-brain/principles/scope-control|スコープの切り方]] · [[iwasaka-brain/principles/quality-vs-speed|品質と速度のトレードオフ]] · [[iwasaka-brain/principles/simplicity-and-reuse|既存の踏襲・二重管理の回避]]
- [[iwasaka-brain/principles/type-safety-and-static-guards|型・lint・フックで守る]] · [[iwasaka-brain/principles/multi-tenant-safety|テナント境界・認可への姿勢]] · [[iwasaka-brain/principles/operability-and-observability|運用・監視・コスト]]
- [[iwasaka-brain/principles/ai-delegation|AI に任せる範囲と自分で持つ範囲]] · [[iwasaka-brain/principles/communication-and-reporting|報告・共有の原則]] · [[iwasaka-brain/principles/decision-under-uncertainty|不確実な中での決め方]]

## 5. 依頼テンプレート（prompts）

- [[iwasaka-brain/prompts/investigation-prompts|調査・原因究明]] · [[iwasaka-brain/prompts/planning-prompts|設計・計画書]] · [[iwasaka-brain/prompts/implementation-prompts|実装・修正]]
- [[iwasaka-brain/prompts/verification-prompts|検証・敵対的レビュー]] · [[iwasaka-brain/prompts/incident-prompts|障害・運用トラブル]] · [[iwasaka-brain/prompts/writing-prompts|ドキュメント・記事・報告]]

## 6. 想定問答（faq）

- [[iwasaka-brain/faq/architecture-and-design|設計・技術選定]] · [[iwasaka-brain/faq/review-and-quality|レビュー・品質]] · [[iwasaka-brain/faq/process-and-scope|進め方・スコープ・見積]]
- [[iwasaka-brain/faq/ai-usage|AI の使い方]] · [[iwasaka-brain/faq/incident-and-operations|障害・運用・セキュリティ姿勢]]

## 使い方の目安

- 「本人ならどう答えるか」を再現したい → faq → 根拠リンク先の principles / patterns
- 「本人の代わりに AI へ依頼文を書かせたい」 → prompts + patterns/how-i-ask
- 「この時期に何をしていたか」 → timeline → domains
- 生成方法・機密ポリシー → [[iwasaka-brain/README|README]]

<#
.SYNOPSIS
    iwastack セットアップスクリプト (PowerShell)
.DESCRIPTION
    iwastack のサブエージェントおよびスキルを、指定したリポジトリまたはグローバル環境にインストールします。
.PARAMETER TargetPath
    インストール先のプロジェクトディレクトリ（既定値: カレントディレクトリ）
.PARAMETER Global
    指定した場合、~/.gemini/config/ にグローバルインストールします。
.EXAMPLE
    .\scripts\setup.ps1 -TargetPath C:\path\to\my-new-repo
.EXAMPLE
    .\scripts\setup.ps1 -Global
#>

param(
    [string]$TargetPath = ".",
    [switch]$Global
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir
$AgentsSource = Join-Path $RepoRoot ".agents"
$TemplatesSource = Join-Path $RepoRoot "templates"

if ($Global) {
    $GlobalConfigDir = Join-Path $HOME ".gemini\config"
    $GlobalAgentsDir = Join-Path $GlobalConfigDir "agents"
    $GlobalSkillsDir = Join-Path $GlobalConfigDir "skills"

    Write-Host "[iwastack] グローバル環境 (~/.gemini/config) へのインストールを開始します..." -ForegroundColor Cyan
    
    if (-not (Test-Path $GlobalAgentsDir)) { New-Item -ItemType Directory -Path $GlobalAgentsDir -Force | Out-Null }
    if (-not (Test-Path $GlobalSkillsDir)) { New-Item -ItemType Directory -Path $GlobalSkillsDir -Force | Out-Null }

    Copy-Item -Path (Join-Path $AgentsSource "agents\*") -Destination $GlobalAgentsDir -Recurse -Force
    Copy-Item -Path (Join-Path $AgentsSource "skills\*") -Destination $GlobalSkillsDir -Recurse -Force

    Write-Host "[iwastack] グローバルインストールが完了しました！" -ForegroundColor Green
    Write-Host "すべての Antigravity セッションで iwastack のサブエージェントとスキルが利用可能です。"
    exit 0
}

$ResolvedTarget = Resolve-Path $TargetPath
$TargetAgentsDir = Join-Path $ResolvedTarget ".agents"
$TargetAgentsMd = Join-Path $ResolvedTarget "AGENTS.md"

Write-Host "[iwastack] プロジェクトローカルインストールを開始します: $ResolvedTarget" -ForegroundColor Cyan

if (-not (Test-Path $TargetAgentsDir)) {
    New-Item -ItemType Directory -Path $TargetAgentsDir -Force | Out-Null
}

Copy-Item -Path $AgentsSource\* -Destination $TargetAgentsDir -Recurse -Force

if (-not (Test-Path $TargetAgentsMd)) {
    Copy-Item -Path (Join-Path $TemplatesSource "AGENTS.md") -Destination $TargetAgentsMd -Force
    Write-Host "  + AGENTS.md テンプレートを作成しました" -ForegroundColor Green
} else {
    Write-Host "  ! 既存の AGENTS.md が存在するため上書きをスキップしました" -ForegroundColor Yellow
}

Write-Host "[iwastack] インストールが正常に完了しました！" -ForegroundColor Green
Write-Host "対象プロジェクト: $ResolvedTarget"
Write-Host "  - .agents/agents/ (5+1 agents)"
Write-Host "  - .agents/skills/ (5+1 skills)"
Write-Host "  - AGENTS.md (Project Rules)"

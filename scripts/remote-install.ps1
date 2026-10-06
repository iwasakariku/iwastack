# iwastack Remote Installer (PowerShell)
# 使い方:
#   irm https://raw.githubusercontent.com/iwasakariku/iwastack/main/scripts/remote-install.ps1 | iex

$ErrorActionPreference = "Stop"

$RepoOwner = "iwasakariku"
$RepoName = "iwastack"
$Branch = "main"
$RawBase = "https://raw.githubusercontent.com/$RepoOwner/$RepoName/$Branch"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  iwastack Remote Installer (No-clone)   " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$CurrentDir = Get-Location
Write-Host "[iwastack] インストール先: $CurrentDir" -ForegroundColor Yellow

$AgentsDir = Join-Path $CurrentDir ".agents"
$AgentsSubDir = Join-Path $AgentsDir "agents"
$SkillsSubDir = Join-Path $AgentsDir "skills"

# フォルダ作成
$Dirs = @(
    $AgentsSubDir,
    (Join-Path $SkillsSubDir "iwasaka-greenfield"),
    (Join-Path $SkillsSubDir "iwasaka-fullcycle"),
    (Join-Path $SkillsSubDir "iwasaka-plan-gate"),
    (Join-Path $SkillsSubDir "iwasaka-adversarial-review"),
    (Join-Path $SkillsSubDir "iwasaka-investigation"),
    (Join-Path $SkillsSubDir "iwasaka-ship-gate")
)

foreach ($d in $Dirs) {
    if (-not (Test-Path $d)) {
        New-Item -ItemType Directory -Path $d -Force | Out-Null
    }
}

# ファイル一覧
$FilesToDownload = @(
    # Agents
    @{ Url = "$RawBase/.agents/agents/iwasaka-persona.md"; Dest = Join-Path $AgentsSubDir "iwasaka-persona.md" },
    @{ Url = "$RawBase/.agents/agents/iwasaka-product.md"; Dest = Join-Path $AgentsSubDir "iwasaka-product.md" },
    @{ Url = "$RawBase/.agents/agents/iwasaka-scout.md"; Dest = Join-Path $AgentsSubDir "iwasaka-scout.md" },
    @{ Url = "$RawBase/.agents/agents/iwasaka-refuter.md"; Dest = Join-Path $AgentsSubDir "iwasaka-refuter.md" },
    @{ Url = "$RawBase/.agents/agents/iwasaka-reviewer.md"; Dest = Join-Path $AgentsSubDir "iwasaka-reviewer.md" },
    @{ Url = "$RawBase/.agents/agents/iwasaka-red-tester.md"; Dest = Join-Path $AgentsSubDir "iwasaka-red-tester.md" },
    # Skills
    @{ Url = "$RawBase/.agents/skills/iwasaka-greenfield/SKILL.md"; Dest = Join-Path $SkillsSubDir "iwasaka-greenfield\SKILL.md" },
    @{ Url = "$RawBase/.agents/skills/iwasaka-fullcycle/SKILL.md"; Dest = Join-Path $SkillsSubDir "iwasaka-fullcycle\SKILL.md" },
    @{ Url = "$RawBase/.agents/skills/iwasaka-plan-gate/SKILL.md"; Dest = Join-Path $SkillsSubDir "iwasaka-plan-gate\SKILL.md" },
    @{ Url = "$RawBase/.agents/skills/iwasaka-adversarial-review/SKILL.md"; Dest = Join-Path $SkillsSubDir "iwasaka-adversarial-review\SKILL.md" },
    @{ Url = "$RawBase/.agents/skills/iwasaka-investigation/SKILL.md"; Dest = Join-Path $SkillsSubDir "iwasaka-investigation\SKILL.md" },
    @{ Url = "$RawBase/.agents/skills/iwasaka-ship-gate/SKILL.md"; Dest = Join-Path $SkillsSubDir "iwasaka-ship-gate\SKILL.md" },
    # Rules
    @{ Url = "$RawBase/templates/AGENTS.md"; Dest = Join-Path $CurrentDir "AGENTS.md" }
)

foreach ($f in $FilesToDownload) {
    if ($f.Dest -like "*AGENTS.md" -and (Test-Path $f.Dest)) {
        Write-Host "  ! 既存の AGENTS.md が存在するためスキップ" -ForegroundColor Yellow
        continue
    }
    Write-Host "  ⬇️ ダウンロード中: $($f.Dest.Replace($CurrentDir.Path, ''))"
    Invoke-RestMethod -Uri $f.Url -OutFile $f.Dest
}

Write-Host ""
Write-Host "🎉 [iwastack] インストールが完了しました！" -ForegroundColor Green
Write-Host "Antigravity を起動すると、自動的に iwastack のエージェント・スキルが有効化されます。"

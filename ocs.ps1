#!/usr/bin/env pwsh
# ocs — opencode 会话选择器（Windows / PowerShell 启动器，5.1 与 7 均可）
# 真正的逻辑在同目录的 Python 脚本 `ocs` 里；这里只负责：
#   1) 把控制台切到 UTF-8（正常显示中文和 •/◆ 等符号）
#   2) 找到 Python 3 解释器
#   3) 把命令行参数原样转发过去
$ErrorActionPreference = 'Stop'

try {
    [Console]::InputEncoding  = [System.Text.UTF8Encoding]::new($false)
    [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
} catch { }
$env:PYTHONUTF8 = '1'
$env:PYTHONIOENCODING = 'utf-8'

$script = Join-Path $PSScriptRoot 'ocs'

$py = $null
foreach ($cand in @('py', 'python', 'python3')) {
    $c = Get-Command $cand -ErrorAction SilentlyContinue
    if ($c) { $py = $c.Source; break }
}
if (-not $py) {
    Write-Error '找不到 Python。请先安装 Python 3.8+（winget install Python.Python.3.12），并把 python 加入 PATH。'
    exit 1
}

$argList = @()
if ([IO.Path]::GetFileNameWithoutExtension($py) -eq 'py') { $argList += '-3' }  # py 启动器要显式指定 Python 3
$argList += $script
$argList += $args

& $py @argList
exit $LASTEXITCODE

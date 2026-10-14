#!/usr/bin/env pwsh
# ocs 安装脚本（Windows / PowerShell）：把 ocs 装到 ~/.local/bin
#   · ocs       —— 真正的 Python 逻辑
#   · ocs.ps1   —— PowerShell 启动器（切 UTF-8、找 Python、转发参数）
#   · ocs.cmd   —— 让裸命令 `ocs` 能被解析（.ps1 不在 PATHEXT 里）
$ErrorActionPreference = 'Stop'

$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$bin = Join-Path $HOME '.local\bin'
New-Item -ItemType Directory -Force -Path $bin | Out-Null

Copy-Item -LiteralPath (Join-Path $dir 'ocs')     -Destination (Join-Path $bin 'ocs')     -Force
Copy-Item -LiteralPath (Join-Path $dir 'ocs.ps1') -Destination (Join-Path $bin 'ocs.ps1') -Force

# 裸命令 `ocs` 的入口：优先 pwsh，没有就退回 Windows PowerShell
$shim = @'
@echo off
setlocal
set "PSEXE=pwsh"
where pwsh >nul 2>nul || set "PSEXE=powershell"
"%PSEXE%" -NoProfile -ExecutionPolicy Bypass -File "%~dp0ocs.ps1" %*
'@
Set-Content -LiteralPath (Join-Path $bin 'ocs.cmd') -Value $shim -Encoding ASCII

Write-Host "OK  已安装到 $bin\ocs（及 ocs.ps1、ocs.cmd）"

# 确保 ~/.local/bin 在用户 PATH 里
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$parts = @($userPath -split ';' | Where-Object { $_ -ne '' })
if ($parts -notcontains $bin) {
    [Environment]::SetEnvironmentVariable('Path', (($parts + $bin) -join ';'), 'User')
    Write-Host "OK  已把 $bin 加入用户 PATH（重新打开终端后生效）"
} else {
    Write-Host "OK  $bin 已在 PATH 里"
}

Write-Host ''
Write-Host '用法：新开一个 PowerShell 窗口，输入  ocs  即可'
Write-Host '依赖：Python 3.8+、fzf（winget install junegunn.fzf）、opencode'

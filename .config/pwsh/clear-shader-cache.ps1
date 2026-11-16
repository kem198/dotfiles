<#
.SYNOPSIS
    NVIDIA / DirectX Shader Cache Cleanup

.DESCRIPTION
    DirectXおよびNVIDIAのシェーダーキャッシュの中身を削除する。
    キャッシュフォルダー自体は削除せず、中のファイル・フォルダーのみ削除する。

.EXECUTION
    削除対象を確認する (削除しない)
    .\clear-shader-cache.ps1 -WhatIf

    削除する
    .\clear-shader-cache.ps1

.TARGET FOLDERS
    DirectX:
      %LOCALAPPDATA%\D3DSCache

    NVIDIA DirectX:
      %LOCALAPPDATA%\NVIDIA\DXCache

    NVIDIA OpenGL:
      %LOCALAPPDATA%\NVIDIA\GLCache

    NVIDIA:
      %LOCALAPPDATA%\NVIDIA Corporation\NV_Cache

.REFERENCES

    参考記事:
    https://gaming-st.com/trouble-settings/shader-cache-delete-nvidia-amd-steam/
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param()

$ErrorActionPreference = "Continue"

# Cache directories
$targets = @(
    "$env:LOCALAPPDATA\D3DSCache"
    "$env:LOCALAPPDATA\NVIDIA\DXCache"
    "$env:LOCALAPPDATA\NVIDIA\GLCache"
    "$env:LOCALAPPDATA\NVIDIA Corporation\NV_Cache"
)

Write-Host "`n[START] Shader Cache Cleanup" -ForegroundColor Cyan

foreach ($path in $targets) {

    Write-Host "`n[TARGET] $path" -ForegroundColor Yellow

    if (-not (Test-Path -LiteralPath $path -PathType Container)) {
        Write-Host "[SKIP] Folder not found" -ForegroundColor DarkGray
        continue
    }

    $items = @(
        Get-ChildItem -LiteralPath $path -Force -ErrorAction SilentlyContinue
    )

    if ($items.Count -eq 0) {
        Write-Host "[EMPTY] No files to delete" -ForegroundColor DarkGray
        continue
    }

    foreach ($item in $items) {
        try {
            if ($PSCmdlet.ShouldProcess($item.FullName, "Delete cache")) {
                Remove-Item -LiteralPath $item.FullName `
                    -Recurse -Force -ErrorAction Stop

                Write-Host "[DELETED] $($item.Name)" -ForegroundColor Green
            }
        }
        catch {
            Write-Warning "[FAILED] $($item.FullName): $($_.Exception.Message)"
        }
    }
}

Write-Host "`n[DONE] Shader Cache Cleanup" -ForegroundColor Cyan

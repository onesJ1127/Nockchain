# ⚠️ 请以管理员身份运行此脚本
# 自动安装 WSL 和 Nockchain（只支持 Windows 10/11）

Write-Host "🔧 检查 WSL 安装..."
wsl --status | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "📦 启用 WSL 和安装 Ubuntu..."
    wsl --install -d Ubuntu-22.04
    Write-Host "✅ 安装已启动，请重启系统后重新运行此脚本"
    exit
}

Write-Host "✅ WSL 已启用"

# 实际下载地址（你需要确保这个脚本文件已上传至你的 GitHub 仓库）
$scriptUrl = "https://raw.githubusercontent.com/onesJ1127/Nockchain/main/nockchain_linux.sh"

Write-Host "📥 正在通过 WSL 下载并执行脚本..."
wsl bash -c "curl -sSL '$scriptUrl' -o nockchain_install.sh && chmod +x nockchain_install.sh && ./nockchain_install.sh"

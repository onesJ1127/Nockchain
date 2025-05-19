#!/bin/bash

set -e  # 出错就停止脚本

echo "🔄 更新 Ubuntu 软件源（使用 apt）..."
sudo apt update

echo "🔧 安装必要工具：curl、git、gcc、make..."
sudo apt install -y curl git build-essential

echo "🦀 安装 Rust..."
if ! command -v rustc &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
else
  echo "✅ Rust 已安装"
fi

echo "🔁 更新环境变量..."
if [ -f "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi
if [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

echo "🔽 克隆 nockchain 仓库..."
git clone https://github.com/zorp-corp/nockchain.git || {
  echo "❌ 无法克隆仓库，可能不存在或私有。请检查链接。"
  exit 1
}

cd nockchain

echo "⚙️ 安装 hoonc 编译器..."
make install-hoonc

echo "⚙️ 编译 Nockchain..."
make build

echo "💼 安装 Nockchain 钱包..."
make install-nockchain-wallet

echo "💾 安装 Nockchain 主程序..."
make install-nockchain

echo "✅ 准备完毕！等待创世块的测试 Nockchain 节点："
echo "👉 make run-nockchain-follower"

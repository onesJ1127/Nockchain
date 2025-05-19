#!/bin/bash

set -e

echo "🍎 检查并安装 Homebrew..."
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew 已安装"
fi

echo "🔧 安装依赖：git、curl、make、gcc..."
brew install git curl make gcc

echo "🦀 安装 Rust..."
if ! command -v rustc &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
else
  echo "✅ Rust 已安装"
fi

echo "🔁 更新环境变量..."
source "$HOME/.bash_profile" 2>/dev/null || true
source "$HOME/.zprofile" 2>/dev/null || true
source "$HOME/.cargo/env" 2>/dev/null || true

echo "📥 克隆 nockchain 仓库..."
git clone https://github.com/zorp-corp/nockchain.git || {
  echo "❌ 克隆失败，请检查链接"
  exit 1
}

cd nockchain

echo "⚙️ 安装 hoonc 编译器..."
make install-hoonc

echo "⚙️ 构建项目..."
make build

echo "💼 安装钱包..."
make install-nockchain-wallet

echo "💾 安装主程序..."
make install-nockchain

echo "✅ 安装完成，运行节点："
echo "👉 make run-nockchain-follower"

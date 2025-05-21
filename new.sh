#!/bin/bash

set -e

# Step 1: 安装 Rust
if ! command -v cargo >/dev/null; then
  echo "安装 Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source $HOME/.cargo/env
fi

# Step 2: 安装依赖
sudo apt update
sudo apt install -y clang llvm-dev libclang-dev make git

# Step 3: 克隆仓库
cd /home/cc/cc/web
git clone https://github.com/zorp-corp/nockchain.git
cd nockchain

# Step 4: 配置 .env
cp .env_example .env

# Step 5: 安装 hoonc
make install-hoonc

# Step 6: 编译
make build

# Step 7: 安装钱包和主程序
make install-nockchain-wallet
make install-nockchain

# Step 8: 生成钱包
nockchain-wallet keygen

echo "✅ 安装完成，请手动编辑 .env 填入 MINING_PUBKEY，然后执行 make run-nockchain"

# Nockchain 一键安装指南 🚀

## 一键启动命令 🛠️


### macOS 🍎
打开终端  
一键命令：
```bash
curl -sSL https://raw.githubusercontent.com/onesJ1127/Nockchain/main/nockchain_install_mac.sh -o /tmp/nockchain_install_mac.sh && bash /tmp/nockchain_install_mac.sh
```

### Linux (Ubuntu) 🐧
打开终端  
一键命令：
```bash
curl -sSL https://raw.githubusercontent.com/onesJ1127/Nockchain/main/nockchain_install_linux.sh -o nockchain_install.sh && chmod +x nockchain_install.sh && ./nockchain_install.sh
```

## 运行 Nockchain 节点 🚀
安装完成后，进入仓库目录并启动节点：
```bash
cd ~/nockchain  # macOS/Linux
# 或
cd /home/$USER/nockchain  # WSL/Linux
make run-nockchain-follower
```

查看日志：
```bash
screen -r leader  # 主节点日志
screen -r follower  # 从节点日志
```

最小化 screen：按 `Ctrl+A` 再按 `D`。  
停止节点：按 `Ctrl+C` 或 `pkill hoonc`。

检查输出：
```bash
ls -l ~/nockchain/out.jam
ls -l ~/nockchain/assets
```

## 故障排除 🔍

### 1. libclang 错误
**问题**：编译 `murmur3-sys` 失败，提示 `Unable to find libclang`。  
**解决**：  
**Linux/WSL**：
```bash
sudo apt install -y clang-14 libclang-14-dev
export LIBCLANG_PATH=/usr/lib/x86_64-linux-gnu
echo 'export LIBCLANG_PATH=/usr/lib/x86_64-linux-gnu' >> ~/.bashrc
source ~/.bashrc
```

**macOS**：
```bash
brew install llvm
export LIBCLANG_PATH=$(brew --prefix llvm)/lib
echo 'export LIBCLANG_PATH=$(brew --prefix llvm)/lib' >> ~/.zshrc
source ~/.zshrc
```

清理并重试：
```bash
cd ~/nockchain
rm -rf target
cargo clean
make build
```

### 2. make 命令失败
**问题**：`make install-hoonc` 或 `make build` 报错。  
**解决**：  
检查 Rust 版本：
```bash
rustup update
rustc --version
```

查看详细日志：
```bash
cd ~/nockchain
RUST_LOG=trace make build > build.log 2>&1
tail -n 50 build.log
```

## 官方
- **GitHub**: zorp-corp/nockchain  
- **Twitter**: @nockchain  

🎉 5 月 19 日主网上线，准备好挖 `$NOCK` 吧！

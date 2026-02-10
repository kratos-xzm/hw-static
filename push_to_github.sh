#!/bin/bash
# 自动推送到 GitHub 的脚本
# 用法: ./push_to_github.sh <文件名> <提交信息>

cd /home/kratos/.openclaw/workspace

if [ -z "$1" ]; then
    echo "错误：请提供文件名"
    exit 1
fi

FILE="$1"
COMMIT_MSG="${2:-更新文件: $FILE}"

# 添加文件
git add "$FILE"

# 提交
git commit -m "$COMMIT_MSG"

# 推送
git push origin main

echo "✅ 文件已推送到 GitHub"
echo "🌐 访问地址: https://kratos-xzm.github.io/hw-static/$FILE"

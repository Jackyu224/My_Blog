#!/bin/bash

# 检查是否提供了提交信息
if [ -z "$1" ]; then
    echo "请提供提交信息。"
    exit 1
fi

# 拉取远程更新并合并到本地
git pull origin master

# 检查是否有合并冲突
if [ $? -ne 0 ]; then
    echo "拉取远程更改时发生冲突，请手动解决冲突后重试。"
    exit 1
fi

# 添加所有更改
git add .

# 提交更改
git commit -m "$1"

# 推送更改到远程仓库的 master 分支
git push origin master

# 提示用户操作完成
echo "提交并推送到 GitHub 完成。"

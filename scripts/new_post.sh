#!/bin/bash

# 检查是否提供了文章标题
if [ -z "$1" ]; then
    echo "请提供文章标题。"
    exit 1
fi

# 获取当前日期
date=$(date +%Y-%m-%d)

# 将标题转换为文件名格式 (将空格替换为-，小写)
title_slug=$(echo "$1" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')

# 创建新的 Markdown 文件路径
filename="_posts/${date}-${title_slug}.md"

# 创建博客文章文件，并添加 Jekyll 标准的 front-matter
cat <<EOT >> $filename
---
layout: post
title: "$1"
date: $date
categories: blog
tag: [标签1, 标签2]
---
你的内容从这里开始...
EOT

# 提示用户文章已创建
echo "新的博客文章已创建: $filename"

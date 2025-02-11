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

# 让用户输入分类
echo "请输入分类（可输入多个，使用英文逗号分隔，例如 Java,SpringBoot）："
read category

# 允许用户选择图标
icons=("book" "code" "web" "chat" "note" "game" "link" "design" "image")

echo "请选择一个图标 (输入编号):"
select icon in "${icons[@]}"; do
    if [[ " ${icons[*]} " == *" $icon "* ]]; then
        break
    else
        echo "无效的选择，请重新输入。"
    fi
done

# 创建博客文章文件，并添加 Jekyll 标准的 front-matter
cat <<EOT >> $filename
---
layout: post
title: "$1"
date: $date
categories: $category
thumbnail: /style/image/thumbnail.png
icon: $icon
---

* content
{:toc}



EOT

# 提示用户文章已创建
echo "新的博客文章已创建: $filename"
echo "已设置图标: $icon"
echo "已设置分类: $category"
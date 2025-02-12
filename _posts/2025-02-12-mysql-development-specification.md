---
layout: post
title: "MySQL 开发规范"
date: 2025-02-12
categories: mysql
thumbnail: /style/image/img.jpg
icon: code
---

* content
{:toc}
# 规范化的数据库设计要点



## **(1) 字段命名规范**

✅ **表名 & 字段名使用小写，单词间用 `_` 连接**（避免大小写混淆，提升可读性）
✅ **主键一般以 `_id` 结尾**，如 `order_id`, `book_id`, `item_id`
✅ **布尔或枚举类型字段使用 ENUM 或 TINYINT**，如 `status ENUM('C', 'P')`
✅ **日期字段一般用 `_date` 结尾**，如 `create_date`



## **(2) 数据类型选择规范**

✅ **整数 ID 使用 `INT UNSIGNED AUTO_INCREMENT`**，避免负数
✅ **价格使用 `DECIMAL(10,2)`，而不是 `FLOAT` 或 `DOUBLE`**，避免精度问题
✅ **字符串存储使用 `VARCHAR(N)`，而不是 `TEXT`**，`TEXT` 不能建索引
✅ **库存使用 `INT UNSIGNED`，确保不能有负数库存**
✅ **时间使用 `DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP`** 记录创建时间



## **(3) 索引优化**

✅ **主键默认带索引，不需要额外创建**
✅ **高频查询字段建立 `INDEX` 提升查询性能**

- `INDEX idx_create_date (create_date);`
- `INDEX idx_order_id (order_id);` 

✅ **关联表的外键字段 `order_id`、`book_id` 需要索引**



## **(4) 约束（Constraints）**

✅ **`PRIMARY KEY`：主键唯一性**
✅ **`NOT NULL`：确保重要字段不能为空**
✅ **`DEFAULT` 值：减少 `NULL` 处理，提高查询效率**
✅ **`FOREIGN KEY`：保证数据一致性，`CASCADE` 或 `RESTRICT` 处理关联数据删除**

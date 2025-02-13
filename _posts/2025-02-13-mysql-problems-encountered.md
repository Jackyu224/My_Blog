---
layout: post
title: "MySQL 瓶颈"
date: 2025-02-13
categories: mysql,problems
thumbnail: /style/image/problems.jpg
icon: note
---

* content
{:toc}


## 目前的问题

**看得懂 SQL 代码**，但自己写不出来。

**题目读不懂**，不知道该查询哪个表、怎么拆解问题。



## **解题的标准步骤**

无论什么 SQL 题目，按这个步骤思考：

1. **题目要求什么？**
   - 关键词：查找、筛选、计算、分组、排序……
   - 重点找出 **查询对象**（哪张表？查哪些字段？）
2. **数据存在哪里？**
   - 需要从哪张表找数据？多个表是否有关联？
   - **如果有多个表，主键 & 外键是什么？如何关联？**
3. **如何筛选数据？**
   - **条件 (`WHERE`)**：是否需要按时间、状态、关键字筛选？
   - **计算 (`SUM()`、`COUNT()`、`AVG()` 等聚合函数)**
4. **是否需要分组 (`GROUP BY`) 或排序 (`ORDER BY`)？**
   - **需要按某个字段汇总数据吗？**
   - **结果需要按大小排序吗？**
5. **是否有特定的数据范围？**
   - 例如取 **前 10 名** (`LIMIT 10`)
   - 取 **第 5 到第 10 条** (`LIMIT 5 OFFSET 4`)



## **从“读题”到“拆解”**

✅ **方法 1：找关键词** 每次看到题目，先标记 **重要关键词**：

- “**销量最多**” → `SUM(quantity) ORDER BY DESC`
- “**库存最高**” → `MAX(inventory)`
- “**某年销量**” → `YEAR(createdate)`
- “**未被购买的书**” → `NOT IN (SELECT bookid FROM OrderItem)`

✅ **方法 2：列出表和字段** 每次遇到问题，先**明确数据在哪张表**：

| 需要的数据       | 可能在哪张表？ | 可能的字段                                 |
| ---------------- | -------------- | ------------------------------------------ |
| 图书信息         | `Book`         | `bookid`, `bookname`, `inventory`, `price` |
| 订单信息         | `Orders`       | `orderid`, `createdate`, `customername`    |
| 订单明细（销量） | `OrderItem`    | `bookid`, `quantity`, `orderid`            |

✅ **方法 3：一步步写 SQL** 比如：

1. 先找库存最高的书

   ```sql
   
   SELECT MAX(inventory) FROM Book;
   ```

2. 再查找库存最高的书的信息

   ```sql
   
   SELECT * FROM Book WHERE inventory = (SELECT MAX(inventory) FROM Book);
   ```



## **快速上手写 SQL**

✅ **建议 1：多手写 SQL 代码** 光看 SQL 是不够的，建议：

- **自己打开 MySQL 或者 SQL 练习网站**（如 [SQL Fiddle](http://sqlfiddle.com/)）尝试写查询。
- **随手改动 SQL 语句，看结果如何变化**。

✅ **建议 2：练习 “翻译 SQL”** 可以用**自然语言**描述 SQL：

- **`SELECT \* FROM Book WHERE inventory = (SELECT MAX(inventory) FROM Book);`** **翻译**："查询 `Book` 表中库存最多的书的信息。"

✅ **建议 3：尝试分解问题**

不要一次性写复杂 SQL可以分步骤写

1. 先写简单查询

   ```sql
   复制编辑
   SELECT MAX(inventory) FROM Book;
   ```

2. 再加上 WHERE 过滤

   ```sql
   复制编辑
   SELECT * FROM Book WHERE inventory = (SELECT MAX(inventory) FROM Book);
   ```

3. **最后加排序等优化**

✅ **建议 4：用 `LIMIT` 试试看** 如果查询数据量很大，**加 `LIMIT 10` 只看前 10 条数据**：

```sql
复制编辑
SELECT * FROM Book LIMIT 10;
```

这样可以**更快调试 SQL 语句**。

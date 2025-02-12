---
layout: post
title: "MySQL 关键字使用"
date: 2025-02-12
categories: mysql
thumbnail: /style/image/499399.jpg
icon: note
---

* content
{:toc}


### GROUP BY

通常与 `GROUP BY` 语句结合使用，以对数据进行分组和计算。

`GROUP BY` 的作用是**把相同值的行分组在一起**，然后对每个组进行聚合计算。

`GROUP BY` 语句的作用是 **按照指定字段分组**。否则导致数据被拆分

在 SQL 中，**当使用 `GROUP BY` 时，`SELECT` 语句中的字段必须满足以下两种情况之一**：

1. **属于 `GROUP BY` 语句中的列**
2. **使用了聚合函数（SUM、AVG、COUNT 等）**

结合 `HAVING`，可以筛选出符合特定条件的分组



![](https://cdn.jsdelivr.net/gh/Jackyu224/Img@main/img/202502121508454.png)



#### **❌**错误的

```sql
SELECT bookname, author, price, inventory, quantity, SUM(quantity), createdate
FROM OrderItem
JOIN Book b ON b.bookid = OrderItem.bookid
JOIN Orders o ON o.orderid = OrderItem.orderid
WHERE YEAR(createdate) = 2010
GROUP BY b.bookid, bookname, author, price, inventory, quantity, createdate;

```

#### ✅ 正确的 SQL 语句

```sql
SELECT bookname, author, price, inventory,sum(quantity)
FROM orderitem
		 JOIN Book b ON b.bookid = orderitem.bookid
		 JOIN Orders o ON o.orderid = orderitem.orderid
WHERE year(createdate)=2010
GROUP BY b.bookid
ORDER BY sum(quantity) DESC;
```



#### 💡 **总结**

- 书籍信息（`bookname`, `author`, `price`, `inventory`）对 **相同 `bookid` 来说不会变化**，可以直接放 `SELECT` 里。
- 订单信息（`quantity`, `createdate`）**在不同订单里会变化**，必须使用 **聚合函数** (`SUM()` 或 `GROUP_CONCAT()`）。
- `GROUP BY` 不能包含 `quantity` 和 `createdate`，否则数据会被拆成多行，而不是按 `bookid` 统计。
- **所有非聚合字段** 都要在 `GROUP BY` 里。



### **ORDER BY 和 GROUP BY 的区别**



|                                                | `ORDER BY`                 | `GROUP BY`                     |
| ---------------------------------------------- | -------------------------- | ------------------------------ |
| **作用**                                       | 对查询结果排序             | 进行分组，并对每组进行聚合计算 |
| **是否去重**                                   | ❌ 不去重                   | ✅ 会去重（合并相同的分组）     |
| **是否可以使用 `SUM()`、`COUNT()` 等聚合函数** | ❌ 不能                     | ✅ 需要                         |
| **是否影响查询的行数**                         | ❌ 不影响，所有数据都会显示 | ✅ 影响，合并相同分组的数据     |



### IN



### LIKE



### JOIN 






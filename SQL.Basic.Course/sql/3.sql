--第三章 聚合和排序
/* 聚合函数
COUNT :  计算表中的记录数（行数）
SUM
AVG
MAX
MIN */

-- COUNT(*)得到包含NULL的所有列，而COUNT(列名)得到除NULL的所有列
SELECT COUNT(*)
 FROM Product;
 
SELECT COUNT(*),COUNT(purchase_price)
 FROM Product;
 
 
--SUM(列名)得到除NULL的所有列之和
SELECT SUM(sale_price)
 FROM Product;
 
--AVG(列名)得到除NULL的所有列之和再除以非空列个数
SELECT AVG(sale_price)
 FROM Product; 

--MAX/MIN函数原则上可适用于任何数据类型的列，而SUM和AVG仅适用于数值类型的列
SELECT MAX(regist_date),MIN(regist_date)
 FROM Product; 

--使用聚合函数删除重复值（关键字DISTINCT）
--计算去除重复数据后的数据行数
SELECT COUNT(DISTINCT product_type)
 FROM Product;

--先计算数据行数再删除重复数据的结果 
SELECT DISTINCT COUNT(product_type)
 FROM Product;
 
SELECT SUM(sale_price),SUM(DISTINCT sale_price)
 FROM Product;
 
--3-2 对表进行分组
--GROUP BY子句(注意：SELECT与GROUP BY后的列名应相同)
SELECT product_type, COUNT(*)
  FROM Product
  GROUP BY product_type;
  
--子句的暂定书写顺序：SELECT -> FROM -> WHERE -> GROUP BY

--含有NULL时,也视为一类

 
--使用WHERE子句时GROUP BY执行结果
SELECT purchase_price, COUNT(*)
  FROM Product
  WHERE product_type ='衣服'
  GROUP BY purchase_price;
  
--与聚合函数和GROUP BY子句有关的常见错误

--1.在SELECT子句中书写了多余列
SELECT product_name,purchase_price, COUNT(*)
  FROM Product
  GROUP BY purchase_price;
--修改
--法一：在GROUP BY子句添加少的列名，起不到分组作用
SELECT product_name,purchase_price, COUNT(*)
  FROM Product
  GROUP BY product_name,purchase_price;
--法二：删除SELECT中多余的列
SELECT purchase_price, COUNT(*)
  FROM Product
  GROUP BY purchase_price;  
 
--2. 在GROUP BY子句中写了列的别名，先执行GROUP BY，再执行SELECT
SELECT product_type AS pt, COUNT(*)
  FROM Product
  GROUP BY pt;
 --根据想法修改后依然不能使用，建议不要在GROUP BY后写列的别名
SELECT product_type AS pt FROM Product;
SELECT pt, COUNT(*)
  FROM Product
  GROUP BY pt;
  
--3. 在GROUP BY子句结果的显示是随机的
--4.不能在WHERE子句中使用聚合函数
SELECT product_type, COUNT(*)
  FROM Product
  GROUP BY product_type;

SELECT product_type, COUNT(*)
  FROM Product
  WHERE COUNT(*) = 2
  GROUP BY product_type; 
 --如何解决第4个问题呢，答案在下一节中
 
 
 --3-3 为聚合结果指定条件
 --HAVING子句
 --子句的暂定书写顺序：SELECT -> FROM -> WHERE -> GROUP BY -> HAVING
 SELECT product_type, COUNT(*)
  FROM Product
  GROUP BY product_type
  HAVING COUNT(*) = 2;
  
  SELECT product_type, AVG(sale_price)
    FROM Product
    GROUP BY product_type
    HAVING AVG(sale_price) >= 2500;
    
--HAVING子句的构成要素：常数、聚合函数、GROUP BY子句中列名（聚合键）
--HAVING子句错误使用
SELECT product_type, COUNT(*)
  FROM Product
  GROUP BY product_type
  HAVING product_name = '圆珠笔';
--修改
--法一：
SELECT product_type, COUNT(*)
  FROM Product
  WHERE product_name = '圆珠笔'
  GROUP BY product_type;
--即更适合运用WHERE语句 
--法二：  
 SELECT product_type
  FROM Product
  WHERE product_name = '圆珠笔' ;
  
--3-4 对查询结果进行排序
--ORDER BY子句，升序不添加任何函数或添加ASC,降序添加DESC
SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY  sale_price;
    
SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY  sale_price DESC;

--子句的暂定书写顺序：SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY


--指定多个排序键
SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY  sale_price,purchase_price;

--NULL的顺序：排序键中包含NULL是，会在开头或末尾进行汇总
SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY purchase_price;

SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY purchase_price DESC;

--ORDER BY子句中可以使用列的别名
SELECT product_id AS id,product_name,sale_price AS sp,purchase_price
    FROM Product
    ORDER BY id,sp;
/*原因：使用HAVINNG子句时SELSCT语句的顺序：
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
SELSCT语句在GROUP BY子句之后，在ORDER BY子句之前*/


--ORDER BY子句中可以使用的列：
--SELECT子句中不包含的列
SELECT product_name,sale_price,purchase_price
    FROM Product
    ORDER BY product_id DESC;
    
--聚合函数
SELECT product_type,COUNT(*)
    FROM Product
    GROUP BY product_type
    ORDER BY COUNT(*);
    
/* 不要使用列编号
列编号:SELECT子句中从左到右的顺序所对应的编号,从1开始
不让用的原因:阅读较难,该排序功能将被删除
提出原因:有所了解  */
SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY sale_price  DESC,product_id;

--与上等价的是
SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY 3 DESC,1;
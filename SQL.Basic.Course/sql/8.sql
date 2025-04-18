--SQL 高级处理
--8-1 窗口函数
/* 窗口函数也称为OLAP函数，对数据库数据进行实时分析处理，具有分组和排序两种功能
   语法：  <窗口函数>  OVER  ([PARTITION  BY <列清单>]    --[]中内容可以省略
                                  ORDER BY <排序用列清单>)
   窗口函数大体可以分为以下两种：
     1. 能够作为窗口函数的聚合函数（SUM、AVG、COUNT、MAX、MIN）
     2.RANK、DENSE_RANK、ROW_NUMBER等专用窗口函数    */
        
     
--使用RANK函数：用来计算记录排序的函数
SELECT product_name, product_type, sale_price,
       RANK () OVER (PARTITION BY product_type    --PARTITION BY 设定排序的对象范围
                         ORDER BY sale_price ) AS ranking  --ORDER BY 指定按照哪一列，升序还是降序进行排序
  FROM Product;
  
 --不指定PARTITION BY，得到的结果是不切块的
 SELECT product_name, product_type, sale_price,
       RANK () OVER (ORDER BY sale_price) AS ranking 
  FROM Product;
  
  /*  专用窗口函数的种类：
            1.RANK函数：计算排序时，如果存在相同位次的记录，则会跳过之后的位次，如1，1，3.....
            2.DENSE_RANK函数：计算排序时，即使存在相同位次的记录，也不会跳过之后的位次，如1，1，2.....
            3.ROW_NUMBER函数：赋予唯一的连续位次，有2条记录排在第1位时：1，2，3...... */
  --进行比较
  SELECT product_name, product_type, sale_price,
       RANK () OVER (ORDER BY sale_price) AS ranking, 
       DENSE_RANK () OVER (ORDER BY sale_price) AS dense_ranking,
       ROW_NUMBER () OVER (ORDER BY sale_price) AS row_num
  FROM Product;
  
  --适用范围：只能在SELECT语句中使用 
 
  --作为窗口函数使用的聚合函数，要指定窗口函数中的变量
  SELECT product_id, product_name, sale_price,
       SUM(sale_price)  OVER (ORDER BY product_id) AS current_sum   --累计求和
  FROM Product;
  
  SELECT product_id, product_name, sale_price,
       AVG (sale_price) OVER (ORDER BY product_id) AS current_avg     --累计求平均
  FROM Product;
  
  
  SELECT product_id, product_name, sale_price
       AVG (sale_price) OVER (ORDER BY product_id
                              ROWS 2 PRECEDING) AS moving_avg     --移动平均，指定最靠近的三行作为汇总对象  
  FROM Product;
  -- ROWS 2 PRECEDING  框架：截止到之前两行
  
  
SELECT product_id, product_name, sale_price,
       AVG (sale_price) OVER (ORDER BY product_id
                                ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg
  FROM Product;
 -- ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING   框架：截止到之前一行和之后一行
  
-- 两个ORDER BY
--注意一个ORDER BY只能指定ranking单元格中的数值，输出结果可能是乱序的，
--要想有序，得再次使用一个ORDER BY
SELECT product_name, product_type, sale_price, 
       RANK () OVER (ORDER BY sale_price) AS ranking
  FROM Product;  
  
 SELECT product_name, product_type, sale_price, 
       RANK () OVER (ORDER BY sale_price) AS ranking
  FROM Product
 ORDER BY ranking;  
 
 
-- 8-2  GROUPING运算符 （同时得到小计和合计）
--同时得到合计行
SELECT product_type, SUM(sale_price)
  FROM Product
GROUP BY product_type;
 
 --添加合计行,再通过将UNION ALL将两个表合为一个
SELECT '合计' AS product_type, SUM(sale_price) AS sum
  FROM Product
UNION ALL
SELECT product_type, SUM(sale_price)
  FROM Product
GROUP BY product_type;

--上面方法繁琐，引入GROUPING运算符：ROLLUP、CUSE、GROUPING SETS 
-- ROLLUP:同时得到合计和小计
-- 超级分组记录默认使用NULL作为聚合键
SELECT product_type, SUM(sale_price) AS sum_price
  FROM Product
 GROUP BY ROLLUP(product_type);
 
  SELECT * FROM Product
--将登记日期添加到聚合键当中，不使用ROLLUP       只有同一类商品在同一日期的合计
SELECT product_type, regist_date, SUM(sale_price) AS sum_price
  FROM Product
GROUP BY product_type, regist_date; 
 
--将登记日期添加到聚合键当中，使用ROLLUP           在上面基础上，添加了按类合计和总合计
 SELECT product_type, regist_date, SUM(sale_price) AS sum_price
  FROM Product
 GROUP BY ROLLUP(product_type, regist_date);
 
 
 --使用GROUPING函数判断NULL，遇到超级分组记录中的NULL返回1，其余返回0
 SELECT GROUPING(product_type) AS product_type, 
        GROUPING(regist_date) AS regist_date, SUM(sale_price) AS sum_price
  FROM Product
 GROUP BY ROLLUP(product_type, regist_date);
 
 --在超级分组记录的键值中插入恰当的字符串
 SELECT CASE WHEN GROUPING(product_type) = 1 
            THEN '商品种类 合计' 
            ELSE product_type END AS product_type,
       CASE WHEN GROUPING(regist_date) = 1 
            THEN '登记日期 合计' 
            ELSE CAST(regist_date AS VARCHAR(16)) END AS regist_date,
       SUM(sale_price) AS sum_price
  FROM Product
 GROUP BY ROLLUP(product_type, regist_date);
 

--CUSE:取得全部组合的效果
 SELECT CASE WHEN GROUPING(product_type) = 1 
            THEN '商品种类 合计'
            ELSE product_type END AS product_type,
       CASE WHEN GROUPING(regist_date) = 1 
            THEN '登记日期 合计'
            ELSE CAST(regist_date AS VARCHAR(16)) END AS regist_date,
       SUM(sale_price) AS sum_price
  FROM Product
 GROUP BY CUBE(product_type, regist_date);
 
 
--GROUPING SETS：取得期望的积木，只取得部分组合的结果
 SELECT CASE WHEN GROUPING(product_type) = 1 
            THEN '商品种类 合计'
            ELSE product_type END AS product_type,
       CASE WHEN GROUPING(regist_date) = 1 
            THEN '登记日期 合计'
            ELSE CAST(regist_date AS VARCHAR(16)) END AS regist_date,
       SUM(sale_price) AS sum_tanka
  FROM Product
 GROUP BY GROUPING SETS (product_type, regist_date);
--5-1 视图
--视图和表
--表中存储的是实际数据，而视图中保存的是从表中取出的数据所使用的SELECT语句
--我们应该将经常使用的SELECT语句做成视图

--创建视图的方法
/*  语句：
         CREATE VIEW 视图名称 （<视图名称1>,<视图名称2>,.....）
         AS
         <SELECT语句>     */
         
         
--步骤1：恢复原始数据
 DELETE FROM Product;
 
 BEGIN TRANSACTION;
 INSERT INTO Product VALUES ('0001' , 'T恤衫','衣服',1000,500,'2009-09-20');
 INSERT INTO Product VALUES ('0002' , '打孔器','办公用品',500,320,'2009-09-11');
 INSERT INTO Product VALUES ('0003' , '运动T恤','衣服',4000,2800,NULL);
 INSERT INTO Product VALUES ('0004' , '菜刀','厨房用具',3000,2800,'2009-09-20');
 INSERT INTO Product VALUES ('0005' , '高压锅','厨房用具',6800,5000,'2009-01-15');
 INSERT INTO Product VALUES ('0006' , '叉子','厨房用具',500,NULL,'2009-09-20');
 INSERT INTO Product VALUES ('0007' , '擦菜板','厨房用具',880,790,'2008-04-28');
 INSERT INTO Product VALUES ('0008' , '圆珠笔','办公用品',100,NULL,'2009-11-11');
 COMMIT;

SELECT * 
   FROM Product ; 

--创建视图
CREATE VIEW ProductSum (product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
  FROM Product
 GROUP BY product_type;

SELECT product_type ,cnt_product
  FROM ProductSum;
 
--应该避免在视图上创建视图，会降低SQL性能  
CREATE VIEW ProductSumJim (product_type ,cnt_product)
AS
SELECT product_type,cnt_product 
FROM ProductSum                         --上一个视图
WHERE product_type = '办公用品';

SELECT product_type ,cnt_product
  FROM ProductSumJim;  

/* 视图限制：
   1.定义视图时不能使用ORDER BY子句（视图和表一样，没有顺序）
   2.视图由表派生出来，需和表同时进行更新，否则便无法进行更新   */
 --能够更新的情况
CREATE VIEW ProductJim (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
AS 
SELECT *
  FROM Product
 WHERE product_type = '办公用品';
 
 SELECT *
  FROM ProductJim;  
--向视图中添加行  
INSERT INTO ProductJim VALUES('0009','印章','办公用品',95,10,'2009-11-30');

SELECT *
  FROM ProductJim;
SELECT *
  FROM Product;
  
--删除视图
DROP VIEW ProductSum;
--删除视图中某行记录，直接从表中删除
DELETE FROM Product WHERE product_id = '0009';

--5-2 子查询(原则上必须为子查询设定名称)
CREATE VIEW ProductSum (product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
  FROM Product
 GROUP BY product_type;

SELECT product_type ,cnt_product
  FROM ProductSum;
-- 同样能得到结果的子查询的代码如下：
SELECT product_type, cnt_product
  FROM (SELECT product_type, COUNT(*) AS cnt_product
          FROM Product
         GROUP BY product_type) AS ProductSum;

--尝试增加子查询的层数
SELECT product_type, cnt_product
  FROM (SELECT *
          FROM(SELECT product_type, COUNT(*) AS cnt_product
                 FROM Product
               GROUP BY product_type) AS ProductSum
         WHERE product_type = '厨房用具') AS ProductSum2;
         
--标量子查询: 必须而且只能返回一行一列的结果,即只是一个值
--在WHERE子句中使用标量子查询
--错误示例
SELECT product_id, product_name, sale_price
  FROM Product
 WHERE sale_price >  AVG(sale_price) ;
  
--计算平均销售单价的标量子查询                                            
 SELECT AVG(sale_price) FROM Product ;
 
--选出销售单价高于全部商品平均销售单价的商品                        
SELECT product_id, product_name, sale_price
  FROM Product
 WHERE sale_price > (SELECT AVG(sale_price)
                         FROM Product);
                         
--标量子查询的书写位置：能够用常数或者列名的地方
--在SELECT子句中使用
SELECT product_id, product_name, sale_price,(SELECT AVG(sale_price)FROM Product) AS avg_price
  FROM Product;
  
--在HAVING子句中使用
SELECT product_type, AVG(sale_price)
  FROM Product
  GROUP BY product_type
 HAVING AVG(sale_price) > (SELECT AVG(sale_price) FROM Product);
 
--使用标量子查询的注意事项:返回多行结果是普通子查询,不是标量子查询

--5-3 关联子查询
--按照商品种类计算平均价格
SELECT AVG(sale_price)
  FROM Product
 GROUP BY product_type;


--发生错误的子查询
SELECT product_id, product_name, sale_price
  FROM Product
 WHERE sale_price > (SELECT AVG(sale_price)
                         FROM Product
                        GROUP BY product_type);  --错误原因:子查询返回不止一个值
                        
                        
--关联子查询                        
SELECT product_type, product_name, sale_price
  FROM Product AS P1
 WHERE sale_price > (SELECT AVG(sale_price)
                         FROM Product AS P2
                        WHERE P1.product_type = P2.product_type  --关键条件
                        GROUP BY product_type);
--数据更新
--数据的插入(INTERT语句的使用方法)
CREATE TABLE ProductIns
(product_id     CHAR(4)        NOT NULL ,
 product_name   VARCHAR(100)   NOT NULL ,
 product_type   VARCHAR(100)   NOT NULL ,
 sale_price     INTEGER        DEFAULT 0,   --插入默认值，此处销售单价的默认值设定为0
 purchase_price INTEGER ,
 regist_date    DATE ,
 PRIMARY KEY (product_id));
 
 INSERT into ProductIns (product_id,product_name,product_type,sale_price,purchase_price,
   regist_date) VALUES  ('0001','T恤衫','衣服',1000,500,'2009-09-20');
 
 --列清单可以省略，在前面创建表时有演示
 
 
 --插入NULL:约束条件设为非空时，不能插入
 --删除列清单和值清单的purchase_price列
 INSERT into ProductIns (product_id,product_name,product_type,sale_price,
   regist_date) VALUES  ('0008' , '圆珠笔','办公用品',100,'2009-11-11');
   
   
 --插入默认值：
 ----法一:显式方法：插入DEFAULT关键字
 INSERT INTO ProductIns VALUES ('0007' , '擦菜板','厨房用具',DEFAULT,790,'2008-04-28'); 
 SELECT * 
 FROM ProductIns
 WHERE product_id = '0007'
 ----法二：隐式方法：删除列清单和值清单的sale_price列
 INSERT into ProductIns (product_id,product_name,product_type,purchase_price,
   regist_date) VALUES ('0007' , '擦菜板','厨房用具',790,'2008-04-28'); 
  --未使用默认值
 INSERT INTO ProductIns VALUES ('0005' , '高压锅','厨房用具',6800,5000,'2009-01-15');
  SELECT * 
 FROM ProductIns
 WHERE product_id = '0005'
 
 --从其他表中复制数据:表名改变，其他不变
 CREATE TABLE ProductCopy
(product_id     CHAR(4)        NOT NULL ,
 product_name   VARCHAR(100)   NOT NULL ,
 product_type   VARCHAR(100)   NOT NULL ,
 sale_price     INTEGER ,
 purchase_price INTEGER ,
 regist_date    DATE ,
 PRIMARY KEY (product_id));
 
 INSERT into ProductCopy (product_id,product_name,product_type,sale_price,purchase_price,regist_date)
  SELECT product_id,product_name,product_type,sale_price,purchase_price,regist_date
  FROM Product;
  --查看结果
  SELECT * FROM ProductCopy
  
--汇总表
CREATE TABLE ProductType
(product_type   VARCHAR(100)   NOT NULL ,
 sum_sale_price     INTEGER ,
 sum_purchase_price INTEGER ,
 PRIMARY KEY (product_type ));
 
 INSERT into ProductType (product_type,sum_sale_price,sum_purchase_price)
  SELECT product_type,SUM(sale_price),SUM(purchase_price)
  FROM Product
  GROUP BY product_type;
  --查看结果
  SELECT * FROM ProductType;
  
  /* 注意:INSERT语句中的SELECT语句中,可以使用WHERE子句或者GROUP BY子句等任何SQL语法,
  但使用ORDER BY子句并不会产生任何效果.  */
  
  
  --4-2 数据的删除
  --完全删除表： DROP TABLE <表名>;
  --只留表的框架，完全删除表中的数据: DELETE FROM  <表名>;
  --指定删除对象：DELETE FROM  <表名>  WHERE <条件> ；
  --注：DELETE语句中只能使用WHERE子句，GROUP BY子句和ORDER BY子句是抽取数据的，在删除数据时并不能起到作用
  
  
  --4-3 数据的更新
  --UPDATE语句的基本语法
  UPDATE Product
     SET regist_date = '2009-10-10';
  
  SELECT * 
   FROM Product ;

--指定条件的UPDATE   
  UPDATE Product
     SET sale_price = sale_price*10
     WHERE product_type ='厨房用具';
  
 SELECT * 
   FROM Product ; 
 
--使用NULL进行更新
 UPDATE Product
     SET regist_date = NULL
     WHERE product_id = '0008';

SELECT * 
   FROM Product ; 
   
--多列更新:一次更新一个条件可能会造成浪费
UPDATE Product
     SET sale_price = sale_price*10,
         purchase_price = purchase_price/2
     WHERE product_type ='厨房用具';
  
 SELECT * 
   FROM Product ; 
   
   
--4-4 事务
-- 事务:对表中数据进行更新的单位,简单来讲就是需要在同一个处理单元中执行的一系列更新处理的集合
 UPDATE Product
   SET sale_price = sale_price - 1000
   WHERE product_name = '运动T恤';
 UPDATE Product
   SET sale_price = sale_price + 1000
   WHERE product_name ='T恤';
SELECT * 
   FROM Product ; 
   
   
--创建事务
/* 事务开始语句:BEGIN TRANSACTION;
                语句1、语句2.......
   事务结束语句：COMMIT:提交事务包含的全部更新处理的结束指令，相当于覆盖保存，
                        一旦提交，无法恢复事务开始之前状态（谨慎）
                 或ROLLBACK：取消事务包含全部更新处理的结束指令，相当于放弃保存，
                          一旦回滚，数据库就会恢复事务开始之前状态（无需谨慎） */
                          
--ACID特性
/* DBMS的事务具有四种特性：原子性、一致性、隔离性、持久性
   原子性：在事务结束时，其中包含的更新处理要么全部执行，要么完全不执行
   一致性：事务中包含的处理要满足数据库提前设置的约束条件
   隔离性：保证不同事务之间互不干扰
   持久性：事务结束时，DBMS能保证该时间点的数据状态会被保存的特性 */
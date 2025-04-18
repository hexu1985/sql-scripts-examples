 --2-1 SELECT语句基础
 --列的查询
 SELECT product_id,product_name,purchase_price
    FROM Product;
    
 --查询表中所有列   
 SELECT *
   FROM Product;
 
 --为列设定别名  
 SELECT product_id   AS  id,
        product_name AS  name,
        purchase_price AS price
    FROM Product;    
    
 --设定中文名，要用""括起来
 SELECT product_id   AS  "商品编号",
        product_name AS  "商品名称",
        purchase_price AS "进货单价"
    FROM Product;     
    
 --常数的查询
 SELECT '商品'  AS string, 38 AS number, '2009-02-24' AS date,
        product_id,product_name
    FROM Product;     
    
    
--从结果中删除重复行，使用DISTINCT,含有空的单元格时，也被视为一类数据
SELECT DISTINCT  product_type FROM Product; 
SELECT DISTINCT  purchase_price FROM Product; 
--在多列之前使用DISTINCT
SELECT DISTINCT  product_type,regist_date FROM Product;

--根据where语句来选择记录
SELECT product_name, product_type 
   FROM Product
   WHERE  product_type = '衣服';
   
-- 也可不选出作为查询条件的列
SELECT product_name
   FROM Product
   WHERE  product_type = '衣服';
   
--随意改变子句的书写顺序会造成错误
SELECT product_name, product_type 
   WHERE  product_type = '衣服'
   FROM Product;


--单行注释用--
--多行注释用/*   */



--2-2算数运算符和比较运算符
SELECT product_name,sale_price,
     sale_price *2 AS "sale_price_x2"
 FROM Product;
 
--算术运算符+-*/，所有包含NULL的计算，结果肯定是NULL
--比较运算符=,<>,<,>,<=,>=
SELECT product_name,product_type 
   FROM Product
   WHERE  sale_price = 500;
   
SELECT product_name,product_type 
   FROM Product
   WHERE  sale_price <> 500;
   
SELECT product_name,product_type,regist_date 
   FROM Product
   WHERE  regist_date < '2009-09-27'
      
SELECT product_name,sale_price,purchase_price
  FROM Product
  WHERE sale_price - purchase_price >= 500;
 
 
--对字符串（char）使用不等号时要注意的事项 :按照字典顺序进行排序
CREATE TABLE Chars
(chr CHAR(3) NOT NULL,
PRIMARY KEY (chr));

BEGIN TRANSACTION;
INSERT INTO Chars VALUES ('1');
INSERT INTO Chars VALUES ('2');
INSERT INTO Chars VALUES ('3');
INSERT INTO Chars VALUES ('10');
INSERT INTO Chars VALUES ('11');
INSERT INTO Chars VALUES ('222');
COMMIT;

SELECT chr 
  FROM Chars
  WHERE chr > '2';


--不能对NULL使用比较运算符
SELECT product_name,purchase_price
  FROM Product
  WHERE purchase_price = 2800;

--错误的SELECT语句  
SELECT product_name,purchase_price
  FROM Product
  WHERE purchase_price = NULL;
  
--正确的选取NULL记录的语句
SELECT product_name,purchase_price
  FROM Product
  WHERE purchase_price IS NULL;
  
SELECT product_name,purchase_price
  FROM Product
  WHERE purchase_price IS NOT NULL;
  
  
--2-3逻辑运算符
--NOT运算符，用来否定某一条件，但不能滥用(不简单，反而难理解)
SELECT product_name,purchase_price
  FROM Product
  WHERE  NOT purchase_price = 2800;

--AND运算符
SELECT product_name,purchase_price
  FROM Product
  WHERE product_type = '厨房用具'
  AND  sale_price >= 3000;
  
--OR运算符
SELECT product_name,purchase_price
  FROM Product
  WHERE product_type = '厨房用具'
  OR  sale_price >= 3000;
 
-- AND运算符优于OR运算符,想要优先执行OR运算，要带括号
SELECT product_name,purchase_price,regist_date
  FROM Product
  WHERE product_type = '办公用品'
  AND regist_date = '2009-09-11' 
  OR  regist_date = '2009-09-20';


 SELECT product_name,purchase_price,regist_date
  FROM Product
  WHERE product_type = '办公用品'
  AND (regist_date = '2009-09-11' OR  regist_date = '2009-09-20');
  
  
--真、假、不确定（NULL）——三值逻辑
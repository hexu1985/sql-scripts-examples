--6-1  函数
--创建算术函数表
CREATE TABLE SampleMath
(m  NUMERIC (10,3),
 n  INTEGER,
 p  INTEGER);

BEGIN TRANSACTION;

INSERT INTO SampleMath(m, n, p) VALUES (500,  0,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (-180, 0,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, NULL, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 7,    3);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 5,    2);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 4,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8,    NULL, 3);
INSERT INTO SampleMath(m, n, p) VALUES (2.27, 1,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (5.555,2,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 1,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8.76, NULL, NULL);

COMMIT;

SELECT * FROM SampleMath;

--ABS函数：绝对值
SELECT m,
  ABS(m) AS abs_col
  FROM SampleMath;
  
--MOD函数：求余
 SELECT n,p,
     n%p AS mod_col     --  被除数%除数
  FROM SampleMath; 
  
 --ROUND函数：四舍五入
 SELECT m,n,
  ROUND(m,n) AS round_col  --ROUND(对象数值,四舍五入位数)
  FROM SampleMath;
  
  
--创建字符串函数表

CREATE TABLE SampleStr
(str1  VARCHAR(40),
 str2  VARCHAR(40),
 str3  VARCHAR(40));


BEGIN TRANSACTION;

INSERT INTO SampleStr (str1, str2, str3) VALUES ('opx',	        'rt'	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc'	,	'def'	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('山田'	,	'太郎'  ,	'是我');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aaa'	,	NULL    ,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES (NULL	,	'xyz',	        NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('@!#$%',	NULL	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('ABC'	,	NULL	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aBC'	,	NULL	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc太郎',	'abc'	,	'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abcdefabc',   'abc'	,	'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('micmic',	      'i',        'I');;

COMMIT;

SELECT * FROM SampleStr;

DROP TABLE SampleStr;

--+函数：拼接(2012版本之前,之后用CONCAT(字符串1，字符串2.....))
SELECT str1, str2, str3,
       str1 + str2 + str3 AS str_concat
  FROM SampleStr;
  
--LEN函数：字符串长度
SELECT str1,
       LEN(str1)AS len_str
 FROM SampleStr;
 
--LOWER函数：大写转小写
SELECT str1,
       LOWER(str1) AS low_str
  FROM SampleStr
 WHERE str1 IN ('ABC', 'aBC', 'abc', '山田');
 
--REPLACE函数：字符串的替换，只替换一部分
SELECT str1, str2, str3,
       REPLACE(str1, str2, str3) AS rep_str   --REPLACE(对象字符串, 替换前字符串, 替换后字符串)
  FROM SampleStr;
  
--SUBSTRING函数：字符串的截取 
SELECT str1,
       SUBSTRING(str1, 3, 2) AS sub_str  --SUBSTRING(对象字符串, 截取的起始位置, 截取的字符数)
  FROM SampleStr;
  
--UPPER函数：小写转大写
SELECT str1,
       UPPER(str1) AS up_str
  FROM SampleStr
 WHERE str1 IN ('ABC', 'aBC', 'abc', '山田');
 
 --CURRENT_TIMESTAMP函数：获取当前日期
 --使用CAST将CURRENT_TIMESTAMP转换为日期类型
SELECT CAST(CURRENT_TIMESTAMP AS DATE) AS CUR_DATE;

--CURRENT_TIMESTAMP函数：获取当前时间
--使用CAST将CURRENT_TIMESTAMP转换为日期类型
SELECT CAST(CURRENT_TIMESTAMP AS TIME) AS CUR_TIME;

--CURRENT_TIMESTAMP函数：获取当前日期和时间
SELECT CURRENT_TIMESTAMP;

--EXTRACT函数：截取日期元素
SELECT CURRENT_TIMESTAMP,
       DATEPART(YEAR   , CURRENT_TIMESTAMP) AS year,
       DATEPART(MONTH  , CURRENT_TIMESTAMP) AS month,
       DATEPART(DAY    , CURRENT_TIMESTAMP) AS day,
       DATEPART(HOUR   , CURRENT_TIMESTAMP) AS hour,
       DATEPART(MINUTE , CURRENT_TIMESTAMP) AS minute,
       DATEPART(SECOND , CURRENT_TIMESTAMP) AS second;

--转换函数：数据类型的转换（cast）,值的转换
--类型转换
SELECT CAST('0001' AS INTEGER) AS int_col;    --CAST(转换前的值 AS 想要转换的数据类型) 

SELECT CAST('2009-12-14' AS DATE) AS date_col;

--COALESCE函数：将NULL转换为其他值
SELECT COALESCE(NULL, 1)                  AS col_1,   
       COALESCE(NULL, 'test', NULL)       AS col_2,
       COALESCE(NULL, NULL, '2009-11-01') AS col_3;

SELECT str2
  FROM SampleStr;
--列
SELECT COALESCE(str2, 'taNULL')
  FROM SampleStr;
  
  
--6-2 谓词：LIKE、BETWEEN、IS NULL、IS NOT NULL、IN、EXISTS
--LIKE:字符串的部分一致查询

CREATE TABLE SampleLike
( strcol VARCHAR(6) NOT NULL,
  PRIMARY KEY (strcol));


BEGIN TRANSACTION;

INSERT INTO SampleLike (strcol) VALUES ('abcddd');
INSERT INTO SampleLike (strcol) VALUES ('dddabc');
INSERT INTO SampleLike (strcol) VALUES ('abdddc');
INSERT INTO SampleLike (strcol) VALUES ('abcdd');
INSERT INTO SampleLike (strcol) VALUES ('ddabc');
INSERT INTO SampleLike (strcol) VALUES ('abddc');

COMMIT;

SELECT *
  FROM SampleLike;

--前方一致查询
SELECT *
  FROM SampleLike
 WHERE strcol LIKE 'ddd%';
 
--中间一致查询
 SELECT *
  FROM SampleLike
 WHERE strcol LIKE '%ddd%';
 
--后方一致查询
SELECT *
  FROM SampleLike
 WHERE strcol LIKE '%ddd';
 
 --还可以用LIKE和下划线进行查询
 SELECT *
  FROM SampleLike
 WHERE strcol LIKE '_bdd__';
 
 
 --BETWEEN:范围查询
 SELECT product_name, sale_price
  FROM Product
 WHERE sale_price BETWEEN 100 AND 1000;   --包含临界值
 
--若不想包含临界值，要用到AND
SELECT product_name, sale_price
  FROM Product
 WHERE sale_price > 100 
   AND sale_price < 1000;
   
--IS NULL、IS NOT NULL:判断是否为空
SELECT product_name, purchase_price
  FROM Product
 WHERE purchase_price IS NULL;
 
 SELECT product_name, purchase_price
  FROM Product
 WHERE purchase_price IS NOT NULL;
 
 --IN: OR的简便用法
 SELECT product_name, purchase_price
  FROM Product
 WHERE purchase_price =  320
    OR purchase_price =  500
    OR purchase_price = 5000;
    
 SELECT product_name, purchase_price
  FROM Product
 WHERE purchase_price IN  ('320','500','5000');
 
 SELECT product_name, purchase_price
  FROM Product
 WHERE purchase_price NOT IN  ('320','500','5000');   
 
 --使用子查询作为IN谓词的参数
 CREATE TABLE ShopProduct
(shop_id      CHAR(4)        NOT NULL ,
 shop_name   VARCHAR(200)    NOT NULL ,
 product_id   CHAR(4)        NOT NULL ,
 quantity     INTEGER        NOT NULL,
 PRIMARY KEY (shop_id, product_id));
 
 BEGIN TRANSACTION;
 INSERT INTO ShopProduct VALUES ('000A' , '东京','0001',30);
 INSERT INTO ShopProduct VALUES ('000A' , '东京','0002',50);
 INSERT INTO ShopProduct VALUES ('000A' , '东京','0003',15);
 INSERT INTO ShopProduct VALUES ('000B' , '名古屋','0002',30);
 INSERT INTO ShopProduct VALUES ('000B' , '名古屋','0003',120);
 INSERT INTO ShopProduct VALUES ('000B' , '名古屋','0004',20);
 INSERT INTO ShopProduct VALUES ('000B' , '名古屋','0006',10);
 INSERT INTO ShopProduct VALUES ('000B' , '名古屋','0007',40);
 INSERT INTO ShopProduct VALUES ('000C' , '大阪','0003',20);
 INSERT INTO ShopProduct VALUES ('000C' , '大阪','0004',50);
 INSERT INTO ShopProduct VALUES ('000C' , '大阪','0006',90);
 INSERT INTO ShopProduct VALUES ('000C' , '大阪','0007',70);
 INSERT INTO ShopProduct VALUES ('000D' , '福冈','0001',100);
 COMMIT;
 
 SELECT *
   FROM ShopProduct;
   
 
 SELECT product_name,sale_price 
      FROM Product
      WHERE   product_id  IN (SELECT  product_id 
                               FROM ShopProduct   
                               WHERE shop_id = '000C');
                               
SELECT product_name,sale_price 
      FROM Product
      WHERE   product_id NOT IN (SELECT  product_id 
                               FROM ShopProduct   
                               WHERE shop_id = '000A');
                               
                               
                               
--EXIST 
SELECT product_name,sale_price 
      FROM Product AS P
      WHERE   EXISTS  (SELECT  *
                         FROM ShopProduct AS SP
                        WHERE shop_id = '000C'
                        AND P.product_id = SP.product_id);
--与之等价的是
SELECT product_name,sale_price 
      FROM Product AS P
      WHERE   EXISTS  (SELECT  1            --这里可以书写适当的常数
                         FROM ShopProduct AS SP
                        WHERE shop_id = '000C'
                        AND P.product_id = SP.product_id);
                        
--用NOT EXISTS 替换NOT IN                       
SELECT product_name,sale_price 
      FROM Product AS P
      WHERE   NOT EXISTS  (SELECT  *           
                         FROM ShopProduct AS SP
                        WHERE shop_id = '000A'
                        AND P.product_id = SP.product_id);
                        
--6-3 CASE 表达式：通俗来讲，就是条件分支
SELECT product_name,
       CASE WHEN product_type = '衣服'    THEN 'A：' + product_type
            WHEN product_type = '办公用品' THEN 'B：' + product_type
            WHEN product_type = '厨房用具' THEN 'C：' + product_type
            ELSE NULL                      --可以忽略，但是不要忽略
       END AS abc_product_type             --不能省略
  FROM Product;
 
--使用GROUP BY 无法实现行列转换
SELECT product_type,
       SUM(sale_price) AS sum_price
  FROM Product
 GROUP BY product_type;
 
 --使用CASE表达式实现行列转换
 SELECT SUM(CASE WHEN product_type = '衣服'    THEN sale_price ELSE 0 END) AS sum_price_clothes,
       SUM(CASE WHEN product_type = '厨房用具' THEN sale_price ELSE 0 END) AS sum_price_kitchen,
       SUM(CASE WHEN product_type = '办公用品' THEN sale_price ELSE 0 END) AS sum_price_office
  FROM Product;
  
 -- 使用简单CASE表达式的情况
SELECT product_name,
       CASE product_type
            WHEN '衣服'    THEN 'A：' + product_type
            WHEN '办公用品' THEN 'B：' + product_type
            WHEN '厨房用具' THEN 'C：' + product_type
            ELSE NULL
        END AS abc_product_type
  FROM Product;

--使用搜索CASE表达式的情况
SELECT product_name,
       CASE WHEN product_type = '衣服'    THEN 'A：' + product_type
            WHEN product_type = '办公用品' THEN 'B：' + product_type
            WHEN product_type = '厨房用具' THEN 'C：' + product_type
            ELSE NULL
       END AS abc_product_type
  FROM Product;
--6-1  ����
--��������������
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

--ABS����������ֵ
SELECT m,
  ABS(m) AS abs_col
  FROM SampleMath;
  
--MOD����������
 SELECT n,p,
     n%p AS mod_col     --  ������%����
  FROM SampleMath; 
  
 --ROUND��������������
 SELECT m,n,
  ROUND(m,n) AS round_col  --ROUND(������ֵ,��������λ��)
  FROM SampleMath;
  
  
--�����ַ���������

CREATE TABLE SampleStr
(str1  VARCHAR(40),
 str2  VARCHAR(40),
 str3  VARCHAR(40));


BEGIN TRANSACTION;

INSERT INTO SampleStr (str1, str2, str3) VALUES ('opx',	        'rt'	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc'	,	'def'	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('ɽ��'	,	'̫��'  ,	'����');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aaa'	,	NULL    ,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES (NULL	,	'xyz',	        NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('@!#$%',	NULL	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('ABC'	,	NULL	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aBC'	,	NULL	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc̫��',	'abc'	,	'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abcdefabc',   'abc'	,	'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('micmic',	      'i',        'I');;

COMMIT;

SELECT * FROM SampleStr;

DROP TABLE SampleStr;

--+������ƴ��(2012�汾֮ǰ,֮����CONCAT(�ַ���1���ַ���2.....))
SELECT str1, str2, str3,
       str1 + str2 + str3 AS str_concat
  FROM SampleStr;
  
--LEN�������ַ�������
SELECT str1,
       LEN(str1)AS len_str
 FROM SampleStr;
 
--LOWER��������дתСд
SELECT str1,
       LOWER(str1) AS low_str
  FROM SampleStr
 WHERE str1 IN ('ABC', 'aBC', 'abc', 'ɽ��');
 
--REPLACE�������ַ������滻��ֻ�滻һ����
SELECT str1, str2, str3,
       REPLACE(str1, str2, str3) AS rep_str   --REPLACE(�����ַ���, �滻ǰ�ַ���, �滻���ַ���)
  FROM SampleStr;
  
--SUBSTRING�������ַ����Ľ�ȡ 
SELECT str1,
       SUBSTRING(str1, 3, 2) AS sub_str  --SUBSTRING(�����ַ���, ��ȡ����ʼλ��, ��ȡ���ַ���)
  FROM SampleStr;
  
--UPPER������Сдת��д
SELECT str1,
       UPPER(str1) AS up_str
  FROM SampleStr
 WHERE str1 IN ('ABC', 'aBC', 'abc', 'ɽ��');
 
 --CURRENT_TIMESTAMP��������ȡ��ǰ����
 --ʹ��CAST��CURRENT_TIMESTAMPת��Ϊ��������
SELECT CAST(CURRENT_TIMESTAMP AS DATE) AS CUR_DATE;

--CURRENT_TIMESTAMP��������ȡ��ǰʱ��
--ʹ��CAST��CURRENT_TIMESTAMPת��Ϊ��������
SELECT CAST(CURRENT_TIMESTAMP AS TIME) AS CUR_TIME;

--CURRENT_TIMESTAMP��������ȡ��ǰ���ں�ʱ��
SELECT CURRENT_TIMESTAMP;

--EXTRACT��������ȡ����Ԫ��
SELECT CURRENT_TIMESTAMP,
       DATEPART(YEAR   , CURRENT_TIMESTAMP) AS year,
       DATEPART(MONTH  , CURRENT_TIMESTAMP) AS month,
       DATEPART(DAY    , CURRENT_TIMESTAMP) AS day,
       DATEPART(HOUR   , CURRENT_TIMESTAMP) AS hour,
       DATEPART(MINUTE , CURRENT_TIMESTAMP) AS minute,
       DATEPART(SECOND , CURRENT_TIMESTAMP) AS second;

--ת���������������͵�ת����cast��,ֵ��ת��
--����ת��
SELECT CAST('0001' AS INTEGER) AS int_col;    --CAST(ת��ǰ��ֵ AS ��Ҫת������������) 

SELECT CAST('2009-12-14' AS DATE) AS date_col;

--COALESCE��������NULLת��Ϊ����ֵ
SELECT COALESCE(NULL, 1)                  AS col_1,   
       COALESCE(NULL, 'test', NULL)       AS col_2,
       COALESCE(NULL, NULL, '2009-11-01') AS col_3;

SELECT str2
  FROM SampleStr;
--��
SELECT COALESCE(str2, 'taNULL')
  FROM SampleStr;
  
  
--6-2 ν�ʣ�LIKE��BETWEEN��IS NULL��IS NOT NULL��IN��EXISTS
--LIKE:�ַ����Ĳ���һ�²�ѯ

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

--ǰ��һ�²�ѯ
SELECT *
  FROM SampleLike
 WHERE strcol LIKE 'ddd%';
 
--�м�һ�²�ѯ
 SELECT *
  FROM SampleLike
 WHERE strcol LIKE '%ddd%';
 
--��һ�²�ѯ
SELECT *
  FROM SampleLike
 WHERE strcol LIKE '%ddd';
 
 --��������LIKE���»��߽��в�ѯ
 SELECT *
  FROM SampleLike
 WHERE strcol LIKE '_bdd__';
 
 
 --BETWEEN:��Χ��ѯ
 SELECT product_name, sale_price
  FROM Product
 WHERE sale_price BETWEEN 100 AND 1000;   --�����ٽ�ֵ
 
--����������ٽ�ֵ��Ҫ�õ�AND
SELECT product_name, sale_price
  FROM Product
 WHERE sale_price > 100 
   AND sale_price < 1000;
   
--IS NULL��IS NOT NULL:�ж��Ƿ�Ϊ��
SELECT product_name, purchase_price
  FROM Product
 WHERE purchase_price IS NULL;
 
 SELECT product_name, purchase_price
  FROM Product
 WHERE purchase_price IS NOT NULL;
 
 --IN: OR�ļ���÷�
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
 
 --ʹ���Ӳ�ѯ��ΪINν�ʵĲ���
 CREATE TABLE ShopProduct
(shop_id      CHAR(4)        NOT NULL ,
 shop_name   VARCHAR(200)    NOT NULL ,
 product_id   CHAR(4)        NOT NULL ,
 quantity     INTEGER        NOT NULL,
 PRIMARY KEY (shop_id, product_id));
 
 BEGIN TRANSACTION;
 INSERT INTO ShopProduct VALUES ('000A' , '����','0001',30);
 INSERT INTO ShopProduct VALUES ('000A' , '����','0002',50);
 INSERT INTO ShopProduct VALUES ('000A' , '����','0003',15);
 INSERT INTO ShopProduct VALUES ('000B' , '������','0002',30);
 INSERT INTO ShopProduct VALUES ('000B' , '������','0003',120);
 INSERT INTO ShopProduct VALUES ('000B' , '������','0004',20);
 INSERT INTO ShopProduct VALUES ('000B' , '������','0006',10);
 INSERT INTO ShopProduct VALUES ('000B' , '������','0007',40);
 INSERT INTO ShopProduct VALUES ('000C' , '����','0003',20);
 INSERT INTO ShopProduct VALUES ('000C' , '����','0004',50);
 INSERT INTO ShopProduct VALUES ('000C' , '����','0006',90);
 INSERT INTO ShopProduct VALUES ('000C' , '����','0007',70);
 INSERT INTO ShopProduct VALUES ('000D' , '����','0001',100);
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
--��֮�ȼ۵���
SELECT product_name,sale_price 
      FROM Product AS P
      WHERE   EXISTS  (SELECT  1            --���������д�ʵ��ĳ���
                         FROM ShopProduct AS SP
                        WHERE shop_id = '000C'
                        AND P.product_id = SP.product_id);
                        
--��NOT EXISTS �滻NOT IN                       
SELECT product_name,sale_price 
      FROM Product AS P
      WHERE   NOT EXISTS  (SELECT  *           
                         FROM ShopProduct AS SP
                        WHERE shop_id = '000A'
                        AND P.product_id = SP.product_id);
                        
--6-3 CASE ���ʽ��ͨ������������������֧
SELECT product_name,
       CASE WHEN product_type = '�·�'    THEN 'A��' + product_type
            WHEN product_type = '�칫��Ʒ' THEN 'B��' + product_type
            WHEN product_type = '�����þ�' THEN 'C��' + product_type
            ELSE NULL                      --���Ժ��ԣ����ǲ�Ҫ����
       END AS abc_product_type             --����ʡ��
  FROM Product;
 
--ʹ��GROUP BY �޷�ʵ������ת��
SELECT product_type,
       SUM(sale_price) AS sum_price
  FROM Product
 GROUP BY product_type;
 
 --ʹ��CASE���ʽʵ������ת��
 SELECT SUM(CASE WHEN product_type = '�·�'    THEN sale_price ELSE 0 END) AS sum_price_clothes,
       SUM(CASE WHEN product_type = '�����þ�' THEN sale_price ELSE 0 END) AS sum_price_kitchen,
       SUM(CASE WHEN product_type = '�칫��Ʒ' THEN sale_price ELSE 0 END) AS sum_price_office
  FROM Product;
  
 -- ʹ�ü�CASE���ʽ�����
SELECT product_name,
       CASE product_type
            WHEN '�·�'    THEN 'A��' + product_type
            WHEN '�칫��Ʒ' THEN 'B��' + product_type
            WHEN '�����þ�' THEN 'C��' + product_type
            ELSE NULL
        END AS abc_product_type
  FROM Product;

--ʹ������CASE���ʽ�����
SELECT product_name,
       CASE WHEN product_type = '�·�'    THEN 'A��' + product_type
            WHEN product_type = '�칫��Ʒ' THEN 'B��' + product_type
            WHEN product_type = '�����þ�' THEN 'C��' + product_type
            ELSE NULL
       END AS abc_product_type
  FROM Product;
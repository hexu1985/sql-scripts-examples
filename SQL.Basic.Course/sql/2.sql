 --2-1 SELECT������
 --�еĲ�ѯ
 SELECT product_id,product_name,purchase_price
    FROM Product;
    
 --��ѯ����������   
 SELECT *
   FROM Product;
 
 --Ϊ���趨����  
 SELECT product_id   AS  id,
        product_name AS  name,
        purchase_price AS price
    FROM Product;    
    
 --�趨��������Ҫ��""������
 SELECT product_id   AS  "��Ʒ���",
        product_name AS  "��Ʒ����",
        purchase_price AS "��������"
    FROM Product;     
    
 --�����Ĳ�ѯ
 SELECT '��Ʒ'  AS string, 38 AS number, '2009-02-24' AS date,
        product_id,product_name
    FROM Product;     
    
    
--�ӽ����ɾ���ظ��У�ʹ��DISTINCT,���пյĵ�Ԫ��ʱ��Ҳ����Ϊһ������
SELECT DISTINCT  product_type FROM Product; 
SELECT DISTINCT  purchase_price FROM Product; 
--�ڶ���֮ǰʹ��DISTINCT
SELECT DISTINCT  product_type,regist_date FROM Product;

--����where�����ѡ���¼
SELECT product_name, product_type 
   FROM Product
   WHERE  product_type = '�·�';
   
-- Ҳ�ɲ�ѡ����Ϊ��ѯ��������
SELECT product_name
   FROM Product
   WHERE  product_type = '�·�';
   
--����ı��Ӿ����д˳�����ɴ���
SELECT product_name, product_type 
   WHERE  product_type = '�·�'
   FROM Product;


--����ע����--
--����ע����/*   */



--2-2����������ͱȽ������
SELECT product_name,sale_price,
     sale_price *2 AS "sale_price_x2"
 FROM Product;
 
--���������+-*/�����а���NULL�ļ��㣬����϶���NULL
--�Ƚ������=,<>,<,>,<=,>=
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
 
 
--���ַ�����char��ʹ�ò��Ⱥ�ʱҪע������� :�����ֵ�˳���������
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


--���ܶ�NULLʹ�ñȽ������
SELECT product_name,purchase_price
  FROM Product
  WHERE purchase_price = 2800;

--�����SELECT���  
SELECT product_name,purchase_price
  FROM Product
  WHERE purchase_price = NULL;
  
--��ȷ��ѡȡNULL��¼�����
SELECT product_name,purchase_price
  FROM Product
  WHERE purchase_price IS NULL;
  
SELECT product_name,purchase_price
  FROM Product
  WHERE purchase_price IS NOT NULL;
  
  
--2-3�߼������
--NOT�������������ĳһ����������������(���򵥣����������)
SELECT product_name,purchase_price
  FROM Product
  WHERE  NOT purchase_price = 2800;

--AND�����
SELECT product_name,purchase_price
  FROM Product
  WHERE product_type = '�����þ�'
  AND  sale_price >= 3000;
  
--OR�����
SELECT product_name,purchase_price
  FROM Product
  WHERE product_type = '�����þ�'
  OR  sale_price >= 3000;
 
-- AND���������OR�����,��Ҫ����ִ��OR���㣬Ҫ������
SELECT product_name,purchase_price,regist_date
  FROM Product
  WHERE product_type = '�칫��Ʒ'
  AND regist_date = '2009-09-11' 
  OR  regist_date = '2009-09-20';


 SELECT product_name,purchase_price,regist_date
  FROM Product
  WHERE product_type = '�칫��Ʒ'
  AND (regist_date = '2009-09-11' OR  regist_date = '2009-09-20');
  
  
--�桢�١���ȷ����NULL��������ֵ�߼�
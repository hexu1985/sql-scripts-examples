--5-1 ��ͼ
--��ͼ�ͱ�
--���д洢����ʵ�����ݣ�����ͼ�б�����Ǵӱ���ȡ����������ʹ�õ�SELECT���
--����Ӧ�ý�����ʹ�õ�SELECT���������ͼ

--������ͼ�ķ���
/*  ��䣺
         CREATE VIEW ��ͼ���� ��<��ͼ����1>,<��ͼ����2>,.....��
         AS
         <SELECT���>     */
         
         
--����1���ָ�ԭʼ����
 DELETE FROM Product;
 
 BEGIN TRANSACTION;
 INSERT INTO Product VALUES ('0001' , 'T����','�·�',1000,500,'2009-09-20');
 INSERT INTO Product VALUES ('0002' , '�����','�칫��Ʒ',500,320,'2009-09-11');
 INSERT INTO Product VALUES ('0003' , '�˶�T��','�·�',4000,2800,NULL);
 INSERT INTO Product VALUES ('0004' , '�˵�','�����þ�',3000,2800,'2009-09-20');
 INSERT INTO Product VALUES ('0005' , '��ѹ��','�����þ�',6800,5000,'2009-01-15');
 INSERT INTO Product VALUES ('0006' , '����','�����þ�',500,NULL,'2009-09-20');
 INSERT INTO Product VALUES ('0007' , '���˰�','�����þ�',880,790,'2008-04-28');
 INSERT INTO Product VALUES ('0008' , 'Բ���','�칫��Ʒ',100,NULL,'2009-11-11');
 COMMIT;

SELECT * 
   FROM Product ; 

--������ͼ
CREATE VIEW ProductSum (product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
  FROM Product
 GROUP BY product_type;

SELECT product_type ,cnt_product
  FROM ProductSum;
 
--Ӧ�ñ�������ͼ�ϴ�����ͼ���ή��SQL����  
CREATE VIEW ProductSumJim (product_type ,cnt_product)
AS
SELECT product_type,cnt_product 
FROM ProductSum                         --��һ����ͼ
WHERE product_type = '�칫��Ʒ';

SELECT product_type ,cnt_product
  FROM ProductSumJim;  

/* ��ͼ���ƣ�
   1.������ͼʱ����ʹ��ORDER BY�Ӿ䣨��ͼ�ͱ�һ����û��˳��
   2.��ͼ�ɱ�������������ͱ�ͬʱ���и��£�������޷����и���   */
 --�ܹ����µ����
CREATE VIEW ProductJim (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
AS 
SELECT *
  FROM Product
 WHERE product_type = '�칫��Ʒ';
 
 SELECT *
  FROM ProductJim;  
--����ͼ�������  
INSERT INTO ProductJim VALUES('0009','ӡ��','�칫��Ʒ',95,10,'2009-11-30');

SELECT *
  FROM ProductJim;
SELECT *
  FROM Product;
  
--ɾ����ͼ
DROP VIEW ProductSum;
--ɾ����ͼ��ĳ�м�¼��ֱ�Ӵӱ���ɾ��
DELETE FROM Product WHERE product_id = '0009';

--5-2 �Ӳ�ѯ(ԭ���ϱ���Ϊ�Ӳ�ѯ�趨����)
CREATE VIEW ProductSum (product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
  FROM Product
 GROUP BY product_type;

SELECT product_type ,cnt_product
  FROM ProductSum;
-- ͬ���ܵõ�������Ӳ�ѯ�Ĵ������£�
SELECT product_type, cnt_product
  FROM (SELECT product_type, COUNT(*) AS cnt_product
          FROM Product
         GROUP BY product_type) AS ProductSum;

--���������Ӳ�ѯ�Ĳ���
SELECT product_type, cnt_product
  FROM (SELECT *
          FROM(SELECT product_type, COUNT(*) AS cnt_product
                 FROM Product
               GROUP BY product_type) AS ProductSum
         WHERE product_type = '�����þ�') AS ProductSum2;
         
--�����Ӳ�ѯ: �������ֻ�ܷ���һ��һ�еĽ��,��ֻ��һ��ֵ
--��WHERE�Ӿ���ʹ�ñ����Ӳ�ѯ
--����ʾ��
SELECT product_id, product_name, sale_price
  FROM Product
 WHERE sale_price >  AVG(sale_price) ;
  
--����ƽ�����۵��۵ı����Ӳ�ѯ                                            
 SELECT AVG(sale_price) FROM Product ;
 
--ѡ�����۵��۸���ȫ����Ʒƽ�����۵��۵���Ʒ                        
SELECT product_id, product_name, sale_price
  FROM Product
 WHERE sale_price > (SELECT AVG(sale_price)
                         FROM Product);
                         
--�����Ӳ�ѯ����дλ�ã��ܹ��ó������������ĵط�
--��SELECT�Ӿ���ʹ��
SELECT product_id, product_name, sale_price,(SELECT AVG(sale_price)FROM Product) AS avg_price
  FROM Product;
  
--��HAVING�Ӿ���ʹ��
SELECT product_type, AVG(sale_price)
  FROM Product
  GROUP BY product_type
 HAVING AVG(sale_price) > (SELECT AVG(sale_price) FROM Product);
 
--ʹ�ñ����Ӳ�ѯ��ע������:���ض��н������ͨ�Ӳ�ѯ,���Ǳ����Ӳ�ѯ

--5-3 �����Ӳ�ѯ
--������Ʒ�������ƽ���۸�
SELECT AVG(sale_price)
  FROM Product
 GROUP BY product_type;


--����������Ӳ�ѯ
SELECT product_id, product_name, sale_price
  FROM Product
 WHERE sale_price > (SELECT AVG(sale_price)
                         FROM Product
                        GROUP BY product_type);  --����ԭ��:�Ӳ�ѯ���ز�ֹһ��ֵ
                        
                        
--�����Ӳ�ѯ                        
SELECT product_type, product_name, sale_price
  FROM Product AS P1
 WHERE sale_price > (SELECT AVG(sale_price)
                         FROM Product AS P2
                        WHERE P1.product_type = P2.product_type  --�ؼ�����
                        GROUP BY product_type);
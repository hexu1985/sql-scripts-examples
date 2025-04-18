--���ݸ���
--���ݵĲ���(INTERT����ʹ�÷���)
CREATE TABLE ProductIns
(product_id     CHAR(4)        NOT NULL ,
 product_name   VARCHAR(100)   NOT NULL ,
 product_type   VARCHAR(100)   NOT NULL ,
 sale_price     INTEGER        DEFAULT 0,   --����Ĭ��ֵ���˴����۵��۵�Ĭ��ֵ�趨Ϊ0
 purchase_price INTEGER ,
 regist_date    DATE ,
 PRIMARY KEY (product_id));
 
 INSERT into ProductIns (product_id,product_name,product_type,sale_price,purchase_price,
   regist_date) VALUES  ('0001','T����','�·�',1000,500,'2009-09-20');
 
 --���嵥����ʡ�ԣ���ǰ�洴����ʱ����ʾ
 
 
 --����NULL:Լ��������Ϊ�ǿ�ʱ�����ܲ���
 --ɾ�����嵥��ֵ�嵥��purchase_price��
 INSERT into ProductIns (product_id,product_name,product_type,sale_price,
   regist_date) VALUES  ('0008' , 'Բ���','�칫��Ʒ',100,'2009-11-11');
   
   
 --����Ĭ��ֵ��
 ----��һ:��ʽ����������DEFAULT�ؼ���
 INSERT INTO ProductIns VALUES ('0007' , '���˰�','�����þ�',DEFAULT,790,'2008-04-28'); 
 SELECT * 
 FROM ProductIns
 WHERE product_id = '0007'
 ----��������ʽ������ɾ�����嵥��ֵ�嵥��sale_price��
 INSERT into ProductIns (product_id,product_name,product_type,purchase_price,
   regist_date) VALUES ('0007' , '���˰�','�����þ�',790,'2008-04-28'); 
  --δʹ��Ĭ��ֵ
 INSERT INTO ProductIns VALUES ('0005' , '��ѹ��','�����þ�',6800,5000,'2009-01-15');
  SELECT * 
 FROM ProductIns
 WHERE product_id = '0005'
 
 --���������и�������:�����ı䣬��������
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
  --�鿴���
  SELECT * FROM ProductCopy
  
--���ܱ�
CREATE TABLE ProductType
(product_type   VARCHAR(100)   NOT NULL ,
 sum_sale_price     INTEGER ,
 sum_purchase_price INTEGER ,
 PRIMARY KEY (product_type ));
 
 INSERT into ProductType (product_type,sum_sale_price,sum_purchase_price)
  SELECT product_type,SUM(sale_price),SUM(purchase_price)
  FROM Product
  GROUP BY product_type;
  --�鿴���
  SELECT * FROM ProductType;
  
  /* ע��:INSERT����е�SELECT�����,����ʹ��WHERE�Ӿ����GROUP BY�Ӿ���κ�SQL�﷨,
  ��ʹ��ORDER BY�Ӿ䲢��������κ�Ч��.  */
  
  
  --4-2 ���ݵ�ɾ��
  --��ȫɾ���� DROP TABLE <����>;
  --ֻ����Ŀ�ܣ���ȫɾ�����е�����: DELETE FROM  <����>;
  --ָ��ɾ������DELETE FROM  <����>  WHERE <����> ��
  --ע��DELETE�����ֻ��ʹ��WHERE�Ӿ䣬GROUP BY�Ӿ��ORDER BY�Ӿ��ǳ�ȡ���ݵģ���ɾ������ʱ������������
  
  
  --4-3 ���ݵĸ���
  --UPDATE���Ļ����﷨
  UPDATE Product
     SET regist_date = '2009-10-10';
  
  SELECT * 
   FROM Product ;

--ָ��������UPDATE   
  UPDATE Product
     SET sale_price = sale_price*10
     WHERE product_type ='�����þ�';
  
 SELECT * 
   FROM Product ; 
 
--ʹ��NULL���и���
 UPDATE Product
     SET regist_date = NULL
     WHERE product_id = '0008';

SELECT * 
   FROM Product ; 
   
--���и���:һ�θ���һ���������ܻ�����˷�
UPDATE Product
     SET sale_price = sale_price*10,
         purchase_price = purchase_price/2
     WHERE product_type ='�����þ�';
  
 SELECT * 
   FROM Product ; 
   
   
--4-4 ����
-- ����:�Ա������ݽ��и��µĵ�λ,������������Ҫ��ͬһ������Ԫ��ִ�е�һϵ�и��´���ļ���
 UPDATE Product
   SET sale_price = sale_price - 1000
   WHERE product_name = '�˶�T��';
 UPDATE Product
   SET sale_price = sale_price + 1000
   WHERE product_name ='T��';
SELECT * 
   FROM Product ; 
   
   
--��������
/* ����ʼ���:BEGIN TRANSACTION;
                ���1�����2.......
   ���������䣺COMMIT:�ύ���������ȫ�����´���Ľ���ָ��൱�ڸ��Ǳ��棬
                        һ���ύ���޷��ָ�����ʼ֮ǰ״̬��������
                 ��ROLLBACK��ȡ���������ȫ�����´���Ľ���ָ��൱�ڷ������棬
                          һ���ع������ݿ�ͻ�ָ�����ʼ֮ǰ״̬����������� */
                          
--ACID����
/* DBMS����������������ԣ�ԭ���ԡ�һ���ԡ������ԡ��־���
   ԭ���ԣ����������ʱ�����а����ĸ��´���Ҫôȫ��ִ�У�Ҫô��ȫ��ִ��
   һ���ԣ������а����Ĵ���Ҫ�������ݿ���ǰ���õ�Լ������
   �����ԣ���֤��ͬ����֮�以������
   �־��ԣ��������ʱ��DBMS�ܱ�֤��ʱ��������״̬�ᱻ��������� */
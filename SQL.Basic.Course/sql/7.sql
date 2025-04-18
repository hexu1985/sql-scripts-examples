--7-1  �������㣺��ļӼ�������¼������������
--��ļӷ�-UNION(����,ȥ���ظ���¼)
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

DROP TABLE  Product2;
  
CREATE TABLE Product2
(product_id     CHAR(4)        NOT NULL ,
 product_name   VARCHAR(100)   NOT NULL ,
 product_type   VARCHAR(32)   NOT NULL ,
 sale_price     INTEGER ,
 purchase_price INTEGER ,
 regist_date    DATE ,
 PRIMARY KEY (product_id));
 
 BEGIN TRANSACTION;
 INSERT INTO Product2 VALUES ('0001' , 'T����','�·�',1000,500,'2008-09-20');
 INSERT INTO Product2 VALUES ('0002' , '�����','�칫��Ʒ',500,320,'2009-09-11');
 INSERT INTO Product2 VALUES ('0003' , '�˶�T��','�·�',4000,2800,NULL);
 INSERT INTO Product2 VALUES ('0009' , '����','�·�',800,500,NULL);
 INSERT INTO Product2 VALUES ('0010' , 'ˮ��','�����þ�',2000,1700,'2009-09-20');
 COMMIT;
 
 SELECT * 
   FROM Product2 ; 
   
   
 SELECT product_id, product_name
   FROM Product
 UNION
 SELECT product_id, product_name
   FROM Product2
  
-- ���������ע������:
--    1.��Ϊ�������ļ�¼������������ͬ
--      ����ʾ��:
      SELECT product_id, product_name
        FROM Product
      UNION
      SELECT product_id, product_name,sale_price
        FROM Product2
--    2.��Ϊ�������ļ�¼���е��������ͱ���һ��
--      ����ʾ����
      SELECT product_id, product_name
        FROM Product
      UNION
      SELECT product_id, sale_price
        FROM Product2
--  ͻ�����룺�в�ͬ������ͬ������ûɶ��˼�����г����Ľ���Ǵ����
       SELECT product_id, purchase_price
        FROM Product
      UNION
      SELECT product_id, sale_price
        FROM Product2
        
--    3.����ʹ���κε�SELECT��䣬��ORDER BY�Ӿ�ֻ�������ʹ��һ��
      SELECT product_id, product_name
        FROM Product
       WHERE product_type = '�����þ�'
       UNION
      SELECT product_id, product_name
        FROM Product2
       WHERE product_type = '�����þ�'
    ORDER BY product_id;
    
 --�����ظ��еļ�������-ALLѡ�����UNION���ALL
 SELECT product_id, product_name
   FROM Product
 UNION ALL
 SELECT product_id, product_name
   FROM Product2
  
--ѡȡ���еĹ�������-INTERSECT(����)
    SELECT product_id, product_name
      FROM Product
       INTERSECT
      SELECT product_id, product_name
        FROM Product2
    ORDER BY product_id;
 
 --��¼�ļ���-EXCEPT(�)
    SELECT product_id, product_name
      FROM Product
     EXCEPT
      SELECT product_id, product_name
        FROM Product2
    ORDER BY product_id;
    
    SELECT product_id, product_name
        FROM Product2
     EXCEPT
      SELECT product_id, product_name
      FROM Product
    ORDER BY product_id;
    
SELECT *
   FROM ShopProduct
       
--7-2  ���ᣨ����Ϊ��λ�Ա�������ᣬ������У�
--�����ᣬʹ��Product���ShopProduct��
SELECT *
   FROM Product
SELECT *
   FROM ShopProduct

SELECT SP.shop_id , SP.shop_name , SP.product_id, P.product_name,P.sale_price
FROM ShopProduct AS SP INNER JOIN Product  AS P
  ON SP.product_id = P.product_id;

--�������WHERE�Ӿ���Խ��ʹ��,GROUP��BY, ORDER BY, HAVING �ȹ��߶���������ʹ��
SELECT SP.shop_id , SP.shop_name , SP.product_id, P.product_name,P.sale_price
FROM ShopProduct AS SP INNER JOIN Product  AS P
  ON SP.product_id = P.product_id
WHERE SP.shop_id ='000A';


--�����ᣬʹ��Product���ShopProduct��
SELECT SP.shop_id , SP.shop_name , P.product_id, P.product_name,P.sale_price
FROM ShopProduct AS SP RIGHT OUTER  JOIN Product  AS P
  ON SP.product_id = P.product_id
  ORDER BY SP.shop_id;
  
--Ҫ�㣺
--     1.��ѡȡ�����ű������е�ȫ����Ϣ
--     2.ָ������Ĺؼ�����LEFT��RIGHT,д��FROM�Ӿ�������Ҳ��
SELECT SP.shop_id , SP.shop_name , P.product_id, P.product_name,P.sale_price
FROM ShopProduct AS SP LEFT OUTER  JOIN Product  AS P
  ON SP.product_id = P.product_id
  ORDER BY SP.shop_id;     --��������һ��


--3�����ϵı������
DROP TABLE InventoryProduct;

CREATE TABLE InventoryProduct
(inventory_id         CHAR(4)        NOT NULL ,
 product_id           CHAR(4)        NOT NULL ,
 inventory_quantity   INTEGER        NOT NULL ,
 PRIMARY KEY (inventory_id ,product_id));
 
 BEGIN TRANSACTION;
 INSERT INTO InventoryProduct VALUES ('P001' , '0001',0);
 INSERT INTO InventoryProduct VALUES ('P001' , '0002',120);
 INSERT INTO InventoryProduct VALUES ('P001' , '0003',200);
 INSERT INTO InventoryProduct VALUES ('P001' , '0004',3);
 INSERT INTO InventoryProduct VALUES ('P001' , '0005',0);
 INSERT INTO InventoryProduct VALUES ('P001' , '0006',99);
 INSERT INTO InventoryProduct VALUES ('P001' , '0007',999);
 INSERT INTO InventoryProduct VALUES ('P001' , '0008',200);
 INSERT INTO InventoryProduct VALUES ('P002' , '0001',10);
 INSERT INTO InventoryProduct VALUES ('P002' , '0002',25);
 INSERT INTO InventoryProduct VALUES ('P002' , '0003',34);
 INSERT INTO InventoryProduct VALUES ('P002' , '0004',19);
 INSERT INTO InventoryProduct VALUES ('P002' , '0005',99);
 INSERT INTO InventoryProduct VALUES ('P002' , '0006',0);
 INSERT INTO InventoryProduct VALUES ('P002' , '0007',0);
 INSERT INTO InventoryProduct VALUES ('P002' , '0008',18);
 COMMIT;
 
--��3�ű����������
SELECT SP.shop_id , SP.shop_name , SP.product_id, P.product_name,P.sale_price,IP.inventory_quantity
FROM ShopProduct AS SP INNER JOIN Product  AS P 
  ON SP.product_id = P.product_id 
     INNER JOIN InventoryProduct AS IP
     ON SP.product_id  = IP.product_id
WHERE IP.inventory_id = 'P001';

--��������-CROSS JOIN(�ѿ�����)--ֱ��ճ������
--   (ע��һ�㲻��ʹ�ã�����ԭ�򣺽���������������������Ļ���)
SELECT SP.shop_id , SP.shop_name , SP.product_id, P.product_name,P.sale_price
FROM ShopProduct AS SP CROSS JOIN Product  AS P ;

--��ʱ�﷨-������
SELECT SP.shop_id , SP.shop_name , SP.product_id, P.product_name,P.sale_price
FROM ShopProduct  SP,  Product  P
  WHERE SP.product_id = P.product_id
    AND SP.shop_id ='000A';
--��֮ǰ��˵�ı�׼�﷨��ͬ����������ʱ�﷨��ϣ�������˽�
SELECT SP.shop_id , SP.shop_name , SP.product_id, P.product_name,P.sale_price
FROM ShopProduct AS SP INNER JOIN Product  AS P
  ON SP.product_id = P.product_id
WHERE SP.shop_id ='000A';
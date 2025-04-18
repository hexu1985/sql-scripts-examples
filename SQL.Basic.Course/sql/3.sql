--������ �ۺϺ�����
/* �ۺϺ���
COUNT :  ������еļ�¼����������
SUM
AVG
MAX
MIN */

-- COUNT(*)�õ�����NULL�������У���COUNT(����)�õ���NULL��������
SELECT COUNT(*)
 FROM Product;
 
SELECT COUNT(*),COUNT(purchase_price)
 FROM Product;
 
 
--SUM(����)�õ���NULL��������֮��
SELECT SUM(sale_price)
 FROM Product;
 
--AVG(����)�õ���NULL��������֮���ٳ��Էǿ��и���
SELECT AVG(sale_price)
 FROM Product; 

--MAX/MIN����ԭ���Ͽ��������κ��������͵��У���SUM��AVG����������ֵ���͵���
SELECT MAX(regist_date),MIN(regist_date)
 FROM Product; 

--ʹ�þۺϺ���ɾ���ظ�ֵ���ؼ���DISTINCT��
--����ȥ���ظ����ݺ����������
SELECT COUNT(DISTINCT product_type)
 FROM Product;

--�ȼ�������������ɾ���ظ����ݵĽ�� 
SELECT DISTINCT COUNT(product_type)
 FROM Product;
 
SELECT SUM(sale_price),SUM(DISTINCT sale_price)
 FROM Product;
 
--3-2 �Ա���з���
--GROUP BY�Ӿ�(ע�⣺SELECT��GROUP BY�������Ӧ��ͬ)
SELECT product_type, COUNT(*)
  FROM Product
  GROUP BY product_type;
  
--�Ӿ���ݶ���д˳��SELECT -> FROM -> WHERE -> GROUP BY

--����NULLʱ,Ҳ��Ϊһ��

 
--ʹ��WHERE�Ӿ�ʱGROUP BYִ�н��
SELECT purchase_price, COUNT(*)
  FROM Product
  WHERE product_type ='�·�'
  GROUP BY purchase_price;
  
--��ۺϺ�����GROUP BY�Ӿ��йصĳ�������

--1.��SELECT�Ӿ�����д�˶�����
SELECT product_name,purchase_price, COUNT(*)
  FROM Product
  GROUP BY purchase_price;
--�޸�
--��һ����GROUP BY�Ӿ�����ٵ��������𲻵���������
SELECT product_name,purchase_price, COUNT(*)
  FROM Product
  GROUP BY product_name,purchase_price;
--������ɾ��SELECT�ж������
SELECT purchase_price, COUNT(*)
  FROM Product
  GROUP BY purchase_price;  
 
--2. ��GROUP BY�Ӿ���д���еı�������ִ��GROUP BY����ִ��SELECT
SELECT product_type AS pt, COUNT(*)
  FROM Product
  GROUP BY pt;
 --�����뷨�޸ĺ���Ȼ����ʹ�ã����鲻Ҫ��GROUP BY��д�еı���
SELECT product_type AS pt FROM Product;
SELECT pt, COUNT(*)
  FROM Product
  GROUP BY pt;
  
--3. ��GROUP BY�Ӿ�������ʾ�������
--4.������WHERE�Ӿ���ʹ�þۺϺ���
SELECT product_type, COUNT(*)
  FROM Product
  GROUP BY product_type;

SELECT product_type, COUNT(*)
  FROM Product
  WHERE COUNT(*) = 2
  GROUP BY product_type; 
 --��ν����4�������أ�������һ����
 
 
 --3-3 Ϊ�ۺϽ��ָ������
 --HAVING�Ӿ�
 --�Ӿ���ݶ���д˳��SELECT -> FROM -> WHERE -> GROUP BY -> HAVING
 SELECT product_type, COUNT(*)
  FROM Product
  GROUP BY product_type
  HAVING COUNT(*) = 2;
  
  SELECT product_type, AVG(sale_price)
    FROM Product
    GROUP BY product_type
    HAVING AVG(sale_price) >= 2500;
    
--HAVING�Ӿ�Ĺ���Ҫ�أ��������ۺϺ�����GROUP BY�Ӿ����������ۺϼ���
--HAVING�Ӿ����ʹ��
SELECT product_type, COUNT(*)
  FROM Product
  GROUP BY product_type
  HAVING product_name = 'Բ���';
--�޸�
--��һ��
SELECT product_type, COUNT(*)
  FROM Product
  WHERE product_name = 'Բ���'
  GROUP BY product_type;
--�����ʺ�����WHERE��� 
--������  
 SELECT product_type
  FROM Product
  WHERE product_name = 'Բ���' ;
  
--3-4 �Բ�ѯ�����������
--ORDER BY�Ӿ䣬��������κκ��������ASC,�������DESC
SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY  sale_price;
    
SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY  sale_price DESC;

--�Ӿ���ݶ���д˳��SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY


--ָ����������
SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY  sale_price,purchase_price;

--NULL��˳��������а���NULL�ǣ����ڿ�ͷ��ĩβ���л���
SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY purchase_price;

SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY purchase_price DESC;

--ORDER BY�Ӿ��п���ʹ���еı���
SELECT product_id AS id,product_name,sale_price AS sp,purchase_price
    FROM Product
    ORDER BY id,sp;
/*ԭ��ʹ��HAVINNG�Ӿ�ʱSELSCT����˳��
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
SELSCT�����GROUP BY�Ӿ�֮����ORDER BY�Ӿ�֮ǰ*/


--ORDER BY�Ӿ��п���ʹ�õ��У�
--SELECT�Ӿ��в���������
SELECT product_name,sale_price,purchase_price
    FROM Product
    ORDER BY product_id DESC;
    
--�ۺϺ���
SELECT product_type,COUNT(*)
    FROM Product
    GROUP BY product_type
    ORDER BY COUNT(*);
    
/* ��Ҫʹ���б��
�б��:SELECT�Ӿ��д����ҵ�˳������Ӧ�ı��,��1��ʼ
�����õ�ԭ��:�Ķ�����,�������ܽ���ɾ��
���ԭ��:�����˽�  */
SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY sale_price  DESC,product_id;

--���ϵȼ۵���
SELECT product_id,product_name,sale_price,purchase_price
    FROM Product
    ORDER BY 3 DESC,1;
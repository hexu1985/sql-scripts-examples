--7-1  集合运算：表的加减法（记录行数的增减）
--表的加法-UNION(并集,去除重复记录)
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
 INSERT INTO Product2 VALUES ('0001' , 'T恤衫','衣服',1000,500,'2008-09-20');
 INSERT INTO Product2 VALUES ('0002' , '打孔器','办公用品',500,320,'2009-09-11');
 INSERT INTO Product2 VALUES ('0003' , '运动T恤','衣服',4000,2800,NULL);
 INSERT INTO Product2 VALUES ('0009' , '手套','衣服',800,500,NULL);
 INSERT INTO Product2 VALUES ('0010' , '水壶','厨房用具',2000,1700,'2009-09-20');
 COMMIT;
 
 SELECT * 
   FROM Product2 ; 
   
   
 SELECT product_id, product_name
   FROM Product
 UNION
 SELECT product_id, product_name
   FROM Product2
  
-- 集合运算的注意事项:
--    1.作为运算对象的记录的列数必须相同
--      错误示例:
      SELECT product_id, product_name
        FROM Product
      UNION
      SELECT product_id, product_name,sale_price
        FROM Product2
--    2.作为运算对象的记录的列的数据类型必须一致
--      错误示例：
      SELECT product_id, product_name
        FROM Product
      UNION
      SELECT product_id, sale_price
        FROM Product2
--  突发奇想：列不同，类型同，但是没啥意思，运行出来的结果是错误的
       SELECT product_id, purchase_price
        FROM Product
      UNION
      SELECT product_id, sale_price
        FROM Product2
        
--    3.可以使用任何的SELECT语句，但ORDER BY子句只能在最后使用一次
      SELECT product_id, product_name
        FROM Product
       WHERE product_type = '厨房用具'
       UNION
      SELECT product_id, product_name
        FROM Product2
       WHERE product_type = '厨房用具'
    ORDER BY product_id;
    
 --包含重复行的集合运算-ALL选项，即在UNION后加ALL
 SELECT product_id, product_name
   FROM Product
 UNION ALL
 SELECT product_id, product_name
   FROM Product2
  
--选取表中的公共部分-INTERSECT(交集)
    SELECT product_id, product_name
      FROM Product
       INTERSECT
      SELECT product_id, product_name
        FROM Product2
    ORDER BY product_id;
 
 --记录的减法-EXCEPT(差集)
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
       
--7-2  联结（以列为单位对表进行联结，即添加列）
--内联结，使用Product表和ShopProduct表
SELECT *
   FROM Product
SELECT *
   FROM ShopProduct

SELECT SP.shop_id , SP.shop_name , SP.product_id, P.product_name,P.sale_price
FROM ShopProduct AS SP INNER JOIN Product  AS P
  ON SP.product_id = P.product_id;

--内联结和WHERE子句可以结合使用,GROUP　BY, ORDER BY, HAVING 等工具都可以正常使用
SELECT SP.shop_id , SP.shop_name , SP.product_id, P.product_name,P.sale_price
FROM ShopProduct AS SP INNER JOIN Product  AS P
  ON SP.product_id = P.product_id
WHERE SP.shop_id ='000A';


--外联结，使用Product表和ShopProduct表
SELECT SP.shop_id , SP.shop_name , P.product_id, P.product_name,P.sale_price
FROM ShopProduct AS SP RIGHT OUTER  JOIN Product  AS P
  ON SP.product_id = P.product_id
  ORDER BY SP.shop_id;
  
--要点：
--     1.会选取出单张表（主表）中的全部信息
--     2.指定主表的关键字是LEFT和RIGHT,写在FROM子句左侧表和右侧表
SELECT SP.shop_id , SP.shop_name , P.product_id, P.product_name,P.sale_price
FROM ShopProduct AS SP LEFT OUTER  JOIN Product  AS P
  ON SP.product_id = P.product_id
  ORDER BY SP.shop_id;     --和内联结一样


--3张以上的表的联结
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
 
--对3张表进行内联结
SELECT SP.shop_id , SP.shop_name , SP.product_id, P.product_name,P.sale_price,IP.inventory_quantity
FROM ShopProduct AS SP INNER JOIN Product  AS P 
  ON SP.product_id = P.product_id 
     INNER JOIN InventoryProduct AS IP
     ON SP.product_id  = IP.product_id
WHERE IP.inventory_id = 'P001';

--交叉联结-CROSS JOIN(笛卡尔积)--直接粘贴过来
--   (注：一般不会使用，介绍原因：交叉联结是所有联结运算的基础)
SELECT SP.shop_id , SP.shop_name , SP.product_id, P.product_name,P.sale_price
FROM ShopProduct AS SP CROSS JOIN Product  AS P ;

--过时语法-内联结
SELECT SP.shop_id , SP.shop_name , SP.product_id, P.product_name,P.sale_price
FROM ShopProduct  SP,  Product  P
  WHERE SP.product_id = P.product_id
    AND SP.shop_id ='000A';
--与之前所说的标准语法相同，会碰到过时语法，希望有所了解
SELECT SP.shop_id , SP.shop_name , SP.product_id, P.product_name,P.sale_price
FROM ShopProduct AS SP INNER JOIN Product  AS P
  ON SP.product_id = P.product_id
WHERE SP.shop_id ='000A';
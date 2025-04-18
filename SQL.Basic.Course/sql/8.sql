--SQL �߼�����
--8-1 ���ں���
/* ���ں���Ҳ��ΪOLAP�����������ݿ����ݽ���ʵʱ�����������з�����������ֹ���
   �﷨��  <���ں���>  OVER  ([PARTITION  BY <���嵥>]    --[]�����ݿ���ʡ��
                                  ORDER BY <���������嵥>)
   ���ں���������Է�Ϊ�������֣�
     1. �ܹ���Ϊ���ں����ľۺϺ�����SUM��AVG��COUNT��MAX��MIN��
     2.RANK��DENSE_RANK��ROW_NUMBER��ר�ô��ں���    */
        
     
--ʹ��RANK���������������¼����ĺ���
SELECT product_name, product_type, sale_price,
       RANK () OVER (PARTITION BY product_type    --PARTITION BY �趨����Ķ���Χ
                         ORDER BY sale_price ) AS ranking  --ORDER BY ָ��������һ�У������ǽ����������
  FROM Product;
  
 --��ָ��PARTITION BY���õ��Ľ���ǲ��п��
 SELECT product_name, product_type, sale_price,
       RANK () OVER (ORDER BY sale_price) AS ranking 
  FROM Product;
  
  /*  ר�ô��ں��������ࣺ
            1.RANK��������������ʱ�����������ͬλ�εļ�¼���������֮���λ�Σ���1��1��3.....
            2.DENSE_RANK��������������ʱ����ʹ������ͬλ�εļ�¼��Ҳ��������֮���λ�Σ���1��1��2.....
            3.ROW_NUMBER����������Ψһ������λ�Σ���2����¼���ڵ�1λʱ��1��2��3...... */
  --���бȽ�
  SELECT product_name, product_type, sale_price,
       RANK () OVER (ORDER BY sale_price) AS ranking, 
       DENSE_RANK () OVER (ORDER BY sale_price) AS dense_ranking,
       ROW_NUMBER () OVER (ORDER BY sale_price) AS row_num
  FROM Product;
  
  --���÷�Χ��ֻ����SELECT�����ʹ�� 
 
  --��Ϊ���ں���ʹ�õľۺϺ�����Ҫָ�����ں����еı���
  SELECT product_id, product_name, sale_price,
       SUM(sale_price)  OVER (ORDER BY product_id) AS current_sum   --�ۼ����
  FROM Product;
  
  SELECT product_id, product_name, sale_price,
       AVG (sale_price) OVER (ORDER BY product_id) AS current_avg     --�ۼ���ƽ��
  FROM Product;
  
  
  SELECT product_id, product_name, sale_price
       AVG (sale_price) OVER (ORDER BY product_id
                              ROWS 2 PRECEDING) AS moving_avg     --�ƶ�ƽ����ָ�������������Ϊ���ܶ���  
  FROM Product;
  -- ROWS 2 PRECEDING  ��ܣ���ֹ��֮ǰ����
  
  
SELECT product_id, product_name, sale_price,
       AVG (sale_price) OVER (ORDER BY product_id
                                ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg
  FROM Product;
 -- ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING   ��ܣ���ֹ��֮ǰһ�к�֮��һ��
  
-- ����ORDER BY
--ע��һ��ORDER BYֻ��ָ��ranking��Ԫ���е���ֵ������������������ģ�
--Ҫ�����򣬵��ٴ�ʹ��һ��ORDER BY
SELECT product_name, product_type, sale_price, 
       RANK () OVER (ORDER BY sale_price) AS ranking
  FROM Product;  
  
 SELECT product_name, product_type, sale_price, 
       RANK () OVER (ORDER BY sale_price) AS ranking
  FROM Product
 ORDER BY ranking;  
 
 
-- 8-2  GROUPING����� ��ͬʱ�õ�С�ƺͺϼƣ�
--ͬʱ�õ��ϼ���
SELECT product_type, SUM(sale_price)
  FROM Product
GROUP BY product_type;
 
 --��Ӻϼ���,��ͨ����UNION ALL���������Ϊһ��
SELECT '�ϼ�' AS product_type, SUM(sale_price) AS sum
  FROM Product
UNION ALL
SELECT product_type, SUM(sale_price)
  FROM Product
GROUP BY product_type;

--���淽������������GROUPING�������ROLLUP��CUSE��GROUPING SETS 
-- ROLLUP:ͬʱ�õ��ϼƺ�С��
-- ���������¼Ĭ��ʹ��NULL��Ϊ�ۺϼ�
SELECT product_type, SUM(sale_price) AS sum_price
  FROM Product
 GROUP BY ROLLUP(product_type);
 
  SELECT * FROM Product
--���Ǽ�������ӵ��ۺϼ����У���ʹ��ROLLUP       ֻ��ͬһ����Ʒ��ͬһ���ڵĺϼ�
SELECT product_type, regist_date, SUM(sale_price) AS sum_price
  FROM Product
GROUP BY product_type, regist_date; 
 
--���Ǽ�������ӵ��ۺϼ����У�ʹ��ROLLUP           ����������ϣ�����˰���ϼƺ��ܺϼ�
 SELECT product_type, regist_date, SUM(sale_price) AS sum_price
  FROM Product
 GROUP BY ROLLUP(product_type, regist_date);
 
 
 --ʹ��GROUPING�����ж�NULL���������������¼�е�NULL����1�����෵��0
 SELECT GROUPING(product_type) AS product_type, 
        GROUPING(regist_date) AS regist_date, SUM(sale_price) AS sum_price
  FROM Product
 GROUP BY ROLLUP(product_type, regist_date);
 
 --�ڳ��������¼�ļ�ֵ�в���ǡ�����ַ���
 SELECT CASE WHEN GROUPING(product_type) = 1 
            THEN '��Ʒ���� �ϼ�' 
            ELSE product_type END AS product_type,
       CASE WHEN GROUPING(regist_date) = 1 
            THEN '�Ǽ����� �ϼ�' 
            ELSE CAST(regist_date AS VARCHAR(16)) END AS regist_date,
       SUM(sale_price) AS sum_price
  FROM Product
 GROUP BY ROLLUP(product_type, regist_date);
 

--CUSE:ȡ��ȫ����ϵ�Ч��
 SELECT CASE WHEN GROUPING(product_type) = 1 
            THEN '��Ʒ���� �ϼ�'
            ELSE product_type END AS product_type,
       CASE WHEN GROUPING(regist_date) = 1 
            THEN '�Ǽ����� �ϼ�'
            ELSE CAST(regist_date AS VARCHAR(16)) END AS regist_date,
       SUM(sale_price) AS sum_price
  FROM Product
 GROUP BY CUBE(product_type, regist_date);
 
 
--GROUPING SETS��ȡ�������Ļ�ľ��ֻȡ�ò�����ϵĽ��
 SELECT CASE WHEN GROUPING(product_type) = 1 
            THEN '��Ʒ���� �ϼ�'
            ELSE product_type END AS product_type,
       CASE WHEN GROUPING(regist_date) = 1 
            THEN '�Ǽ����� �ϼ�'
            ELSE CAST(regist_date AS VARCHAR(16)) END AS regist_date,
       SUM(sale_price) AS sum_tanka
  FROM Product
 GROUP BY GROUPING SETS (product_type, regist_date);
/*
  �����������е�SELECT���
*/
-- ʹ�ñ�����ʹ�õ�Shohin��
SELECT *
  FROM Shohin
UNION
SELECT *
  FROM Shohin
INTERSECT
SELECT *
  FROM Shohin
ORDER BY shohin_id;
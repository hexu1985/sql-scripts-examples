/*
  �����������SELECT���
*/
SELECT shohin_id, SUM(shohin_mei)
-- ��SELECT����д���
  FROM Shohin
 GROUP BY shohin_bunrui
 WHERE torokubi > '2009-09-01';

SELECT shiire_tanka, COUNT(*)
  FROM Shohin
 WHERE shohin_bunrui = '�·�'
 GROUP BY shiire_tanka;
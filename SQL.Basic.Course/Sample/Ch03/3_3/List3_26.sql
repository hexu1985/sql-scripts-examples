SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
WHERE shohin_bunrui = '�·�'
 GROUP BY shohin_bunrui;
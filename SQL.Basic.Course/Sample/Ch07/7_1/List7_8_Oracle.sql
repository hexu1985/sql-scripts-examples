-- ��Shohin2�ļ�¼��ɾ��Shohin�ļ�¼
SELECT shohin_id, shohin_mei
  FROM Shohin2
MINUS
SELECT shohin_id, shohin_mei
  FROM Shohin
ORDER BY shohin_id;
SELECT shohin_id, shohin_mei
  FROM Shohin
 WHERE shohin_bunrui = '�����þ�'
UNION
SELECT shohin_id, shohin_mei
  FROM Shohin2
 WHERE shohin_bunrui = '�����þ�'
ORDER BY shohin_id;



/* ע�������
-- ����������ͬ���ᷢ������
SELECT shohin_id, shohin_mei
  FROM Shohin
UNION
SELECT shohin_id, shohin_mei, hanbai_tanka
  FROM Shohin2;
*/

/* ע�������
-- �����������Ͳ�ͬ����������
SELECT shohin_id, hanbai_tanka
  FROM Shohin
UNION
SELECT shohin_id, torokubi
  FROM Shohin2;
*/
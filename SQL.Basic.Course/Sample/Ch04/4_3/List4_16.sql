UPDATE Shohin
   SET hanbai_tanka = hanbai_tanka * 10
 WHERE shohin_bunrui = '�����þ�';

-- ȷ�ϸ�������
SELECT * FROM Shohin ORDER BY shohin_id;
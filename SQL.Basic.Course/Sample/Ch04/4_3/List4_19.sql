-- ʹ�ö��Ŷ��н��зָ�����
UPDATE Shohin
   SET hanbai_tanka = hanbai_tanka * 10,
       shiire_tanka = shiire_tanka / 2
 WHERE shohin_bunrui = '�����þ�';

-- ȷ�ϸ��½��
SELECT * FROM Shohin ORDER BY shohin_id;
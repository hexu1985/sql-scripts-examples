-- ������С�������������б���ʽ
UPDATE Shohin
   SET (hanbai_tanka, shiire_tanka) = (hanbai_tanka * 10, shiire_tanka / 2)
 WHERE shohin_bunrui = '�����þ�';

-- ȷ�ϸ�������
SELECT * FROM Shohin ORDER BY shohin_id;
-- ����Ʒ���е����ݸ��Ƶ�������Ʒ����
INSERT INTO ShohinCopy (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi)
SELECT shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi
  FROM Shohin;

-- ȷ�ϸ�����
SELECT * FROM ShohinCopy;
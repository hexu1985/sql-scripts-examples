CREATE VIEW ShohinSumJim (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, cnt_shohin
  FROM ShohinSum
 WHERE shohin_bunrui = '�칫��Ʒ';

-- ȷ�ϴ����õ���ͼ
SELECT shohin_bunrui, cnt_shohin
  FROM ShohinSumJim;
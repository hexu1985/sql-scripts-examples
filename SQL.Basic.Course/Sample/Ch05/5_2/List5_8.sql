-- ������Ʒ����ͳ����Ʒ��������ͼ
CREATE VIEW ShohinSum (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui;

-- ȷ�ϴ��������ͼ
SELECT shohin_bunrui, cnt_shohin
  FROM ShohinSum;



/* ɾ��ShohinSum�����
DROP VIEW ShohinSum;
*/
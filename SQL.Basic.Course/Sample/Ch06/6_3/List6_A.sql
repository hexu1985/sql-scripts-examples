
-- ʹ�ü�CASE���ʽ�����
SELECT shohin_mei,
       CASE shohin_bunrui
            WHEN '�·�'         THEN 'A��' || shohin_bunrui
            WHEN '�칫��Ʒ'     THEN 'B��' || shohin_bunrui
            WHEN '�����þ�' THEN 'C��' || shohin_bunrui
            ELSE NULL
        END AS abc_shohin_bunrui
  FROM Shohin;



/*
-- ʹ�ò�ѯCASE���ʽ���������д�����嵥6-41��
SELECT shohin_mei,
       CASE WHEN shohin_bunrui = '�·�'         THEN 'A��' || shohin_bunrui
            WHEN shohin_bunrui = '�칫��Ʒ'     THEN 'B��' || shohin_bunrui
            WHEN shohin_bunrui = '�����þ�' THEN 'C��' || shohin_bunrui
            ELSE NULL
       END AS abc_shohin_bunrui
  FROM Shohin;
*/


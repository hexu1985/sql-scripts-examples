-- Oracle��ʹ��DECODE����CASE���ʽ
SELECT  shohin_mei,
        DECODE(shohin_bunrui, '�·�',         'A��' || shohin_bunrui,
                              '�칫��Ʒ',     'B��' || shohin_bunrui,
                              '�����þ�', 'C��' || shohin_bunrui,
               NULL) AS abc_shohin_bunrui
  FROM Shohin;
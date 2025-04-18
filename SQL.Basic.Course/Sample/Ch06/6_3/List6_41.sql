SELECT shohin_mei,
       CASE WHEN shohin_bunrui = '�·�'         THEN 'A��' || shohin_bunrui
            WHEN shohin_bunrui = '�칫��Ʒ'     THEN 'B��' || shohin_bunrui
            WHEN shohin_bunrui = '�����þ�' THEN 'C��' || shohin_bunrui
            ELSE NULL
       END AS abc_shohin_bunrui
  FROM Shohin;
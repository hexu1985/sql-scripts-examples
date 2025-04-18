SELECT CASE WHEN GROUPING(shohin_bunrui) = 1 
            THEN '��Ʒ���� �ϼ�'
            ELSE shohin_bunrui END AS shohin_bunrui,
       CASE WHEN GROUPING(torokubi) = 1 
            THEN '�Ǽ����� �ϼ�'
            ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
       SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY CUBE(shohin_bunrui, torokubi);
-- ��torokubiΪNULLʱ����ʾ��1��1��1�ա���
SELECT torokubi, shohin_mei, hanbai_tanka,
       SUM (hanbai_tanka) OVER (ORDER BY COALESCE(torokubi, CAST('0001-01-01' AS DATE))) AS current_sum_tanka
  FROM Shohin;

-- ��torokubiΪNULLʱ�����ü�¼������ǰ��ʾ��
SELECT torokubi, shohin_mei, hanbai_tanka,
       SUM (hanbai_tanka) OVER (ORDER BY torokubi NULLS FIRST) AS current_sum_tanka
  FROM Shohin;
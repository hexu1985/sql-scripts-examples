-- 1.�µ����۵���
UPDATE ShohinSaeki
   SET hanbai_tanka = 3000
 WHERE shohin_id = '0003';

-- 2.�����ټ���
UPDATE ShohinSaeki
   SET saeki = hanbai_tanka - shiire_tanka
 WHERE shohin_id = '0003';

-- ȷ�����ݸ���
SELECT * FROM ShohinSaeki;

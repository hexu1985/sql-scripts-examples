-- �԰�����Ʒ����õ������۵��ۺϼ�ֵ��������ת��
SELECT SUM(CASE WHEN shohin_bunrui = '�·�'         THEN hanbai_tanka ELSE 0 END) AS sum_tanka_ihuku,
       SUM(CASE WHEN shohin_bunrui = '�����þ�' THEN hanbai_tanka ELSE 0 END) AS sum_tanka_kitchen,
       SUM(CASE WHEN shohin_bunrui = '�칫��Ʒ'     THEN hanbai_tanka ELSE 0 END) AS sum_tanka_jimu
  FROM Shohin;
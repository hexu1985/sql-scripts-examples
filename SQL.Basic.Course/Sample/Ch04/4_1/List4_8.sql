-- ʡ��shiire_tanka�У���Լ������Ĭ�ϲ���NULL
INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, torokubi) VALUES ('0008', 'Բ���', '�칫��Ʒ', 100, '2009-11-11');

-- ȷ�ϲ�����
SELECT * FROM ShohinIns WHERE shohin_id = '0008';

-- ʡ��shohin_mei�У�NOT NULLԼ����������
INSERT INTO ShohinIns (shohin_id, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) VALUES ('0009', '�칫��Ʒ', 1000, 500, '2009-12-12');
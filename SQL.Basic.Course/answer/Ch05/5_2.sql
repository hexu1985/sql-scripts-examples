/*
  �����������е�SELECT���
*/
-- ����ͼ�����1�м�¼
INSERT INTO ViewRenshu5_1 VALUES ('��', 300, '2009-11-02');


-- ʵ���Ϻ������INSERT�����ͬ
INSERT INTO Shohin (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) 
            VALUES (NULL, '��', NULL, 300, NULL, '2009-11-02');



/*
  ʹ��PostgreSQLʱ����Ҫ��INSERT֮ǰ
  ִ��������佫��ͼ�趨Ϊ���Ը���
*/
CREATE OR REPLACE RULE insert_rule5_1
AS ON INSERT
TO ViewRenshu5_1 DO INSTEAD
INSERT INTO Shohin (shohin_mei, hanbai_tanka, torokubi)
VALUES (new.shohin_mei, new.hanbai_tanka, new.torokubi);


/* 
  ���������趨֮���ٴ�ִ��INSERTʱ����������������NOT NULLԼ������������
postgres=# INSERT INTO ViewRenshu5_1 VALUES ('��', 300, '2009-11-02');
ERROR:  null value in column "shohin_id" violates not-null constraint
*/

/*
  ɾ��Shohin�������ݵ�DELETE���
 ���ָ���ʹ��CREATE TABLE����ʱ����Ϊ�յ�״̬��
*/
DELETE FROM Shohin;


/*
  ���������������3�м�¼��INSERT���
*/
-- ���3�м�¼��SQL Server��PostgreSQL�������
BEGIN TRANSACTION;
    INSERT INTO Shohin VALUES ('0001', 'T��', '�·�', 1000, 500, '2009-09-20');
    INSERT INTO Shohin VALUES ('0002', '�����', '�칫��Ʒ', 500, 320, '2009-09-11');
    INSERT INTO Shohin VALUES ('0003', '�˶�T��', '�·�', 4000, 2800, NULL);
COMMIT;

-- ���3�м�¼��MySQL�������
START TRANSACTION;
    INSERT INTO Shohin VALUES ('0001', 'T��', '�·�', 1000, 500, '2009-09-20');
    INSERT INTO Shohin VALUES ('0002', '�����', '�칫��Ʒ', 500, 320, '2009-09-11');
    INSERT INTO Shohin VALUES ('0003', '�˶�T��', '�·�', 4000, 2800, NULL);
COMMIT;

-- ���3�м�¼��Oracle��DB2�������
INSERT INTO Shohin VALUES ('0001', 'T��', '�·�', 1000, 500, '2009-09-20');
INSERT INTO Shohin VALUES ('0002', '�����', '�칫��Ʒ', 500, 320, '2009-09-11');
INSERT INTO Shohin VALUES ('0003', '�˶�T��', '�·�', 4000, 2800, NULL);
COMMIT;


/*
  �����������е�INSERT���
  ��Shohin���в���Shohin����������
*/
INSERT INTO Shohin SELECT * FROM Shohin;
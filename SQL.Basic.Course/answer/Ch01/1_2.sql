-- [PostgreSQL] [MySQL]
ALTER TABLE Jyushoroku ADD COLUMN yubin_bango CHAR(8) NOT NULL;


-- [Oracle]
ALTER TABLE Jyushoroku ADD (yubin_bango CHAR(8)) NOT NULL;


-- [SQL Server]
ALTER TABLE Jyushoroku ADD yubin_bango CHAR(8) NOT NULL;


/*
 [DB2] �޷���ӡ�
 ��DB2�У����ҪΪ��ӵ����趨NOT NULLԼ����
 ��Ҫ����������ָ��Ĭ��ֵ������ɾ��NOT NULLԼ����
 ������޷�������С�

*/
-- [DB2 ������]
ALTER TABLE Jyushoroku ADD COLUMN yubin_bango CHAR(8) NOT NULL DEFAULT '0000-000';
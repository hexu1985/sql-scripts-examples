-- MySQL��ʹ��IF����CASE���ʽ
SELECT  shohin_mei,
        IF( IF( IF(shohin_bunrui = '�·�',  CONCAT('A��', shohin_bunrui), NULL)
            	    IS NULL AND shohin_bunrui = '�칫��Ʒ', CONCAT('B��', shohin_bunrui), 
            	IF(shohin_bunrui = '�·�',  CONCAT('A��', shohin_bunrui), NULL))
                    IS NULL AND shohin_bunrui = '�����þ�', CONCAT('C��', shohin_bunrui), 
                    IF( IF(shohin_bunrui = '�·�',  CONCAT('A��', shohin_bunrui), NULL)
            	    IS NULL AND shohin_bunrui = '�칫��Ʒ', CONCAT('B��', shohin_bunrui), 
            	IF(shohin_bunrui = '�·�',  CONCAT('A��', shohin_bunrui), NULL))) AS abc_shohin_bunrui
  FROM Shohin;
START TRANSACTION;

    -- �˶�T�������۵����µ�1000��Ԫ
    UPDATE Shohin
       SET hanbai_tanka = hanbai_tanka - 1000
     WHERE shohin_mei = '�˶�T��';

    -- T�������۵����ϸ�1000��Ԫ
    UPDATE Shohin
       SET hanbai_tanka = hanbai_tanka + 1000
     WHERE shohin_mei = 'T��';

COMMIT;
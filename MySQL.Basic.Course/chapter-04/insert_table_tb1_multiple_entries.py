#!/usr/bin/env python3

import MySQLdb
from db_config import *

mydb = MySQLdb.connect(host=CONFIG_DB_HOST, port=CONFIG_DB_PORT,
                        user=CONFIG_DB_USER, password=CONFIG_DB_PASSWD,
                        database=CONFIG_DB_NAME, charset='utf8')

cursor = mydb.cursor()
data = [("A101","佐藤",40),
        ("A102","高桥",28),
        ("A103","中川",20),
        ("A104","渡边",23),
        ("A105","西泽",35),
        ]

sqlstr = """
INSERT INTO tb1 VALUES(%s, %s, %s)
"""
cursor.executemany(sqlstr, data)
cursor.close()
mydb.commit()
mydb.close()


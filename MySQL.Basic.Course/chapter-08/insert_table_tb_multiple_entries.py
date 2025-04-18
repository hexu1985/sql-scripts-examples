#!/usr/bin/env python3

import MySQLdb
from db_config import *

mydb = MySQLdb.connect(host=CONFIG_DB_HOST, port=CONFIG_DB_PORT,
                        user=CONFIG_DB_USER, password=CONFIG_DB_PASSWD,
                        database=CONFIG_DB_NAME, charset='utf8')

cursor = mydb.cursor()
data = [('A103',101,4),
        ('A102',54,5),
        ('A104',181,4),
        ('A101',184,4),
        ('A103', 17,5),
        ('A101',300,5),
        ('A102',205,6),
        ('A104', 93,5),
        ('A103', 12,6),
        ('A107', 87,6),
        ]

sqlstr = """
INSERT INTO tb VALUES(%s, %s, %s)
"""
cursor.executemany(sqlstr, data)
cursor.close()
mydb.commit()
mydb.close()

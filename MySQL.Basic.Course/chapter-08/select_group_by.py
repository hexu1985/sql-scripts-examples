#!/usr/bin/env python3

import MySQLdb
from db_config import *

mydb = MySQLdb.connect(host=CONFIG_DB_HOST, port=CONFIG_DB_PORT,
                        user=CONFIG_DB_USER, password=CONFIG_DB_PASSWD,
                        database=CONFIG_DB_NAME, charset='utf8')

cursor = mydb.cursor()
sqlstr = """
SELECT empid, AVG(sales) FROM tb GROUP BY empid
"""
cursor.execute(sqlstr)
while True:
    data = cursor.fetchone()
    if (data):
        print(data)
    else:
        break
cursor.close()
mydb.commit()
mydb.close()


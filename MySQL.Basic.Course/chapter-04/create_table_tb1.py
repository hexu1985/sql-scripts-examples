#!/usr/bin/env python3

import MySQLdb
from db_config import *

mydb = MySQLdb.connect(host=CONFIG_DB_HOST, port=CONFIG_DB_PORT,
                        user=CONFIG_DB_USER, password=CONFIG_DB_PASSWD,
                        database=CONFIG_DB_NAME, charset='utf8')

cursor = mydb.cursor()
sqlstr = """
CREATE TABLE tb1 (empid VARCHAR(10),name VARCHAR(10),age INT) CHARSET=utf8
"""
cursor.execute(sqlstr)
cursor.close()
mydb.commit()
mydb.close()


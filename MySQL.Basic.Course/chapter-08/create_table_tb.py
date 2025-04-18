#!/usr/bin/env python3

import MySQLdb
from db_config import *

mydb = MySQLdb.connect(host=CONFIG_DB_HOST, port=CONFIG_DB_PORT,
                        user=CONFIG_DB_USER, password=CONFIG_DB_PASSWD,
                        database=CONFIG_DB_NAME, charset='utf8')

cursor = mydb.cursor()
sqlstr = """
CREATE TABLE tb (empid VARCHAR(20),sales INT,month INT)
"""
cursor.execute(sqlstr)
cursor.close()
mydb.commit()
mydb.close()


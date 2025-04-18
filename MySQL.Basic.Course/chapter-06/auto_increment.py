
#!/usr/bin/env python3

import MySQLdb
from db_config import *

mydb = MySQLdb.connect(host=CONFIG_DB_HOST, port=CONFIG_DB_PORT,
                        user=CONFIG_DB_USER, password=CONFIG_DB_PASSWD,
                        database=CONFIG_DB_NAME, charset='utf8')

cursor = mydb.cursor()

cursor.execute("""
DROP TABLE IF EXISTS t_serial
""")

cursor.execute("""
CREATE TABLE t_serial (a INT AUTO_INCREMENT PRIMARY KEY,b VARCHAR(10)) CHARSET=utf8
""")

cursor.execute("""
INSERT INTO t_serial (b) VALUES('子')
""")

cursor.execute("""
INSERT INTO t_serial (b) VALUES('丑')
""")

cursor.execute("""
INSERT INTO t_serial (b) VALUES('寅')
""")

cursor.execute("""
SELECT * FROM t_serial
""")

while True:
    data = cursor.fetchone()
    if (data):
        print(data)
    else:
        break

cursor.close()
mydb.commit()
mydb.close()


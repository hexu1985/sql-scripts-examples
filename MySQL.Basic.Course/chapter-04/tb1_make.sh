#!/bin/bash

DB_USER="hexu"
DB_PASSWD="123456"

mysql -u${DB_USER} -p${DB_PASSWD} -Dtest -e "source tb1_make.sql"

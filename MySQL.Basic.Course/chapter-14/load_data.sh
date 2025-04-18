#!/bin/bash

cp t.csv /tmp/
mysql -Dtest -uhexu -p123456 -e "load data infile '/tmp/t.csv' into table tb1 character set utf8 fields terminated by ','"


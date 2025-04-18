#!/bin/bash

sudo rm -f /tmp/out2.csv
mysql -Dtest -uhexu -p123456 -e "SELECT * INTO OUTFILE '/tmp/out2.csv' FIELDS TERMINATED BY ',' FROM tb1"
cat /tmp/out2.csv

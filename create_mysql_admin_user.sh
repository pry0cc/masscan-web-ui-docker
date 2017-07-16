#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

PASS=${MYSQL_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${MYSQL_PASS} ] && echo "preset" || echo "random" )
echo "=> Creating MySQL masscan user with ${_word} password"

mysql -uroot -e "create database masscan"
mysql -uroot -e "CREATE USER 'masscan'@'127.0.0.1' IDENTIFIED BY '$PASS'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON masscan.* TO 'masscan'@'127.0.0.1'"
echo "define('DB_PASSWORD', '$PASS');" >> /app/config.php 

mysql -uroot masscan < /app/db-structure-mysql.sql

# You can create a /mysql-setup.sh file to intialized the DB
if [ -f /mysql-setup.sh ] ; then
  . /mysql-setup.sh
fi

echo "=> Done!"

echo "========================================================================"
echo "You can now connect to this MySQL Server using:"
echo ""
echo "    mysql -umasscan -p$PASS -h<host> -P<port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "MySQL user 'root' has no password but only allows local connections"
echo "========================================================================"

mysqladmin -uroot shutdown

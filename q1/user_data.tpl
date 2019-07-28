#!/bin/bash
yum update -y
echo "starting mysql-server installation" >> /home/ec2-user/.av-start-up.log
yum install mysql-server -y
echo "mysql-server installed" >> /home/ec2-user/.av-start-up.log
/sbin/service mysqld start
mysqladmin -u root password 'toor'
RDS_MYSQL_ENDPOINT="${rds_endpoint}";
RDS_MYSQL_USR="${rds_usr}";
RDS_MYSQL_PWD="${rds_pwd}";
RDS_MYSQL_BASE="${rds_dbname}";
mysql -h $RDS_MYSQL_ENDPOINT -u $RDS_MYSQL_USR -p$RDS_MYSQL_PWD -D $RDS_MYSQL_BASE -e 'quit';
if [[ $? -eq 0 ]]; then
  echo "MySQL: connection OK" >> conn;
  mysql -h $RDS_MYSQL_ENDPOINT -u $RDS_MYSQL_USR -p$RDS_MYSQL_PWD -D $RDS_MYSQL_BASE -e 'CREATE TABLE av_test( id INT, name VARCHAR(20))';
  echo "MySQL: table created" >> conn;
  mysql -h $RDS_MYSQL_ENDPOINT -u $RDS_MYSQL_USR -p$RDS_MYSQL_PWD -D $RDS_MYSQL_BASE -e 'INSERT into av_test (id, name) VALUES (1, "Avinash")';
  echo "MySQL: row inserted" >> conn;
  echo "MySQL: select query -" >> conn;
  mysql -h $RDS_MYSQL_ENDPOINT -u $RDS_MYSQL_USR -p$RDS_MYSQL_PWD -D $RDS_MYSQL_BASE -e 'SELECT * from av_test' >> conn;
else
  echo "MySQL: connection Failed" >> conn;
fi;

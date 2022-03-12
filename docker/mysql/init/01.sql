DROP USER IF EXISTS 'nlp'@'%';
CREATE USER 'nlp'@'%' identified with 'mysql_native_password' by 'nlp';

CREATE DATABASE IF NOT EXISTS `nlp`;
GRANT ALL ON `nlp`.* TO 'nlp'@'%';

GRANT ALL PRIVILEGES ON *.* TO 'nlp'@'%';
flush privileges;

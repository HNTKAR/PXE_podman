CREATE DATABASE kea_db;
CREATE USER 'kea_user'@'localhost' IDENTIFIED BY 'kea_password';
GRANT ALL ON kea_db.* TO 'kea_user'@'localhost';
SET GLOBAL innodb_flush_log_at_trx_commit=2;
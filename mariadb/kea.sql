CREATE DATABASE kea_db;
CREATE USER 'kea_user'@'localhost' IDENTIFIED BY 'kea_password';
GRANT ALL ON kea_db.* TO 'kea_user'@'localhost';
SET @@global.log_bin_trust_function_creators = 1;
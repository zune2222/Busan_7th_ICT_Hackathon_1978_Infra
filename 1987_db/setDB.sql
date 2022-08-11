CREATE DATABASE 1987_god_think;

create user 'admin'@'%' identified by 'qwer1234';
grant all privileges on 1987_god_think.* to 'admin'@'%' identified by 'qwer1234';
flush privileges;
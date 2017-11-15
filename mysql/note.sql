# 列出所有的服务器上的数据库
show databases;

# 查看表
USE blog;
SHOW TABLES;

# 查看表中的列
SHOW COLUMNS FROM auth_user;
  DESCRIBE auth_user;
#查看表信息
  desc tb_dept;
  --- describe 表名  是 show columns from 表名 的一种快捷方式

# 修改密码
-- cmd,运行DOS，cd到mysql的bin文件夹，然后执行如下
-- D:\Mysql\bin>mysqladmin -u root -p password newPwd
-- Enter password:(在此输入原密码)
-- newPwd指的是新密码
-- 然后打开mysql 直接输入新密码即可
-- 格式：mysqladmin -u用户名 -p旧密码 password 新密码。

# 创建数据库
CREATE DATABASE 库名; create database if not exists 库名
# 删除数据库
DROP DATABASE 库名;

# 创建customer表
# smallint
create table customers(
    id int unsigned not null auto_increment,  -- id unsigned int primary key auto_increment
    name char(20) not null default '',
    address varchar(50) null default '',
    city char(50) null default '',
    age int not null default 0,
    love char(50) not null default 'No habbit',
    primary key(id)
)engine=InnoDB;
-- MyISAM

# 删除数据表;
DROP TABLE 表名;
# 将表中记录清空;
DELETE FROM 表名;
#重命名表
rename table pet to animals;

#增加一列
alter table 表名 add 列名 char(100) null;
#删除
alter table 表名 drop column 列名;

# 为 parts 表增加一个索引,索引建立在 model 字段上,给这个索引起个名字叫idx_model
ALTER TABLE parts ADD INDEX idx_model (model);


insert tb3 (id,username) values (4,'jona');

-- 字符串长度
length(str): 			是计算字段的长度一个汉字是算三个字符,一个数字或字母算一个字符
CHAR_LENGTH(str) 		返回值为字符串str 的长度，长度的单位为字符。一个多字节字符算作一个单字符。对于一个包含五个二字节字符集, LENGTH()返回值为 10,而CHAR_LENGTH()的返回值为5。
CHARACTER_LENGTH(str) CHARACTER_LENGTH()是CHAR_LENGTH()的同义词。
BIT_LENGTH(str) 		返回2进制长度.
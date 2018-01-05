
-- 数值类型
--
-- tinyint		1 字节	(-128,127)					(0,255)	小整数值
-- smallint		2 字节	(-32 768,32 767)			(0,65 535)	大整数值
-- mediumint	3 字节	(-8 388 608,8 388 607)		(0,16 777 215)	大整数值
-- int/integer	4 字节	(-2 147 483 648,2 147 483 647)	(0,4 294 967 295)	大整数值
-- bigint		8 字节	
-- FLOAT		4 字节		单精度浮点数值
-- DOUBLE		8 字节		双精度浮点数值
-- DECIMAL		对DECIMAL(M,D)如果M>D，为M+2否则为D+2	依赖于M和D的值	小数值

-- 日期和时间类型
--
-- DATE			3 字节	1000-01-01/9999-12-31		YYYY-MM-DD	日期值
-- TIME			3 字节	'-838:59:59'/'838:59:59'	HH:MM:SS	时间值或持续时间
-- YEAR			1 字节	1901/2155					YYYY		年份值
-- DATETIME		8 字节	1000-01-01 00:00:00/9999-12-31 23:59:59	 YYYY-MM-DD HH:MM:SS
-- TIMESTAMP	4 字节	1970-01-01 00:00:00 结束时间: 2147483647 秒,到 2038-1-19 11:14:07，可根据时区自动调整
-- from_unixtime 时间戳转换为日期
-- unix_timestamp 日期转换为时间戳

-- 日期和时间类型
-- 
-- CHAR			0-255			字节	定长字符串
-- VARCHAR		0-65535 		字节	变长字符串
-- TINYBLOB		0-255			字节	不超过 255 个字符的二进制字符串
-- TINYTEXT		0-255			字节	短文本字符串
-- BLOB			0-65 535		字节	二进制形式的长文本数据
-- TEXT			0-65 535		字节	长文本数据
-- MEDIUMBLOB	0-16 777 215	字节	二进制形式的中等长度文本数据
-- MEDIUMTEXT	0-16 777 215	字节	中等长度文本数据
-- LONGBLOB		0-4 294 967 295	字节	二进制形式的极大文本数据
-- LONGTEXT		0-4 294 967 295	字节	极大文本数据

CREATE TABLE IF NOT EXISTS 表名(
	  # 设置主键  auto_increment 属性只用于整数类型，一个表中最多只能有一个auto_increment列
    id INT UNSIGNED not null AUTO_INCREMENT comment '主键',

    # 常用于 类型、记录状态等
    字段名 tinyint 	UNSIGNED NOT NULL default 0 comment '类型',
    # 小于指定的位数将填0，指定为zerofill，则自动添加unsigned属性
    字段名 INT(5) ZEROFILL NOT NULL default 0 comment '类型',
    字段名 CHAR(10) not null default '' comment '名字',
    字段名 ENUM('fish', 'apple', 'dog') not null comment '',
    字段名 VARCHAR(32) 				not null 						comment '名字',
    # 定点数   适合用来表示货币或高精度的数据
    字段名 decimal(6,2) 			not null default 0  			comment '身高',
    字段名 DATE 					not null default '0000-00-00'  	comment '出厂时间',
    # 获取数字值，应添加 +0      msyql只给第一个timestamp字段设置默认值为系统时间，如果有第二个timestamp，则默认为0值
    字段名 TIMESTAMP not null default current_timestamp comment '出厂时间',
    字段名 TIMESTAMP not null default '0000-00-00 00:00:00' comment '出厂时间',
    # 默认4位格式 1901~2115和0000     2位格式  70~69，表示1970~2069（5.5.27，已不再支持）
    字段名 YEAR not null default '0000'  	comment '年份',
    字段名 text not null default '' comment '个人简介',
    # 设置主键，多主键，以逗号分隔。
    PRIMARY KEY (id),
    # 唯一键
    UNIQUE(id)
)
ENGINE=InnoDB -- InnoDB,myisam
COMMENT='表注释'
DEFAULT CHARSET=utf8
-- 从100开始自增
AUTO_INCREMENT = 100;

# 查看警告
show warnings;

/**
 * mysql有初始化的4个数据库
 * infomation_schema      主要存储了系统中的一些数据库对象信息，比如用户表信息、列信息、权限信息、字符集信息、分区信息等
 *                        一个虚拟数据库，物理上并不存在相关的目录和文件
 *                        比较常用的视图
 *                           schemata    提供了当前mysql中所有数据库信息，show databases 的结果取之此表
 *                           tables      提供了关于数据库中的表的信息（包括视图）
 *                           columns     提供了表中的列信息
 *                           statistics  提供了表索引的信息
 * cluster                存储了系统的集群信息
 * mysql                  存储了系统的用户权限信息
 * test                   系统创建的测试数据库
 */

# 创建数据库
CREATE DATABASE 库名;
CREATE DATABASE if not exists 库名;
# 删除数据库
DROP DATABASE 库名;
# 查看数据库
SHOW DATABASES;
# 选择数据库
use 库名;


# 查看所有数据表
SHOW tables;
# 查看表定义
DESC 表名;
# 查看创建表的建表语句  \G 选项使得记录能够按照字段竖向排列
SHOW CREATE TABLE 表名 \G;
# 删除表
DROP TABLE 表名;
# 查看表状态
SHOW TABLE STATUS LIKE '表名';
# 清空表
TRUNCATE TABLE 表名;
/**
 * 修改表引擎，方法一
 * 会执行很长时间，mysql会按行将数据从原表复制到一张新表，复制期间会消耗所有I/O能力，同时原表会读锁
 * 转换表引擎，将会失去和原引擎的所有特性，比如innodb上的外键
 */
ALTER TABLE 表名 ENGINE = INNODB;
/**
 * 修改表引擎，方法二
 * 使用于数据量不大的情况
 */
CREATE TABLE 表2 LIKE 表1;
ALTER TABLE 表2 ENGINE = myisam;
INSERT INTO 表2 SELECT * FROM 表1;
-- 适用于数据量大的情况，将上面一条语句换成下面的  最小值x和最大值y进行相应的替换
START TRANSACTION;
INSERT INTO 表2 SELECT * FROM 表1 WHERE 主键 BETWEEN x AND y;
COMMIT;

# 修改已创建了的表注释
ALTER TABLE 表名 COMMENT '修改表注释';
# 更改表名
ALTER TABLE 表名 rename 表名1;
# 设置自增起始值
ALTER TABLE 表名 AUTO_INCREMENT=10000;

# 修改现有字段，加上解释     First 放在最前面  after 放在某字段后面
ALTER TABLE 表名 MODIFY COLUMN 字段名 VARCHAR(100) COMMENT '修改列注释' AFTER 字段名;
# 修改字段的默认值，这条语句会直接修改.frm文件而不涉及表数据
ALTER TABLE 表名 MODIFY COLUMN 字段名 set default 5;
# 添加字段
ALTER TABLE 表名 ADD 字段名 int AUTO_INCREMENT primary key;
# 删除字段
ALTER TABLE 表名 DROP COLUMN 字段名;
# 更改字段名，并修改字段类型为int
ALTER TABLE 表名 CHANGE 字段名 字段名1 int;
-- change和modify都可以修改表的定义，不同的是change后面需要写两次列名，不方便。但是change的优点是可以修改列名称，modify则不能；

# 插入记录，多条
INSERT INTO 表名 ( field1, field2, ..., fieldN ) VALUES ( value1, value2, ..., valueN ), ( value1, value2, ..., valueN );
# 插入记录，value顺序应该和字段的排列顺序一致
INSERT INTO 表名 VALUES (value1, value2, ..., valueN);

# 更新字段值
UPDATE 表名 SET field1=value1, field2=value2 [WHERE CONDITION];
# 更新多个表中的字段值
UPDATE 表名 a, 表名 b SET a.字段名 = b.字段名, a.字段名 = a.字段名 + b.字段名 [WHERE CONDITION];
-- 多表更新语法，因更多的用在根据一个表的字段来动态的更新另外一个表的字段

# 删除记录
DELETE FROM 表名 [WHERE CONDITION];
# 删除多表记录
DELETE a, b FROM 表名 a, 表名 b WHERE a.字段名 = b.字段名 and b.字段名 = 2;
-- 不管是单表还多表，不叫where条件将会把表的所有记录删除

# 查询不重复的记录
SELECT DISTINCT 字段名 FROM 表名;
# 根据多个字段排序
SELECT * from 表名 ORDER BY 字段名1, 字段名2 DESC;
# union all  是把结果集直接合并在一起
# union      是将union all 的结果进行一次distinct
SELECT * FROM 表1
UNION
SELECT * FROM 表2;

/**
 * 聚合
 * having 对聚合后的结果进行条件过滤
 * where  对聚合前就对记录进行过滤
 */


# 删除指定数据库下所有前缀为XXX的表
SELECT concat('drop table 库名.', table_name, ';') FROM tables WHERE table_schema='库名' and table_name LIKE '前缀%';
# 将指定数据库下的所有存储引擎为myisam的表改为innodb
SELECT concat('alter table 库名.', table_name, ' engine=innodb;') FROM tables WHERE table_schema='库名' and engine = 'MyISAM';



---------------------------------------------------

now()               当前日期
from_unixtime       时间戳转换为日期
unix_timestamp      日期转换为时间戳
LAST_INSERT_ID()    最近一次的自增值，针对所有表

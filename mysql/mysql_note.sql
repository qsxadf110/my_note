
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
-- TIMESTAMP	4 字节	1970-01-01 00:00:00 结束时间: 2147483647 秒,到 2038-1-19 11:14:07

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
	-- 设置主键 多主键，以逗号分隔。
    id INT UNSIGNED not null PRIMARY KEY AUTO_INCREMENT comment '主键',

    -- 常用于 类型、记录状态等
    字段名 tinyint 	UNSIGNED NOT NULL default 0 comment '类型',
    字段名 CHAR(10) not null default '' comment '名字',
    字段名 VARCHAR(32) 				not null 						comment '名字',
    字段名 decimal(6,2) 			not null default 0  			comment '身高',
    字段名 DATE 					not null default '0000-00-00'  	comment '出厂时间',
    字段名 text not null default '' comment '个人简介',
    -- 设置主键
    -- PRIMARY KEY (id)
)
ENGINE=InnoDB -- InnoDB,myisam
COMMENT='表注释'
DEFAULT CHARSET=utf8
-- 从100开始自增
AUTO_INCREMENT = 100;

-- 修改已创建了的表注释
ALTER TABLE 表名 COMMENT '修改表注释'
-- 修改现有列，加上解释
ALTER TABLE 表名 MODIFY COLUMN  字段名 VARCHAR(100) COMMENT '修改列注释'
-- 添加列
alter table 表名 add id int auto_increment primary key
-- 设置自增起始值
alter table 表名 AUTO_INCREMENT=10000;
-- 清空表
TRUNCATE TABLE 表名

INSERT INTO table_name ( field1, field2,...fieldN )
                       VALUES
                       ( value1, value2,...valueN );


UPDATE table_name SET field1=value1, field2=value2
[WHERE Clause]
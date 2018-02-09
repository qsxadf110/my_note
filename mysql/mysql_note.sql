
-- 数值类型
--
-- tinyint		1 字节	(-128,127)					    (0,255)	小整数值
-- smallint		2 字节	(-32 768,32 767)			    (0,65 535)	大整数值
-- mediumint	3 字节	(-8 388 608,8 388 607)		    (0,16 777 215)	大整数值
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
    字段名 tinyint UNSIGNED NOT NULL default 0 comment '类型',
    # 小于指定的位数将填0，指定为zerofill，则自动添加unsigned属性
    字段名 INT(5) ZEROFILL NOT NULL default 0 comment '类型',
    # 会删除末尾空格
    字段名 CHAR(10) not null default '' comment '名字',
    # 忽略大小写，插入不在指定范围的值，会自动选择第一个值插入；一次只能取单个值
    字段名 ENUM('fish', 'apple', 'dog') not null comment '',
    -- insert into field values('fish');
    # set 和 enum 非常相似，但set可以一次选取多个值，超出允许范围的值将插入失败，重复成员的值将只取一次
    字段名 SET('fish', 'apple', 'dog') not null comment '',
    -- insert into field values('fish, apple');
    字段名 VARCHAR(32) 				not null 						comment '名字',
    # 定点数   适合用来表示货币或高精度的数据
    字段名 decimal(6,2) 			not null default 0  			comment '身高',
    字段名 DATE 					not null default '0000-00-00'  	comment '出厂时间',
    # 获取数字值，应添加 +0      msyql只给第一个timestamp字段设置默认值为系统时间，如果有第二个timestamp，则默认为0值
    # 插入日期，会先转换为本地时区存放；取出后也会将日期转化为本地时区后显示
    字段名 TIMESTAMP not null default current_timestamp comment '出厂时间',
    字段名 TIMESTAMP not null default current_timestamp ON UPDATE current_timestamp comment '最后修改的时间',
    字段名 TIMESTAMP not null default '0000-00-00 00:00:00' comment '出厂时间',
    # 默认4位格式 1901~2115和0000     2位格式  70~69，表示1970~2069（5.5.27，已不再支持）
    字段名 YEAR not null default '0000' comment '年份',
    字段名 text not null default '' comment '个人简介',
    # 设置主键，多主键，以逗号分隔。
    PRIMARY KEY (id),
    # 唯一键，要去该列唯一，允许为空，但只能有一个空值
    CONSTRAINT 约束名 UNIQUE(字段名),
    # 创建外键，外键名为定义的外键约束的名称，一个表中不能有相同名称的外键
	CONSTRAINT 外键名 FOREIGN KEY 字段名 REFERENCES 主表名(主键列),

	# 普通索引
	INDEX 索引名(字段名),
	# 唯一索引
	UNIQUE INDEX 索引名(字段名),
	# 单列索引
	INDEX 索引名(字段名(20)),
	# 全文索引
	-- 可以用于全文搜索，只有myisam存储引擎支持fulltext索引，并且只为char、varchar和text列
	-- 对整个列进行，不支持局部（前缀）索引
	FULLTEXT INDEX 索引名(字段名)

)
ENGINE=InnoDB -- InnoDB,myisam
COMMENT='表注释'
DEFAULT CHARSET=utf8
-- 从100开始自增
AUTO_INCREMENT = 100;

# 查看警告
show warnings;
# 查看mysql当前时区    SYSTEM => 默认和当前主机的时区一致
SHOW VARIABLES LIKE 'time_zone';
# 查看当前数据库支持的表引擎
SHOW ENGINES \G;
# 修改时区
SET TIME_ZONE = '+9:00';
# 关闭外键约束    0 关闭  1 开启
SET FOREIGN_KEY_CHECKS = 0;
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
# 查看表状态（对于innnodb - 外键信息）
SHOW TABLE STATUS LIKE '表名';
# 清空表
TRUNCATE TABLE 表名;
# 优化表（因为text或blog带来的性能问题）
OPTIMIZE TABLE 表名;
# 查询当前服务器的字符集和校对规则
SHOW VARIABLES LIKE 'character_set_server';
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
ALTER TABLE 表名 RENAME 表名1;
# 设置自增起始值
ALTER TABLE 表名 AUTO_INCREMENT=10000;

# 修改字段类型，加上解释     First 放在最前面  after 放在某字段后面
ALTER TABLE 表名 MODIFY 字段名 VARCHAR(100) COMMENT '修改列注释' AFTER 字段名;
# 修改字段的默认值，这条语句会直接修改.frm文件而不涉及表数据
ALTER TABLE 表名 MODIFY 字段名 set default 5;
# 更改字段名，并修改字段类型为int
ALTER TABLE 表名 CHANGE 旧字段名 新字段名 int;
-- change和modify都可以修改表的定义，不同的是change后面需要写两次列名，不方便。但是change的优点是可以修改列名称，modify则不能；

# 添加字段
ALTER TABLE 表名 ADD 字段名 数据类型 AUTO_INCREMENT primary key;
# 删除字段
ALTER TABLE 表名 DROP 字段名;
# 删除外键约束
ALTER TABLE 表名 DROP FOREIGN KEY 键名;




/**
 * INSERT 语句
 */
# 插入记录，多条
INSERT INTO 表名 ( field1, field2, ..., fieldN ) VALUES ( value1, value2, ..., valueN ), ( value1, value2, ..., valueN );
# 插入记录，value顺序应该和字段的排列顺序一致
INSERT INTO 表名 VALUES (value1, value2, ..., valueN);
# 插入散列值
INSERT INTO 表名 VALUES (repeat('beijing',2), md5(字段名));


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
 * 子查询
 * ANY、ALL、EXISTS
 */

# any和some是同义词，表示满足任一条件，他们允许创建一个表达式对子查询的返回值列表进行比较，只要满足任一条件，就返回一个结果给外层。
# 返回表2中的所有num2列，然后与表1中的num1进行比较，只要大于num2的任何1个值，即为符合条件的结果。
select num1 from 表1 WHERE num1 > ANY (SELECT num2 FROM 表2);
# 返回表2中的所有num2列，然后与表1中的num1进行比较，大于所有num2的值，即为符合条件的结果。
select num1 from 表1 WHERE num1 > ALL (SELECT num2 FROM 表2);
# 查询suppliers表中是否存在id=107的供应商，如果存在，则查询fruits表中price大于10的记录。
SELECT * FROM fruits WHERE price > 10 AND exists(SELECT s_name FROM suppliers WHERE id = 107);
# 查询suppliers表中是否存在id=107的供应商，如果 不 存在，则查询fruits表中price大于10的记录。
SELECT * FROM fruits WHERE price > 10 AND NOT exists(SELECT s_name FROM suppliers WHERE id = 107);


/**
 * 创建索引
 *
 * 最适合索引的列是出现在where子句中的列，或连接子句中的列；有区分度的索引
 * 使用短索引
 * 利用最左前缀（多列索引可起几个索引的作用，因为可以利用索引中最左边的列集来匹配行）
 * 索引，会降低写操作的性能
 * InnoDB表的普通索引都会保存主键的键值，所以主键要尽可能的短
 */

# 为表创建10个字节的前缀索引，和alter table 作用相同
CREATE INDEX 索引名 ON 表名 (字段名(10));
# 查看指定表中创建的索引
SHOW INDEX FROM 表名 \G;
# 添加普通索引
ALTER TABLE 表名 ADD INDEX 索引名(字段名);
# 添加唯一索引
ALTER TABLE 表名 ADD UNIQUE INDEX 索引名(字段名);
# 删除索引
ALTER TABLE 表名 DROP INDEX 索引名;
DROP INDEX 索引名 ON 表名;

/**
 * 视图
 */

# 创建视图
CREATE VIEW 视图名 AS SELECT 字段名1,字段名2 FROM 表名;
CREATE VIEW 视图名(字段名a, 字段名b) AS SELECT 字段名1, 字段名2 FROM 表名;
# 查看视图
DESCRIBE 视图名;
DESC 视图名;
# 修改视图
CREATE OR REPLACE VIEW 视图名 AS SELECT 字段名1,字段名2 FROM 表名;
ALTER VIEW 视图名 AS SELECT 字段名1,字段名2 FROM 表名;
# 删除视图
DROP VIEW IF EXISTS 视图名;


/**
 * 聚合
 * having 对聚合后的结果进行条件过滤
 * where  对聚合前就对记录进行过滤
 */

# 删除指定数据库下所有前缀为XXX的表
SELECT concat('drop table 库名.', table_name, ';') FROM tables WHERE table_schema='库名' and table_name LIKE '前缀%';
# 将指定数据库下的所有存储引擎为myisam的表改为innodb
SELECT concat('alter table 库名.', table_name, ' engine=innodb;') FROM tables WHERE table_schema='库名' and engine = 'MyISAM';


/**
 * 事件调度
 */

# 每隔5秒 执行一次sql
CREATE EVENT 事件名
    ON SCHEDULE
        EVERY 5 SECOND
    DO
        UPDATE 数据库.表名 SET 字段=字段+1;
# 查看调度器状态
SHOW EVENTS \G;
# 查看事件调度器状态
SHOW VARIABLES LIKE '%scheduler%';
# 打开调度器
SET GLOBAL EVENT_SCHEDULER = 1;
# 查看mysql进程
SHOW PROCESSLIST \G;
# 禁用事件调度器
ALTER EVENT 事件名 DISABLE;
# 删除
DROP EVENT 事件名;

/**
 * 触发器
 *
 * 只能创建在永久表上，不能返回数据，不可开启事务；对插入、更细、删除会有性能影响
 * before after
 * insert update
 */

# 创建触发器
CREATE TRIGGER 触发器名
    AFTER INSERT ON 表名 FOR EACH ROW BEGIN
    INSERT INTO 表名1 VALUES (val1, val2);
END;
# 删除触发器
DROP TRIGGER 触发器名;
# 查看触发器
SHOW TRIGGERS \G;

# 此模式，可将反斜线变为普通字符
no_backslash_escapes


/**
 * 表分区
 *
 * 线性hash的优点：分区维护更加方便；缺点：各个分区之间的数据分布不太均匀
 */
CREATE TABLE 表名(
    ...
)
-- key 分区
PARTITION by KEY (字段) PARTITIONS 4;

# 删除分区，也同时删除了该分区的数据
ALTER TABLE 表名 DROP PARTITION 分区名;
# 为range或list分区表添加一个分区
ALTER TABLE 表名 ADD PARTITION (PARTITION 分区名 VALUES LESS THAN (expr));


/**
 * 优化
 */

# 查询每条语句执行的次数   SHOW [session|global] STATUS 默认session
SHOW STATUS LIKE 'Com_%';
# 查询语句执行情况
EXPLAIN SELECT * FROM 表名 WHERE 字段名 = 'xxx' \G;
-- 相关选项说明
-- type     all, index, range, ref, eq_ref, const/system, null      从左至右，性能由最差到最好
-- possible_keys    查询时可能用到的索引
-- key              查询时实际用到的索引
-- key_len          使用到的索引字段长度
-- rows             扫描行的数量
-- extra            执行情况的描述和说明

# 优化表
-- 适用于删除了表的一大部分，或者对含有可变长度的行的表（varchar，blog，text）进行了很多更改
-- 可对表的空间碎片进行合并，避免空间浪费
-- 只对myisam、bdb、innodb表起作用
-- 会对表进行锁定
optimize TABLE 表名;

/**
 * 大批量插入数据
 */

# 打开或关闭myisam表非唯一索引的更新，在导入数据时，设置这两个命令，可提高导入效率
-- 使用于导入大量数据到一个非空的myisam表，不适用于innodb表
ALTER TABLE 表名 DISABLE KEYS;
LOAD DATA INFILE '/home/mysql/table_data.txt' INTO TABLE 表名;
ALTER TABLE 表名 ENABLE KEYS;
# innodb表，提高导入效率
-- 将导入的顺序按照主键的顺序排列
-- 导入数据前关闭唯一性校验
SET UNIQUE_CHECKS = 0;
-- 导入结束后，打开唯一性校验
SET UNIQUE_CHECKS = 1;


/**
 * show profile 分析sql
 */

# 是否支持profile
SELECT @@have_profiling;
# 是否打开profile
SELECT @@profiling;
# 打开profile（在session级别开启）
SET PROFILING = 1;
# 可以看到执行的sql语句列表，其中有query_id
SHOW PROFILES;
# 可以看到指定query_id的sql语句在执行过程中线程的每个状态和消耗的时间
SHOW PROFILE FOR QUERY 4;

# 查看索引的使用情况
SHOW STATUS LIKE 'Handler_read%';
-- 如果索引正在工作 handler_read_key 的值会很高
-- 如果 handler_read_rnd_next 的值高则意味着查询效率低


/**
 * 查询缓存
 */
SHOW VARIABLES LIKE '%query_cache%';
-- have_query_cache     是否配置了高速缓存
-- query_cache_size     缓存区大小
-- query_cache_type     0-关闭 1-打开 2-只有带sql_cache提供高速缓存


/**
 * mysqldump备份数据库
 */
-- -d   --no-data           不包含数据
-- -n   --no-create-db      不包含数据库的创建语句
-- -t   --no-create-info    不包含表的创建语句
--      --compact           不包含默认选项中的各种注释
-- -c   --complete-insert   导出的insert语句中包含字段名称
-- -F   --flush-logs        备份前关闭旧日志，生成新日志，大大方便恢复过程
-- -l   --lock-tables       给所有表加读锁，备份期间数据无法被更新，可以配合-F选项一起使用
-- $ mysqldump -h127.0.0.1 -p3306 -uroot -pqsxadf110 数据库名 > test.txt
-- $ mysqldump -h127.0.0.1 -p3306 -uroot -pqsxadf110 -d 数据库名 > test.txt

# 备份
-- 会在指定目录生成两个文件，一个是.sql（建表语句），另一个是.txt（存放实际数据）
-- $ mysqldump -uroot -pqsxadf110 -d 数据库名 表名 -T 路径
# 手工设置字符集
-- $ mysqldump -uroot -pqsxadf110 --default-character-set=latin1 数据库名 表名 -T 路径

/**
 * mysqlimport  数据导入工具
 */


/**
 * 权限与安全
 *
 * mysql安装后默认创建用户root@localhost 表示用户root只能从本地进行连接才可以通过认证
 * 3个最重要的权限表：user、db、host
 * user中4个重要部分：用户列、权限列、安全列、资源控制列
 * 权限列分为：普通权限、管理权限
 *
 * 用户连接时，权限表的存取过程：
 * 1.先从user表中的host、user和password这3个字段中判断连接的IP、用户名和密码是否存在于表中
 * 2.通过验证后，按照以下权限表的顺序得到数据库权限：user->db->tables_priv->columns_priv
 * 在这几个权限表中，权限范围依次递减，全局权限覆盖局部权限
 *
 * 对所有数据库都具有相同权限的用户记录并不需要记录到db表，或者说 user表中的每个权限都代表了对所有数据库都有的权限
 */

# 创建用户z1@localhost，并赋予所有数据库上的所有表的select权限，只能从本地连接
GRANT SELECT on *.* TO z1@localhost;
# 在上面的语句基础上，增加对z1的grant权限
GRANT ALL PRIVILEGES ON *.* TO z1@localhost WITH GRANT OPTION;
# 在上面的语句基础上，设置密码为 "123"
GRANT ALL PRIVILEGES ON *.* TO z1@localhost IDENTIFIED BY '123' WITH GRANT OPTION;
# 创建用户z2，可从任何ip进行连接，权限为对test1数据库里的所有表进行select、update、insert、delete操作，密码为123
GRANT SELECT,INSERT,UPDATE,DELETE ON test1.* TO 'z2'@'%' IDENTIFIED BY '123';
-- host值可以为主机名或IP号
-- host 值 % 匹配任何主机名，空host等价于 %
# 授予super、process、file权限给用户z3@%
-- 因为这几个权限都属于管理权限，因此不能够指定某个数据库，on后面必须跟 *.*
GRANT SUPER, PROCESS, FILE ON *.* TO 'z3'@'%';
# 只授予登录权限给z4@localhost
GRANT USAGE ON *.* TO 'z4'@'localhost';

# 查看用户z1@localhost的权限
SELECT * FROM user where user='z1' and host='localhost' \G;
SELECT * FROM db   where user='z1' and host='localhost' \G;
# 查看用户z1@localhost的权限 - grants
SHOW GRANTS FOR z1@localhost;
-- host可以不写，默认是 "%"

# 修改账号密码（在命令行指定密码）
$ mysqladmin -u user_name -h host_name password "newpwd"
# 将用户 z1 的密码改为 biscuit
SET PASSWORD for 'z1'@'%' = PASSWORD('biscuit');
# 更改自己的密码
SET PASSWORD = PASSWORD('biscuit');
# 直接修改user表，改后还要刷新权限表
UPDATE user SET password=password('123') WHERE user='root' AND host='localhost';

# 收回z1@localhost上的insert、select权限
REVOKE SELECT ,INSERT ON *.* FROM z1@localhost;
# 删除用户 z2@localhost
DROP USER z2@localhost;
# 刷新权限
FLUSH PRIVILEGES;


# 将etc/passwd文件加载到表t1中
LOAD DATA INFILE '/etc/passwd' INTO TABLE t1;


# 查看用户进程
SHOW PROCESSLIST;



/**
 * mysql 复制
 */

# ① 在主库上，设置一个复制使用的账户，并授予replication slave权限
GRANT REPLICATION SLAVE ON *.* TO 'rep1'@'192.168.7.200' IDENTIFIED BY '1234test';
# ② 修改主数据库服务器的配置文件my.cnf，开启binlog，并设置server-id的值。重启后生效。
-- 在my.cnf中修改如下：
[mysqld]
log-bin = /home/mysql/log/mysql-bin.log
server-id = 1
# ③ 在主库上，设置读锁定有效，这个操作是为了确保没有数据库操作，以便获得一个一致性的快照
FLUSH tables with read lock;
# ④ 然后得到主库当前的二进制日志名和偏移量值。这个操作的目的是为了在从数据库启动以后，从这个点开始进行数据的恢复。
SHOW MASTER STATUS;
# ⑤ 现在主数据库服务器已经停止了更新操作，需要生成主数据库的备份。如果主数据库的服务可以停止，直接复制数据文件是最快生成快照的方法。
$ tar -cvf data.tar data
# ⑥ 主数据库的备份完毕后，可以恢复写操作，剩下的操作只需要在从库上执行。
UNLOCK TABLES ;
# ⑦ 将主数据库的一致性备份恢复到从数据库上。如果使用.tar打包的文件包，只需要解开到相应的目录即可。
# ⑧ 修改从数据库的my.cnf，增加server-id参数。注意server-id是唯一的，不能和主数据库的配置相同，如果有多个从数据库服务器，都要有自己的唯一server-id。
[mysqld]
server-id = 2
# ⑨ 在从库上，使用 --skip-slave-start 选项启动从数据库，这样不会立即启动从数据库服务器上的复制进程，方便进一步配置。
$ ./bin/mysqld_safe --skip-slave-start
# ⑩ 对从数据库服务器做相应的设置，指定复制使用的用户，主数据库服务器的ip、端口、以及开始执行复制的日志文件和位置。
CHANGE MASTER TO
master_host = '192.168.7.83',
master_port = 3306,
master_user = 'repl1',
master_password = '1234test',
master_log_file = 'mysql-bin.000039',
master_log_pos = 102;
# 11. 从库上启动slave线程
start SLAVE ;
# 12. 查看进程
SHOW PROCESSLIST \G;
# 13. 测试



# 查看binlog刷新到磁盘的频率
show VARIABLES LIKE '%sync_binlog%';
-- 默认情况 sync_binlog=0 表示mysql不控制binlog的刷新，由文件系统自己控制文件系统的刷新
-- sync_binlog=1，表示每一次事务提交，mysql都把binlog刷新到磁盘


---------------------------------------------------

now()                       当前日期
from_unixtime               时间戳转换为日期
unix_timestamp              日期转换为时间戳
LAST_INSERT_ID              当前线程最近一次的自增值，针对所有表
length                      字符串长度
mod(3,2)                    模运算，求余，与3%2效果一样

concat(s1, s2,...sn)        连接s1,s2,...sn为一个字符串
insert(str, x, y, instr)    将字符串str中第x个位置开始，y个字符串长的字符串替换为instr
lower(str)                  转小写
upper(str)                  转大写
left(str,x)                 返回字符串str最左边的x个字符
right(str,x)                返回字符串str最右边的x个字符
lpad(str,n,pad)             用字符串pad对str最左边进行填充，直到长度为n个字符长度
rpad(str,n,pad)             用字符串pad对str最右边进行填充，直到长度为n个字符长度
ltrim(str)                  去除str左侧空格
rtrim(str)                  去除str右侧空格
trim(str)                   去除str两侧空格
repeat(str,x)               返回str重复x次的结果
replace(str,a,b)            用字符串b替换str中所有出现的字符串a
substring(str,x,y)          返回str从x起y个长度的字符串
strcmp(s1, s2)              比较s1和s2的ascii的码值的大小     小：-1 相等：0 大：1

ceil(x)                     大于x的最小整数
floor(x)                    小于x的最大整数
rand()                      返回0~1内的随机值  eg: ceil(100*rand()) 0~100内的随机整数
round(x,y)                  返回参数x的四舍五入的有y位小数的值，y默认为0
turncate(x,y)               返回数字x截断为y位小数的结果，与round区别：仅仅是截断，不进行四舍五入

curdate                     当前日期    2007-07-11
curtime                     当前时间    14:13:43
now                         当前日期和时间     2007-07-11 14:13:43
unix_timestamp(date)        返回日期date的unix时间戳    1184134516
from_unixtime(timestamp)    返回unixtime时间戳的日期值   2007-07-11 14:13:43
week(now())                 所给日期是一年中第几周
year(now())                 所给日期是那一年
monthname(date)             返回英文月份名称
date_format(data,fmt)       按照指定格式显示时间  data_format(now(), '%Y-%m-%d')
datediff(date1, date2)      两个日期相差多少天   datediff('2008-05-05', now())

database()                  返回当前数据库名
version()                   当前版本
user()                      当前登录的用户名
inet_aton(ip)               返回ip的数字表示
inet_ntoa(num)              返回数字表示的ip
md5()
password(str)               返回str的加密版本，一个41位长的字符串


---------------------------------------------------

<=> 和 = 功能相似，在操作数相等时为1，即使操作数的值为null也可以比较
a between min and max       当a大于等于min并且小于等于max，返回值为1，否则返回0
is null
is not null
regexp       str regexp str_pat   当str字符串中含有str_pat相匹配的字符串时，则返回1，否则返回0


if(value,x,y)               如果value为真，返回t否则返回y
ifnull(val1, val2)          如果val1不为空，返回val1，否则返回val2
CASE WHEN val1 THEN [res1] ELSE [default] END               如果val1为真，返回res1，否则default
CASE [expr] WHEN val1 THEN [res1] ELSE [default] END        如果expr等于val1，返回res1，否则default


# 生成删除多表
Select CONCAT( 'drop table if exists ', table_name, ';' ) FROM information_schema.tables Where table_name LIKE '%_copy';
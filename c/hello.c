#include <stdio.h>
#include <float.h>

// 声明一个全局变量
extern int d;
// 定义一个全局变量 a 并给初值。一旦给予赋值，一定是定义，定义才会分配存储空间
// extern int d = 1;

int main()
{
	printf("hello world! \n");
	printf("int sizeof = %lu \n", sizeof(int));

	printf("float 存储最大字节数 : %lu \n", sizeof(float));
   	printf("float 最小值: %E\n", FLT_MIN );
   	printf("float 最大值: %E\n", FLT_MAX );
   	printf("精度值: %d\n", FLT_DIG );

   	// 不带初始化的定义：带有静态存储持续时间的变量会被隐式初始化为 NULL（所有字节的值都是 0），
   	// 其他所有变量的初始值是未定义的。
	int d = 3;           // 定义一个全局变量
	printf("d = %d\n", d);

	return 0;
}

/**
 * 打开一个文本编辑器，添加上述代码。
 * 保存文件为 hello.c。
 * 打开命令提示符，进入到保存文件所在的目录。
 * 键入 gcc hello.c，输入回车，编译代码。
 * 如果代码中没有错误，命令提示符会跳到下一行，并生成 a.out 可执行文件。
 * 现在，键入 a.out 来执行程序。
 * 您可以看到屏幕上显示 "Hello World"。
 * 
 * $ gcc hello.c
 * $ ./a.out
 * Hello, World!
 */

/**
 * for linux
 * 类型				存储大小		值范围
 * char				1 字节		-128 到 127 或 0 到 255
 * unsigned char	1 字节		0 到 255
 * signed char		1 字节		-128 到 127
 * short			2 字节		-32,768 到 32,767
 * unsigned short	2 字节		0 到 65,535
 * int				2 或 4 字节	-32,768 到 32,767 或 -2,147,483,648 到 2,147,483,647
 * unsigned int		2 或 4 字节	0 到 65,535 或 0 到 4,294,967,295
 * long				8 字节		-2,147,483,648 到 2,147,483,647
 * unsigned long	8 字节		0 到 4,294,967,295
 * float			4
 * double 			8
 * long int			8
 * long long		8
 * long double		16
 */

/**
 * 默认为10进制 ，10 ，20。
 * 以0开头为8进制，045，021。
 * 以0b开头为2进制，0b11101101。
 * 以0x开头为16进制，0x21458adf。 
 */


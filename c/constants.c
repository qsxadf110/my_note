#include <stdio.h>

// 宏定义常量,没有数据类型
#define WIDTH 10
#define HEIGHT 3
#define NEWLINE '\n'

// 函数声明
void func1(void);

// static 是全局变量的默认存储类，以下两个变量 (count 和 road) 都有一个 static 存储类。
static int count = 10;
int road;

int main()
{
	int area = WIDTH * HEIGHT;
	printf("area = %d", area);
	printf("%c", NEWLINE);
	printf("%s\n", "newline");

	// const 声明指定类型的常量,可以有不同的作用域
	const int ARGS_A = 3;
	const int ARGS_B = 5;
	int result = ARGS_A + ARGS_B;
	printf("3 + 5 = %d\n", result);

	// auto 存储类是所有局部变量默认的存储类。auto 只能修饰局部变量。
	auto int amount;

	// register 存储类用于定义存储在寄存器中而不是 RAM 中的局部变量。
	// 且不能对它应用一元的 '&' 运算符（因为它没有内存位置）。
	// 寄存器只用于需要快速访问的变量，比如计数器。
	// 并不意味着变量将被存储在寄存器中，它意味着变量可能存储在寄存器中，这取决于硬件和实现的限制。
	register int  miles;

	// 在程序的生命周期内保持局部变量的存在
	// 当 static 修饰全局变量时，会使变量的作用域限制在声明它的文件内。
	static int num;

	while(count--) {
		//func1();
		static int thingy = 0;
		thingy++;
		printf("thingy = %d, count = %d\n", thingy, count);
	}

	return 0;
}

void func1(void) 
{
	static int thingy = 0;
	thingy++;
	printf("thingy = %d, count = %d\n", thingy, count);
}

/**
 * 1. const 定义常量是有数据类型的，而 #define 宏定义常量却没有，
 *		一是 const 有类型；二是 const 可以有不同的作用域。
 * 2. const 常量有数据类型，而宏常量没有数据类型。
 *		编译器可以对 const 进行类型安全检查，而对后者只进行字符替换，没有类型安全检查，
 *		并且在字符替换中可能会产生意料不到的错误。
 * 3. 有些集成化的调试工具可以对 const 常量进行调试，但是不能对宏常量进行调试。
 */

/**
 * 整数常量也可以带一个后缀，后缀是 U 和 L 的组合，
 * U 表示无符号整数（unsigned），L 表示长整数（long）。
 * 后缀可以是大写，也可以是小写，U 和 L 的顺序任意。
 *
 * 带符号的指数是用 e 或 E 引入的。
 */
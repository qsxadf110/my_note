<?php


// 创建指定流或数据报套接字
// 错误号和 errstr参数将始终通过引用传递。
$socket=stream_socket_server('tcp://127.0.0.1:8000', $errno, $errstr);
if(!$socket)
{
		//如果创建socket失败输出内容
	die("创建socket失败：$errstr ($errno)".PHP_EOL);
}

echo 'create socket success'.PHP_EOL;

	//如果创建成功则接受socket连接并获取信息
while($conn = stream_socket_accept($socket))
{
	fwrite($conn, 'The local time is ' . date('n/j/Y g:i a') . "\n");
	fclose($conn);
}

fclose($socket);



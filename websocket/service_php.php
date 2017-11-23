<?php

error_reporting(0);                     
set_time_limit(0);

// 创建一个套接字（通讯节点）
$address = '127.0.0.1';
$port = 9502;

$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
if(!$socket)
	die("socket_create() failed : ".socket_strerror(socket_last_error()). "\n");

// 绑定到socket端口
$isOk = socket_bind($socket, $address, $port);
if(!$isOk)
	die("socket_bind() failed : ".socket_strerror(socket_last_error()). "\n");

//开始监听  
$server = socket_listen($socket, 4);
if(!$server)
	die("socket_listen() failed : ". socket_strerror(socket_last_error()) . "\n"); 

echo "OK\nBinding the socket on $address:$port ...\n";

do {//Never stop the daemon  
    //它接收连接请求并调用一个子链接socket来处理客户端和服务器间的信息
    $msgsock = socket_accept($socket) or die("sock_accept() failed : ". socket_strerror(socket_last_error()) . "\n");  
  
    //读取客户端数据  
    echo "Read client data \n";  
    $buf = socket_read($msgsock, 8192);  
    echo "Received msg : $buf  \n";  
  
    //数据传输，向客户端写入返回结果  
    $msg = "welcome \n";  
    socket_write($msgsock, $msg, strlen($msg)) or die("socket_write() failed : ". socket_strerror(socket_last_error()). "\n");  
    //输出返回到客户端时，父/子socket都应通过socket_close来终止  
    socket_close($msgsock);  
}while(true);  

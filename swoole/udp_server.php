<?php

// 创建Server对象，监听 127.0.0.1:9502端口，类型为SWOOLE_SOCK_UDP
$serv = new swoole_server("127.0.0.1", 9502, SWOOLE_PROCESS, SWOOLE_SOCK_UDP); 

/**
 * 监听数据接收事件
 * 向客户端发送数据
 * $clientInfo是客户端的相关信息，是一个数组，有客户端的IP和端口等内容
 */
$serv->on('Packet', function ($serv, $data, $clientInfo) {
    $serv->sendto($clientInfo['address'], $clientInfo['port'], "Server ".$data);
    var_dump($clientInfo);
    /*
	    array(4) {
		  ["server_socket"] => int(3)
		  ["server_port"] 	=> int(9502)
		  ["address"]		=> string(9) "127.0.0.1"
		  ["port"]			=> int(45350)
		}
	*/
});

/**
 * 启动Server后，客户端无需Connect，直接可以向Server监听的9502端口发送数据包。
 * 对应的事件为onPacket。
 * 向客户端发送数据
 */
$serv->start();

/**
 * UDP服务器可以使用netcat -u 来连接测试
 * netcat -u 127.0.0.1 9502
 */
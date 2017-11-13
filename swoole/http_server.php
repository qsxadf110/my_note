<?php

/**
 * 0.0.0.0 表示监听所有IP地址，一台服务器可能同时有多个IP，
 * 如: 
 * 		127.0.0.1 		本地回环IP
 * 		192.168.1.100	局域网IP
 * 		210.127.20.2 	外网IP
 * 这里也可以单独指定监听一个IP
 * 9501 监听的端口，如果被占用程序会抛出致命错误，中断执行。
 */

$http = new swoole_http_server("0.0.0.0", 9501);

$http->on('request', function ($request, $response) {
	// 一个是$request对象，包含了请求的相关信息，如GET/POST请求的数据。
    var_dump($request->get, $request->post);
    $response->header("Content-Type", "text/html; charset=utf-8");

    // 对request的响应可以通过操作response对象来完成。
    // $response->end()方法表示输出一段HTML内容，并结束此请求。
    $response->end("<h1>Hello Swoole. #".rand(1000, 9999)."</h1>");
});

$http->start();

/**
 * 可以打开浏览器，访问http://127.0.0.1:9501查看程序的结果。
 * 也可以使用apache ab工具对服务器进行压力测试
 */
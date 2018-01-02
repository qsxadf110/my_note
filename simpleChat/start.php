<?php
use Workerman\Worker;
require_once './workerman/Autoloader.php';

$global_uid = 0;

// 当客户端连上来时分配uid，并保存连接，并通知所有客户端
function handle_connection($connection)
{
    global $text_worker, $global_uid;
    // 为这个连接分配一个uid
    $connection->uid = ++$global_uid;
    foreach($text_worker->connections as $conn)
    {
        // $conn->send的数据会自动调用JsonNL::encode方法打包，然后发往客户端
        $conn->send("游客_{$connection->uid} 已上线");
    }
}

// 当客户端发送消息过来时，转发给所有人
function handle_message($connection, $data)
{
    // $data就是客户端传来的数据，数据已经经过text::decode处理过
    global $text_worker;
    foreach($text_worker->connections as $conn)
    {
        // $conn->send的数据会自动调用JsonNL::encode方法打包，然后发往客户端
        $conn->send("游客_{$connection->uid} : $data");
    }
}

// 当客户端断开时，广播给所有客户端
function handle_close($connection)
{
    global $text_worker;
    foreach($text_worker->connections as $conn)
    {
        $conn->send("游客_{$connection->uid} 已离开");
    }
}

// 创建一个文本协议的Worker监听2347接口
$text_worker = new Worker("websocket://0.0.0.0:9502");

// 只启动1个进程，这样方便客户端之间传输数据
$text_worker->count = 1;

$text_worker->onConnect = 'handle_connection';
$text_worker->onMessage = 'handle_message';
$text_worker->onClose = 'handle_close';

Worker::runAll();
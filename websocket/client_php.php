<?php  
/** 
 *  php socket client 
 * */  
  
error_reporting(0);                                                                                                                            
set_time_limit(0);  
  
$host = '127.0.0.1';  
$port = 9502;  
  
$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP) or die("Could not create socket.\n");  
  
$connection = socket_connect($socket, $host, $port) or die("Could not connect server.\n");  
socket_write($socket, "Hello Socket!") or die("Write failed.\n");  
while($buff = socket_read($socket, 1024, PHP_NORMAL_READ)) {  
    echo "Response was : ". $buff . "\n";  
}  
  
socket_close($socket);
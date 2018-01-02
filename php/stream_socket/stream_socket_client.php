<?php



$fp = stream_socket_client("tcp://127.0.0.1:9502", $errno, $errstr, 30);
if (!$fp) {
	die("$errstr ($errno)");
}

fwrite($fp, "haha");
while (!feof($fp)) {
	echo fgets($fp, 1024);
}
fclose($fp);

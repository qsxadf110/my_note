<?php




$handle = fopen('test.txt', 'rb');
stream_filter_append($handle, 'string.toupper');
while (feof($handle) !== true) {
    echo fgets($handle);
}
fclose($handle);
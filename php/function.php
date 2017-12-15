<?php

/**
 * 判断客户端是那种操作系统
 * @return string
 */
function which_system()
{
    if (strpos($_SERVER['HTTP_USER_AGENT'], 'iPhone') || strpos($_SERVER['HTTP_USER_AGENT'], 'iPad')) {
        return 'IOS';
    } else if (strpos($_SERVER['HTTP_USER_AGENT'], 'Android')) {
        return 'Android';
    } else {
        return 'other';
    }
}

/**
 * 判断是否是微信客户端
 * @return bool
 */
function is_weixin()
{
    if (strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false) {
        return true;
    } else {
        return false;
    }
}

/**
 * 获取随机数
 * @param int $length
 * @return string
 */
function create_nonce_str($length = 32)
{
    $chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    $str   = "";
    for ($i = 0; $i < $length; $i++) {
        $str .= substr($chars, mt_rand(0, strlen($chars) - 1), 1);
    }
    return $str;
}

/**
 * 获取本地域名
 */
function getLocaleUrl($always_http = false)
{
	$is_https =
		(isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') ||
		(isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') ||
		(isset($_SERVER['REQUEST_SCHEME']) && $_SERVER['REQUEST_SCHEME'] == 'https');

	$request_scheme = $is_https ? 'https://' : 'http://';
	$hostname = $_SERVER['SERVER_NAME'];
	$hostport = (($is_https && '443' == $_SERVER['SERVER_PORT']) || (!$is_https && '80' == $_SERVER['SERVER_PORT'])) ? '' : ':' . intval($_SERVER['SERVER_PORT']);

	if ($always_http)
		return 'http://' . $hostname . $hostport;
	else
		return $request_scheme . $hostname . $hostport;
}

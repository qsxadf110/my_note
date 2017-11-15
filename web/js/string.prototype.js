// 去除字符串两边的空白字符
String.prototype.trim = function () {
	return this.replace(/(^\s*) | (\s*$)/g, "");
}

// 是否为数字
String.prototype.isNumeric = function () {
	return /^\d+$/.test(this);
}

// 是否为中文
String.prototype.isChinese = function () {
	return /^[\u4e00-\u9fff]+$/.test(this);
}

// 是否为空
String.prototype.isEmpty = function () {
	if( this.trim() == "" || this == null )
		return true;
	else
		return false;
}

// 是否为微信号
String.prototype.isWechat = function () {
    return /^[a-zA-Z]{1}[-_a-zA-Z0-9]{5,19}$/.test(this);
}

// 是否为手机号
String.prototype.isMobile = function () {
    return /^1[0-9]{10}$/.test(this);
}
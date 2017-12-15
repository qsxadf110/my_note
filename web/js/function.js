;(function () {
	whichSystem: function () {
		if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {
			return true;
		} else if (/(Android)/i.test(navigator.userAgent)) {
			return false;
		}
		return false;
	}
,
	isWeiXin: function () {
		if (typeof this.cache.isWeiXin === 'boolean') return this.cache.isWeiXin;
		var ua = navigator.userAgent.toLowerCase().match("micromessenger");
		if (ua && ua[0] === "micromessenger") {
			this.cache.isWeiXin = true;
			return true;
		}

		this.cache.isWeiXin = false;
		return false;
	}
,
	isRightId: function (playerId) {
		return /^\d{6,10}$/.test(playerId);
	}
,
	isMobile: function (tel) {
		return /^1[0-9]{10}$/.test(tel);
	}
,
	/**
	 * 获取指定url参数
	 */
	getQueryString: function (name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
		var r = window.location.search.substr(1).match(reg);
		if (r !== null)
			return r[2];

		return null;
	}
,
	/**
	 * 获取url参数对象
	 */
	getQueryObj: function () {
		var tmp = window.location.search.substr(1).split('&');
		var res = {};
		for (var i = 0; i < tmp.length; i++) {
			var arr = tmp[i].split('=');
			res[arr[0]] = arr[1];
		}

		return res;
	}
,
	/**
	 * 获取本页面名称
	 */
	getPageName: function () {
		var name = window.location.pathname.split('/').pop();
		return name;
	}
,
	/**
	 * 获取随机字符串
	 */
	randomString: function (len, charSet) {
		charSet = charSet || 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
		var randomString = '';
		var randomPoz = 0;
		for (var i = 0; i < len; i++) {
			randomPoz = Math.floor(Math.random() * charSet.length);
			randomString += charSet.substring(randomPoz,randomPoz+1);
		}
		return randomString;
	}
	/**
	 * canvas转图片
	 */
	convertCanvasToImage: function (canvas) {
		var image = new Image();
		image.src = canvas.toDataURL("image/png");
		return image;
	}
,
	/**
	 * 添加dom元素
	 */
	addElement: function () {
		var frmPost = document.createElement('form');
		frmPost.id = '____frmPost____';
		frmPost.name = '____frmPost____';
		frmPost.method = 'post';
		frmPost.action = '';
		var add_formchild = function (name, value) {
			var edt = document.createElement('input');
			edt.type = 'text';
			edt.id = name;
			edt.name = name;
			edt.value = value;
			frmPost.appendChild(edt);
		}
	}
,
	/**
	 * 获取随机数
	 */
	randomNum: function (min, max) {
		return Math.floor(min + Math.random() * (max - min));
	}
,
	/**
	 * 校验邮箱地址
	 */
	isEmail: function (str) {
		return /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.test(str);
	}
,
	/**
	 * 校验身份证
	 */
	isIdCard: function (str) {
		return /^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/.test(str)
	}
,
	/**
	 * 校验手机号
	 */
	isPhoneNum: function (str) {
		return /^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$/.test(str);
	}
,
	/**
	 * 校验URL链接
	 */
	isUrl: function (str) {
		return /[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/i.test(str);
	}
,
	/**
	 * 现金额转大写
	 */
	digitUppercase: function (n) {
		var fraction = ['角', '分'];
		var digit = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖'];
		var unit = [
			['元', '万', '亿'],
			['', '拾', '佰', '仟']
		];
		var head = n < 0 ? '欠' : '';
		n = Math.abs(n);
		var s = '';
		for (var i = 0; i < fraction.length; i++) {
			s += (digit[Math.floor(n * 10 * Math.pow(10, i)) % 10] + fraction[i]).replace(/零./, '');
		}
		s = s || '整';
		n = Math.floor(n);
		for (var i = 0; i < unit[0].length && n > 0; i++) {
			var p = '';
			for (var j = 0; j < unit[1].length && n > 0; j++) {
				p = digit[n % 10] + unit[1][j] + p;
				n = Math.floor(n / 10);
			}
			s = p.replace(/(零.)*零$/, '').replace(/^$/, '零') + unit[0][i] + s;
		}
		return head + s.replace(/(零.)*零元/, '元')
									 .replace(/(零.)+/g, '零')
									 .replace(/^整$/, '零元整');
	}
,
	/**
	 * 判断浏览器是否支持webP格式图片
	 * @return {Boolean}
	 */
	isSupportWebP: function () {
		return !![].map && document.createElement('canvas').toDataURL('image/webp').indexOf('data:image/webp') == 0;
	}
,

	/**
	 * @desc   格式化${startTime}距现在的已过时间
	 * @param  {Date} startTime  毫秒级时间戳
	 * @return {String}
	 */
	formatPassTime: function (startTime) {
		var currentTime = Date.parse(new Date()),
			time = currentTime - startTime,
			day = parseInt(time / (1000 * 60 * 60 * 24)),
			hour = parseInt(time / (1000 * 60 * 60)),
			min = parseInt(time / (1000 * 60)),
			month = parseInt(day / 30),
			year = parseInt(month / 12);

		if (year) return year + "年前";
		if (month) return month + "个月前";
		if (day) return day + "天前";
		if (hour) return hour + "小时前";
		if (min) return min + "分钟前";
		else return '刚刚';
	}
,
	/**
	 * @desc   格式化现在距${endTime}的剩余时间
	 * @param  {Date} endTime
	 * @return {String}
	 */
	formatRemainTime: function (endTime) {
		var startDate = new Date(); //开始时间
		var endDate = new Date(endTime); //结束时间
		var t = endDate.getTime() - startDate.getTime(); //时间差
		var d = 0,
			h = 0,
			m = 0,
			s = 0;
		if (t >= 0) {
			d = Math.floor(t / 1000 / 3600 / 24);
			h = Math.floor(t / 1000 / 60 / 60 % 24);
			m = Math.floor(t / 1000 / 60 % 60);
			s = Math.floor(t / 1000 % 60);
		}
		return d + "天 " + h + "小时 " + m + "分钟 " + s + "秒";
	}
,
	/**
	 * 对象序列化
	 * @param  {Object} obj
	 * @return {String}
	 */
	stringfyQueryString: function (obj) {
		if (!obj) return '';
		var pairs = [];
		for (var key in obj) {
			var value = obj[key];
			if (value instanceof Array) {
				for (var i = 0; i < value.length; ++i) {
					pairs.push(encodeURIComponent(key + '[' + i + ']') + '=' + encodeURIComponent(value[i]));
				}
				continue;
			}
			pairs.push(encodeURIComponent(key) + '=' + encodeURIComponent(obj[key]));
		}
		return pairs.join('&');
	}
,
	/**
	 * jQuery ajax 示例
	 */
	api: function () {

		$.ajax(
			{
				url: '',
				type: 'POST',
				dataType: 'json',
				async: false,
				data: apiDate,
				timeout: 10000,
				success: function (r) {

				},
				complete: function (r) {

				},
				error: function (xhr, textStatus) {

				}
			}
		);
	}
})()
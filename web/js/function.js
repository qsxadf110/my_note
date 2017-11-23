;(function () {
	whichSystem: function () {
    if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {
      return true;
    } else if (/(Android)/i.test(navigator.userAgent)) {
      return false;
    }
    return false;
  },
  isWeiXin: function () {
    var ua = navigator.userAgent.toLowerCase();
    if (ua.match(/MicroMessenger/i) == "micromessenger")
      return true;

    return false;

  },
  isRightId: function (playerId) {
    return /^\d{6,10}$/.test(playerId);
  },
  isMobile: function (tel) {
    return /^1[0-9]{10}$/.test(tel);
  },
  getQueryString: function (name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r !== null)
      return r[2];

    return null;
  },
  getQueryObj: function () {
    var tmp = window.location.search.substr(1).split('&');
    var res = {};
    for (var i = 0; i < tmp.length; i++) {
      var arr = tmp[i].split('=');
      res[arr[0]] = arr[1];
    }

    return res;
  },
  getPageName: function () {
    var name = window.location.pathname.split('/').pop();
    return name;
  },
  convertCanvasToImage: function (canvas) {
    var image = new Image();
    image.src = canvas.toDataURL("image/png");
    return image;
  },
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
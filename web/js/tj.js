(function (window, undefined) {

	function Tool(name) {
		this.name = name;
		this.test = function () {
			console.log(this.name);
		}
	}

	Tool.prototype = {
		test_a: function () {
			console.log('test_a')
		},
		test_b: function () {
			this.log('test_b'+this.name);
			this.log(this);
		},
		log: function (obj) {
			console.log(obj);
		},
		storage: function (name, obj) {
			if(typeof obj !== 'undefined')
	          sessionStorage.setItem(name, JSON.stringify(obj));
	        else {
	          var res = sessionStorage.getItem(name);
	          res = JSON.parse(res);
	          return res;
	        }
		},
		isEmptyObject: function( obj ) {

			var name;

			for ( name in obj ) {
				return false;
			}
			return true;
		},
		trim: function( text ) {
			return text == null ?
				"" :
				( text + "" ).replace( rtrim, "" );
		}
	};

	window.Tool = Tool;
})(window);
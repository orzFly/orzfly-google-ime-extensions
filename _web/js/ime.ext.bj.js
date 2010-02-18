(function () {
	$(document).ready(function () {
		window['virtualIME']['extensions']['bj'] = [];
		window['virtualIME']['extensions']['bj']['name'] = "标记对";
		window['virtualIME']['extensions']['bj']['description'] = "输入任意字符串得到标记对，使用+分割参数";
		window['virtualIME']['extensions']['bj']['get'] = function (arg) {
			args = arg.split(/\+/);
			input = args.shift();
			if (input == '') return {result: [], baseKey: 0};
			var argtext = "";
			if (args.length > 0) {
				$.each(args, function(index,item){
					argtext += " " + item + "=\"\""
				});
			}
			return {result: [
		    	"&lt;" + input + argtext + "&gt;&lt;/" + input + "&gt;",
		    	"[" + input + argtext + "][/" + input + "]",
				"{" + input + argtext + "}{/" + input + "}",
		    ], baseKey: 49};
		};
	});
})();

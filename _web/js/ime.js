(function () {
	$.prototype['appendText'] = function (F) {
		if (typeof F !== "object" && F != null) {
			return this.append((this[0] && this[0].ownerDocument || document).createTextNode(F))
		}
		var E = "";
		o.each(F || this, function () {
			o.each(this.childNodes, function () {
				if (this.nodeType != 8) {
					E += this.nodeType != 1 ? this.nodeValue : o.fn.text([this])
				}
			})
		});
		return E
	};
	$(document).ready(function () {
		$('body').append('<div id="ime" style="display: none;"><div id="ime-warpper"><div id="ime-logo"></div><div id="ime-input"><span id="ime-input-text"></span></div><div id="ime-desc"></div><div class="clear"></div><div id="ime-page-down"></div><div id="ime-page-up"></div><div id="ime-output"><ul></ul></div><div class="clear"></div></div></div>');
		window['virtualIME'] = {};
		window['virtualIME']['display'] = $('#ime');
		window['virtualIME']['input'] = $('#parse');
		window['virtualIME']['inputDisplay'] = $('#ime-input-text');
		window['virtualIME']['descriptionDisplay'] = $('#ime-desc');
		window['virtualIME']['outputDisplay'] = $('#ime-output ul');
		window['virtualIME']['logoButton'] = $('#ime-logo');
		window['virtualIME']['pageUpButton'] = $('#ime-page-up');
		window['virtualIME']['pageDownButton'] = $('#ime-page-down');
		window['virtualIME']['parse'] = "";
		window['virtualIME']['lastParse'] = "";
		window['virtualIME']['result'] = [];
		window['virtualIME']['page'] = 1;
		window['virtualIME']['pages'] = 1;
		window['virtualIME']['choice'] = 1;
		window['virtualIME']['choiceCount'] = 1;
		window['virtualIME']['baseKey'] = 0; // 49 for 1, 65 for a, 0 for none
		window['virtualIME']['extensions'] = {};
		window['virtualIME']['settings'] = {};
		window['virtualIME']['settings']['choicePerPage'] = 9;
		window['virtualIME']['settings']['extensionsDescription'] = '直接输入数字或选择扩展命令';
		window['virtualIME']['data'] = {
			chineseNumber: { 0:'〇', 1:'一', 2:'二', 3:'三', 4:'四', 5:'五', 6:'六', 7:'七', 8:'八', 9:'九', 10: '十'}
		};
		window['virtualIME']['emptyResult'] = {result:[], baseKey: 0, description: ''};
		window['virtualIME']['queryText'] = function (pinyin) {
			return virtualIME.emptyResult;
		};
		window['virtualIME']['queryNumber'] = function (number) {
			var cn1, cn2, cn3;
			cn1 = '未完成';
			cn2 = '研究中';
			cn3 = number;
			for(var i=0;i<10; i++){
				cn3 = cn3.replace(new RegExp(i.toString(), "gi"), virtualIME.data.chineseNumber[i]);
			}
			return {result:[cn1, cn2, cn3], baseKey: 65, description: ''}
		};
		window['virtualIME']['queryExtensions'] = function (keyword, after) {
			var result, result2;
			if (keyword.length == 2) {
				result = virtualIME.extensions[keyword];
				if (typeof result === "undefined") result2 = virtualIME.emptyResult;
				else{
					result2=result.get(after);
					result2.description = result.description;
				}
			} else if (keyword.length == 1) {
				result = [];
				$.each(virtualIME.extensions, function (index, item) {
					if (index.substring(0, 1) == keyword) result.push(index.substring(0, 1) + '<span class="ime-output-suggest-text">' + index.substring(1, 2) + '</span>.' + item['name'] + '<span class="ime-output-suggest">&raquo;</span>');
				});
				result2={result:result, baseKey: 0, description: virtualIME.settings.extensionsDescription};
			} else if (keyword.length == 0) {
				result = [];
				$.each(virtualIME.extensions, function (index, item) {
					result.push('<span class="ime-output-suggest-text">' + index + '</span>.' + item['name'] + '<span class="ime-output-suggest">&raquo;</span>');
				});
				result2={result:result, baseKey: 0, description: virtualIME.settings.extensionsDescription};
			}
			return result2;
		};
		window['virtualIME']['update'] = function (parse) {
			virtualIME.parse = parse;
			if (virtualIME.lastParse != virtualIME.parse) {
				virtualIME.lastParse = virtualIME.parse;
				var len = virtualIME.parse.length;
				virtualIME.inputDisplay.empty();
				if (len > 0) {
					virtualIME.display.css({
						"left": virtualIME.input.position().left + "px",
						"top": (virtualIME.input.position().top + virtualIME.input.height()) + "px"
					}).show();
					if (virtualIME.parse.charAt(0) != 'i') {
						virtualIME.inputDisplay.appendText(virtualIME.parse);
						virtualIME.result = virtualIME.queryText(virtualIME.parse);
					} else {
						virtualIME.inputDisplay.appendText('i');
						if (/i\d.*/i.exec(virtualIME.parse))
						{
							virtualIME.inputDisplay.text(virtualIME.parse);
							virtualIME.result = virtualIME.queryNumber(virtualIME.parse.substring(1));
						}
						else
						{
							var keyword = ""
							var after = "";
							if (len > 1) {
								keyword = virtualIME.parse.substring(1, 3);
								virtualIME.inputDisplay.append('<span class="ime-input-keyword"></span>')
								virtualIME.inputDisplay.children('.ime-input-keyword').text(keyword);
							}
							if (len >= 3) {
								after = virtualIME.parse.substring(3);
								virtualIME.inputDisplay.appendText(after);
							}
							virtualIME.result = virtualIME.queryExtensions(keyword, after);
							if (virtualIME.result.result.length == 0){
								virtualIME.inputDisplay.text(virtualIME.parse);
							}
						}
					}
				} else {
					virtualIME.display.hide();
					virtualIME.result = virtualIME.emptyResult;
				}
				virtualIME.page = 1;
				var count = Math.floor(virtualIME.result.result.length / virtualIME.settings.choicePerPage);
				if (count < (virtualIME.result.result.length / virtualIME.settings.choicePerPage)) {
					count++;
				}
				virtualIME.pages = count;
				virtualIME.choice = 1;
				virtualIME.updateOutput();
			}
		};
		window['virtualIME']['updateOutput'] = function () {
			virtualIME.baseKey = virtualIME.result.baseKey;
			virtualIME.descriptionDisplay.text(virtualIME.result.description);
			virtualIME.outputDisplay.empty();
			$.each(virtualIME.result.result, function (index, item) {
				if (index > ((virtualIME.page - 1) * virtualIME.settings.choicePerPage - 1) && index <= (virtualIME.page * virtualIME.settings.choicePerPage - 1)) {
					var id = (index - Math.floor(index / virtualIME.settings.choicePerPage) * virtualIME.settings.choicePerPage + 1);
					var idoutput = virtualIME.baseKey != 0 ? '<span class="ime-output-id">' + String.fromCharCode(virtualIME.baseKey + id - 1) + '.</span>' : '';
					idoutput = idoutput.toLowerCase();
					virtualIME.outputDisplay.append('<li id="ime-output-item-' + id + '"><div>' + idoutput + '<span class="ime-output-item">' + item + '</span></div></li>');
				}
			});
			virtualIME.choiceCount = virtualIME.outputDisplay.children().length;
			if (virtualIME.choice > virtualIME.choiceCount) virtualIME.choice = virtualIME.choiceCount;
			virtualIME.outputDisplay.children().click(function () {
				virtualIME.clickOnItem($(this));
			});
			if (virtualIME.result.result.length > 0) {
				virtualIME.outputDisplay.children('#ime-output-item-' + virtualIME.choice).addClass('ime-output-active');
			}
			if (virtualIME.result.result.length > virtualIME.settings.choicePerPage) {
				if (virtualIME.page == virtualIME.pages) {
					virtualIME.pageUpButton.removeClass('ime-button-disable');
					virtualIME.pageDownButton.addClass('ime-button-disable');
				} else if (virtualIME.page == 1) {
					virtualIME.pageUpButton.addClass('ime-button-disable');
					virtualIME.pageDownButton.removeClass('ime-button-disable');
				} else {
					virtualIME.pageUpButton.removeClass('ime-button-disable');
					virtualIME.pageDownButton.removeClass('ime-button-disable');
				}
			} else {
				virtualIME.pageUpButton.addClass('ime-button-disable');
				virtualIME.pageDownButton.addClass('ime-button-disable');
			}
		};
		window['virtualIME']['pageDown'] = function () {
			if (virtualIME.pages <= 1 || virtualIME.page == virtualIME.pages) return false;
			virtualIME.page++;
			virtualIME.updateOutput();
			return true;
		}
		window['virtualIME']['pageUp'] = function () {
			if (virtualIME.pages <= 1 || virtualIME.page == 1) return false;
			virtualIME.page--;
			virtualIME.updateOutput();
			return true;
		}
		window['virtualIME']['charDown'] = function () {
			if (virtualIME.choice == virtualIME.choiceCount) {
				var result = virtualIME.pageDown();
				if (result) {
					virtualIME.choice = 1;
					virtualIME.updateOutput();
				}
				return result;
			}
			virtualIME.choice++;
			virtualIME.updateOutput();
		}
		window['virtualIME']['charUp'] = function () {
			if (virtualIME.choice == 1) {
				var result = virtualIME.pageUp();
				if (result) {
					virtualIME.choice = virtualIME.choiceCount;
					virtualIME.updateOutput();
				}
				return result;
			}
			virtualIME.choice--;
			virtualIME.updateOutput();
		}
		window['virtualIME']['clickOnItem'] = function (item) {
			var suggest = item.children('div').children('.ime-output-item').children('.ime-output-suggest-text').text();
			item.children('div').children('.ime-output-item').children('.ime-output-suggest').remove()
			var text = item.children('div').children('.ime-output-item').text();
			
			if (suggest != "") {
				virtualIME.input.val(virtualIME.input.val() + suggest);
				virtualIME.input.update();
			} else {
				virtualIME.output(text == "" ? virtualIME.input.val() : text);
				virtualIME.input.val('');
				virtualIME.input.update();
			}
			return false;
		}
		window['virtualIME']['output'] = function (text) {
			$('#output').appendText(text);
		};
		window['virtualIME']['outputHTML'] = function (text) {
			$('#output').append(text);
		};
		window['virtualIME']['outputDelete'] = function (text) {
			var old = $('#output').html();
			var newhtml = old.substring(0,old.length - 1);
			newhtml.replace(/<\/?br.*?>/gi, '');
			$('#output').html(newhtml);
		}
		virtualIME.display.click(function () {
			virtualIME.input.focus();
		});
		virtualIME.logoButton.click(function () {
			location.href = "http://www.google.com/";
			return false;
		});
		virtualIME.pageDownButton.click(virtualIME.pageDown);
		virtualIME.pageUpButton.click(virtualIME.pageUp);
		virtualIME.pageUpButton.addClass('ime-button-disable');
		virtualIME.pageDownButton.addClass('ime-button-disable');
		virtualIME.input.update = function (item) {
			document.body.scrollTop = document.body.scrollHeight;
			if (typeof item !== "undefined") {
				if (item.type == "keydown") {
					if (virtualIME.baseKey != 0 && (item.keyCode >= virtualIME.baseKey && item.keyCode <= (virtualIME.baseKey + virtualIME.choiceCount - 1))) {
						if (virtualIME.choiceCount == 0){
							return true;
						}
						var index = item.keyCode - virtualIME.baseKey + 1;
						virtualIME.clickOnItem(virtualIME.outputDisplay.children('#ime-output-item-' + index));
						return false;
					} else if (item.keyCode == 38) {
						virtualIME.charUp();
						return false;
					} else if (item.keyCode == 40) {
						virtualIME.charDown();
						return false;
					} else if (item.keyCode == 32) {
						try {
							virtualIME.clickOnItem(virtualIME.outputDisplay.children('#ime-output-item-' + virtualIME.choice));
						} catch(e) {}
						return false;
					} else if (item.keyCode == 8) {
						if (virtualIME.input.val() == '')
						{
							virtualIME.outputDelete();
							return false;
						}
						else
						{
							virtualIME.update(virtualIME.input.val().toLowerCase());
							return true;
						}
					} else if (item.keyCode == 13) {
						if (virtualIME.input.val() == '')
						{
							virtualIME.outputHTML('<br />');
						}
						else
						{
							virtualIME.output(virtualIME.input.val());
							virtualIME.input.val('');
							virtualIME.input.update();
						}
						return false;
					} else if (item.keyCode == 33 || (item.keyCode == 189 && !item.shiftKey)) {
						virtualIME.pageUp();
						return false;
					} else if (item.keyCode == 34 || (item.keyCode == 187 && !item.shiftKey)) {
						virtualIME.pageDown();
						return false;
					} //else{document.title=item.keyCode;}
				}
			}
			virtualIME.update(virtualIME.input.val().toLowerCase());
			virtualIME.input.width(virtualIME.inputDisplay.width() + 20);
			document.body.scrollTop = document.body.scrollHeight;
		};
		virtualIME.input.change(virtualIME.input.update).keydown(virtualIME.input.update).keyup(virtualIME.input.update);
		try {
			virtualIME.input.focus();
		} catch(e) {}
	});
})();
<%@page import="com.hoson.StringUtil"%>
<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.map.AnyChartUtil"%>
<%@page import="com.hoson.map.WarningAnyChart"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String dateTime=StringUtil.getNowDate()+"";
	AnyChartUtil acu = new AnyChartUtil();
	acu.saveAsXml(request, "gas",dateTime);
	acu.saveAsXml(request,"water",dateTime);
	WarningAnyChart warn=new WarningAnyChart();
	warn.saveAsXml(request,dateTime.substring(0,7));
%>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />

<script type="text/javascript" language="JavaScript" src="js/AnyChart.js"></script>
<script type="text/javascript" src="js/jquery-1.9.0.min.js"></script>
<style type="text/css">
html, body {
	width:100%;
	height:100%;
	padding:0px;
	margin:0px;
}

body {
	text-align:center;
	font-size:14px;
}

.cell_left, .cell_right{
	width:33%;
}

.cell_left {
	margin-right:10px;
}
.cell_right {
	margin-left:10px;
}

.cell_center {
	overflow:hidden;
	zoom:1;
}
#chartContainer,#chartContainer1,#chartContainer2,#chartContainer3,#chartContainer4,#chartContainer5{ width:100%;height:100%;}
.left {
	float:left;
}
.right {
	float:right;
}

.row {
	clear:both;
}

.root {
	width:100%;
	height:100%;
	margin:auto;
}

.root * {
	/*������FF��˵*/
	-moz-user-select:none;
}

.line {
	width:100%px;
	height:0px;
	overflow:hidden;
}

.move {
	border:#CCCCCC 1px solid;
	height:aotu;
	margin-top:5px;
	margin-bottom:5px;
	display:none;
}

.title {
	height:24px;
	line-height:24px;
	background:#58B044;
}

.title_a {
	width:auto;
	margin-right:80px;
	cursor:move;
	font-size:12px;
	font-weight:bold;
	color:#FFFFFF;
	text-align:left;
	padding-left:10px;
}

.title_max, .title_reduce, .title_lock, .title_edit, .title_close {
	float:right;
	width:24px;
	font-size:9px;
	color:#CCCCCC;
	cursor:pointer;
	display:none;
}
.title_max {
	display:block;
	background:url(a2.png) no-repeat;
	 text-indent:-9999px;
}
.title_reduce {
	display:block;
	background:url(a1.png) no-repeat;
	 text-indent:-9999px;
}
.titlev{
	display:block;
	background:url(a3.png) no-repeat;
	 text-indent:-9999px;
}


.title_reduce, .title_lock, .title_edit {
	cursor:pointer;
}

.title_close {
	cursor:default;
}

.content {
	height:300px;
	border-top:#CCCCCC 1px solid;
	background-color:#F7F7F7;
	font-size:12px;
	line-height:130%;
}

.CDrag_temp_div {
	border:#CCCCCC 1px dashed;
	margin-top:5px;
	margin-bottom:5px;
}

a#DEL_CDrag, a#ADD_CDrag {
	color:#6699CC;
	text-decoration:none;
}

a#DEL_CDrag:hover, a#ADD_CDrag:hover {
	color:#FF0000;
}


.Dall_screen, .Iall_screen {
	position:absolute;
	left:0px;
	top:0px;
}

.Dall_screen {
	z-index:99;
	background-color:#000000;
	filter:alpha(opacity=30);
	opacity:0.3;
}

.Iall_screen {
	z-index:98;
	filter:alpha(opacity=0);
	opacity:0;
}

.Nall_screen {
	position:absolute;
	z-index:100;
	left:300px;
	top:100px;
	width:300px;
	height:auto;
	border:#6699CC 1px solid;
	background-color:#F0FAFF;
	padding:10px 0 10px 0;
}

.Call_screen {
	width:100%;
	height:auto;
	line-height:30px;
	font-size:12px;
	padding-bottom:10px;
}

.charttitle {
}
.charttitle h6 {
	margin:0;
	padding:5px 0;
	color:#0e4391;
	font-size:14px;
	font-weight:bold;
}
.charttitle p {
	margin:0;
	padding:0;
	color:#878787;
	text-align:center;
	position:relative;
	zoom:1;
}
.charttitle p a.prev {
	position:absolute;
	left:10px;
}
.charttitle p a.next {
	position:absolute;
	right:10px;
}
</style>

<script type="text/javascript">
var today=new Date();
var dayDate=today.getDate();
var monthDate=(today.getMonth() + 1);
if(monthDate<10){
	monthDate="0"+monthDate;
}
if(dayDate<10){
	dayDate="0"+dayDate;
	}
var now_Date=today.getFullYear()+"-"+monthDate+"-"+dayDate;

var now_month=today.getFullYear()+"-"+monthDate;

var Class = {
//������
	create : function () {
		return function () {
			this.initialize.apply(this, arguments);
		};
	}
};

var $A = function (a) {
//ת������
	return a ? Array.apply(null, a) : new Array;
};

var $ = function (id) {
//��ȡ����
	return document.getElementById(id);
};

var Try = {
//����쳣
	these : function () {
		var returnValue, arg = arguments, lambda, i;
	
		for (i = 0 ; i < arg.length ; i ++) {
			lambda = arg[i];
			try {
				returnValue = lambda();
				break;
			} catch (exp) {}
		}
	
		return returnValue;
	}
	
};

Object.extend = function (a, b) {
//׷�ӷ���
	for (var i in b) a[i] = b[i];
	return a;
};

Object.extend(Object, {

	addEvent : function (a, b, c, d) {
	//��Ӻ���
		if (a.attachEvent) a.attachEvent(b[0], c);
		else a.addEventListener(b[1] || b[0].replace(/^on/, ""), c, d || false);
		return c;
	},
	
	delEvent : function (a, b, c, d) {
		if (a.detachEvent) a.detachEvent(b[0], c);
		else a.removeEventListener(b[1] || b[0].replace(/^on/, ""), c, d || false);
		return c;
	},
	
	reEvent : function () {
	//��ȡEvent
		return window.event ? window.event : (function (o) {
			do {
				o = o.caller;
			} while (o && !/^\[object[ A-Za-z]*Event\]$/.test(o.arguments[0]));
			return o.arguments[0];
		})(this.reEvent);
	}
	
});

Function.prototype.bind = function () {
//���¼�
	var wc = this, a = $A(arguments), o = a.shift();
	return function () {
		wc.apply(o, a.concat($A(arguments)));
	};
};

var CDrag = Class.create();

CDrag.IE = /MSIE/.test(window.navigator.userAgent);

CDrag.load = function (obj_string, func, time) {
//���ض���
	var index = 0, timer = window.setInterval(function () {
		try {
			if (eval(obj_string + ".loaded")) {
				window.clearInterval(timer);
				func(eval("new " + obj_string));
			}
		} catch (exp) {}

		if (++ index == 20) window.clearInterval(timer);
	}, time + index * 3);
};

CDrag.database = {
//���ݴ洢
	json : null,
	
	parse : function (id) {
	//������Դ
		var wc = this, json = wc.json, i;
		for (i in json) {
			if (json[i].id == id)
				return json[i];
		}
	}
};

CDrag.Ajax = Class.create();

Object.extend(CDrag.Ajax, {

	getTransport: function() {
		return Try.these(
			function () { return new ActiveXObject('Msxml2.XMLHTTP'); },
			function () { return new ActiveXObject('Microsoft.XMLHTTP'); },
			function () { return new XMLHttpRequest(); }
		) || false;
	}
	
});

CDrag.Ajax.prototype = {

	initialize : function (url) {
	//��ʼ��
		var wc = this;
		wc.ajax = CDrag.Ajax.getTransport();
	},
	
	load : function (func) {
		var wc = this, ajax = wc.ajax;
		if (ajax.readyState == 4 && ajax.status == 200)
			func(ajax.responseText);
	},
	
	send : function (url, func) {
		var wc = this, ajax = wc.ajax,
			querys = url + "&" + new Date().getTime() + (10000 + parseInt(Math.random() * 10000));
		ajax.open("get", querys, true);
		ajax.onreadystatechange = wc.load.bind(wc, func);
		ajax.send(null);
	}
	
};

CDrag.Table = Class.create();

CDrag.Table.prototype = {
//�е���ק��ʱ������

	initialize : function () {
	//��ʼ��
		var wc = this;
		wc.items = []; //��������
	},
	
	add : function () {
	//�����
		var wc = this, id = wc.items.length, arg = arguments;
		return wc.items[id] = new CDrag.Table.Cols(id, wc, arg[0]);
	}
};

CDrag.Table.Cols = Class.create();

CDrag.Table.Cols.prototype = {
	
	initialize : function (id, parent, element) {
	//��ʼ��
		var wc = this;
		wc.items = []; //��������
		wc.id = id;
		wc.parent = parent;
		wc.element = element;
	},
	
	add : function () {
	//�����
		var wc = this, id = wc.items.length, arg = arguments;
		return wc.items[id] = new CDrag.Table.Rows(id, wc, arg[0], arg[1], arg[2]);
	},
	
	ins : function (num, row) {
	//������
		var wc = this, items = wc.items, i;
		
		if (row.parent == wc && row.id < num) num --; //ͬ�������ƶ���ʱ��
		for (i = num ; i < items.length ; i ++) items[i].id ++;
		
		items.splice(num, 0, row);
		row.id = num, row.parent = wc;
		
		return row;
	},
	
	del : function (num) {
	//ɾ����
		var wc = this, items = wc.items, i;
		
		if (num >= items.length) return;
		for (i = num + 1; i < items.length ; i ++) items[i].id = i - 1;
		return items.splice(num, 1)[0];
	}
	
};

CDrag.Table.Rows = Class.create();

CDrag.Table.Rows.prototype = {
	
	
	initialize : function (id, parent, element, window, locks) {
	//��ʼ��
		var wc = this, temp;
		
		wc.id = id;
		wc.parent = parent;
		wc.root_id = element;
		wc.window = window;
		wc.element = wc.element_init();
		
		temp = wc.element.childNodes[0];
		wc.title = temp.childNodes[5];
		wc.reduce = temp.childNodes[4];
		wc.max = temp.childNodes[3];
		wc.lock = temp.childNodes[2], wc.locks = locks;
		wc.edit = temp.childNodes[1];
		wc.close = temp.childNodes[0];
		wc.content = wc.element.childNodes[1];
		
		wc.Class = wc.mousedown = wc.reduceFunc = wc.lockFunc = wc.editFunc = wc.closeFunc = null;
		
		wc.init();
		wc.load();
	},
	
	element_init : function () {
	//��ʼ��Ԫ��
		var wc = this, div = $("root_row").cloneNode(true);
		
		wc.parent.element.appendChild(div);
		div.style.display = "block";
		return div;
	},
	
	init : function () {
	//��ʼ����Ϣ
		var wc = this;
		if (wc.window == 0) {
			wc.content.style.display = "none";
			wc.reduce.innerHTML = "��ԭ";
		} else {
			wc.content.style.display = "block";
			wc.reduce.innerHTML = "��С";
		}
		
		wc.lock.innerHTML = !wc.locks ? "����" : "���";
	},
	
	load : function () {
	//��ȡ�����Ϣ
		var wc = this, info = CDrag.database.parse(wc.root_id), script;
		
		wc.title.innerHTML = info.title;
		if (info.src) {			
			wc.content.innerHTML = info.src;
			script = document.createElement("script");
			script.src = info.src + ".js";//, script.defer = true;
			document.getElementsByTagName("head")[0].appendChild(script);
			CDrag.load(info.className, wc.upload.bind(wc), 5);
		} else	wc.content.innerHTML = info.className;
	},
	
	upload : function (obj) {
	/*��������Ϣ
		ע��������м�����һ����չ�࣬�����е����ݿ���ͨ����չ��������^o^
		������չ��ĸ�ʽ������open������edit��������������.��̬��Աloaded = true��Ϊ�˼���Ƿ�������
		��չ����ŵ�������.js�ļ��Ȼ���database�ṹ�����趨���������
	*/
		var wc = this;
		wc.Class = obj;
		wc.Class.parent = wc;
		wc.editFunc = Object.addEvent(wc.edit, ["onclick"], wc.lockF(wc.Class, wc.Class.edit, wc));
		wc.Class.open();
	},
	
	lockF : function () {
	//��������
		var wc = this, arg = $A(arguments), root = arg.shift(), func = arg.shift();
		return function () {
			if (!wc.locks) func.apply(root, arg.concat($A(arguments)));
		};
	}
	
};

CDrag.Add = Class.create();

CDrag.Add.prototype = {
	
	initialize : function (parent) {
	//��ʼ������
		var wc = this;
		wc.div = document.createElement("div"); //�����div
		wc.iframe = document.createElement("iframe"); //Э��wc.div��select��iframe
		wc.node = document.createElement("div"); //���ݵײ�div
		wc.content = document.createElement("div"); //���ݲ�div
		wc.button = document.createElement("button"); //���ݴ���ť
		wc.parent = parent;
		wc.json = null;
		
		wc.button.onclick = wc.execute.bind(wc, wc.content); //��ťָ�򷽷�
		wc.init_element();
	},
	
	init_element : function () {
	//��ʼ��Ԫ��
		var wc = this;
		wc.div.setAttribute(CDrag.IE ? "className" : "class", "Dall_screen");
		wc.iframe.setAttribute(CDrag.IE ? "className" : "class", "Iall_screen");
		wc.node.setAttribute(CDrag.IE ? "className" : "class", "Nall_screen");
		wc.content.setAttribute(CDrag.IE ? "className" : "class", "Call_screen");
		wc.button.innerHTML = "ִ��";
		wc.node.appendChild(wc.content);
		wc.node.appendChild(wc.button);
	},
	
	init_json : function () {
	//��ʼ��ԭʼ������Ϣ��
		var wc = this, parent = wc.parent,
			cols = parent.table.items, new_json = {}, init_json = CDrag.database.json, r, i, j;
			
		for (i = 0 ; i < init_json.length ; i ++) //����ԭʼ����
			new_json[init_json[i].id] = { id : init_json[i].id, row : null, title : init_json[i].title };
			
		for (i = 0 ; i < cols.length ; i ++) //�����޸����ɵĴ�������
			for (r = cols[i].items, j = 0 ; j < r.length ; j ++)
				new_json[r[j].root_id].row = r[j];
		return new_json;
	},
	
	init_node : function () {
	//��ʼ�����ݲ�div������
		var wc = this, json = wc.json = wc.init_json(), boxary = [], i;
		for (i in json)
			boxary[boxary.length] = [
				'<input type="checkbox"', json[i].row ? 'checked="checked"' : "",
				' value="', json[i].id, '" />&nbsp;&nbsp;', json[i].title, '<br \/>'
			].join("");

		wc.content.innerHTML = boxary.join(""); //д�����ݲ�
	},
	
	execute : function (div) {
	//����table��ṹ
		var wc = this, parent = wc.parent, json = wc.json, items = div.getElementsByTagName("input"), row, c, i;
		
		try {
		
			for (i = 0 ; i < items.length ; i ++) {
			
				if (items[i].type != "checkbox") continue;
				row = json[items[i].value];
				
				if ((!!row.row) != items[i].checked) {
					if (row.row) parent.remove(row.row); //ɾ��
					else parent.add(parent.table.items[0].add(row.id, 1, false)); //���һ��׷������
					c = true;
				}
				
			}
			
			div.innerHTML = "";
			if (c) parent.set_cookie();
			
		} catch (exp) {}
		wc.close();
	},
	
	add : function () {
	//�������
		var wc = this, div = wc.div, iframe = wc.iframe;
		wc.init_node();
		div.style.height = iframe.style.height = Math.max(document.documentElement.scrollHeight, document.documentElement.offsetHeight) + "px";
		div.style.width = iframe.style.width = Math.max(document.documentElement.scrollWidth, document.documentElement.offsetWidth) + "px";
		document.getElementsByTagName("html")[0].style.overflow = "hidden";
		document.body.appendChild(iframe);
		document.body.appendChild(div);
		document.body.appendChild(wc.node);
	},
	
	close : function () {
	//�ر���ӿ�
		var wc = this, div = wc.div, iframe = wc.iframe;
		document.getElementsByTagName("html")[0].style.overflow = CDrag.IE ? "" : "auto";
		document.body.removeChild(iframe);
		document.body.removeChild(div);
		document.body.removeChild(wc.node);
	}
	
};

CDrag.prototype = {
	
	initialize : function () {
	//��ʼ����Ա
		var wc = this;
		wc.table = new CDrag.Table; //����������
		wc.addc = new CDrag.Add(wc); //������Ӷ���
		wc.iFunc = wc.eFunc = null;
		wc.obj = { on : { a : null, b : "" }, row : null, left : 0, top : 0 };
		wc.temp = { row : null, div : document.createElement("div") };
		wc.temp.div.setAttribute(CDrag.IE ? "className" : "class", "CDrag_temp_div");
		wc.temp.div.innerHTML = "&nbsp;";
	},
	
	reMouse : function (a) {
	//��ȡ���λ��
		var e = Object.reEvent();
		return {
			x : document.documentElement.scrollLeft + e.clientX,
			y : document.documentElement.scrollTop + e.clientY
		};
	},
	
	rePosition : function (o) {
	//��ȡԪ�ؾ���λ��
		var $x = $y = 0;
		do {
			$x += o.offsetLeft;
			$y += o.offsetTop;
		} while ((o = o.offsetParent)); // && o.tagName != "BODY"
		return { x : $x, y : $y };
	},
	
	execMove : function (status, on_obj, in_obj, place) {
	//������ק����ϸ��
		var wc = this, obj = wc.obj.on, temp = wc.temp, px;
		
		obj.a = on_obj, obj.b = status;
		
		if (place == 0) {
		//����
			px = in_obj.element.clientWidth;
			in_obj.element.parentNode.insertBefore(temp.div, in_obj.element);
		} else if (place == 1) {
		//�¼���
			px = in_obj.element.clientWidth - 2;
			in_obj.element.appendChild(temp.div);
		} else {
		//����
			px = in_obj.element.clientWidth;
			in_obj.element.parentNode.appendChild(temp.div);
		}
		
		wc.obj.left = Math.ceil(px / temp.div.offsetWidth * wc.obj.left); //������ק���к��ȱ仯����������ק��ľ�������.
		temp.row.style.width = temp.div.style.width = px + "px"; //�����к�����ȱ仯
	},
	
	sMove : function (o) {
	//���϶���ʼʱ���ò���
		
		var wc = this;
		if (o.locks || wc.iFunc || wc.eFinc) return;
		
		var mouse = wc.reMouse(), obj = wc.obj, temp = wc.temp, div = o.element, position = wc.rePosition(div);
		
		obj.row = o;
		obj.on.b = "me";
		obj.left = mouse.x - position.x;
		obj.top = mouse.y - position.y;
		
		temp.row = document.body.appendChild(div.cloneNode(true)); //����Ԥ��ק����
		temp.row.style.width = div.clientWidth + "px";
		
		with (temp.row.style) {
		//���ø��ƶ���
			position = "absolute";
			left = mouse.x - obj.left + "px";
			top = mouse.y - obj.top + "px";
			zIndex = 100;
			opacity = "0.3";
			filter = "alpha(opacity:30)";
		}
		
		with (temp.div.style) {
		//����վλ����
			height = div.clientHeight + "px";
			width = div.clientWidth + "px";
		}
		

		div.parentNode.replaceChild(temp.div, div);
		
		wc.iFunc = Object.addEvent(document, ["onmousemove"], wc.iMove.bind(wc));
		wc.eFunc = Object.addEvent(document, ["onmouseup"], wc.eMove.bind(wc));
		document.onselectstart = new Function("return false");
	},
	
	iMove : function () {
	//������ƶ�ʱ���ò���
		var wc = this, mouse = wc.reMouse(), cols = wc.table.items, obj = wc.obj, temp = wc.temp,
			row = obj.row, div = temp.row, t_position, t_cols, t_rows, i, j;
		
		with (div.style) {
			left = mouse.x - obj.left + "px";
			top = mouse.y - obj.top + "px";
		}
		
		for (i = 0 ; i < cols.length ; i ++) {
			t_cols = cols[i];
			//if (t_cols != obj.row.parent) continue;
			t_position = wc.rePosition(t_cols.element);
			if (t_position.x < mouse.x && t_position.x + t_cols.element.offsetWidth > mouse.x) {
				if (t_cols.items.length > 0) { //���������������0
					if (t_cols.items[0] != obj.row && wc.rePosition(t_cols.items[0].element).y + 20 > mouse.y) {
						//�����һ�в�Ϊ��ק���������λ�ô��ڵ�һ�е�λ�ü������ϡ���
						//����
						wc.execMove("up", t_cols.items[0], t_cols.items[0], 0);
					} else if (t_cols.items.length > 1 && t_cols.items[0] == row &&
						wc.rePosition(t_cols.items[1].element).y + 20 > mouse.y) {
						//�����һ������ק������������ڵڶ���λ����û�ж�����
						//����
						wc.execMove("me", t_cols.items[1], t_cols.items[1], 0);
					} else {
						for (j = t_cols.items.length - 1 ; j > -1 ; j --) {
							//�����������ϲ�ѯ
							t_rows = t_cols.items[j];
							if (t_rows == obj.row) {
								if (t_cols.items.length == 1) {
								//�����ק���Ǵ������һ��
									wc.execMove("me", t_cols, t_cols, 1);
								}
								continue;
							}
							if (wc.rePosition(t_rows.element).y < mouse.y) {
								//�������������������������
								if (t_rows.id + 1 < t_cols.items.length && t_cols.items[t_rows.id + 1] != obj.row) {
									//�����������һ������������һ�е��������
									wc.execMove("down", t_rows, t_cols.items[t_rows.id + 1], 0);
								} else if (t_rows.id + 2 < t_cols.items.length) {
									//���������һ������ק��������뵽�����У�����ק���󷵻�ԭλ
									wc.execMove("me", null, t_cols.items[t_rows.id + 2], 0);
								} else {
									//ǰ�涼û����������������
									wc.execMove("down", t_rows, t_rows, 2);
								}
								return;
							};
						};
					};
				} else {
				//�����������������
					wc.execMove("new", t_cols, t_cols, 1);
				};
			};
		};
	},
	
	eMove : function () {
	//������ͷ�ʱ���ò���
		var wc = this, obj = wc.obj, temp = wc.temp, row = obj.row, div = row.element, o_cols, n_cols, number;
		
		if (obj.on.b != "me") {
			number = (obj.on.b == "down" ? obj.on.a.id + 1 : 0);
			n_cols = (obj.on.b != "new" ? obj.on.a.parent : obj.on.a);
			o_cols = obj.row.parent;
			n_cols.ins(number, o_cols.del(obj.row.id));
			
			wc.set_cookie();
		}
		
		temp.div.parentNode.replaceChild(div, temp.div);
		temp.row.parentNode.removeChild(temp.row);
		delete temp.row;
		
		Object.delEvent(document, ["onmousemove"], wc.iFunc);
		Object.delEvent(document, ["onmouseup"], wc.eFunc);
		document.onselectstart = wc.iFunc = wc.eFunc = null;
	},
	
	reduce : function (o) {
	//����С
		var wc = this;
		if ((o.window = (o.window == 1 ? 0 : 1))) {
			o.content.style.display = "block";
			o.reduce.innerHTML = "��С";
		} else {
			o.content.style.display = "none";
			o.reduce.innerHTML = "��ԭ";
		}
		wc.set_cookie();
	},

	max : function (o) {
	//����С
		var wc = this;
		if ((o.window = (o.window == 1 ? 0 : 1))) {
			o.element.style.position = "";
			o.element.style.margin = "";
			o.content.style.height = "";
			o.element.style.width = "";
			o.content.style.display = "block";
			o.max.innerHTML = "���";
		} else {
			o.element.style.position = "absolute";
			o.element.style.left = "0";
			o.element.style.top = "0";
			o.element.style.margin = "0";
			o.element.style.width = document.documentElement.clientWidth - 2 + "px";
			o.content.style.display = "block";
			
			//o.content.style.height = document.documentElement.clientHeight - 26 + "px";
			//o.content.style.height = document.documentElement.clientHeight - 27 + "px";
			var height = document.documentElement.clientHeight;
			height = height > 642 ? 642 : height;
			o.content.style.height = height + "px";
			
			o.max.innerHTML = "��ԭ";
		}
		wc.set_cookie();
	},
	
	lock : function (o) {
	//����
		var wc = this;
		if (o.locks) {
			o.locks = false;
			o.lock.innerHTML = "����";
		} else {
			o.locks = true;
			o.lock.innerHTML = "���";
		}
		wc.set_cookie();
	},
	
	close : function (o) {
	//�رն���
		var wc = this;
		wc.remove(o);
		wc.set_cookie();
	},
	
	remove : function (o) {
	//�Ƴ�����
		var wc = this, parent = o.parent;
		
		Object.delEvent(o.close, ["onclick"], o.closeFunc);
		if (o.editFunc) Object.delEvent(o.edit, ["onclick"], o.editFunc);
		Object.delEvent(o.lock, ["onclick"], o.lockFunc);
		Object.delEvent(o.reduce, ["onclick"], o.reduceFunc);
		Object.delEvent(o.max, ["onclick"], o.maxFunc);
		Object.delEvent(o.title, ["onmousedown"], o.mousedown);
		
		o.mousedown = o.reduceFunc = o.maxFunc = o.lockFunc = o.editFunc = o.closeFunc = null;
		
		parent.element.removeChild(o.element);
		parent.del(o.id);
		delete wc.Class;
		delete o;
	},
	
	create_json : function () {
	//����json��
		var wc = this, cols = wc.table.items, a = [], b = [], i, j, r;
		for (i = 0 ; i < cols.length ; i ++) {
			for (r = cols[i].items, j = 0 ; j < r.length ; j ++)
				b[b.length] = "{id:'" + r[j].root_id + "',window:" + r[j].window + ",locks:" + r[j].locks + "}";
			a[a.length] = "cols:'" + cols[i].element.id + "',rows:[" + b.splice(0, b.length).join(",") + "]";
		}
		return escape("[{" + a.join("},{") + "}]");
	},
	
	parse_json : function (cookie) {
	//����json�ɶ���
		return eval("(" + cookie + ")");
	},
	
	get_cookie : function () {
	//��ȡCOOKIE
		return (/CDrag=([^;]+)(?:;|$)/.exec(document.cookie) || [,])[1];
	},
	
	set_cookie : function () {
	//����COOKIE
		var wc = this, date = new Date;
		date.setDate(date.getDate() + 1);
		document.cookie = "CDrag=" + wc.create_json() + ";expires=" + date.toGMTString();
	},
	
	del_cookie : function () {
	//ɾ��COOKIE
		var wc = this, cookie = wc.get_cookie(), date;
		if (cookie) {
			date = new Date;
			date.setTime(date.getTime() - 1);
			document.cookie = "CDrag=" + cookie + ";expires=" + date.toGMTString();
		}
	},
	
	parse : function (o) {
	//��ʼ����Ա
		try {
			var wc = this, table = wc.table, cols, rows, div, i, j;
			for (i = 0 ; i < o.length ; i ++) {

				div = $(o[i].cols), cols = table.add(div);
				for (j = 0 ; j < o[i].rows.length ; j ++)
					wc.add(cols.add(o[i].rows[j].id, o[i].rows[j].window, o[i].rows[j].locks));
			}
		} catch (exp) {
			wc.del_cookie();
		}

      //��ˮ����ͼ
		var chart = new AnyChart('./swf/AnyChart.swf');
	    chart.width = "100%";//chart.width = '660';
	   	chart.height = "94%";
//     	chart.height = "100%";
      	chart.setXMLFile("water.xml");
	    chart.write("chartContainer");
	    
      //��������ͼ
	    var chart2 = new AnyChart('./swf/AnyChart.swf');
	    chart2.width = "100%";
// 		chart2.height = "100%";
      	chart2.height = "94%";
      	chart2.setXMLFile("gas.xml");
	    chart2.write("chartContainer2");
	    
      //ͨѶ����״̬
	    var chart3 = new AnyChart('./swf/AnyChart.swf');
	    chart3.width = "100%";
      	chart3.height = "100%";
      	chart3.setXMLFile("./comm_state_data.jsp?state=zc&infectant_id=B01&"+
      	"infectant_id=001&infectant_id=060&infectant_id=101&infectant_id=065&data_flag=real&station_type=1");
	    chart3.write("chartContainer3");
	    
	    
      //ʵʱ��������
	    var chart4 = new AnyChart('./swf/AnyChart.swf');
	    chart4.width = "100%";
     	chart4.height = "100%";
      	chart4.setXMLFile("./net_rate_data.jsp?state=zc&infectant_id=011&data_flag=real&station_type=1");
	    chart4.write("chartContainer4");
	    
      //�쳣��������
	    var chart5 = new AnyChart('./swf/AnyChart.swf');
	    chart5.width = "100%";
// 	    chart5.height = "100%";
		 chart5.height="94%";
      	chart5.setXMLFile("warning.xml");
	    chart5.write("chartContainer5");
	    
      //����ͨѶ����״̬
	    var chart6 = new AnyChart('./swf/AnyChart.swf');
	    chart6.width = "100%";
      	chart6.height = "100%";
      	chart6.setXMLFile("./comm_state_data_gas.jsp?state=zc&infectant_id=02&infectant_id=01"
      	+"&infectant_id=S02&infectant_id=S01&infectant_id=S03&infectant_id=03&infectant_id=04&infectant_id=S08&"
      	+"infectant_id=B02&infectant_id=2&infectant_id=1&infectant_id=3&infectant_id=S05&data_flag=real&station_type=2");
	    chart6.write("chartContainer6");
	    
	},
	
	add : function (o) {
	//��Ӷ���
		var wc = this;
		o.mousedown = Object.addEvent(o.title, ["onmousedown"], o.lockF(wc, wc.sMove, o));
		o.reduceFunc = Object.addEvent(o.reduce, ["onclick"], o.lockF(wc, wc.reduce, o));
		o.maxFunc = Object.addEvent(o.max, ["onclick"], o.lockF(wc, wc.max, o));
		o.lockFunc = Object.addEvent(o.lock, ["onclick"], wc.lock.bind(wc, o));
		o.closeFunc = Object.addEvent(o.close, ["onclick"], o.lockF(wc, wc.close, o));
	},
	
	append : function () {
		var wc = this;
		wc.addc.add();
	}
	
};



CDrag.database.json = [
		
	{ id : "m_1_1", title : "��ˮ����ͼ", className : "��һ�еĵ�һ��", src : "<div class='charttitle' ><p><a class='prev' href='javascript:waterChangeDate(-1);water_ajax();'>��һ��</a><span id='dateTime'>"+now_Date+" </span><a class='next'  href='javascript:waterChangeDate(1);water_ajax();' >��һ��</a></p></div><div id='chartContainer'></div>" },
	
// 	{ id : "m_1_1", title : "��ˮ����ͼ", className : "��һ�еĵ�һ��", src : "<div id='chartContainer'></div>" },
	
	{ id : "m_1_2", title : "��ˮͨѶ����״̬", className : "�����еĵ�һ��", src : "<div id='chartContainer3'></div>" },
	
	{ id : "m_2_1", title : "��������ͼ", className : "��һ�еĵڶ���", src : "<div class='charttitle' ><p><a class='prev' href='javascript:gasChangeDate(-1);gas_ajax();'>��һ��</a><span id='dateTime2'>"+now_Date+" </span><a class='next' href='javascript:gasChangeDate(1);gas_ajax();' >��һ��</a></p></div><div id='chartContainer2'></div>" },

	{ id : "m_2_2", title : "����ͨѶ����״̬", className : "�����еĵڶ���", src : "<div id='chartContainer6'></div>" },

// 	{ id : "m_1_2", title : "��������ͼ", className : "��һ�еĵڶ���", src : "<div id='chartContainer2'></div>" },
		
	{ id : "m_3_1", title : "�쳣��������", className : "�ڶ��еĵ�һ��", src : "<div class='charttitle' ><p><a class='prev' href='javascript:changTheMonth(-1);warn_ajax();'>��һ��</a><span id='monthTime'>"+now_month+" </span><a class='next' href='javascript:changTheMonth(1);warn_ajax();' >��һ��</a></p></div><div id='chartContainer5'></div>" },

// 	{ id : "m_3_1", title : "�쳣��������", className : "�ڶ��еĵ�һ��", src : "<div id='chartContainer5'></div>" },
	
	
	{ id : "m_3_2", title : "ʵʱ��������", className : "�ڶ��еĵڶ���", src : "<div id='chartContainer4'></div>" }
	
];

Object.addEvent(window, ["onload"], function () {
	var wc = new CDrag, cookie = wc.get_cookie();
		
		json = cookie ? wc.parse_json(unescape(cookie)) : [
		
		{ cols : "m_1", rows : [
			{ id : "m_1_1", window : 1, locks : false },
			{ id : "m_1_2", window : 1, locks : false }
		] },
		
		{ cols : "m_2", rows : [
			{ id : "m_2_1", window : 1, locks : false },
			{ id : "m_2_2", window : 1, locks : false }
		] },
		
		{ cols : "m_3", rows : [
			{ id : "m_3_1", window : 1, locks : false },
			{ id : "m_3_2", window : 1, locks : false }
		] }
		
	];
	
	wc.parse(json);
	
	(function (wc) {
		/*$("DEL_CDrag").onclick = function () {
			wc.del_cookie();
			window.location.reload();
		};
		
		$("ADD_CDrag").onclick = function () {
			wc.append();
		};*/
		
	})(wc);

	wc = null;
/*
*onload����ʱ��Ϊ��ǰ
*/
//var d=new Date();
//var now_Date=d.getYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
//document.getElementById("dateTime").innerHTML=now_Date;
//document.getElementById("dateTime2").innerHTML=now_Date;
});


	var xmlHttp;
	function createXMLHttpRequest(){
		if(window.ActiveXObject){
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}else if(window.XMLHttpRequest){
			xmlHttp=new XMLHttpRequest();
		}
	}
	/* ��ˮ ��һ��/��һ��	*/
	function waterChangeDate(n){
		var reg=new RegExp("-","g");
		var date=document.getElementById("dateTime").innerHTML.replace(reg,"/");
		var today=new Date(new Date(date).valueOf() + n*24*60*60*1000);
		var dayDate=today.getDate();
		var monthDate=(today.getMonth() + 1);
		if(monthDate<10){
			monthDate="0"+monthDate;
		}
		if(dayDate<10){
			dayDate="0"+dayDate;
		}
		var changedDate=today.getFullYear() + "-" + monthDate + "-" + dayDate;
		document.getElementById("dateTime").innerHTML=changedDate;
	}
	
	function  water_ajax(){
		createXMLHttpRequest();
		var dateTime=document.getElementById("dateTime").innerHTML;
		var args="dateTime="+dateTime;
		xmlHttp.open("post","water_ajax.jsp",true);
		xmlHttp.setRequestHeader("Content-Type",
	    "application/x-www-form-urlencoded"); 
		xmlHttp.onreadystatechange=waterCallback;
		xmlHttp.send(args);
	}
	
	function waterCallback(){
		if(xmlHttp.readyState==4 && xmlHttp.status==200){
			var result=xmlHttp.responseText;
			//window.location.reload();
		//	document.getElementById("__AnyChart___0").exeCommand('Refresh');
			document.getElementById("dateTime").innerHTML=result;
			var chart = new AnyChart('./swf/AnyChart.swf');
	    	chart.width = "100%";//chart.width = '660';
//      	chart.height = "94%";
      		chart.height = "94%";
      		chart.setXMLFile("water.xml");
	    	chart.write("chartContainer");
		}
	}
	
	/*������һ��/��һ��*/
	function gasChangeDate(n){
		var reg=new RegExp("-","g");
		var date=document.getElementById("dateTime2").innerHTML.replace(reg,"/");
		var today=new Date(new Date(date).valueOf() + n*24*60*60*1000);
		var dayDate=today.getDate();
		var monthDate=(today.getMonth() + 1);
		if(monthDate<10){
			monthDate="0"+monthDate;
		}
		if(dayDate<10){
			dayDate="0"+dayDate;
		}
		var changedDate=today.getFullYear() + "-" + monthDate + "-" + dayDate;
		document.getElementById("dateTime2").innerHTML=changedDate;
	}
	
	function gas_ajax(){
		createXMLHttpRequest();
		var dateTime=document.getElementById("dateTime2").innerHTML;
		var args="dateTime="+dateTime;
		xmlHttp.open("post","gas_ajax.jsp",true);
		xmlHttp.setRequestHeader("Content-Type",
	    "application/x-www-form-urlencoded"); 
		xmlHttp.onreadystatechange=gasCallback;
		xmlHttp.send(args);
	}
	
	function gasCallback(){
		if(xmlHttp.readyState==4 && xmlHttp.status==200){
			var result=xmlHttp.responseText;
			//window.location.reload();
		//	document.getElementById("__AnyChart___0").exeCommand('Refresh');
			document.getElementById("dateTime2").innerHTML=result;
			var chart = new AnyChart('./swf/AnyChart.swf');
	    	chart.width = "100%";//chart.width = '660';
	//      chart.height = "94%";
     		chart.height = "94%";
      		chart.setXMLFile("gas.xml");
	    	chart.write("chartContainer2");
		}
	}
	
	/* �쳣�������� ��һ��/��һ��*/
	function changTheMonth(n){
		var reg=new RegExp("-","g");
 		var dt=document.getElementById("monthTime").innerHTML.replace(reg,"/")+"/01";
 		var today=new Date(new Date(dt).valueOf() );
 		today.setMonth(today.getMonth()+n);
 		var monthDate=today.getMonth()+1;
 		if((today.getMonth() + 1)<10){ 
 		    monthDate="0"+(today.getMonth() + 1);
 		}
		var changedMonth=today.getFullYear() + "-" + monthDate;
		document.getElementById("monthTime").innerHTML=changedMonth;
	}
	
	function warn_ajax(){
		createXMLHttpRequest();
		var monthTime=document.getElementById("monthTime").innerHTML;
		var args="monthTime="+monthTime;
		xmlHttp.open("post","warn_ajax.jsp",true);
		xmlHttp.setRequestHeader("Content-Type",
	    "application/x-www-form-urlencoded"); 
		xmlHttp.onreadystatechange=warnCallback;
		xmlHttp.send(args);
	}
	
	function warnCallback(){
		if(xmlHttp.readyState==4 && xmlHttp.status==200){
			var result=xmlHttp.responseText;
			//window.location.reload();
		//	document.getElementById("__AnyChart___0").exeCommand('Refresh');
			document.getElementById("monthTime").innerHTML=result;
			var chart = new AnyChart('./swf/AnyChart.swf');
	    	chart.width = "100%";
     		chart.height = "94%";
      		chart.setXMLFile("warning.xml");
	    	chart.write("chartContainer5");
		}
	}
</script>
</head>
<body>
<div class="move" id="root_row"><div class="title"><div class="title_close">�ر�</div><div class="title_edit">�༭</div><div class="title_lock">����</div><div class="title_max">���</div><div class="title_reduce">��С</div><div class="title_a">��</div></div><div class="content"></div></div>
<div class="root">
	<div class="cell_left left" id="m_1">
		<div class="line">��</div>
	</div>
	<div class="cell_right right" id="m_3">
		<div class="line">��</div>
	</div>
	<div class="cell_center" id="m_2">
		<div class="line">��</div>
	</div>
</div>
<script type="text/javascript" >
	jQuery(function(){
 		var j= 0
		jQuery(".title div").live('click',function(){
			if(j == 0){
				jQuery(this).addClass("titlev").siblings().removeClass("titlev");
				j=j+1;
			}else{
				jQuery(this).removeClass("titlev");
				j=0;
			 }
		});
 });

</script>
</body>
</html>

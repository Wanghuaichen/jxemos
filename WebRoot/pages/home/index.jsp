<%@ page contentType="text/html;charset=gbk"%>
<%@page
	import="com.hoson.f,java.util.*,com.hoson.zdxupdate.*,com.hoson.XBean"%>
<%@page import="com.hoson.PageData"%>
<%
	String user_name = (String) session.getAttribute("user_name");
	if (f.empty(user_name)) {
		response.sendRedirect("./login/nologin.jsp");
		return;
	}
	String session_id = (String) session.getAttribute("session_id");
	Map map = zdxUpdate.getRight(user_name, session_id);
	//Map map = null;
	XBean b = new XBean(map);
	String url = "../station_new/";

	//String gis_url;
	//String gis_Addr=request.getRemoteAddr();
	//String[]gis_Array=gis_Addr.split("\\.");
	//if(gis_Array[0].equals("192") && gis_Array[1].equals("168"))
	//gis_url="http://192.168.7.11:8000/hbGis/";
	//else
	//gis_url="http://115.149.128.19:8000/hbGis/";
	//gis_url = "http://59.53.91.34:8080/hbGis/";
	String map_url = "../flashmap/map.jsp";
	String sp_url = "../site/sp/sp_list.jsp";
	sp_url = "../sp/list.jsp";
	String home_url = "../flashmap/drag.jsp";

	//url = "../map/index_new.jsp";
	//url = "home_tj.jsp";
	//url = "../real_data/index_zj.jsp";
	url = "../real_data/index.jsp";
	//System.out.println("role=="+session.getAttribute("yw_role"));
	int padding_left = 5;
	String report_url = "../report/index_new.jsp";
	report_url = "../report_sj/index.jsp";
	String yw_url = "../../../swj_yw/index_goto.jsp?user_id="
			+ session.getAttribute("user_id") + "&user_name="
			+ user_name + "&yw_role=" + session.getAttribute("yw_role")
			+ "&area_id=" + session.getAttribute("area_id");
	Map r = new HashMap();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<link rel="stylesheet" href="../../web/index.css" />
<script type="text/javascript"
	src="../../web/script/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".nav li").click(function() {
			$(this).addClass("current").siblings().removeClass("current");
			var index = $(this).index();
			$(".nd").eq(index).show().siblings().hide();
		})
		$(".nd li").click(function() {
			$(this).addClass("current").siblings().removeClass("current");
		})

	})
</script>
<script type="text/javascript">
	$(function() {
		$(".tip").live('click', function() {
			$this = $(this);
			$(".h").hide();
			$this.animate({
				top : '0'
			}, 500, function() {
				$this.addClass("tip-selected");
				$this.removeClass("tip");
			});

		})

		$(".tip-selected").live('click', function() {

			$this = $(this);
			$(".h").show();
			$this.css({
				top : '83px'
			});
			$this.removeClass("tip-selected");
			$this.addClass("tip");

		})
	})
</script>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

.l {
	float: left;
	width: 210px;
	overflow-x: hidden;
	overflow-y: scroll;
	height: 100%;
	position: relative;
	background: #e1efe3;
}

.h {
	position: relative;
}

.r {
	float: left;
	height: 100%;
	white-space: nowrap;
	width: 80%;
	position: relative;
}

.tip {
	width: 89px;
	height: 23px;
	background: url(../../web/images/tip.png) no-repeat;
	z-index: 9999;
	position: absolute;
	right: 59px;
	top: 83px;
	display: block;
	cursor: pointer;
}

.tip-selected {
	width: 89px;
	height: 23px;
	background: url(../../web/images/tip.png) no-repeat left -22px;
	cursor: pointer;
	z-index: 9999;
	position: absolute;
	right: 59px;
	top: 83px;
	display: block;
}
</style>
<title>丰城市环境自动监控系统</title>
</head>
<body>
	<%
		String sql = "select page_url from t_sys_ures where user_id='"
				+ session.getAttribute("user_id") + "' ;";
		String page_url = null;
		try {
			page_url = f.queryOne(sql, null).get("page_url").toString();
		} catch (NullPointerException e) {
			page_url = "";
		}
		PageData pd = new PageData();
		// page_url 说明：com/hoson/PageData.java
	%>
	<form name="form1">
		<div class="header h">
			<h1 class="logo">
				<img src="../../web/images/LOGO.png" />
			</h1>
			<h2 class="logo2">
				<img src="../../web/images/LOGO2.png" />
			</h2>
			<ul class="nh">
				<li class="name">您好！<%=user_name%>&emsp;</li>
				<!--
    	<li>|</li>
    	<li><a href="loadFile.jsp">帮助</a></li>
    -->
				<li>|</li>
				<%
					if (user_name.equals("admin")
							|| page_url.indexOf(pd.get("修改密码")) != -1) {
				%>
				<li><a href="../home/pwd_edit.jsp" id='yjfk'
					target='frm_home_main' onclick="f_menu_now('修改密码','','yjfk')"><span>修改密码</span>
				</a>
				</li>
				<%
					}
				%>
				<li>|</li>
				<li><a href="javascript:f_logout()">退出</a>
				</li>
			</ul>
			<div class="nav">
				<ul class="nav-tabs">
					<li class="current"><a href="#"
						onclick="f_menu_sssj('首页','','','<%=home_url%>','frm_home_main')"><span>首页</span>
					</a>
					</li>
					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("地理信息")) != -1) {
					%>
					<li><a href="#"><span>地理信息</span>
					</a>
					</li>
					<%} %>
					<!-- <li><a href="#" onclick="f_menu_sssj('电子地图','','','<%=map_url%>','frm_home_main')"><span>电子地图</span></a></li> -->
					
					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("实时监控")) != -1) {
					%>
					<li><a href='../real_data/index.jsp' id='sy1'
						target='frm_home_main' onmouseover='f_hide_all(0)'
						onclick="f_menu_sssj('实时监控','0','','../real_data/index.jsp','frm_home_main')"><span>实时监控</span>
					</a>
					</li>
					<%} %>
					<!-- 
					<li><a href='../sh_new/index.jsp' target='frm_home_main'
						onmouseover='f_hide_all(0)'
						onclick="f_menu_sssj('数据补录','-1','','../jdkh/index.jsp','frm_home_main')"><span>数据补录</span>
					</a>
					</li>
 					-->
					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("数据查询")) != -1) {
					%>
					<li><a href="#"><span>数据查询</span>
					</a>
					</li>
					<%
						}
					%>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("统计报表")) != -1) {
					%>
					<li><a href="#"><span>统计报表</span>
					</a>
					</li>
					<%
						}
					%>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("视频监控p")) != -1) {
					%>
					<li><a href="#"><span>视频监控</span>
					</a>
					</li>
					<%
						}
					%>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("意见反馈")) != -1) {
					%>
					<li><a href="#"><span>意见反馈</span>
					</a>
					</li>
					<%
						}
					%>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("系统设置")) != -1) {
					%>
					<li><a href="#"><span>系统设置</span>
					</a>
					</li>
					<%
						}
					%>
					<li><a href="#"><span>应急指挥</span>
					</a>
					</li>
				</ul>
				<div class="mt"></div>
			</div>
			<div class="nq">
				<div class="nr">

					<ul class="nd">
					</ul>
					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("地理信息")) != -1) {
					%>
					<ul class="nd" style="display:none;">
						<li
							style="margin-left: -11px;background: url('');width: 0px;border-style: none;"></li>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("电子地图")) != -1) {
					%>							
						<li><a href="../g_map/g_map.jsp" target='frm_home_main'
							onclick="f_menu_now('地理信息-->电子地图','','')"><span>电子地图</span>
						</a>
						</li>
					<%} %>
										<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("区域地图")) != -1) {
					%>								
						<li><a href="<%=map_url%>" target='frm_home_main'
							onclick="f_menu_now('地理信息-->区域地图','','')"><span>区域地图</span>
						</a>
						</li>
					<%} %>
					</ul>
					<%} %>
					
					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("实时监控")) != -1) {
					%>					
					<ul class="nd" style="display:none;">
					</ul>
					<%} %>
					<!-- 
					<ul class="nd" style="display:none;">
					</ul>
					 -->
					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("数据查询")) != -1) {
					%>
					<ul class="nd" style="display:none;">
						<li
							style="margin-left: -11px;background: url('');width: 0px;border-style: none;"></li>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("综合查询")) != -1) {
						%>
						<li><a href="../fx/query/data.jsp?sh_flag=0" id="sssj"
							target='frm_home_main'
							onclick="f_menu_now('数据查询-->综合查询','1','sssj')"><span>综合查询</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("报警数据")) != -1) {
						%>
						<li><a href="../warn/index.jsp" target='frm_home_main'
							id="bjsj" onclick="f_menu_now('数据查询-->报警数据','1','bjsj')"><span>报警数据</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("数据分析")) != -1) {
						%>
						<li><a href="../fx/fx_home.jsp?action_flag=0" id="sjfx"
							target='frm_home_main'
							onclick="f_menu_now('数据查询-->数据分析','1','sjfx')"><span>数据分析</span>
						</a>
						</li>
						<%
							}
						%>
					</ul>
					<%
						}
					%>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("统计报表")) != -1) {
					%>
					<ul class="nd" style="display:none;">
						<li
							style="margin-left: -11px;background: url('');width: 0px;border-style: none;"></li>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("污染物排放总量报表")) != -1) {
						%>
						<li><a href='../report_sj/index.jsp' id='jcd'
							target='frm_home_main' onmouseover='f_hide_all(2)'
							onclick="f_menu_now('统计报表-->污染物排放总量报表','2','')"><span>污染物排放总量报表</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("汇总报表")) != -1) {
						%>
						<li><a href='../report_cm/index.jsp' id='jcd'
							target='frm_home_main' onmouseover='f_hide_all(2)'
							onclick="f_menu_now('统计报表-->汇总报表','2','')"><span>汇总报表</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("站位在线统计报表")) != -1) {
						%>
						<li><a href='../report/zwzxtjrpt.jsp?sh_flag=0' id='jcd'
							target='frm_home_main' onmouseover='f_hide_all(2)'
							onclick="f_menu_now('统计报表-->站位在线统计报表','2','')"><span>站位在线统计报表</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("综合报表")) != -1) {
						%>
						<li><a href='../report/zhrpt.jsp?sh_flag=0' id='jcd'
							target='frm_home_main' onmouseover='f_hide_all(2)'
							onclick="f_menu_now('统计报表-->综合报表','2','')"><span>综合报表</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("自定义报表")) != -1) {
						%>
						<li><a href='../report_diy/index.jsp' id='jcd'
							target='frm_home_main' onmouseover='f_hide_all(2)'
							onclick="f_menu_now('统计报表-->自定义报表','2','')"><span>自定义报表</span>
						</a>
						</li>
						<%
							}
						%>
					</ul>
					<%
						}
					%>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("视频监控p")) != -1) {
					%>
					<ul class="nd" style="display:none;">
						<li
							style="margin-left: -11px;background: url('');width: 0px;border-style: none;"></li>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("视频监控c")) != -1) {
						%>
						<li><a href="../sp/list.jsp" id='yjcx' target='_blank'><span>视频监控</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("视频设置")) != -1) {
						%>
						<li><a href="../system/sp/form.jsp" id='yjcx'
							target='frm_home_main'
							onclick="f_menu_now('视频监控-->视频设置','3','yjcx')"><span>视频设置</span>
						</a>
						</li>
						<%
							}
						%>
					</ul>
					<%
						}
					%>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("意见反馈")) != -1) {
					%>
					<ul class="nd" style="display:none;">
						<li
							style="margin-left: -11px;background: url('');width: 0px;border-style: none;"></li>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("意见反馈")) != -1) {
						%>
						<li><a href="../advice/advice.jsp" id='yjfk'
							target='frm_home_main'
							onclick="f_menu_now('意见反馈-->意见反馈','4','yjfk')"><span>意见反馈</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("意见查询")) != -1) {
						%>
						<li><a href="../advice/query.jsp" id='yjcx'
							target='frm_home_main'
							onclick="f_menu_now('意见反馈-->意见查询','4','yjcx')"><span>意见查询</span>
						</a>
						</li>
						<%
							}
						%>
					</ul>
					<%
						}
					%>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("系统设置")) != -1) {
					%>
					<ul class="nd" style="display:none;">
						<li
							style="margin-left: -11px;background: url('');width: 0px;border-style: none;"></li>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("站位管理")) != -1) {
						%>
						<!-- <li><a href="../system/station/q_form.jsp" id='yjcx' target='frm_home_main' onclick="f_menu_now('系统设置->站位管理','5','yjcx')" ><span>站位管理</span></a></li> -->
						<li><a href="../system/station/station_info.jsp" id='yjcx'
							target='frm_home_main'
							onclick="f_menu_now('系统设置-->站位管理','5','yjcx')"><span>站位管理</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("行业管理")) != -1) {
						%>
						<li><a href="../system/trade/trade_query.jsp" id='yjcx'
							target='frm_home_main'
							onclick="f_menu_now('系统设置-->行业管理','5','yjcx')"><span>行业管理</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("部门管理")) != -1) {
						%>
						<li><a href="../system/tab_dept/tab_dept_query.jsp" id='yjfk'
							target='frm_home_main'
							onclick="f_menu_now('系统设置-->部门管理','5','yjfk')"><span>部门管理</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("用户管理")) != -1) {
						%>
						<li><a href="../system/user/user_query.jsp" id='yjcx'
							target='frm_home_main'
							onclick="f_menu_now('系统设置-->用户管理','5','yjcx')"><span>用户管理</span>
						</a>
						</li>
						<%
							}
						%>

						<!--
        <li><a href="../system/msg/index.jsp" id='yjcx' target='frm_home_main' onclick="f_menu_now('系统设置--短信平台','5','yjcx')" ><span>短信平台</span></a></li>
        <li><a href="../system/jsgs/index.jsp" id='yjcx' target='frm_home_main' onclick="f_menu_now('系统设置--数据计算公式','5','yjcx')" ><span>数据计算公式</span></a></li>
        -->
					</ul>
					<%
						}
					%>

				</div>
			</div>

		</div>
		<div class="f-nav">
			<p>
				<span>当前位置：</span><a href="#"><font id='menu_now'>首页</font>
				</a>
			</p>
		</div>
		<p class="tip"></p>
	</form>
	<iframe name='frm_home_main' id="frm_home_main" src='<%=home_url%>'
		style="  width:100%; min-height:500px; height:100&;" frameborder="0"
		onload="this.height=frm_home_main.document.body.scrollHeight"></iframe>
	<script>
		function f_logout() {
			if (confirm("您确认要退出系统吗")) {
				//window.opener=null;window.close();
				//document.location.reload();
				window.top.location.href = "../login/logout.jsp";
			} else {
			}
		}

		function f_do_nothing() {

		}

		function f_right(user) {
			if (user != "admin") {
				var div2 = document.getElementById("frm_home_main");
				div2.src = "../advice/query_advice.jsp";
			} else {
				var div2 = document.getElementById("frm_home_main");
				div2.src = "../advice/query_admin.jsp";
			}
		}
		function f_advice() {
			f_hide_all();
			f_ajf_show('menu_advice');
		}

		function f_ajf_show(ids) {
			var arr = ids.split(",");
			var i, num = 0;
			var obj = null;
			num = arr.length;
			for (i = 0; i < num; i++) {
				obj = document.getElementById(arr[i]);
				obj.style.display = '';
			}
		}

		function f_ajf_hide(ids) {
			var arr = ids.split(",");
			var i, num = 0;
			var obj = null;
			num = arr.length;
			for (i = 0; i < num; i++) {
				obj = document.getElementById(arr[i]);
				obj.style.display = 'none';
			}
		}

		function f_zh(id) {
			//f_ajf_hide("menu_sys");
			f_hide_all();
			f_ajf_show("menu_zh");
		}

		function f_sys() {
			f_hide_all();
			f_ajf_show("menu_sys");
			// f_ajf_hide("menu_zh");
		}
		function f_sh() {
			f_hide_all();
			f_ajf_show('menu_sh');
		}
		function f_jdkh() {
			f_hide_all();
			f_ajf_show('menu_jdkh');
		}
		function f_gis() {
			//f_ajf_show("menu_sys");
			f_hide_all();
			f_ajf_show("menu_gis");
		}

		function f_hide_all(id) {
			f_ajf_hide("menu_zh,menu_advice,menu_sh,menu_jdkh");

		}

		function f_menu_now(s, id, id1) {
			var obj = document.getElementById("menu_now");
			obj.innerHTML = s;

		}

		function f_menu_sssj(s, id, id1, url, target) {
			//var form = document.forms("form1");

			var obj = document.getElementById("menu_now");
			obj.innerHTML = s;

			form1.action = url;
			form1.target = target;

			form1.submit();
		}

		//** iframe自动适应页面 **//
		//输入你希望根据页面高度自动调整高度的iframe的名称的列表
		//用逗号把每个iframe的ID分隔. 例如: ["myframe1", "myframe2"]，可以只有一个窗体，则不用逗号。
		//定义iframe的ID
		var iframeids = [ "frm_home_main" ]
		//如果用户的浏览器不支持iframe是否将iframe隐藏 yes 表示隐藏，no表示不隐藏
		var iframehide = "yes"
		function dyniframesize() {
			var dyniframe = new Array()
			for (i = 0; i < iframeids.length; i++) {
				if (document.getElementById) {
					//自动调整iframe高度
					dyniframe[dyniframe.length] = document
							.getElementById(iframeids[i]);
					if (dyniframe[i] && !window.opera) {
						dyniframe[i].style.display = "block"
						if (dyniframe[i].contentDocument
								&& dyniframe[i].contentDocument.body.offsetHeight) //如果用户的浏览器是NetScape
							dyniframe[i].height = dyniframe[i].contentDocument.body.offsetHeight;
						else if (dyniframe[i].Document
								&& dyniframe[i].Document.body.scrollHeight) //如果用户的浏览器是IE
							dyniframe[i].height = dyniframe[i].Document.body.scrollHeight;
					}
				}
				//根据设定的参数来处理不支持iframe的浏览器的显示问题
				if ((document.all || document.getElementById)
						&& iframehide == "no") {
					var tempobj = document.all ? document.all[iframeids[i]]
							: document.getElementById(iframeids[i])
					tempobj.style.display = "block"
				}
			}
		}
		// if (window.addEventListener)
		//window.addEventListener("load", dyniframesize, false)
		//else if (window.attachEvent)
		//window.attachEvent("onload", dyniframesize)
		//else
		//window.dyniframesize 

		//alert("您显示器的分辨率为:\n" + screen.width + "×" + screen.height + "像素");

		if (screen.height >= 900 && screen.height <= 1024) {
			document.getElementById("frm_home_main").height = 550;
		} else if (screen.height >= 800 && screen.height < 900) {
			document.getElementById("frm_home_main").height = 450;
		} else if (screen.height >= 768 && screen.height < 800) {
			document.getElementById("frm_home_main").height = 390;
		} else if (screen.height >= 720 && screen.height < 768) {
			document.getElementById("frm_home_main").height = 354;
		}
	</script>
</body>
</html>

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
<title>����л����Զ����ϵͳ</title>
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
		// page_url ˵����com/hoson/PageData.java
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
				<li class="name">���ã�<%=user_name%>&emsp;</li>
				<!--
    	<li>|</li>
    	<li><a href="loadFile.jsp">����</a></li>
    -->
				<li>|</li>
				<%
					if (user_name.equals("admin")
							|| page_url.indexOf(pd.get("�޸�����")) != -1) {
				%>
				<li><a href="../home/pwd_edit.jsp" id='yjfk'
					target='frm_home_main' onclick="f_menu_now('�޸�����','','yjfk')"><span>�޸�����</span>
				</a>
				</li>
				<%
					}
				%>
				<li>|</li>
				<li><a href="javascript:f_logout()">�˳�</a>
				</li>
			</ul>
			<div class="nav">
				<ul class="nav-tabs">
					<li class="current"><a href="#"
						onclick="f_menu_sssj('��ҳ','','','<%=home_url%>','frm_home_main')"><span>��ҳ</span>
					</a>
					</li>
					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("������Ϣ")) != -1) {
					%>
					<li><a href="#"><span>������Ϣ</span>
					</a>
					</li>
					<%} %>
					<!-- <li><a href="#" onclick="f_menu_sssj('���ӵ�ͼ','','','<%=map_url%>','frm_home_main')"><span>���ӵ�ͼ</span></a></li> -->
					
					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("ʵʱ���")) != -1) {
					%>
					<li><a href='../real_data/index.jsp' id='sy1'
						target='frm_home_main' onmouseover='f_hide_all(0)'
						onclick="f_menu_sssj('ʵʱ���','0','','../real_data/index.jsp','frm_home_main')"><span>ʵʱ���</span>
					</a>
					</li>
					<%} %>
					<!-- 
					<li><a href='../sh_new/index.jsp' target='frm_home_main'
						onmouseover='f_hide_all(0)'
						onclick="f_menu_sssj('���ݲ�¼','-1','','../jdkh/index.jsp','frm_home_main')"><span>���ݲ�¼</span>
					</a>
					</li>
 					-->
					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("���ݲ�ѯ")) != -1) {
					%>
					<li><a href="#"><span>���ݲ�ѯ</span>
					</a>
					</li>
					<%
						}
					%>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("ͳ�Ʊ���")) != -1) {
					%>
					<li><a href="#"><span>ͳ�Ʊ���</span>
					</a>
					</li>
					<%
						}
					%>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("��Ƶ���p")) != -1) {
					%>
					<li><a href="#"><span>��Ƶ���</span>
					</a>
					</li>
					<%
						}
					%>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("�������")) != -1) {
					%>
					<li><a href="#"><span>�������</span>
					</a>
					</li>
					<%
						}
					%>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("ϵͳ����")) != -1) {
					%>
					<li><a href="#"><span>ϵͳ����</span>
					</a>
					</li>
					<%
						}
					%>
					<li><a href="#"><span>Ӧ��ָ��</span>
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
								|| page_url.indexOf(pd.get("������Ϣ")) != -1) {
					%>
					<ul class="nd" style="display:none;">
						<li
							style="margin-left: -11px;background: url('');width: 0px;border-style: none;"></li>

					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("���ӵ�ͼ")) != -1) {
					%>							
						<li><a href="../g_map/g_map.jsp" target='frm_home_main'
							onclick="f_menu_now('������Ϣ-->���ӵ�ͼ','','')"><span>���ӵ�ͼ</span>
						</a>
						</li>
					<%} %>
										<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("�����ͼ")) != -1) {
					%>								
						<li><a href="<%=map_url%>" target='frm_home_main'
							onclick="f_menu_now('������Ϣ-->�����ͼ','','')"><span>�����ͼ</span>
						</a>
						</li>
					<%} %>
					</ul>
					<%} %>
					
					<%
						if (user_name.equals("admin")
								|| page_url.indexOf(pd.get("ʵʱ���")) != -1) {
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
								|| page_url.indexOf(pd.get("���ݲ�ѯ")) != -1) {
					%>
					<ul class="nd" style="display:none;">
						<li
							style="margin-left: -11px;background: url('');width: 0px;border-style: none;"></li>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("�ۺϲ�ѯ")) != -1) {
						%>
						<li><a href="../fx/query/data.jsp?sh_flag=0" id="sssj"
							target='frm_home_main'
							onclick="f_menu_now('���ݲ�ѯ-->�ۺϲ�ѯ','1','sssj')"><span>�ۺϲ�ѯ</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("��������")) != -1) {
						%>
						<li><a href="../warn/index.jsp" target='frm_home_main'
							id="bjsj" onclick="f_menu_now('���ݲ�ѯ-->��������','1','bjsj')"><span>��������</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("���ݷ���")) != -1) {
						%>
						<li><a href="../fx/fx_home.jsp?action_flag=0" id="sjfx"
							target='frm_home_main'
							onclick="f_menu_now('���ݲ�ѯ-->���ݷ���','1','sjfx')"><span>���ݷ���</span>
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
								|| page_url.indexOf(pd.get("ͳ�Ʊ���")) != -1) {
					%>
					<ul class="nd" style="display:none;">
						<li
							style="margin-left: -11px;background: url('');width: 0px;border-style: none;"></li>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("��Ⱦ���ŷ���������")) != -1) {
						%>
						<li><a href='../report_sj/index.jsp' id='jcd'
							target='frm_home_main' onmouseover='f_hide_all(2)'
							onclick="f_menu_now('ͳ�Ʊ���-->��Ⱦ���ŷ���������','2','')"><span>��Ⱦ���ŷ���������</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("���ܱ���")) != -1) {
						%>
						<li><a href='../report_cm/index.jsp' id='jcd'
							target='frm_home_main' onmouseover='f_hide_all(2)'
							onclick="f_menu_now('ͳ�Ʊ���-->���ܱ���','2','')"><span>���ܱ���</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("վλ����ͳ�Ʊ���")) != -1) {
						%>
						<li><a href='../report/zwzxtjrpt.jsp?sh_flag=0' id='jcd'
							target='frm_home_main' onmouseover='f_hide_all(2)'
							onclick="f_menu_now('ͳ�Ʊ���-->վλ����ͳ�Ʊ���','2','')"><span>վλ����ͳ�Ʊ���</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("�ۺϱ���")) != -1) {
						%>
						<li><a href='../report/zhrpt.jsp?sh_flag=0' id='jcd'
							target='frm_home_main' onmouseover='f_hide_all(2)'
							onclick="f_menu_now('ͳ�Ʊ���-->�ۺϱ���','2','')"><span>�ۺϱ���</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("�Զ��屨��")) != -1) {
						%>
						<li><a href='../report_diy/index.jsp' id='jcd'
							target='frm_home_main' onmouseover='f_hide_all(2)'
							onclick="f_menu_now('ͳ�Ʊ���-->�Զ��屨��','2','')"><span>�Զ��屨��</span>
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
								|| page_url.indexOf(pd.get("��Ƶ���p")) != -1) {
					%>
					<ul class="nd" style="display:none;">
						<li
							style="margin-left: -11px;background: url('');width: 0px;border-style: none;"></li>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("��Ƶ���c")) != -1) {
						%>
						<li><a href="../sp/list.jsp" id='yjcx' target='_blank'><span>��Ƶ���</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("��Ƶ����")) != -1) {
						%>
						<li><a href="../system/sp/form.jsp" id='yjcx'
							target='frm_home_main'
							onclick="f_menu_now('��Ƶ���-->��Ƶ����','3','yjcx')"><span>��Ƶ����</span>
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
								|| page_url.indexOf(pd.get("�������")) != -1) {
					%>
					<ul class="nd" style="display:none;">
						<li
							style="margin-left: -11px;background: url('');width: 0px;border-style: none;"></li>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("�������")) != -1) {
						%>
						<li><a href="../advice/advice.jsp" id='yjfk'
							target='frm_home_main'
							onclick="f_menu_now('�������-->�������','4','yjfk')"><span>�������</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("�����ѯ")) != -1) {
						%>
						<li><a href="../advice/query.jsp" id='yjcx'
							target='frm_home_main'
							onclick="f_menu_now('�������-->�����ѯ','4','yjcx')"><span>�����ѯ</span>
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
								|| page_url.indexOf(pd.get("ϵͳ����")) != -1) {
					%>
					<ul class="nd" style="display:none;">
						<li
							style="margin-left: -11px;background: url('');width: 0px;border-style: none;"></li>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("վλ����")) != -1) {
						%>
						<!-- <li><a href="../system/station/q_form.jsp" id='yjcx' target='frm_home_main' onclick="f_menu_now('ϵͳ����->վλ����','5','yjcx')" ><span>վλ����</span></a></li> -->
						<li><a href="../system/station/station_info.jsp" id='yjcx'
							target='frm_home_main'
							onclick="f_menu_now('ϵͳ����-->վλ����','5','yjcx')"><span>վλ����</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("��ҵ����")) != -1) {
						%>
						<li><a href="../system/trade/trade_query.jsp" id='yjcx'
							target='frm_home_main'
							onclick="f_menu_now('ϵͳ����-->��ҵ����','5','yjcx')"><span>��ҵ����</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("���Ź���")) != -1) {
						%>
						<li><a href="../system/tab_dept/tab_dept_query.jsp" id='yjfk'
							target='frm_home_main'
							onclick="f_menu_now('ϵͳ����-->���Ź���','5','yjfk')"><span>���Ź���</span>
						</a>
						</li>
						<%
							}
						%>

						<%
							if (user_name.equals("admin")
										|| page_url.indexOf(pd.get("�û�����")) != -1) {
						%>
						<li><a href="../system/user/user_query.jsp" id='yjcx'
							target='frm_home_main'
							onclick="f_menu_now('ϵͳ����-->�û�����','5','yjcx')"><span>�û�����</span>
						</a>
						</li>
						<%
							}
						%>

						<!--
        <li><a href="../system/msg/index.jsp" id='yjcx' target='frm_home_main' onclick="f_menu_now('ϵͳ����--����ƽ̨','5','yjcx')" ><span>����ƽ̨</span></a></li>
        <li><a href="../system/jsgs/index.jsp" id='yjcx' target='frm_home_main' onclick="f_menu_now('ϵͳ����--���ݼ��㹫ʽ','5','yjcx')" ><span>���ݼ��㹫ʽ</span></a></li>
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
				<span>��ǰλ�ã�</span><a href="#"><font id='menu_now'>��ҳ</font>
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
			if (confirm("��ȷ��Ҫ�˳�ϵͳ��")) {
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

		//** iframe�Զ���Ӧҳ�� **//
		//������ϣ������ҳ��߶��Զ������߶ȵ�iframe�����Ƶ��б�
		//�ö��Ű�ÿ��iframe��ID�ָ�. ����: ["myframe1", "myframe2"]������ֻ��һ�����壬���ö��š�
		//����iframe��ID
		var iframeids = [ "frm_home_main" ]
		//����û����������֧��iframe�Ƿ�iframe���� yes ��ʾ���أ�no��ʾ������
		var iframehide = "yes"
		function dyniframesize() {
			var dyniframe = new Array()
			for (i = 0; i < iframeids.length; i++) {
				if (document.getElementById) {
					//�Զ�����iframe�߶�
					dyniframe[dyniframe.length] = document
							.getElementById(iframeids[i]);
					if (dyniframe[i] && !window.opera) {
						dyniframe[i].style.display = "block"
						if (dyniframe[i].contentDocument
								&& dyniframe[i].contentDocument.body.offsetHeight) //����û����������NetScape
							dyniframe[i].height = dyniframe[i].contentDocument.body.offsetHeight;
						else if (dyniframe[i].Document
								&& dyniframe[i].Document.body.scrollHeight) //����û����������IE
							dyniframe[i].height = dyniframe[i].Document.body.scrollHeight;
					}
				}
				//�����趨�Ĳ���������֧��iframe�����������ʾ����
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

		//alert("����ʾ���ķֱ���Ϊ:\n" + screen.width + "��" + screen.height + "����");

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

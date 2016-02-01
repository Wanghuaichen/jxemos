<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.f,java.util.*"%>
<%
 String user_name = (String)session.getAttribute("user_name");
	 if(f.empty(user_name)){
   response.sendRedirect("./login/nologin.jsp");
   return;
  }
  
  String url = "../station_new/";
  
  String gis_url;
	String gis_Addr=request.getRemoteAddr();
	String[]gis_Array=gis_Addr.split("\\.");
	if(gis_Array[0].equals("192") && gis_Array[1].equals("168"))
	  gis_url="http://192.168.7.11/JXGIS/Default.aspx";
	else
	  gis_url="http://115.149.128.19/JXGIS/Default.aspx"; 
  String sp_url = "../site/sp/sp_list.jsp";
  sp_url = "../sp/list.jsp";
  
  url = "../map/index_new.jsp";
  url = "home_tj.jsp";
  url = "../real_data/index_zj.jsp";
  url = "../real_data/index.jsp";
  System.out.println("role=="+session.getAttribute("yw_role"));
  int padding_left = 5;
  String report_url="../report/index_new.jsp";
  report_url="../report_sj/index.jsp";
  String yw_url = "../../../swj_yw/index_goto.jsp?user_id="+session.getAttribute("user_id")+"&user_name="+session.getAttribute("user_name")+"&yw_role="+session.getAttribute("yw_role")+"&area_id="+session.getAttribute("area_id");
  Map r = new HashMap();
%>
<HEAD><TITLE>江西省环境在线自动监测监控系统</TITLE></HEAD>
<style>
*{ padding:0px; margin:0px; font-size:12px; line-height:18px;}
a{ text-decoration:none;}
a:hover{ text-decoration:underline;}


.white12_nav{ color:#FFFFFF;}
a.white12_nav:hover{ color:#fffc00;}

.white12_nav_b{color:#FFFFFF; font-weight:bold;}

.yellow12_nav{ color:#fffc00;}

.yellow12_nav_b{ color:#fffc00; font-weight:bold;}


.nav_bg01{background:url(./img/index_nav_bg01.jpg) no-repeat bottom }
.nav_bg02{background:url(./img/index_nav_bg02.jpg) no-repeat bottom }

.blue12_nav{ color:#5f95d1; text-decoration:none;}
a.blue12_nav:hover{ color:#5f95d1; text-decoration:underline}

.blue12_nav_b{
	font-size: 12px;
	font-weight: bold;
	color: #3d72a6;
	line-height:18px;
	text-decoration:none;
	
}
a:blue12_nav_b:hover{ text-decoration:underline;}
</style>
<body scroll=no>
<table style='width:100%;height:100%' border=0 cellspacing=0>
  
  <tr>
    <td height="48" valign="bottom" background="./img/index_top_bg.jpg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="500" align="left"><img src="./img/index_logo.jpg" width="450" height="48" /></td>
        <td valign="bottom" style="padding-right:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="right"><table width="60%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="right"><span class="blue12_nav_b"><%=user_name%></span> 用户 </td>
                <td width="110" align="right"><a href="loadFile.jsp" class="blue12_nav">用户手册</a> <a href="javascript:f_logout()" class="blue12_nav">退出</a></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td ><table id="topTable" width="540" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td width="90" height="28" align="center" valign="bottom" class="nav_bg02"  >
                <a href='../real_data/index.jsp' class="blue12_nav_b" id='sy1' target='frm_home_main' onmouseover='f_hide_all(0)' onclick="f_menu_now('首页','0','')">首页</a>
                </td>
                <td width="90" align="center" valign="bottom" class="nav_bg01" >
                <a href='javascript:f_do_nothing()' onmouseover='f_zh(1)' class="blue12_nav_b"  >综合</a>
                </td>
                <td width="90" align="center" valign="bottom" class="nav_bg02"  >
                <a href='../station_new/' target='frm_home_main' id='jcd' onmouseover='f_hide_all(2)'  onclick="f_menu_now('监测点','2','')" class="blue12_nav_b" >监测点</a>
                </td>
                <td width="90" align="center" valign="bottom" class="nav_bg02" >
                <a href="<%=gis_url%>" class="blue12_nav_b" id='gis' target='frm_home_main' onmouseover='f_hide_all(3)'  onclick="f_menu_now('GIS','3','')">GIS</a></td>
                <td width="90" align="center" valign="bottom" class="nav_bg02" >
                <a  class="blue12_nav_b" href="javascript:f_do_nothing()" id='zyjfk' onmouseover='f_advice(4)' >意见反馈</a>
                </td>
                <td width="90" align="center" valign="bottom" class="nav_bg02" >
                <a  class="blue12_nav_b" href="javascript:f_do_nothing()" id='sh' onmouseover='f_sh(5)' >审核</a>
                </td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table>
    
    </td>
  </tr>
  <tr>
    <td height="32" background="./img/index_nav_bg.jpg"><table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="200" style="padding-left:5px;">
        <span class="yellow12_nav">当前位置：</span><font id='menu_now' class="white12_nav">首页</font>
        </td>
        
        <td align="right" class="white12_nav" style="padding-right:15px;">
        <div id='menu_zh' style='display:yes;'>
        <a href='../real_data/index.jsp' id="sssj" class='yellow12_nav' target='frm_home_main'  onclick="f_menu_now('综合-->实时数据','1','sssj')">实时数据</a>│   
        <a href='../warn/' class='white12_nav' id="bjsj" target='frm_home_main'  onclick="f_menu_now('综合-->报警数据','1','bjsj')">报警数据</a>│
        <a href='../fx/fx_home.jsp?action_flag=0' id="sjfx" class='white12_nav' target='frm_home_main' onclick="f_menu_now('综合-->数据分析','1','sjfx')">数据分析</a>│
        <a href='..//fx/query/data.jsp?sh_flag=0' id="sjcx" class='white12_nav' target='frm_home_main' onclick="f_menu_now('综合-->数据查询','1','sjcx')">数据查询</a>│
        <a href='<%=report_url%>?sh_flag=0' id='zlbb' class='white12_nav' target='frm_home_main' onclick="f_menu_now('综合-->总量报表','1','zlbb')">总量报表</a>│
        <a href='../report/index_new.jsp?sh_flag=0' id='qtbb' class='white12_nav' target='frm_home_main' onclick="f_menu_now('综合-->其它报表','1','qtbb')">其它报表</a>│
        <a href='<%=sp_url%>' class='white12_nav' target='new' id='sp' onclick="f_menu_now('综合-->视频','1','sp')">视频</a>│
</div>

<div id='menu_advice' style='display:none;'>
           <a href='../advice/advice.jsp' id='yjfk' class="white12_nav" target='frm_home_main' onclick="f_menu_now('意见反馈-->意见反馈','4','yjfk')">意见反馈</a>│  
           <a href='#' class="white12_nav" id='yjcx' onclick="f_right('<%=session.getAttribute("user_name") %>');f_menu_now('意见反馈-->意见查询','4','yjcx')">意见查询</a>
          </div>
          <div id='menu_sh' style='display:none;'>
           <a href='../sh_new/search/w.jsp' id='ycsjcx' class="white12_nav" target='frm_home_main' onclick="f_menu_now('审核-->异常数据查询','5','ycsjcx')">异常数据查询</a>│  
           <a href='../sh_new/index.jsp' target='frm_home_main' class="white12_nav" id='sjsh' onclick="f_menu_now('审核-->数据审核','5','sjsh')">数据审核</a>│ 
         <a href='../system/station/q_form.jsp' class='white12_nav' target='frm_home_main' id='zwgl' onclick="f_menu_now('审核-->站位管理','5','zwgl')">站位管理</a>
          </div>
</td>


      </tr>
    </table></td>
  </tr>
   <tr>
    <td height='100%'>
    <iframe name='frm_home_main' id="frm_home_main"  src='<%=url%>' width=100% height=100% frameborder=0></iframe>
    </td>
  </tr>
</table>
<script>
function f_logout(){
if(confirm("您确认要退出系统吗")){
		window.opener=null;window.close();
		document.location.reload();
	 }else{}
}

function f_do_nothing(){
  
}

function f_right(user)
{
	if(user!="admin")
	{
		var div2 = document.getElementById("frm_home_main");
		div2.src="../advice/query_advice.jsp";
	}
	else
	{
		var div2 = document.getElementById("frm_home_main");
		div2.src="../advice/query_admin.jsp";
	}
}
function f_advice()
{
	f_hide_all();
	f_ajf_show('menu_advice');
}
function f_sh()
{
	f_hide_all();
	f_ajf_show('menu_sh');
}
 function f_ajf_show(ids){
   var arr=ids.split(",");
   var i,num=0;
var obj = null;
   num=arr.length;
   for(i=0;i<num;i++){
     obj = document.getElementById(arr[i]);
     obj.style.display='';  
}
}

 function f_ajf_hide(ids){
   var arr=ids.split(",");
   var i,num=0;
var obj = null;
   num=arr.length;
   for(i=0;i<num;i++){
     obj = document.getElementById(arr[i]);
     obj.style.display='none';  
}
}

function f_zh(id){
//f_ajf_hide("menu_sys");
f_hide_all();
    f_ajf_show("menu_zh");
}
function f_sys(){
f_hide_all();
f_ajf_show("menu_sys");

   // f_ajf_hide("menu_zh");
}

function f_gis(){
//f_ajf_show("menu_sys");
f_hide_all();
    f_ajf_show("menu_gis");
}

function f_hide_all(id){
f_ajf_hide("menu_zh,menu_advice,menu_sh");
 
}

function f_menu_now(s,id,id1){
  var obj = document.getElementById("menu_now");
  obj.innerHTML=s;
  //修改按钮为选中
   var table = document.getElementById("topTable");   
  for(i=0;i<table.rows[0].cells.length;i++){   
    if(id==i){
  		table.rows[0].cells[i].className="nav_bg01";
  	}else{
  		table.rows[0].cells[i].className="nav_bg02";
  	}
  }
  //修改所有连接为白色
   var links = document.getElementsByTagName("a");
  for(var i=0;i<links.length;i++){
    if(links[i].className=='white12_nav'||links[i].className=='yellow12_nav'){
    	links[i].className="white12_nav";
    }
  }
  //修改选中为黄色
  var menu = document.getElementById(id1);
  if(menu.className=='white12_nav'){
  	 menu.className="yellow12_nav";
  }else{
  	 menu.className="white12_nav";
  }
}

</script>
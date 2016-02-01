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
*{padding:0;margin:0;font-size:13px}
a{text-decoration:none; color:blue;font-weight:bold}
.m2{color:white;}
.m3{color:#fffc00;}
.m4{color:blue;}
.m5{color:#fffc00;}
</style>
<body scroll=no>
<table style='width:100%;height:100%' border=0 cellspacing=0>
  <tr>
    <td height=50px valign=top>
    
    
    
    <table border=0 width='100%' cellspacing=0 height='100%' style='background:url(./img/index_top_bg.jpg) repeat-x center'>
    <tr style='background:url(./img/index_logo.jpg) no-repeat left'>

      
      <td align='right' valign='bottom' style=''>
      <!--valign=top-->
     
     
    
      
      <form id="form1">
      <div style='padding-bottom:3px;padding-right:<%=padding_left%>px'>
      
     
      	<font color=black> 当前用户 <b><%=user_name%></b> </font>
      	 
       
       &nbsp;&nbsp;
      
            <a href='../real_data/index.jsp' id='sy' target='frm_home_main' onmouseover='f_hide_all()' onclick="f_menu_now('首页','sy')">首页</a>
            <a href='javascript:f_do_nothing()' onmouseover='f_zh()'>综合</a>
            <a href='../station_new/' target='frm_home_main' id='jcd' onmouseover='f_hide_all()'  onclick="f_menu_now('监测点','jcd')">监测点</a>
            <%-- 
            <a href='../ps_info/' target='frm_home_main' onmouseover='f_hide_all()'  onclick="f_menu_now('污染源信息')">污染源信息</a>
             --%>
            <a href='<%=gis_url%>' id='gis' target='frm_home_main' onmouseover='f_hide_all()'  onclick="f_menu_now('GIS','gis')" >GIS</a>
            <%-- 
               <a href='<%=yw_url%>' target='frm_home_main' onmouseover='f_hide_all()'  onclick="f_menu_now('运维管理')">运维管理</a>
            <a href='javascript:f_do_nothing()' onmouseover='f_sys()'>系统设置</a>--%>
            
            <a href="javascript:f_do_nothing()" id='zyjfk' onmouseover='f_advice()'  onclick="f_menu_now('意见反馈','zyjfk')">意见反馈</a>
            <a href="loadFile.jsp" id='yhsc' onmouseover='f_hide_all()' onclick="f_menu_now('用户手册','yhsc')" >用户手册</a>
            <a href='javascript:f_logout()' onmouseover='f_hide_all()'>退出</a>
            </div>
          </form>
      </td>
    </tr>
    
    </table>
    
    
    
    
    
    </td>
  </tr>
  
  <form id="form2">
  <tr style='background:url(./img/index_nav_bg.jpg)'>
     <td height=30 align=right style='padding-left:2px;padding-top:3px;padding-right:<%=padding_left%>px'>
       
         <div  style='float:left;width:290px;text-align:left;font-weight:bold;color:white'>
       <font style="color:#fffc00">当前位置:</font><font id='menu_now'>首页</font>
      </div>
    
        
          <div id='menu_zh' style='display:yes'>
            <a href='../real_data/index.jsp' id="sssj" class='m2' target='frm_home_main'  onclick="f_menu_now('综合-->实时数据','sssj')">实时数据</a>
           <%-- <a href='../map/all_area_info.jsp' id="hzxx" class='m2' target='frm_home_main'  onclick="f_menu_now('综合-->汇总信息','hzxx')" >汇总信息</a>--%>
            <a href='../warn/' class='m2' id="bjsj" target='frm_home_main'  onclick="f_menu_now('综合-->报警数据','bjsj')">报警数据</a>
            <a href='../fx/fx_home.jsp?action_flag=0' id="sjfx" class='m2' target='frm_home_main' onclick="f_menu_now('综合-->数据分析','sjfx')">数据分析</a>
            <a href='..//fx/query/data.jsp?sh_flag=0' id="sjcx" class='m2' target='frm_home_main' onclick="f_menu_now('综合-->数据查询','sjcx')">数据查询</a>
            <%--<a href='..//fx/query/data.jsp?sh_flag=1' id="shsjcx" class='m2' target='frm_home_main' onclick="f_menu_now('综合-->审核数据查询','shsjcx')">审核数据查询</a>--%>
            <a href='../sh/index.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r11")%>" onclick="f_menu_now('数据审核')">数据审核</a>
         <!-- <a href='../report_new/index.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('综合综合报表')">综合报表</a>-->
           <a href='<%=report_url%>?sh_flag=0' id='zlbb' class='m2' target='frm_home_main' onclick="f_menu_now('综合-->总量报表','zlbb')">总量报表</a>
           <%--<a href='<%=report_url%>?sh_flag=1' id='shzlbb' class='m2' target='frm_home_main' onclick="f_menu_now('综合-->审核总量报表','shzlbb')">审核总量报表</a>--%>
            <a href='../report/index_new.jsp?sh_flag=0' id='qtbb' class='m2' target='frm_home_main' onclick="f_menu_now('综合-->其它报表','qtbb')">其它报表</a>
            <%--<a href='../report/index_new.jsp?sh_flag=1' id='shqtbb' class='m2' target='frm_home_main' onclick="f_menu_now('综合-->审核其它报表','shqtbb')">审核其它报表</a>--%>
            <a href='<%=sp_url%>' class='m2' target='new' id='sp' onclick="f_menu_now('综合-->视频','sp')">视频</a>
            <%-- <a href='../commons/yz_lch.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('综合-->因子量程')">因子量程</a> --%>
          </div>
          
          <div id='menu_sys' style='display:none;padding-right:<%=padding_left%>px'>
           <a href='../system/tab_dept/tab_dept_query.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r1")%>" onclick="f_menu_now('部门管理')">部门管理</a>
           <a href='../system/area/area_query.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('地区管理')">地区管理</a>
           <a href='../system/user/user_query.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r2")%>" onclick="f_menu_now('用户管理')">用户管理</a>
           <a href='../system/valley/valley_query.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('流域管理')">流域管理</a>
           <a href='../system/param/param_query.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('系统参数')">系统参数</a>
           <a href='../system/station/q_form.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r3")%>" onclick="f_menu_now('站位管理')">站位管理</a>
           <a href='../system/trade/trade_query.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r4")%>" onclick="f_menu_now('行业管理')">行业管理</a>
           <a href='../system/sp/form.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r5")%>" onclick="f_menu_now('视频设置')">视频设置</a>
           <a href='../system/msg/index.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r6")%>" onclick="f_menu_now('短信平台')">短信平台</a>
           <a href='../system/jsgs/index.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('数据计算公式')">数据计算公式</a>
            <a href='../home/pwd_edit.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('修改密码')">修改密码</a>
          </div>
          
           <div id='menu_gis' style='display:none;padding-right:<%=padding_left%>px'>
           <a href='<%=gis_url+1%>' class='m2' target='frm_home_main' onclick="f_menu_now('gis|西区')">西区</a>
           <a href='<%=gis_url+2%>' class='m2' target='frm_home_main' onclick="f_menu_now('gis|东区')">东区</a>
           <a href='<%=gis_url+3%>' class='m2' target='frm_home_main' onclick="f_menu_now('gis|微电子区')">微电子区</a>
           <a href='<%=gis_url+4%>' class='m2' target='frm_home_main' onclick="f_menu_now('gis|化工区')">化工区</a>
           <a href='<%=gis_url+5%>' class='m2' target='frm_home_main' onclick="f_menu_now('gis|逸仙园')">逸仙园</a>
           
          </div>
          
          <div id='menu_advice' style='display:none;padding-right:<%=padding_left%>px'>
           <a href='../advice/advice.jsp' id='yjfk' class='m2' target='frm_home_main' onclick="f_menu_now('意见反馈-->意见反馈','yjfk')">意见反馈</a>
           <a href='#' class='m2' id='yjcx' onclick="f_right('<%=session.getAttribute("user_name") %>');f_menu_now('意见反馈-->意见查询','yjcx')">意见查询</a>
          </div>
          
     </td>
  </tr>
  </form>
  <tr style='background:url(./img/index_nav_bgbottom.jpg)'>
  <td height=5px></td>
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

function f_zh(){
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

function f_hide_all(){
f_ajf_hide("menu_sys,menu_zh,menu_gis,menu_advice");
  //  f_ajf_hide("menu_zh");
}

function f_menu_now(s,id){
  var obj = document.getElementById("menu_now");
  obj.innerHTML=s;
   var links = document.getElementsByTagName("a");
  for(var i=0;i<links.length;i++){
    if(links[i].className=='m2'||links[i].className=='m3'){
    	links[i].className="m2";
    }else{
    	links[i].className="m4";
    }
  }
  var menu = document.getElementById(id);
  if(menu.className=='m2'){
  	 menu.className="m3";
  }else{
  	 menu.className="m5";
  }
}

</script>
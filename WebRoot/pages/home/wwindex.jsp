<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.f,java.util.*"%>
<%
 String user_name = (String)session.getAttribute("user_name");
	 if(f.empty(user_name)){
   response.sendRedirect("./login/nologin.jsp");
   return;
  }
  
  String url = "../system/wwuser/user_query.jsp";
  if(!user_name.equals("admin")){
  		url = "../station_new/wwindex.jsp";
  }
  int padding_left = 5;
%>
<style>
*{padding:0;margin:0;font-size:13px}
a{text-decoration:none; color:blue;font-weight:bold}
.m2{color:white;}
.blue12{ text-decoration:underline; color:#0066FF;}
a.blue12:hover{ text-decoration:none;}
.yellow12{color:#fd6900;}
</style>
<body scroll=no>
<table style='width:100%;height:100%' border=0 cellspacing=0>
  <tr>
    <td height=50px valign=top>
    
    <table border=0 width='100%' cellspacing=0 height='100%' style='background:url(./img/index_top_bg.jpg) repeat-x center'>
    <tr style='background:url(./img/ww_index_logo.jpg) no-repeat left'>

      <td align='right' valign='bottom' style=''>
      
      <div style='padding-bottom:3px;padding-right:<%=padding_left%>px'>
      <FONT 
            color=black> <span class="yellow12"><%=user_name%></span>   欢迎您！</FONT>
      	<%
      	if(user_name.equals("admin")){
      	 %>
      	<a href='../system/wwuser/user_query.jsp' target='frm_home_main' class="blue12" onclick="f_menu_now('用户管理')">用户管理</a>
      	<%} %>
      	 <a href='../home/ww_pwd_edit.jsp' target='frm_home_main' class="blue12" onclick="f_menu_now('修改密码')">修改密码</a>
            <a href='javascript:f_logout()' class="blue12" onmouseover='f_hide_all()'>退出</a>
            </div>
      </td>
    </tr>
    
    </table>
    </td>
  </tr>
  
  <tr style='background:url(./img/index_nav_bg.jpg)'>
     <td height=30 align=right style='padding-left:2px;padding-top:3px;padding-right:<%=padding_left%>px'>
       
         <div  style='float:left;width:290px;text-align:left;font-weight:bold;color:white'>
       <font style="color:#fffc00">当前位置:</font><font id='menu_now'>首页</font>
      </div>
     </td>
  </tr>
  
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
		window.location = "../home/wwlogout.jsp";
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

function f_menu_now(s){
  var obj = document.getElementById("menu_now");
  obj.innerHTML=s;
}

</script>
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
<HEAD><TITLE>����ʡ���������Զ������ϵͳ</TITLE></HEAD>
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
      
     
      	<font color=black> ��ǰ�û� <b><%=user_name%></b> </font>
      	 
       
       &nbsp;&nbsp;
      
            <a href='../real_data/index.jsp' id='sy' target='frm_home_main' onmouseover='f_hide_all()' onclick="f_menu_now('��ҳ','sy')">��ҳ</a>
            <a href='javascript:f_do_nothing()' onmouseover='f_zh()'>�ۺ�</a>
            <a href='../station_new/' target='frm_home_main' id='jcd' onmouseover='f_hide_all()'  onclick="f_menu_now('����','jcd')">����</a>
            <%-- 
            <a href='../ps_info/' target='frm_home_main' onmouseover='f_hide_all()'  onclick="f_menu_now('��ȾԴ��Ϣ')">��ȾԴ��Ϣ</a>
             --%>
            <a href='<%=gis_url%>' id='gis' target='frm_home_main' onmouseover='f_hide_all()'  onclick="f_menu_now('GIS','gis')" >GIS</a>
            <%-- 
               <a href='<%=yw_url%>' target='frm_home_main' onmouseover='f_hide_all()'  onclick="f_menu_now('��ά����')">��ά����</a>
            <a href='javascript:f_do_nothing()' onmouseover='f_sys()'>ϵͳ����</a>--%>
            
            <a href="javascript:f_do_nothing()" id='zyjfk' onmouseover='f_advice()'  onclick="f_menu_now('�������','zyjfk')">�������</a>
            <a href="loadFile.jsp" id='yhsc' onmouseover='f_hide_all()' onclick="f_menu_now('�û��ֲ�','yhsc')" >�û��ֲ�</a>
            <a href='javascript:f_logout()' onmouseover='f_hide_all()'>�˳�</a>
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
       <font style="color:#fffc00">��ǰλ��:</font><font id='menu_now'>��ҳ</font>
      </div>
    
        
          <div id='menu_zh' style='display:yes'>
            <a href='../real_data/index.jsp' id="sssj" class='m2' target='frm_home_main'  onclick="f_menu_now('�ۺ�-->ʵʱ����','sssj')">ʵʱ����</a>
           <%-- <a href='../map/all_area_info.jsp' id="hzxx" class='m2' target='frm_home_main'  onclick="f_menu_now('�ۺ�-->������Ϣ','hzxx')" >������Ϣ</a>--%>
            <a href='../warn/' class='m2' id="bjsj" target='frm_home_main'  onclick="f_menu_now('�ۺ�-->��������','bjsj')">��������</a>
            <a href='../fx/fx_home.jsp?action_flag=0' id="sjfx" class='m2' target='frm_home_main' onclick="f_menu_now('�ۺ�-->���ݷ���','sjfx')">���ݷ���</a>
            <a href='..//fx/query/data.jsp?sh_flag=0' id="sjcx" class='m2' target='frm_home_main' onclick="f_menu_now('�ۺ�-->���ݲ�ѯ','sjcx')">���ݲ�ѯ</a>
            <%--<a href='..//fx/query/data.jsp?sh_flag=1' id="shsjcx" class='m2' target='frm_home_main' onclick="f_menu_now('�ۺ�-->������ݲ�ѯ','shsjcx')">������ݲ�ѯ</a>--%>
            <a href='../sh/index.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r11")%>" onclick="f_menu_now('�������')">�������</a>
         <!-- <a href='../report_new/index.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('�ۺ��ۺϱ���')">�ۺϱ���</a>-->
           <a href='<%=report_url%>?sh_flag=0' id='zlbb' class='m2' target='frm_home_main' onclick="f_menu_now('�ۺ�-->��������','zlbb')">��������</a>
           <%--<a href='<%=report_url%>?sh_flag=1' id='shzlbb' class='m2' target='frm_home_main' onclick="f_menu_now('�ۺ�-->�����������','shzlbb')">�����������</a>--%>
            <a href='../report/index_new.jsp?sh_flag=0' id='qtbb' class='m2' target='frm_home_main' onclick="f_menu_now('�ۺ�-->��������','qtbb')">��������</a>
            <%--<a href='../report/index_new.jsp?sh_flag=1' id='shqtbb' class='m2' target='frm_home_main' onclick="f_menu_now('�ۺ�-->�����������','shqtbb')">�����������</a>--%>
            <a href='<%=sp_url%>' class='m2' target='new' id='sp' onclick="f_menu_now('�ۺ�-->��Ƶ','sp')">��Ƶ</a>
            <%-- <a href='../commons/yz_lch.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('�ۺ�-->��������')">��������</a> --%>
          </div>
          
          <div id='menu_sys' style='display:none;padding-right:<%=padding_left%>px'>
           <a href='../system/tab_dept/tab_dept_query.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r1")%>" onclick="f_menu_now('���Ź���')">���Ź���</a>
           <a href='../system/area/area_query.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('��������')">��������</a>
           <a href='../system/user/user_query.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r2")%>" onclick="f_menu_now('�û�����')">�û�����</a>
           <a href='../system/valley/valley_query.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('�������')">�������</a>
           <a href='../system/param/param_query.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('ϵͳ����')">ϵͳ����</a>
           <a href='../system/station/q_form.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r3")%>" onclick="f_menu_now('վλ����')">վλ����</a>
           <a href='../system/trade/trade_query.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r4")%>" onclick="f_menu_now('��ҵ����')">��ҵ����</a>
           <a href='../system/sp/form.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r5")%>" onclick="f_menu_now('��Ƶ����')">��Ƶ����</a>
           <a href='../system/msg/index.jsp' class='m2' target='frm_home_main' style="display:<%=r.get("r6")%>" onclick="f_menu_now('����ƽ̨')">����ƽ̨</a>
           <a href='../system/jsgs/index.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('���ݼ��㹫ʽ')">���ݼ��㹫ʽ</a>
            <a href='../home/pwd_edit.jsp' class='m2' target='frm_home_main' onclick="f_menu_now('�޸�����')">�޸�����</a>
          </div>
          
           <div id='menu_gis' style='display:none;padding-right:<%=padding_left%>px'>
           <a href='<%=gis_url+1%>' class='m2' target='frm_home_main' onclick="f_menu_now('gis|����')">����</a>
           <a href='<%=gis_url+2%>' class='m2' target='frm_home_main' onclick="f_menu_now('gis|����')">����</a>
           <a href='<%=gis_url+3%>' class='m2' target='frm_home_main' onclick="f_menu_now('gis|΢������')">΢������</a>
           <a href='<%=gis_url+4%>' class='m2' target='frm_home_main' onclick="f_menu_now('gis|������')">������</a>
           <a href='<%=gis_url+5%>' class='m2' target='frm_home_main' onclick="f_menu_now('gis|����԰')">����԰</a>
           
          </div>
          
          <div id='menu_advice' style='display:none;padding-right:<%=padding_left%>px'>
           <a href='../advice/advice.jsp' id='yjfk' class='m2' target='frm_home_main' onclick="f_menu_now('�������-->�������','yjfk')">�������</a>
           <a href='#' class='m2' id='yjcx' onclick="f_right('<%=session.getAttribute("user_name") %>');f_menu_now('�������-->�����ѯ','yjcx')">�����ѯ</a>
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
if(confirm("��ȷ��Ҫ�˳�ϵͳ��")){
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
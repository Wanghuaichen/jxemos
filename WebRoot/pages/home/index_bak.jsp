<%@ page contentType="text/html;charset=gbk" %>
<%@page import="com.hoson.f,java.util.*,com.hoson.zdxupdate.*,com.hoson.XBean"%>
<%
 String user_name = (String)session.getAttribute("user_name");
	 if(f.empty(user_name)){
   response.sendRedirect("./login/nologin.jsp");
   return;
  }
  String session_id = (String)session.getAttribute("session_id");
  Map map = zdxUpdate.getRight(user_name,session_id);
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
   String map_url = "../flashmap/jiangxi.jsp";
  String sp_url = "../site/sp/sp_list.jsp";
  sp_url = "../sp/list.jsp";

  //url = "../map/index_new.jsp";
  //url = "home_tj.jsp";
  //url = "../real_data/index_zj.jsp";
  url = "../real_data/index.jsp";
  //System.out.println("role=="+session.getAttribute("yw_role"));
  int padding_left = 5;
  String report_url="../report/index_new.jsp";
  report_url="../report_sj/index.jsp";
  String yw_url = "../../../swj_yw/index_goto.jsp?user_id="+session.getAttribute("user_id")+"&user_name="+session.getAttribute("user_name")+"&yw_role="+session.getAttribute("yw_role")+"&area_id="+session.getAttribute("area_id");
  Map r = new HashMap();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<TITLE>����ʡ���������Զ������ϵͳ</TITLE>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/select1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../scripts/jSelect/jselect.js"></script>
<script type="text/javascript" src="../../scripts/common.js"></script>

</HEAD>

<body style="overflow-x:hidden">
<!--top-->
<form name="form1" >
<div class="Top">
	<div class="clear"></div>
	<div class="userinfo">���ã� <u><%=user_name%></u>�� [<a href="javascript:f_logout()">�˳�</a>] | <a href="loadFile.jsp"><font color="#FF0000">�û��ֲ�</font></a></div>
    <div class="Bread">
      <span class="yellow12_nav">��ǰλ�ã�</span><font id='menu_now' class="white12_nav">��ҳ</font>
    </div>


 <div class="TopMenu">
    <ul>
		<%--<li style="display:<%=b.get("10132") %>"><a href="#tabs-1" href='../real_data/index.jsp' id='sy1' target='frm_home_main' onmouseover='f_hide_all(0)' onclick="f_menu_sssj('ʵʱ����','0','','../real_data/index.jsp','frm_home_main')">ʵʱ����</a></li>
		<li style="display:<%=b.get("10148") %>"><a href="#tabs-2">���ݲ�ѯ</a></li>
		<li style="display:<%=b.get("10136") %>"><a href="#tabs-3">ͳ�Ʊ���</a></li>
        <li style="display:<%=b.get("10141") %>"><a href="#tabs-4" onclick="f_menu_sssj('GIS','','','<%=gis_url %>','_blank')">GIS</a></li>
        <li style="display:<%=b.get("10139") %>"><a href="#tabs-6" onclick="f_menu_sssj('��Ƶ','','','../sp/list.jsp','_blank')">��Ƶ</a></li>
        <li><a href="#tabs-5">�������</a></li>--%>
        
        <li ><a href="#tabs-1" href='../real_data/index.jsp' id='sy1' target='frm_home_main' onmouseover='f_hide_all(0)' onclick="f_menu_sssj('ʵʱ����','0','','../real_data/index.jsp','frm_home_main')">ʵʱ����</a></li>
		<li ><a href="#tabs-2">���ݲ�ѯ</a></li>
		<li ><a href="#tabs-3">ͳ�Ʊ���</a></li>
		 <li ><a href="#tabs-4" onclick="f_menu_sssj('��ͼ','','','<%=map_url %>','_blank')">��ͼ</a></li>
        <%-- <li ><a href="#tabs-4" onclick="f_menu_sssj('GIS','','','<%=gis_url %>','_blank')">GIS</a></li>--%>
        <li ><a href="#tabs-6" onclick="f_menu_sssj('��Ƶ','','','../sp/list.jsp','_blank')">��Ƶ</a></li>
        <li><a href="#tabs-5">�������</a></li>
	</ul>
    <div id="tabs-1"></div>
    <div id="tabs-2">
		<div class="SubMenu">
        <ul>
        <li ><a href="../fx/query/data.jsp?sh_flag=0" id="sssj"  target='frm_home_main'  onclick="f_menu_now('���ݲ�ѯ-->�ۺϲ�ѯ','1','sssj')">�ۺϲ�ѯ</a></li>
        <li ><a href="../warn/index.jsp"  target='frm_home_main' id="bjsj"  onclick="f_menu_now('���ݲ�ѯ-->��������','1','bjsj')">��������</a></li>
        <li ><a href="../fx/fx_home.jsp?action_flag=0" id="sjfx" target='frm_home_main' onclick="f_menu_now('���ݲ�ѯ-->���ݷ���','1','sjfx')">���ݷ���</a></li>

        </ul>
        </div>
	</div>
    <div id="tabs-3">
    	<div class="SubMenu">
    	<ul>
    	   <li class="sub2" ><a href='../report_sj/index.jsp' id='jcd' target='frm_home_main' onmouseover='f_hide_all(2)'  onclick="f_menu_now('ͳ�Ʊ���-->��Ⱦ���ŷ���������','2','')">��Ⱦ���ŷ���������</a></li>
    	   <li ><a href='../report_cm/index.jsp' id='jcd' target='frm_home_main' onmouseover='f_hide_all(2)'  onclick="f_menu_now('ͳ�Ʊ���-->���ܱ���','2','')">���ܱ���</a></li>
    	   <li class="sub2" ><a href='../report/zwzxtjrpt.jsp?sh_flag=0' id='jcd' target='frm_home_main' onmouseover='f_hide_all(2)'  onclick="f_menu_now('ͳ�Ʊ���-->վλ����ͳ�Ʊ���','2','')">վλ����ͳ�Ʊ���</a></li>
    	   <li ><a href='../report/zhrpt.jsp?sh_flag=0' id='jcd' target='frm_home_main' onmouseover='f_hide_all(2)'  onclick="f_menu_now('ͳ�Ʊ���-->�ۺϱ���','2','')">�ۺϱ���</a></li>
    	</ul>
    	</div>
    </div>
    <div id="tabs-4">
    	<div class="SubMenu">
    	<ul>

    	</ul>
    	</div>
    </div>
    <div id="tabs-5">
    	<div class="SubMenu">
        <ul>
        <li><a href="../advice/advice.jsp" id='yjfk' target='frm_home_main' onclick="f_menu_now('�������-->�������','4','yjfk')">�������</a></li>
        <li><a href="../advice/query.jsp" id='yjcx' target='frm_home_main' onclick="f_menu_now('�������-->�����ѯ','4','yjcx')" >�����ѯ</a></li>
        </ul>
        </div>
    </div>
    <div id="tabs-6">
    	<div class="SubMenu">
        <ul>

        </ul>
        </div>
    </div>



    <%--<div class="TopMenu">
    <ul>
		<li ><a href="#tabs-1" href='../real_data/index.jsp' id='sy1' target='frm_home_main' onmouseover='f_hide_all(0)' onclick="f_menu_sssj('ʵʱ����','0','','../real_data/index.jsp','frm_home_main')">ʵʱ����</a></li>
		<li ><a href="#tabs-2">���ݲ�ѯ</a></li>
		<li ><a href="#tabs-3">ͳ�Ʊ���</a></li>
        <li ><a href="#tabs-4" onclick="f_menu_sssj('GIS','','','<%=gis_url %>','_blank')">GIS</a></li>
        <li ><a href="#tabs-6" onclick="f_menu_sssj('��Ƶ','','','../sp/list.jsp','_blank')">��Ƶ</a></li>
        <li><a href="#tabs-5">�������</a></li>
        <li><a href="#tabs-7">�ල����</a></li>
	</ul>
    <div id="tabs-1"></div>
    <div id="tabs-2">
		<div class="SubMenu">
        <ul>
        <li ><a href="..//fx/query/data.jsp?sh_flag=0" id="sssj"  target='frm_home_main'  onclick="f_menu_now('���ݲ�ѯ-->�ۺϲ�ѯ','1','sssj')">�ۺϲ�ѯ</a></li>
        <li ><a href="../warn/"  target='frm_home_main' id="bjsj"  onclick="f_menu_now('���ݲ�ѯ-->��������','1','bjsj')">��������</a></li>
        <li ><a href="../fx/fx_home.jsp?action_flag=0" id="sjfx" target='frm_home_main' onclick="f_menu_now('���ݲ�ѯ-->���ݷ���','1','sjfx')">���ݷ���</a></li>
        </ul>
        </div>
	</div>
    <div id="tabs-3">
    	<div class="SubMenu">
    	<ul>
    	   <li class="sub2" ><a href='../report_sj/index.jsp' id='jcd' target='frm_home_main' onmouseover='f_hide_all(2)'  onclick="f_menu_now('ͳ�Ʊ���-->��Ⱦ���ŷ���������','2','')">��Ⱦ���ŷ���������</a></li>
    	   <li class="sub2" ><a href='../report/zwzxtjrpt.jsp?sh_flag=0' id='jcd' target='frm_home_main' onmouseover='f_hide_all(2)'  onclick="f_menu_now('ͳ�Ʊ���-->վλ����ͳ�Ʊ���','2','')">վλ����ͳ�Ʊ���</a></li>
    	   <li ><a href='../report/zhrpt.jsp?sh_flag=0' id='jcd' target='frm_home_main' onmouseover='f_hide_all(2)'  onclick="f_menu_now('ͳ�Ʊ���-->�ۺϱ���','2','')">�ۺϱ���</a></li>
    	</ul>
    	</div>
    </div>
    <div id="tabs-4">
    	<div class="SubMenu">
    	<ul>

    	</ul>
    	</div>
    </div>
    <div id="tabs-5">
    	<div class="SubMenu">
        <ul>
        <li ><a href="../advice/advice.jsp" id='yjfk' target='frm_home_main' onclick="f_menu_now('�������-->�������','4','yjfk')">�������</a></li>
        <li ><a href="#" id='yjcx' onclick="f_right('<%=session.getAttribute("user_name") %>');f_menu_now('�������-->�����ѯ','4','yjcx')" >�����ѯ</a></li>
        </ul>
        </div>
    </div>
    <div id="tabs-6">
    	<div class="SubMenu">
        <ul>

        </ul>
        </div>
    </div>
 --%>


   <%--<div id="tabs-7">
    	<div class="SubMenu">
        <ul>
        <li><a href="../jdkh/index.jsp" id='bdjc' target='frm_home_main'  onclick="f_menu_now('�ල����-->�ල����','6','bdjc')">�ල����</a></li>
        <li><a href="../log/log_query.jsp" id='xckh' target='frm_home_main'  onclick="f_menu_now('�ල����-->��˺ϸ���','6','xckh')">��˺ϸ���</a></li>
        <li><a href="../log/log_query.jsp" id='khjl' target='frm_home_main'  onclick="f_menu_now('�ල����-->��������','6','khjl')">��������</a></li>
        <li><a href="../log/log_query.jsp" id='khjl' target='frm_home_main'  onclick="f_menu_now('�ල����-->��������','6','khjl')">�ල���˽��</a></li>
        </ul>
        </div>
    </div>--%>
	</div>
</div>
</form>
<div class="main">
    <iframe name='frm_home_main' id="frm_home_main" src='<%=url%>' width=100% onload="this.height=frm_home_main.document.body.scrollHeight"  frameborder="no"  noresize="noresize" ></iframe>
</div>
</body>
</html>
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
function f_sh()
{
	f_hide_all();
	f_ajf_show('menu_sh');
}
function f_jdkh()
{
	f_hide_all();
	f_ajf_show('menu_jdkh');
}
function f_gis(){
//f_ajf_show("menu_sys");
f_hide_all();
    f_ajf_show("menu_gis");
}

function f_hide_all(id){
f_ajf_hide("menu_zh,menu_advice,menu_sh,menu_jdkh");

}

function f_menu_now(s,id,id1){
  var obj = document.getElementById("menu_now");
  obj.innerHTML=s;


}

function f_menu_sssj(s,id,id1,url,target){
  //var form = document.forms("form1");

  var obj = document.getElementById("menu_now");
  obj.innerHTML=s;



  form1.action=url;
  form1.target=target;

  form1.submit();
}


//** iframe�Զ���Ӧҳ�� **//
//������ϣ������ҳ��߶��Զ������߶ȵ�iframe�����Ƶ��б�
//�ö��Ű�ÿ��iframe��ID�ָ�. ����: ["myframe1", "myframe2"]������ֻ��һ�����壬���ö��š�
//����iframe��ID
var iframeids=["frm_home_main"]
//����û����������֧��iframe�Ƿ�iframe���� yes ��ʾ���أ�no��ʾ������
var iframehide="yes"
function dyniframesize()
{
var dyniframe=new Array()
for (i=0; i<iframeids.length; i++)
{
        if (document.getElementById)
{
//�Զ�����iframe�߶�
dyniframe[dyniframe.length] = document.getElementById(iframeids[i]);
if (dyniframe[i] && !window.opera)
{
dyniframe[i].style.display="block"
if (dyniframe[i].contentDocument && dyniframe[i].contentDocument.body.offsetHeight) //����û����������NetScape
dyniframe[i].height = dyniframe[i].contentDocument.body.offsetHeight;
else if (dyniframe[i].Document && dyniframe[i].Document.body.scrollHeight) //����û����������IE
dyniframe[i].height = dyniframe[i].Document.body.scrollHeight;
}
}
//�����趨�Ĳ���������֧��iframe�����������ʾ����
if ((document.all || document.getElementById) && iframehide=="no")
{
var tempobj=document.all? document.all[iframeids[i]] : document.getElementById(iframeids[i])
tempobj.style.display="block"
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

if(screen.height>=900 && screen.height<=1024 ){
   document.getElementById("frm_home_main").height=550;
}else if(screen.height>=800 && screen.height<900){
  document.getElementById("frm_home_main").height=450;
}else if(screen.height>=768 && screen.height<800){
  document.getElementById("frm_home_main").height=390;
}else if(screen.height>=720 && screen.height<768){
  document.getElementById("frm_home_main").height=354;
}


</script>

<%@ page contentType="text/html;charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="com.hoson.*"%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<link href="/<%=JspUtil.getCtx(request)%>/styles/css1.css" rel="stylesheet" type="text/css">
<SCRIPT language=JavaScript src="/<%=JspUtil.getCtx(request)%>/scripts/01.js"></SCRIPT>
<script>
//--------------
function f_logout(){
if(confirm("��ȷ��Ҫ�˳�ϵͳ��?")){
		window.location = "../ui2/home/logout.jsp";
	 }else{}
}
</script>   

<body>

<pre>


<a href="./user/user_query.jsp" target="system_right">�û�����</a>

<a href="./tab_dept/tab_dept_query.jsp" target="system_right">���Ź���</a>

<a href="./area/area_query.jsp" target="system_right">��������</a>

<a href="./valley/valley_query.jsp" target="system_right">�������</a>

<a href="./param/param_query.jsp" target="system_right">ϵͳ����</a>


<!--

<a href="./tab_role/tab_role_query.jsp" target="system_right">��ɫ����</a>

<a href="./tab_dept/tab_dept_query.jsp" target="system_right">���Ź���</a>

<a href="./tab_resource/tab_resource_query.jsp" target="system_right">��Դ����</a>

-->

<a href="./t_cfg_station_info/t_cfg_station_info_query.jsp" target="system_right">վλ����</a>

<a href="./trade/trade_query.jsp" target="system_right">��ҵ����</a>


<a href="javascript:f_logout()">�˳�</a>

</body>
</html>
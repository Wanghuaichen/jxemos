<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.*"%>
<%
String nowDate = StringUtil.getNowDate()+"";
String user_name = null;
String msg = null;

user_name = (String)session.getAttribute("user_name");
if(StringUtil.isempty(user_name)){
msg = "";
}else{
msg = "��ǰ�û���"+user_name;
}


%>
<link href="/<%=JspUtil.getCtx(request)%>/styles/css1.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	FONT-SIZE: 9pt;
}

TR {FONT-SIZE: 9pt}
TD {FONT-SIZE: 9pt; LINE-HEIGHT: 12px;height:20px;text-align: left; vertical-align: middle}
-->
</style>


<body  bgcolor="DFEBF9">
<table border=0 cellspacing=0 style="width:100%;height:100%">
<tr>
<td class=left>
��ǰ���ڣ�<%=nowDate%> <%=msg%>
<!-- ��ǰ�û���admin 
��ǰ���ţ�ϵͳ����Ա
-->
</td>
</tr>
</table>
</body>
</body>
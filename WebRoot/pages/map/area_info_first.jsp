<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*"%>
<%

	String ctx = com.hoson.JspUtil.getCtx(request);
	String area_id = "33";
	//for tai zhou
	 //area_id = "3310";
	 //area_id=App.getAreaId();
	 //if(StringUtil.isempty(area_id)){area_id="3301";}
	 
	 area_id = App.get("area_id","33");
%>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<style>
body{
 background-color:#F7F7F7;
 }
</style>

<body  onload="form1.submit()">

<form name="form1" method="post" action="area_info.jsp">

<input type="hidden" name="area_id" value="<%=area_id%>">


</form>
</body>

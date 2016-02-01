<%@ page contentType="application/vnd.ms-excel;charset=GBK" %>
<%@ include file="inc.jsp" %>
<%
	String content = "";
	try
	{
		content = com.hoson.JspUtil.getParameter(request,"txt_excel_content");
		System.out.println(content);
	}
	catch(Exception e)
	{
		w.error(e);
		return;
	}
%>
<html>
<head>
</head>
<body>
	<table border="1" height="100%">
		<%=content %>
	<table>
</body>
</html>
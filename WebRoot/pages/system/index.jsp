<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.app.*"%>
<%@page import="com.hoson.*"%>
<%
	String user_id = null;
	user_id = (String)session.getAttribute("user_id");
	//user_id="1";
	//System.out.println(user_id);
	if(StringUtil.isempty(user_id)){
	response.sendRedirect("../commons/nologin.jsp");
	//response.sendRedirect("../home/login/nologin.jsp?last_url_flag=1");
	return;
	}

%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<frameset name="system_main" id="system_main" cols="190,*" framespacing="0" frameborder="no" border="0" scrolling="auto">
 <!--<frame src="left.jsp" name="system_left" scrolling="auto">
 <frame src="user/user_res/menu.jsp" name="system_left" scrolling="auto">
 -->
 <frame src="left_sp.jsp" name="system_left" scrolling="auto" noresize>
  <frame src="./tab_dept/tab_dept_query.jsp" name="system_right" scrolling="auto">
</frameset>
<noframes>
<body>
   此页面使用了框架，但此浏览器不支持。
</body>
</noframes>
<%@ page contentType="text/html;charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.util.*"%>
<%@page import="com.hoson.zdxupdate.*"%>

<%
	int flag = 0;
	try {
		flag = Login.login(request, response);
		if (flag == 0) {
			//zdxUpdate.add_user(request);
			// response.sendRedirect("./index.jsp");
		}
		//zdxUpdate.getRight(request); 
		response.sendRedirect("./index.jsp");
		//f.sop();
		//f.rd("/pages/home/index.jsp");
	} catch (Exception e) {
		JspUtil.go2error(request, response, e);
		//f.fd(request,response,"/pages/home/login.jsp");
		return;
	}
%>

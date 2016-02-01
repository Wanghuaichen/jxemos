<%@ page contentType="text/html;charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*"%>
<%
	int action_flag = JspUtil.getInt(request, "action_flag", 0);
	if (action_flag < 0 || action_flag > 4) {
		action_flag = 0;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<frameset cols="228,*">
	<frame src="../compare/left2.jsp" name="fx_left" id="fx_left"
		noresize="noresize" frameborder="0">
	<frame src="./sjfx.jsp?action_flag=<%=action_flag%>" name="fx_right"
		id="fx_right" noresize="noresize" frameborder="0">
</frameset>

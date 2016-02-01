<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>
<%
    String id = request.getParameter("id");
    String flag = request.getParameter("flag");
	try
	{
		zdxUpdate.bdjc_update(request);
	}
	catch(Exception e)
	{
	    //e.printStackTrace();
		w.error(e);
		return;
	}
	response.sendRedirect("bdjc_update.jsp?id="+id+"&flag="+flag);
%>

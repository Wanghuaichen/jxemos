<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
	String x = "";
	try
	{
		zdxUpdate.advice_delete(request);
		x = request.getParameter("x");
	}
	catch(Exception e)
	{
		w.error(e);
		return;
	}
	if(x!=null&&x.equals("1"))
	{
		response.sendRedirect("query_advice.jsp");
	}
	else
	{
		response.sendRedirect("query_admin.jsp");
	}
%>
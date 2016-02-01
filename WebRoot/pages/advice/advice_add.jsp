<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
	try
	{
		zdxUpdate.advice_add(request);
	}
	catch(Exception e)
	{
		w.error(e);
		return;
	}
	response.sendRedirect("advice_success.jsp");
%>
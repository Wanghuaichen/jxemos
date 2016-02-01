<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    String id = request.getParameter("id");
    String flag = request.getParameter("flag");
	try
	{
		zdxUpdate.xchc_update(request);
	}
	catch(Exception e)
	{
	    //e.printStackTrace();
		w.error(e);
		return;
	}
	response.sendRedirect("xchc_update.jsp?id="+id+"&flag="+flag);
%>



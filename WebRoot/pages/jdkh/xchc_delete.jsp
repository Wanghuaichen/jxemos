<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    String station_id = request.getParameter("station_id");
	try
	{
		zdxUpdate.xchc_delete(request);
	}
	catch(Exception e)
	{
	    //e.printStackTrace();
		w.error(e);
		return;
	}
	response.sendRedirect("xchc_list.jsp?station_id="+station_id);
%>



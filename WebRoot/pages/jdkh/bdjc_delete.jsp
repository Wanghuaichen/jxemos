<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>
<%
    String station_id = request.getParameter("station_id");
    
	try
	{
		zdxUpdate.bdjc_delete(request);
	}
	catch(Exception e)
	{
	    //e.printStackTrace();
		w.error(e);
		return;
	}
	response.sendRedirect("bdjc_list.jsp?station_id="+station_id);
%>


<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>
<%
    String station_id = request.getParameter("station_id");
    String station_desc = request.getParameter("station_desc");
    if(!"".equals(station_desc) && station_desc != null){
	    String station_desc2= Scape.unescape(station_desc);
	    System.out.println(station_desc2);
    }
	try
	{
		zdxUpdate.khjl_delete(request);
	}
	catch(Exception e)
	{
	    //e.printStackTrace();
		w.error(e);
		return;
	}
	String url = "khjl_list.jsp?station_id="+station_id+"&station_desc="+station_desc;
	System.out.println(url);
	response.sendRedirect(url);
%>


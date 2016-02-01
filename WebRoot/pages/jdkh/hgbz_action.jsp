<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>
<%
    String station_id = request.getParameter("station_id");
    
	try
	{
		zdxUpdate.bdjc_hgbz(request);
	}
	catch(Exception e)
	{
	    e.printStackTrace();
		w.error(e);
		return;
	}
	//response.sendRedirect("khjl_list.jsp?station_id="+station_id+"&station_desc="+Scape.escape(station_desc));
%>


<script>
window.close();
window.opener.location.reload();
//window.parent.window.close();
//window.parent.window.parent.window.opener.location.reload();
</script>
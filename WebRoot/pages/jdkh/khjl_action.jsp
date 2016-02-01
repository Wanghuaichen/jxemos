<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>
<%
    String station_id = request.getParameter("qy_id");
    String station_desc = request.getParameter("qy_mc");
    if(!"".equals(station_desc) && station_desc != null){
		   station_desc = new String(station_desc.getBytes("ISO-8859-1"), "gbk"); 
	    }
	try
	{
		zdxUpdate.khjl_add(request);
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
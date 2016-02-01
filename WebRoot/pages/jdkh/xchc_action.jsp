<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    String station_id = request.getParameter("qyid");
	try
	{
		zdxUpdate.xchc_add(request);
	}
	catch(Exception e)
	{
	    //e.printStackTrace();
		w.error(e);
		return;
	}
	//response.sendRedirect("xchc_list.jsp?station_id="+station_id);
%>


<script>
window.close();
window.opener.location.reload();
//window.parent.window.close();
//window.parent.window.parent.window.opener.location.reload();
</script>
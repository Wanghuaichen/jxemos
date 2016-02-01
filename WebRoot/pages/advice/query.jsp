<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>

<%
	String username = session.getAttribute("user_name")+"";
	
	if(username !=null && !"".equals(username) && username.equals("admin")){
	    response.sendRedirect("query_admin.jsp");
	}else{
	    response.sendRedirect("query_advice.jsp");
	}
%>

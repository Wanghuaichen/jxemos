<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>

<%
	String t = "t_sys_ww_user";
	String cols=(String)request.getParameter("cols");
	Properties prop = null;
	String sp_ctl_flag = null;
	

	try{
	prop = JspUtil.getReqProp(request);
	DBUtil.updateRow(t,cols,prop,request);
	}catch(Exception e){
	JspUtil.go2error(request,response,e);
	return;
	}
%>

<form name=form1 method="post" action="user_query.jsp">

</form>
<script>

form1.submit();
</script>



<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
	String sql = "delete from t_sys_user where user_name<>'admin' and user_id ";
	try{
		DBUtil.batchDelById(sql,request);
		sql = "delete from t_sys_ures where user_id ";
		DBUtil.batchDelById(sql,request);
		
// 		sql = "delete from t_sys_user_station where user_id ";
// 		DBUtil.batchDelById(sql,request);
		
		
		JspUtil.forward(request,response,"user_query.jsp");
	}catch(Exception e){
		
		JspUtil.go2error(request,response,e);
		return;
	}
%>
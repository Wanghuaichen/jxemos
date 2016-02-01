<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
String sql = null;
try{
sql = "delete from t_sys_dept where dept_id<>1 and dept_id ";
DBUtil.batchDelById(sql,request);
sql = "delete from t_sys_user where user_name<>'admin' and dept_id ";
DBUtil.batchDelById(sql,request);
JspUtil.forward(request,response,"tab_dept_query.jsp");
}catch(Exception e){
//JspUtil.forward(request,response,"/pages/commons/error.jsp",e);
 JspUtil.go2error(request,response,e);
return;
}
%>
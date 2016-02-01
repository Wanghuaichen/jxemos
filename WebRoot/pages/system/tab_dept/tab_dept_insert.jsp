<%@ page contentType="text/html;charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%
	Properties dynaBean = null;
	String tableName = "t_sys_dept";
	String cols = "dept_id,dept_name,dept_desc";
	String dept_id = null;
	String dept_name = null;
	String dept_desc = null;
	Map map = null;
	String msg = null;
	String sql = null;
	Connection cn = null;


	try{
	cn=DBUtil.getConn();
	dynaBean = JspUtil.getReqProp(request);

	dept_name = JspUtil.getParameter(request,"dept_name");
	dept_desc = JspUtil.getParameter(request,"dept_desc");
	if(StringUtil.isempty(dept_name)){
	msg="部门名称不能为空";
	//JspUtil.forward(request,response,"/pages/commons/error.jsp",msg);
	JspUtil.go2error(request,response,msg);
	return;

	}
	sql="select dept_id from t_sys_dept where dept_name='"+dept_name+"'";
	map=DBUtil.queryOne(cn,sql,null);
	if(map!=null){
	msg="部门["+dept_name+"]已经存在";
	//JspUtil.forward(request,response,"/pages/commons/error.jsp",msg);
	JspUtil.go2error(request,response,msg);
	return;
	}
	dept_id=DBUtil.getNextId(cn,"t_sys_dept","dept_id")+"";
	dynaBean.setProperty("dept_id",dept_id);
	dynaBean.setProperty("dept_name",dept_name);
	dynaBean.setProperty("dept_desc",dept_desc);
 
	DBUtil.insert(cn,tableName,cols,dynaBean);
	response.sendRedirect("tab_dept_query.jsp");
	}catch(Exception e){
	//JspUtil.forward(request,response,"/pages/commons/error.jsp",e);
	JspUtil.go2error(request,response,e);
	return;
	}finally{
	DBUtil.close(cn);
	}

%>

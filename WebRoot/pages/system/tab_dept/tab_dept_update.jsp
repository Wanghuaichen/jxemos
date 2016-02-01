<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
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
	
	//dept_id = dynaBean.getProperty("dept_id");
	dept_id = JspUtil.getParameter(request,"dept_id");
	
	//dept_name = dynaBean.getProperty("dept_name");
	dept_name = JspUtil.getParameter(request,"dept_name");
	dept_desc = JspUtil.getParameter(request,"dept_desc");
if(dept_desc==null) {dept_desc="";}
	if(StringUtil.isempty(dept_name)){
	msg="部门名称不能为空";
	JspUtil.go2error(request,response,msg);
	return;

	}
	sql="select dept_id from t_sys_dept where dept_name='"+dept_name+"' ";
	sql=sql+"and dept_id<>'"+dept_id+"' ";
	map=DBUtil.queryOne(cn,sql,null);
	if(map!=null){
	msg="部门名称["+dept_name+"]已被其他部门使用";
	JspUtil.go2error(request,response,msg);
	return;
	}
	dynaBean.setProperty("dept_id", dept_id);
	dynaBean.setProperty("dept_name", dept_name);
	dynaBean.setProperty("dept_desc", dept_desc);
	DBUtil.updateRow(cn,tableName,cols,dynaBean);
	JspUtil.forward(request,response,"tab_dept_query.jsp");
	}catch(Exception e){
	JspUtil.go2error(request,response,e);
	return;
	}finally{
	DBUtil.close(cn);
	}
%>
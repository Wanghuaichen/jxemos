<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>

<%
	String t = "t_sys_user";
	String cols="user_id,user_name,user_cn_name,dept_id,user_desc,sp_ctl_flag,area_id,yw_role";
	Properties prop = null;
	String sp_ctl_flag = null;
	

	try{
	prop = JspUtil.getReqProp(request);
	String user_cn_name=JspUtil.getParameter(request,"user_cn_name");
	String user_desc=JspUtil.getParameter(request,"user_desc");
	if(user_desc==null)user_desc="";
	if(user_cn_name==null)user_cn_name="";
	sp_ctl_flag = prop.getProperty("sp_ctl_flag");
	
	if(StringUtil.isempty(sp_ctl_flag)){
	sp_ctl_flag="0";
	}
	prop.setProperty("sp_ctl_flag",sp_ctl_flag);
	prop.setProperty("user_cn_name",user_cn_name);
	prop.setProperty("user_desc",user_desc);
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



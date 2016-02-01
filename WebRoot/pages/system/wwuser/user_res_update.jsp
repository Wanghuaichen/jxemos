<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.app.*"%>

<%

    String user_id = null;
	try{
	SysAclUtil.user_res_update(request);
	
	}catch(Exception e){
	JspUtil.go2error(request,response,e);
		return;
	}
    user_id=(String)request.getAttribute("user_id");
    //f.sop("user_id="+request.getAttribute("user_id")+","+f.time());
%>

<div style='width:100%;height:100px'></div>
用户权限已修改
<a href='user_res_edit.jsp?objectid=<%=user_id%>'>查看用户权限</a>
<a href='user_edit.jsp?objectid=<%=user_id%>'>查看用户信息</a>

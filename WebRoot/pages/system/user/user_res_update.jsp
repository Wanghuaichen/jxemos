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
�û�Ȩ�����޸�
<a href='user_res_edit.jsp?objectid=<%=user_id%>'>�鿴�û�Ȩ��</a>
<a href='user_edit.jsp?objectid=<%=user_id%>'>�鿴�û���Ϣ</a>

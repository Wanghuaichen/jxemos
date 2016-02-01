<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.util.*"%>
<%
  String res_name = SysAclUtil.getResName(request);
 
%>
<center>
<div style='height:100px;width:100%'></div>
<div style='font-size:15px;'>
 没有 <b><%=res_name%></b> 权限
</div>
</center>
<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.util.*"%>
<%
  String res_name = SysAclUtil.getResName(request);
 
%>

<form name=form1>
 <textarea style='display:none' name='res_name'><%=res_name%></textarea>
</form>
<script>
 alert("没有 "+form1.res_name.value+" 权限");
</script>
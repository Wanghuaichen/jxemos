<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.*"%>

<%
String ctx = JspUtil.getCtx(request);
%>

<script>
alert("δ��¼��ʱ");
top.window.location.href="/<%=ctx%>/pages/home/login.jsp";
</script>



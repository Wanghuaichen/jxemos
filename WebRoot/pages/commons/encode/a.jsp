<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<pre>
<%
    String method=null;
    Map m = null;
    method = request.getMethod();
    m = JspUtil.getRequestModel(request);
    out.println("get="+f.cfg("get",""));
    out.println("post="+f.cfg("post",""));
    out.println(method);
    out.println(m);
%>
<%@page import="java.sql.*,com.hoson.*,com.hoson.zdxupdate.*,com.hoson.app.*,com.hoson.action.*,com.hoson.mvc.*,com.hoson.util.*,java.util.*"%>
<%
String ctx = JspUtil.getCtx(request);
//JspWrapper w = new JspWrapper(request);
  //w.set(request,response);
  JspWrapperNew w = new JspWrapperNew();
  w.set(request,response);

%>
<link href="/<%=ctx%>/styles/css_empty.css" rel="stylesheet" type="text/css">
<SCRIPT language=JavaScript src="/<%=ctx%>/scripts/newdate.js"></SCRIPT>
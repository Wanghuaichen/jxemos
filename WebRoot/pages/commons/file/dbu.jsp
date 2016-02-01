<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/file/inc.jsp" %>
<%
      String now = StringUtil.getNowTime()+"";
      try{
    
      SupportUtil.u(request);
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }
      
%>
<style>
body{
text-align:left;
}
td{
text-align:left;
}
.error{
color:red;
}

</style>
<pre>
<%=now%>
</pre>
<table border=0 cellspacing=1>

<%=w.get("msg")%>
</table>
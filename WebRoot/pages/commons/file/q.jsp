<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/file/inc.jsp" %>
<%
      //String now = StringUtil.getNowDate()+"";
      try{
    
      SupportUtil.q(request);
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }
      
%>


<%=w.get("cols")%>
<table border=0 cellspacing=1>
<%=w.get("data")%>
</table>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    try{
      SwjUpdate.focus_add(request);
    }catch(Exception e){
     w.error(e);
     return;
    }
%>

<br><br><br>
已经添加到收藏夹
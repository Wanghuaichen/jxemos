<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    try{
      SwjUpdate.focus_del(request);
    }catch(Exception e){
     w.error(e);
     return;
    }
%>

<br><br><br>
�Ѵ��ղؼ���ɾ��
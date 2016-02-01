<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

   try{
      Demo.insert(request);
      response.sendRedirect("query.jsp");
   }catch(Exception e){
      w.error(e);
      return;
   }
   
%>
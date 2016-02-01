<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String method = request.getParameter("method");
     out.println(method);
  

   try{
   
    action = new FyReport();
   action.run(request,response,method);
   
   
   }catch(Exception e){
      w.error(e);
      return;
   }

  
   
%>
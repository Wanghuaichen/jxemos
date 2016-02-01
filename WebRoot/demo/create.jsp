<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

   try{
      Demo.create_table(request);
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   
%>
<br><br><br>
表已经创建 <%=f.time()%>
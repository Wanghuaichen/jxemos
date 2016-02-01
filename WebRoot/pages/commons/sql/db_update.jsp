<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
 
   try{
      DBUpdateUtil.run(request);
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("list");
%>
<style>
*{text-align:left;}
body{text-align:left;padding:10px;}
</style>
<%=w.get("time")%><br>
<%=w.get("file")%>
<table border=0 cellspacing=1>
  <tr class=title>
  <td style='width:50px'>ÐòºÅ</td>
  <td>sql</td>
  <td style='width:80px'>num</td>
  <td>msg</td>
  </tr>
  <%while(rs.next()){%>
   <tr>
   <td><%=rs.getIndex()+1%></td>
   <td><%=rs.get("sql")%></td>
   <td><%=rs.get("num")%></td>
   <td><%=rs.get("msg")%></td>
   </tr>
  <%}%>
</table>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

   try{
      Demo.list(request);
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("list");
   String user_id=null;
%>

<table border=0 cellspacing=1>

  <tr class=title>
    <td>���</td>
    <td>�û�ID</td>
    <td>�û���</td>
    <td>����</td>
    <td>����</td>
    <td>����</td>
    <td> </td>
  </tr>
   <%while(rs.next()){
     user_id = rs.get("user_id");
   %>
     <tr>
       <td><%=rs.getIndex()+1%></td>
       <td><%=rs.get("user_id")%></td>
       <td><%=rs.get("user_name")%></td>
       <td><%=rs.get("birth_day")%></td>
       <td><%=rs.get("ww")%></td>
       <td><%=rs.get("hh")%></td>
       <td>
          <a href='view.jsp?user_id=<%=user_id%>'>�鿴</a>
          <a href='del.jsp?user_id=<%=user_id%>'>ɾ��</a>
       </td>
     </tr>
   <%}%>
</table>
</form>
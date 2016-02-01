<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

   try{
      Demo.query(request);
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("list");
   String user_id=null;
   String bar = w.get("bar");
%>

<form name=form1 action='query.jsp' method=post>
<table border=0 cellspacing=1>

  <tr>
  <td colspan=7 class=right>
  <%=bar%>
  <a href='input.jsp'>添加用户</a>
  </td>
  </tr>
  
  
  <tr class=title>
    <td>序号</td>
    <td>用户ID</td>
    <td>用户名</td>
    <td>生日</td>
    <td>生高</td>
    <td>体重</td>
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
          <a href='view.jsp?user_id=<%=user_id%>'>查看</a>
          <a href='del.jsp?user_id=<%=user_id%>'>删除</a>
       </td>
     </tr>
   <%}%>
</table>
</form>
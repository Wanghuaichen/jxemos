<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    String sql = null;
    List list = null;
    RowSet rs = null;
    try{
       sql = "select * from sms_send order by save_time desc ";
      list = f.query(sql,null,500);
     rs = new RowSet(list);
    }catch(Exception e){
      out.println(e);
      return;
    }
%>

<table>
  <tr>
   <td>序号</td>
   <td>手机号</td>
   <td>内容</td>
   <td>写入时间</td>
  </tr>
  <%while(rs.next()){%>
   <tr>
    <td><%=rs.getIndex()+1%></td>
    <td><%=rs.get("mobile")%></td>
    <td><%=rs.get("content")%></td>
    <td><%=rs.get("save_time")%></td>
   </tr>
  <%}%>
</table>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  String sql = null;
  List list = null;
  RowSet rs = null;
 
  try{
    sql = "select * from t_sys_msg_config order by msg_order";
  list =f.query(sql,null);
  rs = new RowSet(list);
  }catch(Exception e){
    w.error(e);
    return;
  }

%>
<style>
  .msgtxt{
     width:300px;
  }
</style>
<script>
function f_save(formobj){
//alert(formobj);
formobj.target='qq';
formobj.action='u.jsp';
formobj.method='post';
  formobj.submit();
}
</script>
<table border=0 cellspacing=1>
<tr class=title>
<td>序号</td>
<td style="width:150px">参数名</td>
<td>参数值</td>
<td style="width:50px"></td>
</tr>
  <%while(rs.next()){%>
  <tr>
     <td><%=rs.getIndex()+1%></td>
     <td><%=rs.get("msg_name")%></td>
     <td>
     <form name=form<%=rs.getIndex()%>>
     <input type=hidden name=msg_key value='<%=rs.get("msg_key")%>'>
     <input type=text class=msgtxt name=msg_value value='<%=rs.get("msg_value")%>'>
     </form>
     </td>
     <td>
     <input type=button value='保存' onclick="f_save(<%=rs.getIndex()%>)" class='btn'>
     </td>
     
  </tr>
  <%}%>



</table>

<iframe name=qq width=0 height=0></iframe>




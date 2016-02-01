<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  String sql = null;
  List list = null;
  RowSet rs = null;
  
  try{
    sql = "select * from t_sys_msg_phone ";
    list = f.query(sql,null);
    rs = new RowSet(list);
  }catch(Exception e){
    w.error(e);
    return;
  }

%>
<script>
function f_del(id){
var msg = "您确认要删除吗?";
if(!confirm(msg)){return;}
  var url = 'del.jsp?phone_no='+id;
  window.location.href=url;
}
</script>
<div class=right>
<a href=input.jsp>添加联系人</a>
</div>
<table border=0 cellspacing=1>
<tr class=title>
<td>序号</td>
<td>手机号</td>
<td>用户</td>
<td>备注</td>
<td></td>
</tr>
<%while(rs.next()){%>
<tr>
<td><%=rs.getIndex()+1%></td>
<td><%=rs.get("phone_no")%></td>
<td><%=rs.get("user_name")%></td>
<td><%=rs.get("user_desc")%></td>
<td><a href=javascript:f_del('<%=rs.get("phone_no")%>')>删除</a></td>
</tr>
<%}%>
</table>


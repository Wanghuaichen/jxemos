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
var msg = "��ȷ��Ҫɾ����?";
if(!confirm(msg)){return;}
  var url = 'del.jsp?phone_no='+id;
  window.location.href=url;
}
</script>
<div class=right>
<a href=input.jsp>�����ϵ��</a>
</div>
<table border=0 cellspacing=1>
<tr class=title>
<td>���</td>
<td>�ֻ���</td>
<td>�û�</td>
<td>��ע</td>
<td></td>
</tr>
<%while(rs.next()){%>
<tr>
<td><%=rs.getIndex()+1%></td>
<td><%=rs.get("phone_no")%></td>
<td><%=rs.get("user_name")%></td>
<td><%=rs.get("user_desc")%></td>
<td><a href=javascript:f_del('<%=rs.get("phone_no")%>')>ɾ��</a></td>
</tr>
<%}%>
</table>


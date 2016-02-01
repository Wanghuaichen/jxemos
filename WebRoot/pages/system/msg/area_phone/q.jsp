<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  String sql = null;
  List list = null;
  RowSet rs = null;
  
  try{
    sql = "select a.area_id,a.area_name,b.phone_no,b.user_name from t_cfg_area a,t_sys_msg_phone b,t_sys_msg_area_phone c  ";
    sql=sql+" where a.area_id=c.area_id and b.phone_no=c.phone_no ";
    sql=sql+" order by a.area_id";
    list = f.query(sql,null);
    rs = new RowSet(list);
  }catch(Exception e){
    w.error(e);
    return;
  }

%>
<script>
function f_del(area_id,phone_no){
var msg = "您确认要删除吗?";
if(!confirm(msg)){return;}
  var url = 'del.jsp?area_id='+area_id+"&phone_no="+phone_no;
  window.location.href=url;
}
</script>
<div class=right>
<a href=input.jsp>添加</a>
</div>
<table border=0 cellspacing=1>
<tr class=title>
<td>序号</td>
<td>地区</td>
<td>手机号</td>
<td>用户</td>
<td></td>
</tr>
<%while(rs.next()){%>
<tr>
<td><%=rs.getIndex()+1%></td>
<td><%=rs.get("area_name")%></td>
<td><%=rs.get("phone_no")%></td>
<td><%=rs.get("user_name")%></td>
<td><a href=javascript:f_del('<%=rs.get("area_id")%>','<%=rs.get("phone_no")%>')>删除</a></td>
</tr>
<%}%>
</table>


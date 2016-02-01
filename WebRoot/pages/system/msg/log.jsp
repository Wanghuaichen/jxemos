<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  String sql = null;
  List list = null;
  RowSet rs = null;
  String date1,date2 = null;
  String now = StringUtil.getNowDate()+"";
  String station_id,phone_no,m_time = null;
  Connection cn = null;
  Map m = null;
  String bar = null;
  try{
 
  date1 = w.p("date1",now);
  date2 = w.p("date2",now);
  
    sql = "select * from t_sys_msg_log where log_time>='"+date1+"' and log_time<='"+date2+" 23:59:59' order by log_id ";
    cn = f.getConn();
    
    m = f.query(cn,sql,null,request);
    list = (List)m.get("data");
    bar = (String)m.get("bar");
    rs = new RowSet(list);
  }catch(Exception e){
    w.error(e);
    return;
  }finally{f.close(cn);}

%>
<script>
function f_go_page(i){
  form1.page.value=i;
  form1.submit();
}
function f_del(log_id){
  form1.log_id.value=log_id;
  form1.action='log_del.jsp'
  form1.submit();
}

</script>
<form name=form1 method=post>
<input type=hidden name=log_id>

<div class=left>
<input type=text class=date name=date1 value='<%=date1%>' onclick="new Calendar().show(this);">
<input type=text class=date name=date2 value='<%=date2%>' onclick="new Calendar().show(this);">


<input type=submit value='查看' class=btn>
</div>

<table border=0 cellspacing=0>
 <tr>
 <td class=right><%=bar%></td>
 </tr>
</table>

<table border=0 cellspacing=1>
<tr class=title>
<td>序号</td>
<td>日志时间</td>
<td>日志内容</td>
<td><a href='javascript:f_del_all()'>全部删除</a></td>
</tr>

<%while(rs.next()){%>
<tr>
   <td><%=rs.getIndex()+1%></td>
   <td><%=rs.get("log_time")%></td>
   <td><%=rs.get("log_content")%></td>
   
   <td>
   <a href="javascript:f_del('<%=rs.get("log_id")%>')">删除</a>
   </td>
   
</tr>
<%}%>
</table>
</form>
<script>
 function f_del_all(){
  
  form1.action='log_del_all.jsp';
  form1.submit();
 }
</script>


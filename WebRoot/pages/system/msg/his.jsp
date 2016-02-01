<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  String sql = null;
  List list = null;
  RowSet rs = null;
  String date1,date2 = null;
  String now = StringUtil.getNowDate()+"";
  String station_id,station_name,phone_no,m_time,user_name = null;
  Connection cn = null;
  Map m = null;
  String bar = null;
  Map stationMap = null;
  List stationList = null;
  Map phoneMap = null;
  try{
  
  date1 = w.p("date1",now);
  date2 = w.p("date2",now);
  

    cn = f.getConn();
    sql = "select station_id,station_desc from t_cfg_station_info ";
    stationMap = f.getMap(cn,sql);
    sql="select phone_no,user_name from t_sys_msg_phone";
    phoneMap = f.getMap(cn,sql);
    
    
        sql = "select * from t_sys_msg_his where m_time>='"+date1+"' and m_time<='"+date2+" 23:59:59' order by m_time desc";
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
function f_del(station_id,m_time,phone_no){
  //form1.page.value=i;
  form1.station_id.value=station_id;
  form1.m_time.value=m_time;
  form1.phone_no.value=phone_no;
  form1.action='his_del.jsp';
  form1.submit();
}

</script>
<form name=form1 method=post>
<input type=hidden name=station_id>
<input type=hidden name=phone_no>
<input type=hidden name=m_time>

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
<td>站位名称</td>
<td>监测时间</td>
<td>手机号</td>
<td style="width:200px">短信内容</td>
<td style="width:50px">删除</td>
</tr>

<%while(rs.next()){
  station_id = rs.get("station_id");
  m_time = rs.get("m_time");
  phone_no = rs.get("phone_no");
  station_name = (String)stationMap.get(station_id);
  user_name = (String)phoneMap.get(phone_no);
  
%>
<tr>
   <td><%=rs.getIndex()+1%></td>
   <td><%=station_name%></td>
   <td><%=rs.get("m_time")%></td>
   <td><%=rs.get("phone_no")%></td>
   
   <td><%=rs.get("msg_content")%></td>
   <td>
   <%if(m_time.indexOf(now)<0){%>
   <a href="javascript:f_del('<%=station_id%>','<%=m_time%>','<%=phone_no%>')">
   删除
   </a>
   <%}%>
   </td>
   
</tr>
<%}%>
</table>
</form>




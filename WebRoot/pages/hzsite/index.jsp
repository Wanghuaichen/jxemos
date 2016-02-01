<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc_empty.jsp" %>
<%
    String station_id = request.getParameter("station_id");
    String sql = null;
    Connection cn = null;
    Map m = null;
    String station_name = null;
    String date1,date2 = null;
    String now = StringUtil.getNowDate()+"";
    try{
      date1=now;
      date2=now;
      if(f.empty(station_id)){throw new Exception("请选择站位");}
      sql = "select station_desc from t_cfg_station_info where station_id='"+station_id+"'";
      cn = DBUtil.getConn();
      m = DBUtil.queryOne(cn,sql,null);
      if(m==null){throw new Exception("记录不存在");}
      station_name = (String)m.get("station_desc");
      
      
    }catch(Exception e){
     w.error(e);
     return;
    }finally{DBUtil.close(cn);}
    
   
%>
<style>
.hh{
 font-weight:bold;
 font-size:20px;
}
</style>
<body scroll=no onload=form1.submit()>
<form name=form1 method=post target=qq action=q.jsp>
<input type=hidden name=station_id value='<%=station_id%>'>
<table border=0 width=100% height=100%>
<tr>
  <td height=20>
    <div class='left hh'><%=station_name%></div>
    <input type=button value='数据查询' onclick=f_q() class=btn>
    <input type=button value='视频' onclick=f_sp() class=btn>
    
    <div id=query_div>
    <select name=data_table onchange=form1.submit()>
    <option value='t_monitor_real_hour'>小时数据
    <option value='t_monitor_real_day'>日数据
    </select>
     
     <input type=text class=date name=date1 value='<%=date1%>'  onclick="new Calendar().show(this);">
     <input type=text class=date name=date2 value='<%=date2%>'  onclick="new Calendar().show(this);">
     <input type=button value='查看' onclick=form1.submit() class=btn>
    </div>
    
  </td>
</tr>

<tr>
<td><iframe name=qq width=100% height=100% frameborder=0></iframe></td>
</tr>

</table>
</form>
</body>

<script>
function f_q(){
 //alert('q');
 form1.action='q.jsp';
 document.getElementById('query_div').style.display='';
 form1.submit();
}
function f_sp(){
 //alert('sp');
  document.getElementById('query_div').style.display='none';
   form1.action='../site/sp/sp_one.jsp';
   form1.submit();
}
</script>





<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    String station_id = request.getParameter("station_id");
    String sql = null;
    Connection cn = null;
    Map m = null;
    String station_name = null;
    String date1,date2 = null;
    String now = StringUtil.getNowDate()+"";
    String data_table = request.getParameter("data_table");
    List list = null;
    RowSet rs1,rs2 = null;
    String bar = null;
    int i,num=0;
    String col = null;
    String v = null;
    String m_time = null;
    try{
      date1 = request.getParameter("date1");
      date2 = request.getParameter("date2");
      cn = f.getConn();
      sql = "select * from t_cfg_infectant_base where infectant_id in(";
      sql=sql+"select infectant_id from t_cfg_monitor_param where station_id='"+station_id+"'";
      sql=sql+") and infectant_type in('1','2') ";
      sql=sql+" order by infectant_order ";
      
      list = DBUtil.query(cn,sql,null);
      num = list.size();
      if(num<1){throw new Exception("«Î≈‰÷√º‡≤‚÷∏±Í");}
      
      rs1 = new RowSet(list);
      
      sql = "select * from "+data_table+" where station_id='"+station_id+"'";
      sql=sql+" and m_time>='"+date1+"' ";
      sql=sql+" and m_time<='"+date2+"' ";
      sql=sql+" order by m_time";
       
      m = f.query(cn,sql,null,request);
      list = (List)m.get("data");
      bar = (String)m.get("bar");
      rs2 = new RowSet(list);
    }catch(Exception e){
     w.error(e);
     return;
    }finally{f.close(cn);}
    
    
    
%>
<form name=form1 method=post>
<input type=hidden name=station_id value='<%=station_id%>'>
<input type=hidden name=date1 value='<%=date1%>'>
<input type=hidden name=date2 value='<%=date2%>'>
<input type=hidden name=data_table value='<%=data_table%>'>

   <table border=0 cellspacing=1>
    <tr class=title>
    <td>–Ú∫≈</td>
    <td style="width:150px">º‡≤‚ ±º‰</td>
    <%while(rs1.next()){%>
    <td>
    <%=rs1.get("infectant_name")%><br>
    <%=rs1.get("infectant_unit")%>
    
    </td>
    <%}%>
    </tr>
    
    <%while(rs2.next()){
    m_time = rs2.get("m_time");
    m_time =f.sub(m_time,0,19);
    %>
    <tr>
    <td><%=rs2.getIndex()+1%></td>
    <td><%=m_time%></td>
    <%
    rs1.reset();
      while(rs1.next()){
      col = rs1.get("infectant_column");
      col=col.toLowerCase();
      v = rs2.get(col);
      v=f.v(v);
    %>
    <td><%=v%></td>
    <%}%>
    
    </tr>
    <%}%>
    
   </table>
   
   <div class=right><%=bar%></div>
</form>

<script>
function f_go_page(i){
form1.page.value=i;
 form1.submit();
}
</script>

